<?php
if (!defined('sugarEntry') || !sugarEntry) {
    die('Not A Valid Entry Point');
}
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
    
    global $db, $mod_strings,$current_user,$app_list_strings, $sugar_config;
    $base_mod_string = return_module_language("", "UT_DocuSign");
    $sugar_smarty = new Sugar_Smarty();
    $isSetDocuSignKey = false;
    $isSetDocuSignAuth = false;
    $aAppKeys = getApplicationKey();
    $aOAuthDBSettings = array();

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
    if (empty($aAppKeys['client_secret']) || empty($aAppKeys['client_key'])) {
        $_SESSION['urdhvadocusign']['errormsg']=$base_mod_string['LBL_UT_AUTH_KEY_SECRET_MISSING'];
        $url = "index.php?module=UT_DocuSign&action=DocuSignAppKeys";
        SugarApplication::redirect($url);
        return;
    }
    if (!empty($aAppKeys['access_token'])) {
        $aOAuthDBSettings['access_token'] = $aAppKeys['access_token'];
    }
    if (!empty($aAppKeys['refresh_token'])) {
        $aOAuthDBSettings['refresh_token'] = $aAppKeys['refresh_token'];
    }
    if (!empty($aAppKeys)) {
        $isSetDocuSignKey = true;
    }
    if (!empty($aOAuthDBSettings)) {
        $isSetDocuSignAuth = true;
    }
    
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
    
    $sugar_smarty->assign('mod', $base_mod_string);
    $sugar_smarty->assign('app', $app_strings);
    $sugar_smarty->assign('applist', $app_list_strings['moduleList']);
    $sugar_smarty->assign('isSetDocuSignKey', $isSetDocuSignKey);
    $sugar_smarty->assign('isSetDocuSignAuth', $isSetDocuSignAuth);
    
    $sugar_smarty->assign('site_url', $sugar_config['site_url']);
    $sSubmitURL = $sugar_config['site_url']."/index.php?entryPoint=DocuSignAuthorizeApps";
    $sRedirectURL = $sugar_config['site_url'].'/UT_DocuSignCallback.php';
    $sugar_smarty->assign('submit_url', $sSubmitURL);
    $sugar_smarty->assign('redirecturl_information', $sRedirectURL);
    $sugar_smarty->display('modules/UT_DocuSign/tpls/DocuSignAuth.tpl');
