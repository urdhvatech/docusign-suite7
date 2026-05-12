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
    $aFinalRes = array(
        'client_secret'=>'',
        'client_key'=>'',
        'integrator_key'=>'',
        'ds_environment_type'=>'',
    );
    $sugar_smarty   = new Sugar_Smarty();
    $sSelSql = "SELECT * FROM ut_docusign_api_keys WHERE deleted=0 ";
    $sSelSql = $db->limitQuery($sSelSql, 0, 1, false, '', false);
    $oRes = $db->query($sSelSql, true);
    $aRow = $db->fetchByAssoc($oRes);

    if (!empty($_POST) && !empty($_POST['client_secret']) && !empty($_POST['client_key']) && !empty($_POST['ds_environment_type'])) {
        $aReturn['error'] = $accountId = $host = '';
        $aFinalRes['client_secret'] = $_POST['client_secret'];
        $aFinalRes['client_key'] = $_POST['client_key'];
        $aFinalRes['integrator_key'] = $_POST['client_key'];
        $aFinalRes['ds_environment_type'] = $_POST['ds_environment_type'];
        $aFinalRes['host'] = '';
        $aFinalRes['accountid'] = '';
        if (empty($aRow)) {
            $sGuid = create_guid();
            $sInsertSql = "INSERT INTO ut_docusign_api_keys (id, client_secret, client_key, integrator_key, ds_environment_type, host, accountid, deleted) 
                        VALUES ('".$sGuid."', '".$aFinalRes['client_secret']."', '".$aFinalRes['client_key']."', '".$aFinalRes['client_key']."', '".$aFinalRes['ds_environment_type']."','".$aFinalRes['host']."','".$aFinalRes['accountid']."', 0);";
            $db->query($sInsertSql, true);
        } else {
            $iChanged = false;
            if ($_POST['client_secret'] != $aRow['client_secret'] || $_POST['client_key'] != $aRow['client_key']) {
                $iChanged = true;
            }
            // if client key and secret has changed then empty the host, accountid, access_token, refresh_token, expires_in, token_type, expiration_datetime
            if ($iChanged) {
                $sUpdateSql = "UPDATE ut_docusign_api_keys SET client_secret='".$_POST['client_secret']."', client_key='".$_POST['client_key']."', integrator_key='".$_POST['client_key']."', ds_environment_type='".$_POST['ds_environment_type']."', host='', accountid='', access_token='', refresh_token='', expires_in='', token_type='', expiration_datetime=NULL WHERE id='".$aRow['id']."'";
            } else {
                $sUpdateSql = "UPDATE ut_docusign_api_keys SET client_secret='".$_POST['client_secret']."', client_key='".$_POST['client_key']."', integrator_key='".$_POST['client_key']."', ds_environment_type='".$_POST['ds_environment_type']."' WHERE id='".$aRow['id']."'";
            }
            $db->query($sUpdateSql, true);
        }
        $_SESSION['urdhvadocusign']['message'] = $base_mod_string['LBL_SETTINGS_DONE'];
        
        // Redirect to oAuth Page.
        $url = "index.php?module=UT_DocuSign&action=DocuSignAuth";
        SugarApplication::redirect($url);
    }
    
    if (!empty($aRow) && !empty($aRow['client_secret']) && !empty($aRow['client_key']) && !empty($aRow['ds_environment_type'])) {
        $aFinalRes['client_secret'] = $aRow['client_secret'];
        $aFinalRes['client_key'] = $aRow['client_key'];
        $aFinalRes['integrator_key'] = $aRow['client_key'];
        $aFinalRes['ds_environment_type'] = $aRow['ds_environment_type'];
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
    $sEnvironmentOptions = get_select_options_with_id($app_list_strings['ds_environment_type_dom'], $aFinalRes['ds_environment_type']);
    $sRedirectURL = $sugar_config['site_url'].'/UT_DocuSignCallback.php';
    
    $sugar_smarty->assign('mod', $base_mod_string);
    $sugar_smarty->assign('app', $app_strings);
    $sugar_smarty->assign('applist', $app_list_strings['moduleList']);
    $sugar_smarty->assign('client_secret', $aFinalRes['client_secret']);
    $sugar_smarty->assign('client_key', $aFinalRes['client_key']);
    $sugar_smarty->assign('ds_environment_option', $sEnvironmentOptions);
    $sugar_smarty->assign('redirecturl_information', $sRedirectURL);
    $sugar_smarty->display('modules/UT_DocuSign/tpls/DocuSignAppKeys.tpl');
