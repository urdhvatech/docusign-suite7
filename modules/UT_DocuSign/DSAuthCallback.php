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
/*
include_once("include/entryPoint.php");
require_once('modules/UT_DocuSign/library/esign-client/autoload.php');
require_once('modules/UT_DocuSign/DocuSignUtils.php');

//$array_get = json_decode(file_get_contents('php://input'));
//error_log("handle_callback 111111=============== ");
//error_log(print_r($array_get,true));
//error_log(print_r($_REQUEST,true));
global $current_user, $db, $sugar_config;

//$SugarUserId = $current_user->id;
$SugarUserId = 1;
function utRedirectToAuth() {
    $queryParams = array(
        'module' => 'UT_DocuSign',
        'action' => 'DocuSignAuth',
    );
    SugarApplication::redirect('index.php?' . http_build_query($queryParams));
}

if(!empty($_REQUEST['entryPoint']) && $_REQUEST['entryPoint']=='DSAuthCallback') {

    require_once('modules/UT_DocuSign/library/UT_DocuSignClient.php');
    $aApplicatonKeys = getApplicationKey();
    if ($aApplicatonKeys['ds_environment_type'] == 'production' && !empty($aApplicatonKeys['host'])) {
        //$host = $aApplicatonKeys['host'];
        $host = 'https://www.docusign.net/restapi';
        //$host = "https://".$aApplicatonKeys['host'].".docusign.net/restapi";
    } else {
        $host = "https://demo.docusign.net/restapi";
    }
    //$returnUrl = $sugar_config['site_url'].'/index.php?entryPoint=DSAuthCallback&module=UT_DocuSign';
    $host = !empty($host) ? $host : 'https://demo.docusign.net/restapi';
    $integratorKey = !empty($aApplicatonKeys['integrator_key']) ? $aApplicatonKeys['integrator_key'] : 'REQUIRED';
    $clientSecret = !empty($aApplicatonKeys['client_secret']) ? $aApplicatonKeys['client_secret'] : 'REQUIRED';
    $clientKey = !empty($aApplicatonKeys['client_key']) ? $aApplicatonKeys['client_key'] : '';
    //$returnUrl = !empty($returnUrl) ? $returnUrl : 'REQUIRED';

    $config = new DocuSign\eSign\Configuration();
    $config->setHost($host);
    $oApiClient = new DocuSign\eSign\Client\ApiClient($config);

    $oAuth = $oApiClient->getOAuth();
    $oAuth->setBasePath($host);

    if(!empty($_GET['code']))
    {
        $code = $_GET['code'];
        try {
            $initialOAuthToken = $oApiClient->generateAccessToken($integratorKey, $clientSecret, $code);
//echo "<pre>initialOAuthToken==============";
//print_r($initialOAuthToken);
//echo "</pre>";
//die("ddddd");
            //BEGIN: Insert the access_token, refresh token, expires_in and token_type in DB.
            setAccessTokenToYourDataStore($initialOAuthToken[0]);
            //ENDS: Insert the access_token, refresh token, expires_in and token_type in DB.
            $user = $oApiClient->getUserInfo($initialOAuthToken[0]['access_token']);
            if(!empty($user[0]['accounts'])) {
                //$loginAccount = $user[0]['accounts'][0];
                //$accountId = $loginAccount->getAccountId();
                // //$testConfig->setAccountId($accountId);
                $GLOBALS['log']->fatal(print_r($user,true));
            }
            else {
                $GLOBALS['log']->fatal("Api response has error : Integration authentication to DocuSign failed.");
                clearAuthDetails();
            }
            utRedirectToAuth();
        } catch (DocuSign\eSign\ApiException $ex) {
            $sErrorMsg = $ex->getMessage().' </br>';
            $GLOBALS['log']->fatal("Api response has error : Integration Callback to DocuSign failed.".$sErrorMsg);
            if (!empty($ex->getResponseObject())) {
                $aError = json_decode($ex->getResponseObject(), true);
                $GLOBALS['log']->fatal("Api response has error : Integration Callback to DocuSign failed.".print_r($aError,true));
            }
            clearAuthDetails();
            utRedirectToAuth();
        }
    }
    else {
        clearAuthDetails();
        utRedirectToAuth();
    }
}
else
{
    $GLOBALS['log']->fatal("Incorrect Entrypoint argument provided for Integration");
    utRedirectToAuth();
}

function clearAuthDetails() {
    global $db;
    // unset fields from table
    $sSelSql = "SELECT * FROM ut_docusign_api_keys WHERE deleted=0 ";
    $sSelSql = $db->limitQuery($sSelSql, 0, 1, false, '', false);
    $oRes = $db->query($sSelSql, true);
    $aRow = $db->fetchByAssoc($oRes);
    if (!empty($aRow)) {
        $sUpdateSql = "UPDATE ut_docusign_api_keys SET access_token='', refresh_token='', expires_in='', token_type='', expiration_datetime='' WHERE id='".$aRow['id']."'";
        $db->query($sUpdateSql, true);
    }
}
*/
