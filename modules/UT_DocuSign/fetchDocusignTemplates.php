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
$json = getJSONobj();
$aReturn = array(
    'license_valid' => 'Yes',
    'message' => '',
    'status' => 'success',
);


require_once('modules/UT_DocuSign/DocuSignUtils.php');
require_once('modules/UT_DocuSign/library/UT_DocuSignClient.php');
global $db,$timedate,$app_list_strings, $sugar_config,$current_user;

if (!checkDocuSignLicense()) {
    $aReturn["license_valid"] = "No";
    echo $json->encode($aReturn);
    exit;
}

$oDocuSignClient = new UT_DocuSignClient(true, 1);
$aResponse = $oDocuSignClient->getTemplates();

if (!empty($aResponse['error'])) {
    $aReturn["message"] = str_replace("DocuSign settings", "<a href='index.php?module=UT_DocuSign&action=DocuSignAppKeys'>DocuSign settings</a>", $aResponse['error']);
    $aReturn["status"] = "fail";
}
if (!empty($aResponse['response'])) {
    $dropdown_name='docusign_templates_list';
    update_rs_dropdown($dropdown_name, $aResponse['response']);
}
echo $json->encode($aReturn);
return;
