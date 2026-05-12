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

global $db, $mod_strings,$current_user,$app_list_strings,$sugar_config;
$base_mod_string = return_module_language("", "UT_DocuSign");
// checking if current user is not admin then do not procced further
if (!$current_user->is_admin) {
    echo $base_mod_string['LBL_NOT_AUTHORIZED'];
    return;
}
if (!checkDocuSignLicense()) {
    $msg = "Invalid License";
    SugarApplication::appendErrorMessage($msg);
    SugarApplication::redirect('index.php?module=UT_DocuSign&action=license');
    exit;
}

$sugar_smarty   = new Sugar_Smarty();
$sugar_smarty->assign('mod', $base_mod_string);
$sugar_smarty->assign('app', $app_strings);
$sugar_smarty->display('modules/UT_DocuSign/tpls/syncDocusignTemplates.tpl');
