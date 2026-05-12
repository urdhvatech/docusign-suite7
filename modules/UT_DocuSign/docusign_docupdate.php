<?php
/**********************************************************************************
* This file is part of package DocuSign By Urdhva Tech.
* Developed by : Urdhva Tech (http://www.urdhva-tech.com)
* Module : DocuSign
* Contact : contact@urdhva-tech.com
* All rights(c) by Urdhva Tech
* This package is licensed software and may only be used in alignment
* with the License Agreement received with this Package.
* This Software is copyrighted and may not be further distributed without
* written consent of Urdhva Tech
*********************************************************************************/
//docusign_docupdate_cron();
function docusign_docupdate_cron($sID='')
{
    require_once('modules/UT_DocuSign/DocuSignUtils.php');
    require_once('modules/UT_DocuSign/library/UT_DocuSignClient.php');
    require_once('modules/Notes/NoteSoap.php');
    global $db,$timedate,$sugar_config,$current_user;
    
    if (!checkDocuSignLicense()) {
        $msg = "Invalid License";
        $GLOBALS['log']->fatal($msg);
        return true;
    }
    
    if (!empty($sID)) {
        $sDocuSignSQL = "SELECT * FROM ut_docusign WHERE deleted=0 AND id='".$sID."'";
    } else {
        $sDocuSignSQL = "SELECT * FROM ut_docusign WHERE deleted=0 AND state <> 'created' AND state <> 'completed' AND state <> 'timedout' AND state <> 'voided' AND state <> 'deleted' AND state <> 'declined'";
    }
    $oDocuSignClient = new UT_DocuSignClient(true, 1);
    
    $oResRS = $db->query($sDocuSignSQL, true);
    while ($aDataOut = $db->fetchByAssoc($oResRS)) {
    
        if (!empty($aDataOut['rs_doc_id'])) {
            $aResponseEnvelopeDetail = $oDocuSignClient->getEnvelope($aDataOut['rs_doc_id']);
            if (empty($aResponseEnvelopeDetail['error'])) {
                $oUTDocuSign = BeanFactory::getBean('UT_DocuSign', $aDataOut['id']);
                $oEnvelope = $aResponseEnvelopeDetail['response'];
                if (!empty($oEnvelope->getStatus())) {
                    $oUTDocuSign->state = $oEnvelope->getStatus();
                } else {
                    continue;
                }
                if (empty($sID) && $aDataOut['state'] == $oEnvelope->getStatus()) {
                    continue; // If the fetched and db status are same, do not update the document and notes.
                }
                if (!empty($oEnvelope->getEmailSubject())) {
                    $oUTDocuSign->subject = $oEnvelope->getEmailSubject();
                }
                if (!empty($oEnvelope->getEmailBlurb())) {
                    $oUTDocuSign->message = $oEnvelope->getEmailBlurb();
                }
                if (!empty($oEnvelope->getInitialSentDateTime())) {
                    $stimestamp = strtotime($oEnvelope->getInitialSentDateTime());
                    $sDate = gmdate("Y-m-d H:i:s", $stimestamp);
                    $sDisplayDate = $timedate->to_display_date_time($sDate);
                    $oUTDocuSign->rs_created_at = $sDisplayDate;
                }
                if (!empty($oEnvelope->getCompletedDateTime())) {
                    $stimestamp = strtotime($oEnvelope->getCompletedDateTime());
                    $sDate = gmdate("Y-m-d H:i:s", $stimestamp);
                    $sDisplayDate = $timedate->to_display_date_time($sDate);
                    $oUTDocuSign->rs_completed_at = $sDisplayDate;
                }
                if (!empty($oEnvelope->getDeclinedDateTime())) {
                    $stimestamp = strtotime($oEnvelope->getDeclinedDateTime());
                    $sDate = gmdate("Y-m-d H:i:s", $stimestamp);
                    $sDisplayDate = $timedate->to_display_date_time($sDate);
                    $oUTDocuSign->rs_declined_on = $sDisplayDate;
                }
                if (!empty($oEnvelope->getVoidedDateTime())) {
                    $stimestamp = strtotime($oEnvelope->getVoidedDateTime());
                    $sDate = gmdate("Y-m-d H:i:s", $stimestamp);
                    $sDisplayDate = $timedate->to_display_date_time($sDate);
                    $oUTDocuSign->rs_voided_on = $sDisplayDate;
                }
                
                if (!empty($oUTDocuSign->docusign_templates)) {
                    $aRespEnv = $oDocuSignClient->getTemplateDetails($oUTDocuSign->docusign_templates);
                    $oEnvelopeTemplate='';
                    if (empty($aRespEnv['error']) && !empty($aRespEnv['response'])) {
                        $oEnvelopeTemplate = $aRespEnv['response'];
                        $aSavedTemplateRoles = unserialize(base64_decode($oUTDocuSign->saved_template_roles));
                        $aCRMRolesData = array();
                        $aCRMRowData = array();
                        // Docusign To CRM mapping
                        if (!empty($oUTDocuSign->ut_dsfieldmapping_ut_docusign_2ut_dsfieldmapping_ida)) {
                            $sSQLMapping = "select id, crmroledata, crmrowdata FROM ut_dsfieldmapping WHERE deleted=0 AND id='".$oUTDocuSign->ut_dsfieldmapping_ut_docusign_2ut_dsfieldmapping_ida."'";
                            $oResMapp = $db->query($sSQLMapping);
                            $aDsMapRow = $db->fetchByAssoc($oResMapp);
                            if (!empty($aDsMapRow)) {
                                $aCRMRolesData = unserialize(base64_decode($aDsMapRow['crmroledata']));
                                $aCRMRowData = unserialize(base64_decode($aDsMapRow['crmrowdata']));
                            }
                            $aSugarDataResponse = $oDocuSignClient->getParsedTabsToReceive($oUTDocuSign->docusign_templates, $oEnvelope, $oEnvelopeTemplate, $aSavedTemplateRoles, $aCRMRolesData, $aCRMRowData);
                            if (!empty($aSugarDataResponse['error'])) {
                                $GLOBALS['log']->fatal('Envelope update failed: DS to CRM mapping failed '.$aSugarDataResponse['error']);
                            } else {
                                if (!empty($aSugarDataResponse['response'])) {
                                    foreach ($aSugarDataResponse['response'] as $sModRecKey => $aSugarData) {
                                        $aModAndRec = explode('_', $sModRecKey);
                                        $oBean = BeanFactory::getBean($aModAndRec[0], $aModAndRec[1]);
                                        foreach ($aSugarData as $sFldName => $sFldValue) {
                                            $oBean->$sFldName = $sFldValue;
                                        }
                                        $oBean->save();
                                    }
                                }
                            }
                        }
                    } else {
                        $GLOBALS['log']->fatal('Envelope update failed: DS to CRM mapping failed '.$aRespEnv['error']);
                    }
                }
                $oUTDocuSign->save();
                
                $aResp = $oDocuSignClient->listDocuments($aDataOut['rs_doc_id']);
                if (empty($aResp['error'])) {
                    $oUTDocuSign->load_relationship("ut_docusign_notes_1");
                    //$oUTDocuSign->load_relationship("ut_docusign_documents_1");
                    $oEnvelopeDocumentsResult = $aResp['response'];
                    $aEnvelopeDocuments = $oEnvelopeDocumentsResult->getEnvelopeDocuments();
                    if (!empty($aEnvelopeDocuments)) {
                        //Delete all Notes
                        foreach ($oUTDocuSign->ut_docusign_notes_1->getBeans() as $eachNote) {
                            // BEGIN: Bug reported on store. mark_deleted creates files in upload/deleted/ for each status update notes were deleted and moved to upload/deleted/ which created the problem of having huge files in that directory.
                            $sNId = $eachNote->id;
                            $removeFile = "upload://$sNId";
                            if (file_exists($removeFile)) {
                                if (!unlink($removeFile)) {
                                    $GLOBALS['log']->error("*** Could not unlink() file: [ {$removeFile} ]");
                                }
                            }
                            $eachNote->uploadfile = '';
                            $eachNote->filename = '';
                            $eachNote->file_mime_type = '';
                            $eachNote->file = '';
                            $eachNote->id = '';
                            // BEGIN: Bug reported on store. mark_deleted creates files in upload/deleted/ for each status update notes were deleted and moved to upload/deleted/ which created the problem of having huge files in that directory.
                            $eachNote->mark_deleted($sNId);
                        }
                        //Delete all Documents
                        /*
                        foreach ($oUTDocuSign->ut_docusign_documents_1->getBeans() as $eachDocument) {
                            $eachDocument->mark_deleted($eachDocument->id);
                        }
                        */
                        foreach ($aEnvelopeDocuments as $sk => $oEnvelopeDocument) {
                            $sDocId = $oEnvelopeDocument->getDocumentId();
                            $aRespGetDoc = $oDocuSignClient->getDocument($sDocId, $aDataOut['rs_doc_id']);
                            $finalNoteName = "";
                            $envelopeDocumentName = $oEnvelopeDocument->getName();
                            if (!empty($envelopeDocumentName)) {
                                $intermediateNoteName = explode(".", $envelopeDocumentName);
                                if (is_array($intermediateNoteName) && count($intermediateNoteName) > 0) {
                                    $innerIntermediateNoteName = explode(".".end($intermediateNoteName), $envelopeDocumentName);
                                    $finalNoteName = $innerIntermediateNoteName[0].".pdf";
                                } else {
                                    $finalNoteName = $intermediateNoteName.".pdf";
                                }
                            }
                            //SplFileObject
                            $finfo = new finfo(FILEINFO_MIME_TYPE);
                            $mime_type = $finfo->file($aRespGetDoc['response']->getRealPath());
                            //Save the data using file_put_contents.
                            //$save = file_put_contents($fileName, file_get_contents($aRespGetDoc['response']->getPathname()));
                            $oNotes = BeanFactory::getBean('Notes');
                            $sNotesID = create_guid();
                            $oNotes->new_with_id = true;
                            $oNotes->id = $sNotesID;
                            $oNotes->name = $finalNoteName;//$oEnvelopeDocument->getName();
                            $oNotes->filename = $finalNoteName;//$oEnvelopeDocument->getName();
                            $oNotes->parent_type = 'UT_DocuSign';
                            $oNotes->parent_id = $oUTDocuSign->id;
                            //$oNotes->assigned_user_id = $SugarUserId;
                            $oNotes->assigned_user_id = $oUTDocuSign->assigned_user_id;
                            $oNotes->save();
                            
                            $oNoteSoap = new NoteSoap();
                            $aNoteFile = array(
                                'id' => $sNotesID,
                                'name'=> $finalNoteName,//$oEnvelopeDocument->getName(),
                                'filename' => $finalNoteName,//$oEnvelopeDocument->getName(),
                                'file' => base64_encode(file_get_contents($aRespGetDoc['response']->getPathname())),
                            );
                            $sNotesID = $oNoteSoap->newSaveFile($aNoteFile);
                            $oUTDocuSign->ut_docusign_notes_1->add($sNotesID);
                            
                            // Begins Relation to Document module
                            /*
                            $oDocument = BeanFactory::getBean("Documents");
                            $sDocCRMId =  create_guid();
                            $oDocument->id = $sDocCRMId;
                            $oDocument->new_with_id = true;
                            $oDocument->category_id = '';
                            $oDocument->name = $oEnvelopeDocument->getName();
                            $oDocument->document_name = $oEnvelopeDocument->getName();
                            $oDocument->file_mime_type = $mime_type;
                            $oDocument->doc_id = 1;
                            //$oDocument->category_id ='Production';  //Document Category
                            $oDocument->doc_type = 'Sugar';
                            $oDocument->assigned_user_id = $oUTDocuSign->assigned_user_id;
                            $oDocument->save();

                            $Revision = new DocumentRevision();
                            $Revision->in_workflow = true;
                            $Revision->not_use_rel_in_req = true;
                            $Revision->new_rel_id = $sDocCRMId;
                            $Revision->new_rel_relname = 'Documents';
                            $Revision->change_log = translate('DEF_CREATE_LOG', 'Documents');
                            $Revision->revision = 1;
                            $Revision->document_id = $sDocCRMId;
                            $Revision->filename = $oEnvelopeDocument->getName();
                            $Revision->file_mime_type = $oDocument->file_mime_type;
                            $Revision->doc_type = "Sugar";
                            $Revision->template_type = 'Source';

                            $Revision->id = create_guid();
                            $Revision->new_with_id = true;
                            //Move file saved during populatefrompost to match the revision id rather than document id
                            $Revision->save();
                            //update document with latest revision id
                            $oDocument->document_revision_id = $Revision->id;
                            $oDocument->save();
                            $uploadFileFilename = new UploadFile("temp_uploadname");
                            $decodedFile = file_get_contents($aRespGetDoc['response']->getPathname());
                            $uploadFileFilename->set_for_soap($oEnvelopeDocument->getName(), $decodedFile);
                            $uploadFileFilename->final_move($Revision->id);

                            $oUTDocuSign->ut_docusign_documents_1->add($sDocCRMId);
                            */
                            // Ends Relation to Document module
                        }
                    }
                } else {
                    $GLOBALS['log']->fatal("Docusign : Error occured ".HtmlSpecialChars($aResp['error']));
                }
                
                $aResp = $oDocuSignClient->listAuditEvents($aDataOut['rs_doc_id']);
                if (empty($aResp['error'])) {
                    if (!empty($aResp['response'])) {
                        $oUTDocuSign->load_relationship("ut_docusign_ut_dsactivities");
                        //Delete all Audit Trials
                        foreach ($oUTDocuSign->ut_docusign_ut_dsactivities->getBeans() as $eachAudit) {
                            $eachAudit->mark_deleted($eachAudit->id);
                        }
                        //Insert new Audit Trials
                        foreach ($aResp['response'] as $iDx => $aAudit) {
                            $oUTRSActivities = BeanFactory::getBean('UT_DSActivities');
                            $act_id = create_guid();
                            $oUTRSActivities->new_with_id = true;
                            $oUTRSActivities->id = $act_id;
                            $oUTRSActivities->assigned_user_id = $oUTDocuSign->assigned_user_id;
                            if (!empty($aAudit['Action'])) {
                                $oUTRSActivities->name = $aAudit['Action'];
                                $oUTRSActivities->description = $aAudit['Message'];
                            }
                            if (!empty($aAudit['Action'])) {
                                $oUTRSActivities->rs_keyword = $aAudit['Action'];
                            }
                            if (!empty($aAudit['logTime'])) {
                                $stimestamp = strtotime($aAudit['logTime']);
                                $sDate = gmdate("Y-m-d H:i:s", $stimestamp);
                                $sDisplayDate = $timedate->to_display_date_time($sDate);
                                $oUTRSActivities->rs_created_at = $sDisplayDate;
                            }
                            //$oUTRSActivities->assigned_user_id = $SugarUserId;
                            $oUTRSActivities->save();
                            
                            if ($oUTDocuSign->ut_docusign_ut_dsactivities->add($oUTRSActivities->id) == false) {
                                $GLOBALS['log']->fatal("Failed to associate RSActivities (".$oUTRSActivities->id.") with DocuSign (".$oUTDocuSign->id.")");
                            }
                        }
                    }
                } else {
                    $GLOBALS['log']->fatal("Docusign : Error occured ".HtmlSpecialChars($aResp['error']));
                }
            } else {
                $GLOBALS['log']->fatal("Docusign : Error occured ".HtmlSpecialChars($aResponseEnvelopeDetail['error']));
            }
        }
    }
    if (!empty($sID)) {
        return true;
    }
}
