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
if (!defined('sugarEntry') || !sugarEntry) {
    die('Not A Valid Entry Point');
}

    require_once('modules/UT_DocuSign/DocuSignUtils.php');
    require_once('modules/UT_DocuSign/library/UT_DocuSignClient.php');
    require_once('modules/Notes/NoteSoap.php');
    global $db, $app_strings, $mod_strings,$current_user,$app_list_strings, $sugar_config,$timedate;
    // checking if current user is not admin then do not procced further
    $aReturn = array(
        'error' => '',
        'response' => '',
    );
    $isSetDocuSignKey = false;
    $aAppKeys = getApplicationKey();
    if (!empty($aAppKeys) && !empty($aAppKeys['host']) && !empty($aAppKeys['accountid'])) {
        $isSetDocuSignKey = true;
    }
    if ($isSetDocuSignKey == false) {
        $aReturn['error'] = 'Missing Docusign api keys';
        return $aReturn;
    }

    require_once('modules/ACLActions/ACLAction.php');
    if (!ACLAction::userHasAccess($current_user->id, 'UT_DocuSign', 'edit', 'module', true, true)) {
        $aReturn['error'] = $mod_strings['LBL_NOT_AUTHORIZED'];
        echo json_encode($aReturn);
        exit;
    }
    $SugarUserId = $current_user->id;
    $oDocuSignClient = new UT_DocuSignClient();
    if (!empty($_POST) && $_POST['sending_type'] == 'external_file' && !empty($_FILES)) {
        $sRSTemplateID = '';
        $guid = $sNewGuid = '';
        require_once("include/utils/sugar_file_utils.php");
        require_once("include/upload_file.php");
        $directoryName = "UT_DSUploads";
        $sFileName = $_FILES['uploadfiles']['name'];
        if (!sugar_is_file($directoryName) && !sugar_is_dir($directoryName)) {
            sugar_mkdir($directoryName, 0755, true);
        }
        $sFilePathName = $directoryName."/".$sFileName;
        if (!move_uploaded_file($_FILES['uploadfiles']['tmp_name'], $sFilePathName)) {
            $msg = "can't move_uploaded_file to $directoryName. You should try making the directory writable by the webserver";
            $GLOBALS['log']->fatal("ERROR: ".$msg);
            $aReturn['error'] = $msg;
            echo json_encode($aReturn);
            exit;
        }
        $iIsSMSSending = false;
        $iIsSMS_OTP_AuthSending = false;
        $recipients = array();
        $aFinalRecipients = $aFinalCC = array();
        foreach ($_REQUEST as $sKey => $sReqValue) {
            if (strpos($sKey, 'must_sign|||') !== false) {
                $aExplodedSigner = explode("|||", $sKey);
                if (!empty($aExplodedSigner[1])) {
                    $sOwnerName=htmlspecialchars($_POST['receipient_name___'.$aExplodedSigner[1]]);
                    $sOwnerEmail=$_POST['receipient_email___'.$aExplodedSigner[1]];
                    $sOwnerPhone = $_POST['receipient_phone___'.$aExplodedSigner[1]]; // SMS
                    if ($sReqValue == '1') {
                        $aTempRoles=array();
                        //$aTempRoles['name'] = $sReqValue;
                        $aTempRoles['name'] = 'signer';
                        $aTempRoles['signer_name'] = $sOwnerName;
                        $aTempRoles['signer_email'] = $sOwnerEmail;
                        //BEGINS: Added by Urdhva Tech SMS
                        if(!empty($oDocuSignClient->is_sms_auth) && !empty($_REQUEST['sending_option']) && ($_REQUEST['sending_option'] == 'sms_auth' )){ //|| $_REQUEST['sending_option'] == 'email_sms'
                            $aTempRoles['signer_phone'] = $sOwnerPhone; // SMS
                            //$iIsSMSSending = false;
                            $iIsSMS_OTP_AuthSending = true;
                            //$aTempRoles['sms_sending'] = false;
                            $aTempRoles['sms_otp_auth'] = true;
                        }
                        //ENDS: Added by Urdhva Tech SMS
                        $aTempRoles['cstm_roletype'] = $aExplodedSigner[0];
                        $sTmpSugarId=$sTmpSugarMod='';
                        if (!empty($_POST['sugar_module___'.$aExplodedSigner[1]]) && !empty($_POST['sugar_module_id___'.$aExplodedSigner[1]])) {
                            $sTmpSugarId = $_POST['sugar_module_id___'.$aExplodedSigner[1]];
                            $sTmpSugarMod = $_POST['sugar_module___'.$aExplodedSigner[1]];
                        }
                        $aTempRoles['cstm_sugar_id'] = $sTmpSugarId;
                        $aTempRoles['cstm_sugar_module'] = $sTmpSugarMod;
                        $aFinalRecipients[]=$aTempRoles;
                        if (!empty($_POST['sugar_module___'.$aExplodedSigner[1]]) && !empty($_POST['sugar_module_id___'.$aExplodedSigner[1]])) {
                            $aSugarRecordInfo[] = array(
                                'role' =>'signer',
                                'name' => $sOwnerName,
                                'email' => $sOwnerEmail,
                                'phone' => $sOwnerPhone,
                                'parent_id' => $_POST['sugar_module_id___'.$aExplodedSigner[1]],
                                'parent_type' => $_POST['sugar_module___'.$aExplodedSigner[1]],
                            );
                        } else {
                            $aSugarRecordInfo[] = array(
                                'role' =>'signer',
                                'name' => $sOwnerName,
                                'email' => $sOwnerEmail,
                                'phone' => $sOwnerPhone,
                                'parent_id' => '',
                                'parent_type' => '',
                            );
                        }
                    } else {
                        $sOwnerName=htmlspecialchars($_POST['receipient_name___'.$aExplodedSigner[1]]);
                        $sOwnerEmail=$_POST['receipient_email___'.$aExplodedSigner[1]];
                        $sOwnerPhone=$_POST['receipient_phone___'.$aExplodedSigner[1]]; // SMS
                        $aTempRoles=array();
                        $aTempRoles['name'] = 'cc';
                        $aTempRoles['signer_name'] = $sOwnerName;
                        $aTempRoles['signer_email'] = $sOwnerEmail;
                        //BEGINS: Added by Urdhva Tech SMS
                        if(!empty($oDocuSignClient->is_sms_auth) && !empty($_REQUEST['sending_option']) && ($_REQUEST['sending_option'] == 'sms_auth')){ //|| $_REQUEST['sending_option'] == 'email_sms'
                            $aTempRoles['signer_phone'] = $sOwnerPhone; // SMS
                            //$iIsSMSSending = false;
                            $iIsSMS_OTP_AuthSending = true;
                            //$aTempRoles['sms_sending'] = false;
                            $aTempRoles['sms_otp_auth'] = true;
                        }
                        //ENDS: Added by Urdhva Tech SMS
                        $aTempRoles['cstm_roletype'] = $aExplodedSigner[0];
                        $sTmpSugarId=$sTmpSugarMod='';
                        if (!empty($_POST['sugar_module___'.$aExplodedSigner[1]]) && !empty($_POST['sugar_module_id___'.$aExplodedSigner[1]])) {
                            $sTmpSugarId = $_POST['sugar_module_id___'.$aExplodedSigner[1]];
                            $sTmpSugarMod = $_POST['sugar_module___'.$aExplodedSigner[1]];
                        }
                        $aTempRoles['cstm_sugar_id'] = $sTmpSugarId;
                        $aTempRoles['cstm_sugar_module'] = $sTmpSugarMod;
                        $aFinalCC[]=$aTempRoles;
                        if (!empty($_POST['sugar_module___'.$aExplodedSigner[1]]) && !empty($_POST['sugar_module_id___'.$aExplodedSigner[1]])) {
                            $aSugarRecordInfo[] = array(
                                    'role' =>'cc',
                                    'name' => $sOwnerName,
                                    'email' => $sOwnerEmail,
                                    'phone' => $sOwnerPhone,
                                    'parent_id' => $_POST['sugar_module_id___'.$aExplodedSigner[1]],
                                    'parent_type' => $_POST['sugar_module___'.$aExplodedSigner[1]],
                                );
                        } else {
                            $aSugarRecordInfo[] = array(
                                    'role' =>'cc',
                                    'name' => $sOwnerName,
                                    'email' => $sOwnerEmail,
                                    'phone' => $sOwnerPhone,
                                    'parent_id' => '',
                                    'parent_type' => '',
                                );
                        }
                    }
                }
            }
        }
        $file_data = array(
                        'name' => $sFileName,
                        'source' => 'upload',
                     );
        $sDocumentName = $_POST['subject'];
        $sMessage = $_POST['message'];
        //$tags = array();
        $doc_callback_url = $sugar_config['site_url'].'/index.php?entryPoint=DSPushServiceCallback';
        $file = new SplFileInfo($sFilePathName);
        $ext  = $file->getExtension();
        $oDocuSignClient->setDocumentFileName($sFilePathName);//"/Docs/SignTest1.pdf";
        $oDocuSignClient->setDocumentName($sFileName);//"SignTest1.docx";
        $oDocuSignClient->setDocumentExtension($ext);//".docx .pdf .doc";
        $oDocuSignClient->setCstmSigners($aFinalRecipients);
        $oDocuSignClient->setCstmCarbonCopy($aFinalCC);
        // Note: callbackurl should be HTTPS, Only then it will work
        if (strpos($sugar_config['site_url'], 'https://') !== false) {
            $oDocuSignClient->setCstmEnvelopWebHookURL($doc_callback_url); //The URL will receive a POST for each of the following document events: created, viewed, signed, executed. Note that due to the asynchronous nature of processing, the order in which the document callbacks are sent is not guaranteed
        } else {
            //echo "The string https was not found in the string ".$sugar_config['site_url'];
        }
        $oDocuSignClient->setCstmEmailSubject($_POST['subject']);
        $oDocuSignClient->setCstmEmailBlurb($_POST['message']);
        
        $args = array();
        //$args['encodedPayload'] = base64_encode(serialize($aSugarRecordInfo));
        $args['crmfile'] = $sFileName;
        $sSenderViewReturnURL = $sugar_config['site_url'].'/index.php?entryPoint=DS_ResponseOfSenderView&'. http_build_query($args);
        $oDocuSignClient->setCstmSenderViewReturnURL($sSenderViewReturnURL);
        $aResp = $oDocuSignClient->CreateEmbeddedSendingView();
        if (!empty($aResp['error'])) {
            $aReturn['error']= $aResp['error'];
            echo json_encode($aReturn);
            return;
        }
        if (!empty($aResp['response'])) {
            $sNewCreatedEnvelopeId = $oDocuSignClient->getCreatedEnvelopeId();
            $sNewGuid = $sNewCreatedEnvelopeId;
            $oUTDocuSign = BeanFactory::getBean('UT_DocuSign');
            $id = create_guid();
            $oUTDocuSign->new_with_id = true;
            $oUTDocuSign->id = $id;
            $oUTDocuSign->document_name = 'RS : ';
            $oUTDocuSign->sending_type = $_POST['sending_type'];
            $oUTDocuSign->sending_option = $_POST['sending_option']; // SMS
            // This is the sending id, Based on this we will receive a callback from RS once the document is created. So directly getting Document Details is not possible.
            $oUTDocuSign->rs_doc_id = $sNewGuid;
            $oUTDocuSign->recipient_name = '-- Multiple Recipient --';
            $oUTDocuSign->email_address = '-- Multiple Recipient --';
            $oUTDocuSign->subject = $sDocumentName;
            $oUTDocuSign->message = $sMessage;
            $oUTDocuSign->assigned_user_id = $SugarUserId;
            $oUTDocuSign->save();
            if (!empty($aSugarRecordInfo)) {
                foreach ($aSugarRecordInfo as $field_value) {
                    $oSigner = BeanFactory::getBean("UT_DSSigners");
                    $oSigner->name = $field_value['name'];
                    $oSigner->recipient_email = $field_value['email'];
                    $oSigner->role = $field_value['role'];
                    $oSigner->ut_dssigners_ut_docusignut_docusign_ida = $oUTDocuSign->id;
                    if (!empty($field_value['parent_id'])) {
                        $oSigner->parent_id = $field_value['parent_id'];
                    }
                    if (!empty($field_value['parent_type'])) {
                        $oSigner->parent_type = $field_value['parent_type'];
                    }
                    $oSigner->assigned_user_id = $SugarUserId;
                    $oSigner->save();
                    
                    if (!empty($field_value['parent_id']) && !empty($field_value['parent_type'])) {
                        $sRelationShipName = '';
                        if ($field_value['parent_type'] == 'Accounts') {
                            $sRelationShipName = 'ut_docusign_accounts_1';
                            $oParObj = BeanFactory::getBean('Accounts', $field_value['parent_id']);
                        } elseif ($field_value['parent_type'] == 'Contacts') {
                            $sRelationShipName='ut_docusign_contacts_1';
                            $oParObj = BeanFactory::getBean('Contacts', $field_value['parent_id']);
                        } elseif ($field_value['parent_type'] == 'Leads') {
                            $sRelationShipName='ut_docusign_leads_1';
                            $oParObj = BeanFactory::getBean('Leads', $field_value['parent_id']);
                        } elseif ($field_value['parent_type'] == 'Prospects') {
                            $sRelationShipName='ut_docusign_prospects_1';
                            $oParObj = BeanFactory::getBean('Prospects', $field_value['parent_id']);
                        } elseif ($field_value['parent_type'] == 'Users') {
                            $sRelationShipName='ut_docusign_users_1';
                            $oParObj = BeanFactory::getBean('Users', $field_value['parent_id']);
                        } elseif ($field_value['parent_type'] == 'AOS_Contracts') {
                            $sRelationShipName='ut_docusign_aos_contracts_1';
                            $oParObj = BeanFactory::getBean('AOS_Contracts', $field_value['parent_id']);
                        } elseif ($field_value['parent_type'] == 'AOS_Quotes') {
                            $sRelationShipName='ut_docusign_aos_quotes_1';
                            $oParObj = BeanFactory::getBean('AOS_Quotes', $field_value['parent_id']);
                        }
                        if (!empty($sRelationShipName)) {
                            $oParObj->load_relationship($sRelationShipName);
                            if ($oParObj->$sRelationShipName->add($oUTDocuSign->id) == false) {
                                $GLOBALS['log']->fatal("Failed to associate (".$field_value['parent_id'].") with DocuSign (".$oUTDocuSign->id.")");
                            }
                        }
                    }
                }
            }
            // Show the iframe with docusign UI
            $sIframe = '<iframe id="myIframe" src="'.$aResp['response'].'" width="100%" height="700px" frameborder="0" allowtransparency="true"></iframe>';
            $aReturn['response'] = $sIframe;
            echo json_encode($aReturn);
            exit;
        } else {
            $aReturn['error'] = $mod_strings['LBL_NOT_AUTHORIZED'];
            echo json_encode($aReturn);
            exit;
        }
    } else {
        $aReturn['error'] = $mod_strings['LBL_NOT_AUTHORIZED'];
        echo json_encode($aReturn);
        exit;
    }
