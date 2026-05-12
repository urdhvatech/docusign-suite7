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
require_once('modules/DocumentRevisions/DocumentRevision.php');

    global $db, $app_strings, $mod_strings,$current_user,$app_list_strings, $sugar_config,$timedate;
    // checking if current user is not admin then do not procced further
    if (!checkDocuSignLicense()) {
        $msg = "Invalid License";
        SugarApplication::appendErrorMessage($msg);
        SugarApplication::redirect('index.php?module=UT_DocuSign&action=license');
        exit;
    }
    
    $isSetDocuSignKey = false;
    $aAppKeys = getApplicationKey();
    if (!empty($aAppKeys) && !empty($aAppKeys['host']) && !empty($aAppKeys['accountid'])) {
        $isSetDocuSignKey = true;
    }
    if ($isSetDocuSignKey == false) {
        SugarApplication::redirect('index.php?module=UT_DocuSign&action=DocuSignAppKeys');
        exit;
    }
    require_once('modules/ACLActions/ACLAction.php');
    if (!ACLAction::userHasAccess($current_user->id, 'UT_DocuSign', 'edit', 'module', true, true)) {
        echo $mod_strings['LBL_NOT_AUTHORIZED'];
        return;
    }

    $sugar_smarty   = new Sugar_Smarty();
    $SugarUserId = $current_user->id;
    $oDocuSignClient = new UT_DocuSignClient();
    if (!empty($_POST) && $_POST['sending_type'] == 'select_template') {
        $sRSTemplateID = '';
        $guid = $sNewGuid = '';
        $sDocumentName = $_POST['subject'];
        $sSharedWith = array();
        $sMessage = $_POST['message'];
        $bInPerson = null;
        // Note: callbackurl should be HTTPS, Only then it will work
        $sCallbackURL = $sugar_config['site_url'].'/index.php?entryPoint=DSPushServiceCallback';
        $merge_field_values = array();
        $aRoles = array();
        if (!empty($_POST['expires_in'])) {
            $iExpiresIn = $_POST['expires_in'];
        } else {
            $iExpiresIn = 30;
        }
        $iPin = null;
        $aTags = array();
        $iIsSMSSending = false;
        $iIsSMS_OTP_AuthSending = false;
        $workflow_id = '';
        $aSigners = $aCarbonCopy = $aInPersonSigners = array();
        $aSugarRecordInfo = array();
        
        $aFinalMergeField = array();
        $aFinalRoles = array();
        $aCCReceipients=array();
    
        if (!empty($_POST['rs_template_id'])) {
            $sRSTemplateID = $_POST['rs_template_id'];
            $guid = $_POST['rs_template_id'];
            //$signer_sequencing = $_POST['signer_sequencing'];
            //BEGINS: Added by Urdhva Tech: For SMS OTP authentication before signing
            if(!empty($oDocuSignClient->is_sms_auth) && !empty($_REQUEST['sending_option']) && ($_REQUEST['sending_option'] == 'sms_auth')){ //|| $_REQUEST['sending_option'] == 'email_sms'
                //$iIsSMSSending = true;
                $iIsSMS_OTP_AuthSending = true;
            }
            //ENDS: Added by Urdhva Tech: For SMS OTP authentication before signing
            foreach ($_REQUEST as $sKey => $sReqValue) 
            {
                if (strpos($sKey, 'role|||') !== false || strpos($sKey, 'inperson|||') !== false || strpos($sKey, 'cc|||') !== false) {
                    $aExplodedRole = explode("|||", $sKey);
                    if (!empty($aExplodedRole[1])) {
                        $sOwnerName=htmlspecialchars($_POST['receipient_name___'.$aExplodedRole[1]]);
                        $sOwnerEmail=$_POST['receipient_email___'.$aExplodedRole[1]];
                        $sOwnerPhone = $_POST['receipient_phone___'.$aExplodedRole[1]]; // Added by Urdhva Tech SMS
                        $aTempRoles = array();
                        $aTempRoles['name'] = $sReqValue;
                        $aTempRoles['signer_name'] = $sOwnerName;
                        $aTempRoles['signer_email'] = $sOwnerEmail;
                        //BEGINS: Added by Urdhva Tech: For SMS OTP authentication before signing
                        //if($iIsSMSSending == true){
                            //$aTempRoles['signer_phone'] = $sOwnerPhone; // SMS
                            //unset($aTempRoles['signer_email']);
                        //}
                        if($iIsSMS_OTP_AuthSending == true){
                            $aTempRoles['signer_phone'] = $sOwnerPhone;
                        }
                        //ENDS: Added by Urdhva Tech: For SMS OTP authentication before signing
                        $aTempRoles['cstm_roletype'] = $aExplodedRole[0];
                        $sTmpSugarId=$sTmpSugarMod='';
                        if (!empty($_POST['sugar_module___'.$aExplodedRole[1]]) && !empty($_POST['sugar_module_id___'.$aExplodedRole[1]])) {
                            $sTmpSugarId = $_POST['sugar_module_id___'.$aExplodedRole[1]];
                            $sTmpSugarMod = $_POST['sugar_module___'.$aExplodedRole[1]];
                        }
                        $aTempRoles['cstm_sugar_id'] = $sTmpSugarId;
                        $aTempRoles['cstm_sugar_module'] = $sTmpSugarMod;
                        //$aTempRoles['is_sender'] = $bIsSigner;
                        //if(!empty($signer_sequencing)){
                        $sSequenceNumber = 'sequence|||'.$aExplodedRole[1];
                        $aTempRoles['sequence'] = $_REQUEST[$sSequenceNumber];
                        $aTempRoles['rout_sequence'] = $aExplodedRole[1];
                        //}
                        if ($aExplodedRole[0] == 'inperson') {
                            $aTempRoles['in_person_signer_name'] = $_REQUEST['host_name___'.$aExplodedRole[1]];
                        }
                        $aTempRoles['message'] = $_REQUEST['message'];
                        $aFinalRoles[$sSequenceNumber]=$aTempRoles;
                        if (!empty($_POST['sugar_module___'.$aExplodedRole[1]]) && !empty($_POST['sugar_module_id___'.$aExplodedRole[1]])) {
                            $aSugarRecordInfo[] = array(
                                'role' =>$sReqValue,
                                'name' => $sOwnerName,
                                'email' => $sOwnerEmail,
                                'phone' => $sOwnerPhone, // SMS
                                'parent_id' => $_POST['sugar_module_id___'.$aExplodedRole[1]],
                                'parent_type' => $_POST['sugar_module___'.$aExplodedRole[1]],
                            );
                        }
                    }
                }
            }
            //if(!empty($aFinalMergeField)){
            //$merge_field_values=$aFinalMergeField;
            //}
            if (!empty($aFinalRoles)) {
                $aRoles=$aFinalRoles;
            }
            try {
                $oDocuSignClient = new UT_DocuSignClient();
                $dsEnvironment = $oDocuSignClient->getDSEnvironment();
                //BEGINS: Added by Urdhva Tech: For SMS OTP authentication before signing
                if(!empty($oDocuSignClient->is_sms_auth) && !empty($_REQUEST['sending_option']) && ($_REQUEST['sending_option'] == 'sms_auth')) 
                {
                    $oAccountsAPI = new DocuSign\eSign\Api\AccountsApi($oDocuSignClient->getApiClient());
                    $oIdentityVerificationOptions = new DocuSign\eSign\Api\AccountsApi\GetAccountIdentityVerificationOptions();
                    $oIdentityVerificationOptions->setIdentityVerificationWorkflowStatus('all');
                    $oIdentityVerifation = $oAccountsAPI->getAccountIdentityVerification($oDocuSignClient->getAccountId(),$oIdentityVerificationOptions);
                    $aIdentityVerification = $oIdentityVerifation->getIdentityVerification();
                    
                    if(!empty($aIdentityVerification))
                    {
                        foreach($aIdentityVerification as $oIdentityVeri)
                        {
                            if($oIdentityVeri->getWorkflowLabel() == 'Phone Auth'){
                                $workflow_id = $oIdentityVeri->getWorkflowId();
                            }
                        }
                    }
                    if(empty($workflow_id)){
                        $sDesc =  'Identitiy Verifcation workflow for Phone Authentication is not enabled. You should update your DocuSign plan for allowing Phone Authentication.<br/>';
                        $_SESSION['urdhvadocusign']['errormsg'] = $sDesc;
                        //throw new Exception($sDesc);
                        SugarApplication::appendErrorMessage(HtmlSpecialChars($sDesc));
                        SugarApplication::redirect('index.php?module=UT_DocuSign&action=SendDocumentRS');
                        exit;
                    }
                }
                
                //ENDS: Added by Urdhva Tech: For SMS OTP authentication before signing
                //*** STEP 2 - Signature Request from a Template
                // create envelope call is available in the EnvelopesApi
                $envelopeApi = new DocuSign\eSign\Api\EnvelopesApi($oDocuSignClient->getApiClient());
                if (!empty($aRoles)) {
                    $aTemplateRole = array();
                    $aRespEnv = $oDocuSignClient->getTemplateDetails($sRSTemplateID);
                    $oEnvelopeTemplate='';
                    if (empty($aRespEnv['error']) && !empty($aRespEnv['response'])) {
                        $oEnvelopeTemplate = $aRespEnv['response'];
                    }
                    foreach ($aRoles as $sRk => $aRole) {
                        // assign recipient to template role by setting name, email, and role name.  Note that the
                        // template role name must match the placeholder role name saved in your account template.
                        $templateRole = new  DocuSign\eSign\Model\TemplateRole();
                        $templateRole->setName($aRole['signer_name']);
                        $templateRole->setRoleName($aRole['name']);
                        //BEGINS: Added by Urdhva Tech: For SMS OTP authentication before signing
                        if($iIsSMS_OTP_AuthSending == true && !empty($aRole['signer_phone']))
                        {
                            $SignerCountryCode = !empty($sugar_config['docusign_sms_country_code']) ? $sugar_config['docusign_sms_country_code'] : '1';
                            $signer_country_code = preg_replace('/([^\w \-\@\.\,])+/', '', $SignerCountryCode);
                            $aRole['signer_phone'] = preg_replace('/([^\w \-\@\.\,])+/', '', $aRole['signer_phone']);
                            $delivery_method = 'email';
                            $signerPhone = new DocuSign\eSign\Model\RecipientPhoneNumber([
                                'country_code' => $signer_country_code,
                                'number' => $aRole['signer_phone']
                            ]);
                            $templateRole->setDeliveryMethod($delivery_method); // Added by Urdhva Tech EMAIL
                            $templateRole->setEmail($aRole['signer_email']);
                            
                            $aRoutingAndUniqueTmp = explode('_', $aRole['rout_sequence']);
                            $sSequenceNumberTmp = $aRoutingAndUniqueTmp[0];
                            $signer = new \DocuSign\eSign\Model\Signer();
                            $signer->setEmail($aRole['signer_email']);
                            $signer->setName($aRole['signer_name']);
                            $signer->setRoutingOrder($sSequenceNumberTmp);
                            //$signer->setRoleName($aRole['cstm_roletype']);
                            $signer->setRoleName($aRole['name']);
                            
                            $phoneNumber = new DocuSign\eSign\Model\RecipientIdentityPhoneNumber();
                            $phoneNumber->setCountryCode($signer_country_code);
                            $phoneNumber->setNumber($aRole['signer_phone']);

                            $inputOption = new DocuSign\eSign\Model\RecipientIdentityInputOption();
                            $inputOption->setName('phone_number_list');
                            $inputOption->setValueType('PhoneNumberList');
                            $inputOption->setPhoneNumberList(array($phoneNumber));

                            $identityVerification = new DocuSign\eSign\Model\RecipientIdentityVerification();
                            $identityVerification->setWorkflowId($workflow_id);
                            $identityVerification->setInputOptions(array($inputOption));
                            
                            $delivery_method = 'email';
                            $signer->setDeliveryMethod($delivery_method);
                            $signer->setIdentityVerification($identityVerification);
                            $signer->setRecipientId($sSequenceNumberTmp);
                        }
                        else if($iIsSMSSending == true && !empty($aRole['signer_phone']))
                        {
                            /*
                            $aRole['signer_phone'] = preg_replace('/([^\w \-\@\.\,])+/', '', $aRole['signer_phone']);
                            $delivery_method = 'sms';
                            unset($aRole['signer_email']);
                            $SMSDelivery = new DocuSign\eSign\Model\RecipientAdditionalNotification();
                            $SMSDelivery->setSecondaryDeliveryMethod("SMS");
                            $signerPhone = new DocuSign\eSign\Model\RecipientPhoneNumber([
                                'country_code' => '1',
                                'number' => $aRole['signer_phone']
                            ]);
                            $SMSDelivery->setPhoneNumber($signerPhone);
                            //$templateRole->setAdditionalNotifications($SMSDelivery);
                            $templateRole->setDeliveryMethod($delivery_method);
                            $templateRole->setPhoneNumber($signerPhone);
                            */
                        }  //ENDS: Added by Urdhva Tech: For SMS OTP authentication before signing
                        else
                        {
                            $templateRole->setEmail($aRole['signer_email']);
                        }
                        
                        //$aRoutingAndUnique = explode('_',$aRole['sequence']);
                        $aRoutingAndUnique = explode('_', $aRole['rout_sequence']);
                        $sSequenceNumber = $aRoutingAndUnique[0];
                        
                        $templateRole->setRoutingOrder($sSequenceNumber);
                        if (!empty($aRole['in_person_signer_name'])) {
                            $templateRole->setInPersonSignerName($aRole['in_person_signer_name']);
                        }
                        // BEGIN: Parse field to template
                        if (!empty($aRole['name']) && !empty($aRole['cstm_roletype']) && !empty($aRole['cstm_sugar_id']) && !empty($aRole['cstm_sugar_module'])) {
                            //$aListAllTabs = $oDocuSignClient->getParsedTabsToSend($_POST['rs_template_id'],$aRole['name'],$aRole['cstm_roletype'],$aRole['cstm_sugar_id'],$aRole['cstm_sugar_module']);
                            $aCRMRolesData = array();
                            $aCRMRowData = array();
                            // CRM To Docusign mapping
                            if (!empty($_REQUEST['map_crmtodocusign'])) {
                                $sSQLMapping = "select id, crmroledata, crmrowdata FROM ut_dsfieldmapping WHERE deleted=0 AND id='".$_REQUEST['map_crmtodocusign']."'";
                                $oResMapp = $db->query($sSQLMapping);
                                $aDsMapRow = $db->fetchByAssoc($oResMapp);
                                if (!empty($aDsMapRow)) {
                                    $aCRMRolesData = unserialize(base64_decode($aDsMapRow['crmroledata']));
                                    $aCRMRowData = unserialize(base64_decode($aDsMapRow['crmrowdata']));
                                }
                                $aListAllTabs = $oDocuSignClient->getParsedTabsToSend($_POST['rs_template_id'], $oEnvelopeTemplate, $aRole, $aCRMRolesData, $aCRMRowData);
                                if (!empty($aListAllTabs['response'])) {
                                    $oTabs = new DocuSign\eSign\Model\Tabs();

                                    foreach ($aListAllTabs['response'] as $sTabType => $aTabs) {
                                        if ($sTabType == 'TextTabs') {
                                            $oTabs->setTextTabs($aTabs);
                                        } elseif ($sTabType == 'RadioGroupTabs') {
                                            $oTabs->setRadioGroupTabs($aTabs);
                                        } elseif ($sTabType == 'CheckboxTabs') {
                                            $oTabs->setCheckboxTabs($aTabs);
                                        } elseif ($sTabType == 'DateTabs') {
                                            $oTabs->setDateTabs($aTabs);
                                        } elseif ($sTabType == 'EmailTabs') {
                                            $oTabs->setEmailTabs($aTabs);
                                        } elseif ($sTabType == 'ListTabs') {
                                            $oTabs->setListTabs($aTabs);
                                        } elseif ($sTabType == 'NoteTabs') {
                                            $oTabs->setNoteTabs($aTabs);
                                        } elseif ($sTabType == 'NumberTabs') {
                                            $oTabs->setNumberTabs($aTabs);
                                        } elseif ($sTabType == 'SSNTabs') {
                                            $oTabs->setSSNTabs($aTabs);
                                        } elseif ($sTabType == 'ZipTabs') {
                                            $oTabs->setZipTabs($aTabs);
                                        }
                                    }
                                    $templateRole->setTabs($oTabs);
                                    //BEGINS: Added by Urdhva Tech: For SMS OTP authentication before signing
                                    if($iIsSMS_OTP_AuthSending == true && !empty($aRole['signer_phone'])) {
                                        //$signer->setTabs($oTabs);
                                    }
                                    //ENDS: Added by Urdhva Tech: For SMS OTP authentication before signing
                                }
                            }
                        }
                        // ENDS: Parse field to template
                        //BEGIN: Fill the custom field values from CRM
                        //https://github.com/docusign/docusign-csharp-client/issues/75
                        //ENDS: Fill the custom field values from CRM
                        $aTemplateRole[] = $templateRole;
                        //BEGINS: Added by Urdhva Tech: For SMS OTP authentication before signing
                        if($iIsSMS_OTP_AuthSending == true && !empty($aRole['signer_phone']))
                        {
                            if($aRole['cstm_roletype'] == 'role') {
                                array_push($aSigners, $signer);
                            }
                            else if($aRole['cstm_roletype'] == 'cc') {
                                array_push($aCarbonCopy, $signer);
                            }
                            else if($aRole['cstm_roletype'] == 'inperson') {
                                array_push($aInPersonSigners, $signer);
                            }
                        }
                        //ENDS: Added by Urdhva Tech: For SMS OTP authentication before signing
                    }
                }
                //BEGINS: Added by Urdhva Tech: For SMS OTP authentication before signing
                $recipients = new DocuSign\eSign\Model\Recipients();
                if (!empty($aSigners))
                    $recipients->setSigners($aSigners);
                if (!empty($aCarbonCopy))
                    $recipients->setCarbonCopies($aCarbonCopy);
                //ENDS: Added by Urdhva Tech: For SMS OTP authentication before signing
                
                // instantiate a new envelope object and configure settings
                //$sEnvelopeId = create_guid();
                $envelop_definition = new DocuSign\eSign\Model\EnvelopeDefinition();
                $envelop_definition->setEmailSubject($sDocumentName);
                $envelop_definition->setEmailBlurb($sMessage);
                $envelop_definition->setTemplateId($guid);
                //$envelop_definition->setEnvelopeId($sEnvelopeId);
                if (!empty($aTemplateRole)) {
                    $envelop_definition->setTemplateRoles($aTemplateRole);
                }
                
                // When we submit application from demo to production. We need to stop makig calls to webhooks, and other extra calls, It use to give Polling error.
                if ($dsEnvironment != "submit_for_review") {
                    $deliveredEnvelopeEvent = new \DocuSign\eSign\Model\EnvelopeEvent();
                    $deliveredEnvelopeEvent->setEnvelopeEventStatusCode('delivered');
                    $completedEnvelopeEvent = new \DocuSign\eSign\Model\EnvelopeEvent();
                    $completedEnvelopeEvent->setEnvelopeEventStatusCode('completed');
                    $declinedEnvelopeEvent = new \DocuSign\eSign\Model\EnvelopeEvent();
                    $declinedEnvelopeEvent->setEnvelopeEventStatusCode('declined');
                    $voidedEnvelopeEvent = new \DocuSign\eSign\Model\EnvelopeEvent();
                    $voidedEnvelopeEvent->setEnvelopeEventStatusCode('voided');
                    
                    $envelopeEvents = array(
                        $deliveredEnvelopeEvent,
                        $completedEnvelopeEvent,
                        $declinedEnvelopeEvent,
                        $voidedEnvelopeEvent,
                    );
                    
                    $recipient_events = array(
                        (new \DocuSign\eSign\Model\RecipientEvent())->setRecipientEventStatusCode("Sent"),
                        (new \DocuSign\eSign\Model\RecipientEvent())->setRecipientEventStatusCode("Delivered"),
                        (new \DocuSign\eSign\Model\RecipientEvent())->setRecipientEventStatusCode("Completed"),
                        (new \DocuSign\eSign\Model\RecipientEvent())->setRecipientEventStatusCode("Declined"),
                        (new \DocuSign\eSign\Model\RecipientEvent())->setRecipientEventStatusCode("AuthenticationFailed"),
                        (new \DocuSign\eSign\Model\RecipientEvent())->setRecipientEventStatusCode("AutoResponded")
                    );
                    
                    $eventNotification = new \DocuSign\eSign\Model\EventNotification();
                    //create the notification object for this new envelope
                    if (strpos($sugar_config['site_url'], 'https://') !== false) {
                        $eventNotification->setUrl($sCallbackURL);//The URL will receive a POST for each of the following document events: created, viewed, signed, executed. Note that due to the asynchronous nature of processing, the order in which the document callbacks are sent is not guaranteed
                    } else {
                        //echo "The string https was not found in the string ".$sugar_config['site_url'];
                    }
                    $eventNotification->setLoggingEnabled("false");
                    $eventNotification->setRequireAcknowledgment("false");
                    $eventNotification->setUseSoapInterface("false");
                    $eventNotification->setIncludeCertificateWithSoap("false");
                    $eventNotification->setSignMessageWithX509Cert("false");
                    $eventNotification->setIncludeDocuments("false");// incoming messages might be too large.
                    $eventNotification->setIncludeEnvelopeVoidReason("false");
                    $eventNotification->setIncludeTimeZone("false");
                    $eventNotification->setIncludeSenderAccountAsCustomField("false");
                    $eventNotification->setIncludeDocumentFields("false");
                    $eventNotification->setIncludeCertificateOfCompletion("false");// only used with Connect and not on Notifications like this
                    $eventNotification->setEnvelopeEvents($envelopeEvents);
                    //$eventNotification->setRecipientEvents(array());
                    $eventNotification->setRecipientEvents($recipient_events);
                    $envelop_definition->setEventNotification($eventNotification);
                }
                
                // set envelope status to "sent" to immediately send the signature request
                //BEGINS: Added by Urdhva Tech: For SMS OTP authentication before signing
                if($iIsSMS_OTP_AuthSending == true)
                {
                    //The workaround is to create a draft envelope with the templateId and templateRoles attributes and then use the EnvelopeRecipients:update method to update the recipient object(s) with recipientAdditionalNotification objects for SMS Delivery. 
                    //Include the roleName attribute in the update, and then update the envelope to start processing by changing the status attribute to sent.
                    $envelop_definition->setStatus("created"); // creates it as a draft 
                    
                    $options = new \DocuSign\eSign\Api\EnvelopesApi\CreateEnvelopeOptions();
                    $options->setCdseMode(null);
                    $options->setMergeRolesOnDraft(null);
                    $envelop_summary = $envelopeApi->createEnvelope($oDocuSignClient->getAccountId(), $envelop_definition, $options);
                    if (!empty($envelop_summary)) {
                        $sNewGuid = $envelop_summary->getEnvelopeId();
                    }
                    sleep(2);
                    //Not sure if the API changed since 2016 or if it's something else but I had to pass a 4th parameter to the UpdateRecipients method. var recSummary = envelopesApi.UpdateRecipients(apiToken.Account.AccountId, envelopeID.ToString(), recipient, new UpdateRecipientsOptions() { resendEnvelope = "true"});
                    // Get recipients and update them
                    $envelop_definition->setRecipients($recipients);
                    $oRecipients = $envelop_definition->getRecipients();
                    $envelop_definition->setStatus("sent");
                    $oRecipientsOptions = (new DocuSign\eSign\Api\EnvelopesApi\UpdateRecipientsOptions())->setResendEnvelope('true');
                    $envelopeApi->updateRecipients($oDocuSignClient->getAccountId(), $sNewGuid, $oRecipients, $oRecipientsOptions);
                    
                    //$options1 = new DocuSign\eSign\Api\EnvelopesApi\UpdateOptions();
                    //$options1->setResendEnvelope("true");
                    //$oEnvelopeUpdateSummary = $envelopeApi->update($oDocuSignClient->getAccountId(), $sNewGuid, $envelop_definition, $options1);
                    $oEnvelopeUpdateSummary = $envelopeApi->update($oDocuSignClient->getAccountId(), $sNewGuid, $envelop_definition);
                    if (!empty($oEnvelopeUpdateSummary->getErrorDetails())) {
                        $GLOBALS['log']->fatal('Docusign: '.print_r($oEnvelopeUpdateSummary->getErrorDetails(),true));
                    }
                }
                else if($iIsSMSSending == true)
                {
                    //$envelop_definition->setStatus("created"); // creates it as a draft //BEGINS: Added by Urdhva Tech SMS
                    //$envelop_definition->setStatus("sent");
                    //sleep(2);
                    //Not sure if the API changed since 2016 or if it's something else but I had to pass a 4th parameter to the UpdateRecipients method. var recSummary = envelopesApi.UpdateRecipients(apiToken.Account.AccountId, envelopeID.ToString(), recipient, new UpdateRecipientsOptions() { resendEnvelope = "true"});
                    // Get recipients and update them
                    //$oRecipients = $envelop_definition->getRecipients();
                    //$envelopeApi->updateRecipients($account_id, $envelope_id, $recipients = null, \DocuSign\eSign\Api\EnvelopesApi\UpdateRecipientsOptions $options = null)
                    //$oRecipientsOptions = (new DocuSign\eSign\Api\EnvelopesApi\UpdateRecipientsOptions())->setResendEnvelope(true);
                    //$envelopeApi->updateRecipients($oDocuSignClient->getAccountId(), $guid, $recipients = null, $oRecipientsOptions);
                }  //ENDS: Added by Urdhva Tech: For SMS OTP authentication before signing
                else 
                {
                    $envelop_definition->setStatus("sent");
                    // optional envelope parameters
                    $options = new \DocuSign\eSign\Api\EnvelopesApi\CreateEnvelopeOptions();
                    $options->setCdseMode(null);
                    $options->setMergeRolesOnDraft(null);

                    // create and send the envelope (aka signature request)
                    $oEnvelopeSummary = $envelopeApi->createEnvelope($oDocuSignClient->getAccountId(), $envelop_definition, $options);
                    if (!empty($oEnvelopeSummary)) {
                        $sNewGuid = $oEnvelopeSummary->getEnvelopeId();
                    }
                } 
            } catch (DocuSign\eSign\ApiException $ex) {
                $sErrorMsg = $ex->getMessage().' </br>';
                if (!empty($ex->getResponseObject())) {
                    $aError = json_decode($ex->getResponseObject(), true);
                    if (!empty($aError['errorCode'])) {
                        $sErrorMsg .= $aError['message']." (". $aError['errorCode'].") </br>";
                    }
                }
                $_SESSION['urdhvadocusign']['errormsg'] = $sErrorMsg;
                //echo $sErrorMsg;
            } catch (Throwable $ex) {
                // Catching other Throwables (including Errors)
                $sErrorMsg = '';
                if (!empty($ex->getResponseObject())) {
                    $aError = json_decode($ex->getResponseObject(), true);
                    if (!empty($aError['errorCode'])) {
                        $sErrorMsg .= $aError['message']." (". $aError['errorCode'].") </br>";
                    }
                }
                $_SESSION['urdhvadocusign']['errormsg'] = $sErrorMsg;
            }
        } else {
            $_SESSION['urdhvadocusign']['errormsg'] = $mod_strings['LBL_SETTINGS_ERROR'].'<br/>';
        }
    }
    if (!empty($sNewGuid)) {
        $oUTDocuSign = BeanFactory::getBean('UT_DocuSign');
        $id = create_guid();
        $oUTDocuSign->new_with_id = true;
        $oUTDocuSign->id = $id;
        $oUTDocuSign->document_name = 'RS : ';
        $oUTDocuSign->sending_type = $_POST['sending_type'];
        $oUTDocuSign->sending_option = $_POST['sending_option']; // SMS
        if ($_POST['sending_type'] == 'select_template') {
            $oUTDocuSign->docusign_templates = $_POST['rs_template_id'];
            $oUTDocuSign->rs_doc_id = $sNewGuid; // This is the RS document id, So we can call and get the Document Details
        } else {
            // This is the sending id, Based on this we will receive a callback from RS once the document is created. So directly getting Document Details is not possible.
            $oUTDocuSign->sending_request_id = $sNewGuid;
        }
        $oUTDocuSign->recipient_name = '-- Multiple Recipient --';
        $oUTDocuSign->email_address = '-- Multiple Recipient --';
        $oUTDocuSign->subject = $sDocumentName;
        $oUTDocuSign->message = $sMessage;
        if ($dsEnvironment == "submit_for_review") {
            $oUTDocuSign->state = "sent";
        }
                
        if ($_POST['sending_type'] == 'select_template') {
            if ($dsEnvironment != "submit_for_review") {
                $aResponseEnvelopeDetail = $oDocuSignClient->getEnvelope($sNewGuid);
                if (!empty($aResponseEnvelopeDetail['error'])) {
                    $_SESSION['urdhvadocusign']['errormsg'] = HtmlSpecialChars($aResponseEnvelopeDetail['error']);
                    SugarApplication::appendErrorMessage(HtmlSpecialChars($aResponseEnvelopeDetail['error']));
                    SugarApplication::redirect('index.php?module=UT_DocuSign&action=SendDocumentRS');
                    exit;
                }
                $oEnvelope = $aResponseEnvelopeDetail['response'];
                if (!empty($oEnvelope->getStatus())) {
                    $oUTDocuSign->state = $oEnvelope->getStatus();
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
            }
            
            // Save the Roles so that it can be used during syncing from Docusign to CRM
            if (!empty($aRoles)) {
                $oUTDocuSign->saved_template_roles = base64_encode(serialize($aRoles));
            }
            $oUTDocuSign->assigned_user_id = $SugarUserId;
            $oUTDocuSign->save();

            if ($dsEnvironment != "submit_for_review") {
                $aResp = $oDocuSignClient->listDocuments($sNewGuid);
                if (!empty($aResp['error'])) {
                    $_SESSION['urdhvadocusign']['errormsg'] = $aResp['error'];
                    SugarApplication::appendErrorMessage($aResp['error']);
                    SugarApplication::redirect('index.php?module=UT_DocuSign&action=SendDocumentRS');
                    exit;
                }
            }
            // BEGINS: Save the Field Mapping and Docusign
            if (!empty($_POST['map_crmtodocusign'])) {
                $oUTDocuSign->load_relationship("ut_dsfieldmapping_ut_docusign_1");
                if ($oUTDocuSign->ut_dsfieldmapping_ut_docusign_1->add($_POST['map_crmtodocusign']) == false) {
                    $GLOBALS['log']->fatal("Failed to associate DSFieldMapping CRM To DS(".$_POST['map_crmtodocusign'].") with DocuSign (".$oUTDocuSign->id.")");
                }
            }
            if (!empty($_POST['map_docusigntocrm'])) {
                $oUTDocuSign->load_relationship("ut_dsfieldmapping_ut_docusign_2");
                if ($oUTDocuSign->ut_dsfieldmapping_ut_docusign_2->add($_POST['map_docusigntocrm']) == false) {
                    $GLOBALS['log']->fatal("Failed to associate DSFieldMapping DS To CRM(".$_POST['map_docusigntocrm'].") with DocuSign (".$oUTDocuSign->id.")");
                }
            }
            // ENDS: Save the Field Mapping and Docusign
                    
            if ($dsEnvironment != "submit_for_review") {
                $oUTDocuSign->load_relationship("ut_docusign_notes_1");
                //$oUTDocuSign->load_relationship("ut_docusign_documents_1");
                $oEnvelopeDocumentsResult = $aResp['response'];
                $aEnvelopeDocuments = $oEnvelopeDocumentsResult->getEnvelopeDocuments();
                if (!empty($aEnvelopeDocuments)) {
                    foreach ($aEnvelopeDocuments as $sk => $oEnvelopeDocument) {
                        $sDocId = $oEnvelopeDocument->getDocumentId();
                        $aRespGetDoc = $oDocuSignClient->getDocument($sDocId, $sNewGuid);
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
                        $oNotes->assigned_user_id = $SugarUserId;
                        $oNotes->save();

                        $oNoteSoap = new NoteSoap();
                        $aNoteFile = array(
                                    'id' => $sNotesID,
                                    'name'=> $finalNoteName,//$oEnvelopeDocument->getName()
                                    'filename' => $finalNoteName,//$oEnvelopeDocument->getName()
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
                        $oDocument->assigned_user_id = $SugarUserId;
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
                
                $oUTDocuSign->load_relationship("ut_docusign_ut_dsactivities");
                    
                $aResp = $oDocuSignClient->listAuditEvents($sNewGuid);
                if (!empty($aResp['error'])) {
                    $_SESSION['urdhvadocusign']['errormsg'] = $aResp['error'];
                    SugarApplication::appendErrorMessage($aResp['error']);
                    SugarApplication::redirect('index.php?module=UT_DocuSign&action=SendDocumentRS');
                    exit;
                }
                if (!empty($aResp['response'])) {
                    foreach ($aResp['response'] as $iDx => $aAudit) {
                        $oUTRSActivities = BeanFactory::getBean('UT_DSActivities');
                        $act_id = create_guid();
                        $oUTRSActivities->new_with_id = true;
                        $oUTRSActivities->id = $act_id;
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
                        $oUTRSActivities->assigned_user_id = $SugarUserId;
                        $oUTRSActivities->save();

                        if ($oUTDocuSign->ut_docusign_ut_dsactivities->add($oUTRSActivities->id) == false) {
                            $GLOBALS['log']->fatal("Failed to associate RSActivities (".$oUTRSActivities->id.") with DocuSign (".$oUTDocuSign->id.")");
                        }
                    }
                }
            }
        } else {
            $oUTDocuSign->assigned_user_id = $SugarUserId;
            $oUTDocuSign->save();
        }
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
        $_SESSION['urdhvadocusign']['message'] = $mod_strings['LBL_DOC_SENT_FOR_SIGNATURE'].' <a href="index.php?module=UT_DocuSign&action=DetailView&record='.$oUTDocuSign->id.'"> here</a>';
        $url = "index.php?module=UT_DocuSign&action=SendDocumentRS";
        SugarApplication::redirect($url);
    }
    $sRSTemplateOption = '';
    if (!empty($app_list_strings['docusign_templates_list'])) {
        $sRSTemplateOption .= '<option value=""></option>';
        foreach ($app_list_strings['docusign_templates_list'] as $iRsTemplateId => $sTemplateName) {
            $sRSTemplateOption .= '<option value="'.$iRsTemplateId.'">'.$sTemplateName.'</option>';
        }
    }
    $sugar_smarty->assign('rs_template_options', $sRSTemplateOption);
    $sSupportedModuleOption='';
    $aSupportedSignerModule = array('Accounts','Contacts','Leads','Prospects','Users');
    foreach ($aSupportedSignerModule as $sK => $sModName) {
        if (ACLController::checkAccess($sModName, 'list', true)) {
            $sSupportedModuleOption .= '<option value="'.$sModName.'">'.$app_list_strings['moduleList'][$sModName].'</option>';
        }
    }
    $sugar_smarty->assign('sSupportedModuleOption', $sSupportedModuleOption);
    
    $prePopulateAction = '';
    $prePopFromDetailViewModule = '';
    $prePopFromDetailViewId = '';
    $prePopFromDetailViewName = '';
    $prePopFromDetailViewEmail = '';
    $prePopFromDetailViewPhone = '';
    $sCancelRedirectURL = "index.php?module=UT_DocuSign&action=index";
    
    if (!empty($_REQUEST['prePopModule']) && !empty($_REQUEST['prePopID'])) {
        $oDynamicModule = BeanFactory::getBean($_REQUEST['prePopModule'], $_REQUEST['prePopID']);
        $prePopFromDetailViewModule = $_REQUEST['prePopModule'];
        $prePopFromDetailViewId = $_REQUEST['prePopID'];
        if ($_REQUEST['prePopModule'] == 'Accounts') {
            $prePopFromDetailViewName = $oDynamicModule->name;
            $prePopFromDetailViewEmail = $oDynamicModule->email1;
            $prePopFromDetailViewPhone = $oDynamicModule->phone_office;
        } elseif ($_REQUEST['prePopModule'] == 'Contacts' || $_REQUEST['prePopModule'] == 'Leads' || $_REQUEST['prePopModule'] == 'Prospects') {
            $prePopFromDetailViewName = $oDynamicModule->full_name;
            $prePopFromDetailViewEmail = $oDynamicModule->email1;
            $prePopFromDetailViewPhone = $oDynamicModule->phone_mobile;
        }
        
        $sCancelRedirectURL = "index.php?module=".$_REQUEST['prePopModule']."&action=DetailView&record=".$_REQUEST['prePopID'];
    }
    if (!empty($_REQUEST['prePopulateAction'])) {
        $prePopulateAction=$_REQUEST['prePopulateAction'];
    }
    
    $sugar_smarty->assign('prePopFromDetailViewModule', $prePopFromDetailViewModule);
    $sugar_smarty->assign('prePopFromDetailViewId', $prePopFromDetailViewId);
    $sugar_smarty->assign('prePopFromDetailViewName', $prePopFromDetailViewName);
    $sugar_smarty->assign('prePopFromDetailViewEmail', $prePopFromDetailViewEmail);
    $sugar_smarty->assign('prePopFromDetailViewPhone', $prePopFromDetailViewPhone);
    $sugar_smarty->assign('prePopulateAction', $prePopulateAction);
    $sugar_smarty->assign('sCancelRedirectURL', $sCancelRedirectURL);
    // showing message on page it not empty
    if (!empty($_SESSION['urdhvadocusign']['message'])) {
        $sugar_smarty->assign("MESSAGE", $_SESSION['urdhvadocusign']['message']);
        unset($_SESSION['urdhvadocusign']['message']);
    }
    // showing error message on page it not empty
    if (!empty($_SESSION['urdhvadocusign']['errormsg'])) {
        $sugar_smarty->assign("ERRORMESSAGE", $_SESSION['urdhvadocusign']['errormsg']);
        unset($_SESSION['urdhvadocusign']['errormsg']);
    }
    $is_sms_auth = false;
    if (!empty($oDocuSignClient->is_sms_auth)) {
        $is_sms_auth = true;
    }
    $sugar_smarty->assign('is_sms_auth', $is_sms_auth);
    $sugar_smarty->assign('mod', $mod_strings);
    $sugar_smarty->assign('app', $app_strings);
    $sugar_smarty->assign('applist', $app_list_strings['moduleList']);
    $sugar_smarty->display('modules/UT_DocuSign/tpls/SendDocumentRS.tpl');
