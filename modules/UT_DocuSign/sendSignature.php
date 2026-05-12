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
require_once('modules/UT_DocuSign/DocuSignUtils.php');
require_once('modules/UT_DocuSign/library/UT_DocuSignClient.php');
require_once('modules/Notes/NoteSoap.php');
require_once('modules/UT_DocuSign/docusign_docupdate.php');

global $db,$app_strings,$app_list_strings,$current_user, $sugar_config, $current_language;
if (!checkDocuSignLicense()) {
    $msg = "Invalid License";
    echo json_encode($msg);
    exit;
}
$module = $recordId = $modalView = '';
$module = $_REQUEST['moduleName'];
$recordId = $_REQUEST['recordId'];
$modalView = $_REQUEST['modalView'];
$templateID = $_REQUEST['template_id'];

$error_message = '';
$sReceipientName = '';
$sReceipientEmail = '';
$sMessageOut='';
$base_mod_string = return_module_language($current_language, "UT_DocuSign");
$finalSignerTab = array();
$finalDateSignedTab = array();
$finalInitialTab = array();
$aAppKeys = getApplicationKey();

if ($modalView == "DetailView") {
    switch ($module) {
        case 'Accounts':
        case 'Contacts':
        case 'Leads':
        case 'Users':
              $oBean = BeanFactory::getBean($module, $recordId);
              if (empty($oBean->email1)) {
                  $error_message = $base_mod_string['LBL_ERRMSG_1'];
              } else {
                  if ($module == 'Accounts') {
                      $sReceipientName = $oBean->name;
                  } else {
                      $sReceipientName = $oBean->first_name.' '.$oBean->last_name;
                  }
                  $sReceipientEmail = $oBean->email1;
              }
            break;
        case 'AOS_Quotes':
        case 'AOS_Invoices':
            $oBean = BeanFactory::getBean($module, $recordId);
            if (!empty($oBean->billing_contact_id)) {
                $oSubBean = BeanFactory::getBean("Contacts", $oBean->billing_contact_id);
                if (empty($oSubBean->email1)) {
                    $error_message = sprintf($base_mod_string['LBL_ERRMSG_2'], $oSubBean->full_name);
                } else {
                    $sReceipientName = $oSubBean->full_name;
                    $sReceipientEmail = $oSubBean->email1;
                }
            } else {
                $error_message=$base_mod_string['LBL_ERRMSG_3'];
            }
           break;
         case 'AOS_Contracts':
            $oBean = BeanFactory::getBean($module, $recordId);
            if (!empty($oBean->contact_id)) {
                $oSubBean = BeanFactory::getBean("Contacts", $oBean->contact_id);
                if (empty($oSubBean->email1)) {
                    $error_message = sprintf($base_mod_string['LBL_ERRMSG_2'], $oSubBean->full_name);
                } else {
                    $sReceipientName = $oSubBean->full_name;
                    $sReceipientEmail = $oSubBean->email1;
                }
            } else {
                $error_message=$base_mod_string['LBL_ERRMSG_3'];
            }
           break;
    }
    if (empty($error_message)) {
        $aFinalRecipients = $aFinalCC = array();
        $directoryName = "UT_DSUploads";
        if($sugar_config['suitecrm_version'] >= '7.12.0') {
            require_once('modules/UT_DocuSign/generateWrapperPdf.php');
            $aPDFInfo = UTGetWrapperPDFContent($templateID, 'pdf', $module, $recordId);
        }
        else {
            require_once('modules/UT_DocuSign/generatePdf.php');
            $aPDFInfo = UTGetPDFContent($templateID, 'pdf', $module, $recordId);
        }
        
        $sFileName = $aPDFInfo['file_name'];
        //$document_data['base64value'] = base64_encode($aPDFInfo['sPDFContent']);
//        $document_data['filename'] = $aPDFInfo['file_name'];
        $template = new AOS_PDF_Templates();
        $template->retrieve($templateID);
        if (!empty($aPDFInfo['iAssignedUserHasSigner']) && !empty($oBean->assigned_user_id)) {
            $oAssignedUser = BeanFactory::getBean("Users", $oBean->assigned_user_id);
            $aFinalRecipients[]=array(
                                'name'=> 'signer',
                                'signer_name' => htmlspecialchars($oAssignedUser->name),
                                'signer_email' => $oAssignedUser->email1,
                                'message' => $template->name,
                                'cstm_roletype' => 'AssignedUserRole',
                                'cstm_sugar_id' => $oBean->assigned_user_id,
                                'cstm_sugar_module' => "Users",
                             );
        }
        if (!empty($aPDFInfo['iCurrentUserHasSigner']) && !empty($current_user->id)) {
            $aFinalRecipients[]=array(
                                'name'=> 'signer',
                                'signer_name' => htmlspecialchars($current_user->name),
                                'signer_email' => $current_user->email1,
                                'message' => $template->name,
                                'cstm_roletype' => 'CurrentUserRole',
                                'cstm_sugar_id' => $current_user->id,
                                'cstm_sugar_module' => "Users",
                             );
        }
        $aFinalRecipients[]=array(
                                'name'=> 'signer',
                                'signer_name' => htmlspecialchars($sReceipientName),
                                'signer_email' => $sReceipientEmail,
                                'message' => $template->name,
                                'cstm_roletype' => 'role',
                                'cstm_sugar_id' => $recordId,
                                'cstm_sugar_module' => $module,
                             );
        $subject = $template->name;
        $action = "send";
        //$expires_in = "30";
        $description = $template->name;
        //$tags = array('sent_from_api','mutual_nda');
        $tags = array();
        $callbackURL = $sugar_config['site_url'].'/index.php?entryPoint=DSPushServiceCallback';
        $sFilePathName = $directoryName."/".$sFileName;
        $file_data = array(
                        'name' => $sFileName,
                        'source' => 'upload',
                     );
        $sDocumentName = $template->name;
        $sMessage = $template->name;
        $tags = array();
        $doc_callback_url = $sugar_config['site_url'].'/index.php?entryPoint=DSPushServiceCallback';
        $oDocuSignClient = new UT_DocuSignClient();
        $dsEnvironment = $oDocuSignClient->getDSEnvironment();
        $oDocuSignClient->setDocumentFileName($sFilePathName);
        $oDocuSignClient->setDocumentName($sFileName);
        $oDocuSignClient->setCstmSigners($aFinalRecipients);
        $oDocuSignClient->setCstmCarbonCopy($aFinalCC);
        
        if (!empty($aPDFInfo['iAssignedUserHasSigner']) && !empty($oBean->assigned_user_id)) {
            $signHereAssignedUser = new \DocuSign\eSign\Model\SignHere();
            $signHereAssignedUser->setAnchorString('{DS_ASSIGNED_USER_BOX}');
            $signHereAssignedUser->setAnchorXOffset('0');
            $signHereAssignedUser->setAnchorYOffset('0');
            $signHereAssignedUser->setAnchorUnits('inches');
            $signHereAssignedUser->setAnchorIgnoreIfNotPresent('true');
            $signHereAssignedUser->setDocumentId("1");
            $signHereAssignedUser->setRecipientId($oBean->assigned_user_id);
            $finalSignerTab[] = $signHereAssignedUser;
        }
        
        if (!empty($aPDFInfo['iCurrentUserHasSigner']) && !empty($current_user->id)) {
            $signHereCurrentUser = new \DocuSign\eSign\Model\SignHere();
            $signHereCurrentUser->setAnchorString('{DS_CURRENT_USER_BOX}');
            $signHereCurrentUser->setAnchorXOffset('0');
            $signHereCurrentUser->setAnchorYOffset('0');
            $signHereCurrentUser->setAnchorUnits('inches');
            $signHereCurrentUser->setAnchorIgnoreIfNotPresent('true');
            $signHereCurrentUser->setDocumentId("1");
            $signHereCurrentUser->setRecipientId($current_user->id);
            $finalSignerTab[] = $signHereCurrentUser;
        }
        
        if (!empty($aPDFInfo['iHasSigner'])) {
            $signHere = new \DocuSign\eSign\Model\SignHere();
            $signHere->setAnchorString('{DS_BOX}');
            $signHere->setAnchorXOffset('0');
            $signHere->setAnchorYOffset('0');
            $signHere->setAnchorUnits('inches');
            $signHere->setAnchorIgnoreIfNotPresent('true');
            //$signHere->setXPosition("100");
            //$signHere->setYPosition("100");
            $signHere->setDocumentId("1");
            //$signHere->setPageNumber("1");
            $signHere->setRecipientId($recordId);
            $finalSignerTab[] = $signHere;
        }
        $oDocuSignClient->setCstmSignHereTab($finalSignerTab);
        
        if (!empty($aPDFInfo['iHasInitialAssignedUser']) && !empty($oBean->assigned_user_id)) {
            $initialHereAssignedUser = new \DocuSign\eSign\Model\InitialHere();
            $initialHereAssignedUser->setAnchorString('{DS_INITIAL_ASSIGNED_USER}');
            $initialHereAssignedUser->setAnchorXOffset('10');
            $initialHereAssignedUser->setAnchorYOffset('25');
            $initialHereAssignedUser->setAnchorUnits('pixels');
            $initialHereAssignedUser->setAnchorIgnoreIfNotPresent('true');
            $initialHereAssignedUser->setDocumentId("1");
            $initialHereAssignedUser->setRecipientId($oBean->assigned_user_id);
            $initialHereAssignedUser->setScaleValue(60); // This is in percentage.
            $finalInitialTab[] = $initialHereAssignedUser;
        }
        
        if (!empty($aPDFInfo['iHasInitialCurrentUser']) && !empty($current_user->id)) {
            $initialHereCurrentUser = new \DocuSign\eSign\Model\InitialHere();
            $initialHereCurrentUser->setAnchorString('{DS_INITIAL_CURRENT_USER}');
            $initialHereCurrentUser->setAnchorXOffset('10');
            $initialHereCurrentUser->setAnchorYOffset('25');
            $initialHereCurrentUser->setAnchorUnits('pixels');
            $initialHereCurrentUser->setAnchorIgnoreIfNotPresent('true');
            $initialHereCurrentUser->setDocumentId("1");
            $initialHereCurrentUser->setRecipientId($current_user->id);
            $initialHereCurrentUser->setScaleValue(60); // This is in percentage.
            $finalInitialTab[] = $initialHereCurrentUser;
        }
        
        if (!empty($aPDFInfo['iHasInitials'])) {
            $initialHere = new \DocuSign\eSign\Model\InitialHere();
            $initialHere->setAnchorString('{DS_INITIAL}');
            $initialHere->setAnchorXOffset('10');
            $initialHere->setAnchorYOffset('25');
            $initialHere->setAnchorUnits('pixels');
            $initialHere->setAnchorIgnoreIfNotPresent('true');
            //$initialHere->setXPosition("100");
            //$initialHere->setYPosition("100");
            $initialHere->setDocumentId("1");
            //$initialHere->setPageNumber("1");
            $initialHere->setRecipientId($recordId);
            $initialHere->setScaleValue(60); // This is in percentage.
            $finalInitialTab[] = $initialHere;
        }
        $oDocuSignClient->setCstmInitialHereTab($finalInitialTab);
        
        //Date Signed Start
        if (!empty($aPDFInfo['iHasAssignedUserDateSigned']) && !empty($oBean->assigned_user_id)) {
            $dateSignedAssignedUserHere = new \DocuSign\eSign\Model\DateSigned();
            $dateSignedAssignedUserHere->setAnchorString('{DS_DATE_SIGNED_ASSIGNED_USER}');
            $dateSignedAssignedUserHere->setAnchorXOffset('0');
            $dateSignedAssignedUserHere->setAnchorYOffset('0');
            $dateSignedAssignedUserHere->setAnchorUnits('inches');
            $dateSignedAssignedUserHere->setAnchorIgnoreIfNotPresent('true');
            $dateSignedAssignedUserHere->setDocumentId("1");
            $dateSignedAssignedUserHere->setRecipientId($recordId);
            $finalDateSignedTab[] = $dateSignedAssignedUserHere;
        }
        
        if (!empty($aPDFInfo['iHasCurrentUserDateSigned']) && !empty($current_user->id)) {
            $dateSignedCurrentUserHere = new \DocuSign\eSign\Model\DateSigned();
            $dateSignedCurrentUserHere->setAnchorString('{DS_DATE_SIGNED_CURRENT_USER}');
            $dateSignedCurrentUserHere->setAnchorXOffset('0');
            $dateSignedCurrentUserHere->setAnchorYOffset('0');
            $dateSignedCurrentUserHere->setAnchorUnits('inches');
            $dateSignedCurrentUserHere->setAnchorIgnoreIfNotPresent('true');
            $dateSignedCurrentUserHere->setDocumentId("1");
            $dateSignedCurrentUserHere->setRecipientId($current_user->id);
            $finalDateSignedTab[] = $dateSignedCurrentUserHere;
        }
        
        if (!empty($aPDFInfo['iHasDateSigned'])) {
            $dateSignedHere = new \DocuSign\eSign\Model\DateSigned();
            $dateSignedHere->setAnchorString('{DS_DATE_SIGNED}');
            $dateSignedHere->setAnchorXOffset('0');
            $dateSignedHere->setAnchorYOffset('0');
            $dateSignedHere->setAnchorUnits('inches');
            $dateSignedHere->setAnchorIgnoreIfNotPresent('true');
            $dateSignedHere->setDocumentId("1");
            $dateSignedHere->setRecipientId($recordId);
            $finalDateSignedTab[] = $dateSignedHere;
        }
        $oDocuSignClient->setCstmDateSignedTab($finalDateSignedTab);
        //Date Signed End
        
        // Note: callbackurl should be HTTPS, Only then it will work
        if (strpos($sugar_config['site_url'], 'https://') !== false) {
            $oDocuSignClient->setCstmEnvelopWebHookURL($doc_callback_url); //The URL will receive a POST for each of the following document events: created, viewed, signed, executed. Note that due to the asynchronous nature of processing, the order in which the document callbacks are sent is not guaranteed
        } else {
            //echo "The string https was not found in the string ".$sugar_config['site_url'];
        }
        $oDocuSignClient->setCstmEmailSubject($sDocumentName);
        $oDocuSignClient->setCstmEmailBlurb($sMessage);
        $aResp = $oDocuSignClient->signatureRequestOnDocument("sent", false);
        if (!empty($aResp['error'])) {
            unlink($sFilePathName);
            echo json_encode($aResp['error']);
            return;
        } else {
            $sNewGuid = $oDocuSignClient->getEnvelopeId();
            unlink($sFilePathName);
            if (!empty($sNewGuid)) {
                $oUTDocuSign = BeanFactory::getBean('UT_DocuSign');
                $id = create_guid();
                $oUTDocuSign->new_with_id = true;
                $oUTDocuSign->id = $id;
                $oUTDocuSign->document_name = 'DS : ';
                $oUTDocuSign->sending_type = 'select_crm_pdf';
                $oUTDocuSign->recipient_name = $sReceipientName;
                $oUTDocuSign->email_address = $sReceipientEmail;
                $oUTDocuSign->rs_doc_id = $sNewGuid;
                $oUTDocuSign->subject = $sDocumentName;
                $oUTDocuSign->message = $sMessage;
                $oUTDocuSign->state = 'sent';
                $oUTDocuSign->parent_id = $recordId;
                $oUTDocuSign->parent_type = $module;
                $oUTDocuSign->assigned_user_id = $current_user->id;
                $oUTDocuSign->save();
                
                foreach ($aFinalRecipients as $key => $recipientDetails) {
                    $oSigner = BeanFactory::getBean("UT_DSSigners");
                    $oSigner->name = $recipientDetails["signer_name"];
                    $oSigner->recipient_email = $recipientDetails["signer_email"];
                    $oSigner->role = 'signer';
                    $oSigner->ut_dssigners_ut_docusignut_docusign_ida = $oUTDocuSign->id;
                    $oSigner->parent_id = $recipientDetails["cstm_sugar_id"];
                    $oSigner->parent_type = $recipientDetails["cstm_sugar_module"];
                    if ($recipientDetails["cstm_sugar_module"] == "Users") {
                        $oSigner->assigned_user_id = $recipientDetails["cstm_sugar_id"];
                    } else {
                        $oSigner->assigned_user_id = $current_user->id;
                    }
                    $oSigner->save();
                    
                    if (!empty($recipientDetails["cstm_sugar_id"]) && !empty($recipientDetails["cstm_sugar_module"])) {
                        $recordId = $recipientDetails["cstm_sugar_id"];
                        $module = $recipientDetails["cstm_sugar_module"];
                        $sRelationShipName = '';
                        if ($module == 'Accounts') {
                            $sRelationShipName = 'ut_docusign_accounts_1';
                            $oParObj = BeanFactory::getBean('Accounts', $recordId);
                        } elseif ($module == 'Contacts') {
                            $sRelationShipName='ut_docusign_contacts_1';
                            $oParObj = BeanFactory::getBean('Contacts', $recordId);
                        } elseif ($module == 'Leads') {
                            $sRelationShipName='ut_docusign_leads_1';
                            $oParObj = BeanFactory::getBean('Leads', $recordId);
                        } elseif ($module == 'Prospects') {
                            $sRelationShipName='ut_docusign_prospects_1';
                            $oParObj = BeanFactory::getBean('Prospects', $recordId);
                        } elseif ($module == 'Users') {
                            $sRelationShipName='ut_docusign_users_1';
                            $oParObj = BeanFactory::getBean('Users', $recordId);
                        } elseif ($module == 'AOS_Contracts') {
                            $sRelationShipName='ut_docusign_aos_contracts_1';
                            $oParObj = BeanFactory::getBean('AOS_Contracts', $recordId);
                        } elseif ($module == 'AOS_Quotes') {
                            $sRelationShipName='ut_docusign_aos_quotes_1';
                            $oParObj = BeanFactory::getBean('AOS_Quotes', $recordId);
                        }
                        if (!empty($sRelationShipName)) {
                            $oParObj->load_relationship($sRelationShipName);
                            if ($oParObj->$sRelationShipName->add($oUTDocuSign->id) == false) {
                                $GLOBALS['log']->fatal("Failed to associate (".$recordId.") with DocuSign (".$oUTDocuSign->id.")");
                            }
                        }
                    }
                }
                // When we submit application from demo to production. We need to stop makig calls to webhooks, and other extra calls, It use to give Polling error.
                if ($dsEnvironment != "submit_for_review") {
                    docusign_docupdate_cron($oUTDocuSign->id);
                }
            }
            $sMessageOut = $mod_strings['LBL_DOC_SENT_FOR_SIGNATURE'].' <a href="index.php?module=UT_DocuSign&action=DetailView&record='.$oUTDocuSign->id.'"> here</a>';
        }
    } else {
        $sMessageOut=$error_message;
    }
}
echo json_encode($sMessageOut);
