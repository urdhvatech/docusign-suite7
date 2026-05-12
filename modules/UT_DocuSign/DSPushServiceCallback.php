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

  require_once 'include/upload_file.php';
  require_once('modules/UT_DocuSign/DocuSignUtils.php');
  require_once("modules/UT_DocuSign/docusign_docupdate.php");
  global $db,$timedate,$mod_strings, $current_language,$sugar_config,$current_user;
  $current_user = new User();
  $current_user->getSystemUser();
//$aDataCallBack = json_decode(file_get_contents('php://input'),true);
//https://developers.docusign.com/esign-rest-api/code-examples/webhook-status
$file = new UploadFile();
$file->temp_file_location = 'php://input';
$input = $file->get_file_contents();

$simpleXmlObject = new SimpleXmlElement($input);
if (is_object($simpleXmlObject) && !empty($simpleXmlObject->EnvelopeStatus[0]->EnvelopeID)) {
    $envelopeId = $simpleXmlObject->EnvelopeStatus[0]->EnvelopeID;
    //$newStatus = strtolower($simpleXmlObject->EnvelopeStatus[0]->Status);
    
    $aApplicatonKeys = getApplicationKey();
    $sSql = "SELECT id, rs_doc_id 
            FROM ut_docusign 
            WHERE rs_doc_id='".$envelopeId."' AND deleted=0 ";
    $sSql = $db->limitQuery($sSql, 0, 1, false, '', false);
    $oRes = $db->query($sSql, true);
    $aRow = $db->fetchByAssoc($oRes);
    if (!empty($aRow['id'])) {
        // When we submit application from demo to production. We need to stop makig calls to webhooks, and other extra calls, It use to give Polling error.
        if ($aApplicatonKeys['ds_environment_type'] != 'submit_for_review') {
            $status = docusign_docupdate_cron($aRow['id']);
        }
    }
}
