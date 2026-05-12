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

global $mod_strings, $app_strings, $sugar_config;
 
if (ACLController::checkAccess('UT_DocuSign', 'edit', true)) {
    $module_menu[] = array("index.php?module=UT_DocuSign&action=SendDocumentRS", $mod_strings['LNK_NEW_RECORD'], 'Add', 'UT_DocuSign');
}
if (ACLController::checkAccess('UT_DocuSign', 'list', true)) {
    $module_menu[]=array("index.php?module=UT_DocuSign&action=index&return_module=UT_DocuSign&return_action=DetailView", $mod_strings['LNK_LIST'],"List", 'UT_DocuSign');
}
