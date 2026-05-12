<?php
/**
  Created By : Urdhva Tech Pvt. Ltd.
  Created date : 02/20/2017
  Contact at : contact@urdhva-tech.com
  Web : www.urdhva-tech.com
  Skype : urdhvatech
*/
if (!defined('sugarEntry') || !sugarEntry) {
    define('sugarEntry', true);
}
include_once("include/entryPoint.php");
require_once('modules/UT_DocuSign/library/esign-client/autoload.php');
require_once('modules/UT_DocuSign/DocuSignUtils.php');
require_once('modules/UT_DocuSign/library/UT_DocuSignClient.php');

global $current_user, $db, $sugar_config;
$SugarUserId = 1;
function utRedirectToAuth()
{
    $queryParams = array(
        'module' => 'UT_DocuSign',
        'action' => 'DocuSignAuth',
    );
    SugarApplication::redirect('index.php?' . http_build_query($queryParams));
}
if (!empty($_GET['code'])) {
    $aApplicatonKeys = getApplicationKey();
    $host = '';
    if ($aApplicatonKeys['ds_environment_type'] == 'production' ) {
        //$host = $aApplicatonKeys['host'];
        //$host = $aApplicatonKeys['host']."/restapi";
        $host = 'https://www.docusign.net/restapi';
    }
    $host = !empty($host) ? $host : 'https://demo.docusign.net/restapi';
    $integratorKey = !empty($aApplicatonKeys['integrator_key']) ? $aApplicatonKeys['integrator_key'] : 'REQUIRED';
    $clientSecret = !empty($aApplicatonKeys['client_secret']) ? $aApplicatonKeys['client_secret'] : 'REQUIRED';
    $clientKey = !empty($aApplicatonKeys['client_key']) ? $aApplicatonKeys['client_key'] : '';

    $config = new DocuSign\eSign\Configuration();
    $config->setHost($host);
    $oApiClient = new DocuSign\eSign\Client\ApiClient($config);

    $oAuth = $oApiClient->getOAuth();
    $oAuth->setBasePath($host);
    $code = $_GET['code'];
    try {
        $initialOAuthToken = $oApiClient->generateAccessToken($integratorKey, $clientSecret, $code);
        //BEGIN: Insert the access_token, refresh token, expires_in and token_type in DB.
        setAccessTokenToYourDataStore($initialOAuthToken[0]);
        //ENDS: Insert the access_token, refresh token, expires_in and token_type in DB.
        $user = $oApiClient->getUserInfo($initialOAuthToken[0]['access_token']);
        if (!empty($user[0]['accounts'])) {
            //$loginAccount = $user[0]['accounts'][0];
            foreach($user[0]['accounts'] as $loginAccount)
            {
                if($loginAccount->getIsDefault() == true)
                {
                    $host = $loginAccount->getBaseUri();
                    $accountId = $loginAccount->getAccountId();
                    // //$testConfig->setAccountId($accountId);
                    $sSelSql = "SELECT * FROM ut_docusign_api_keys WHERE deleted=0 ";
                    $sSelSql = $db->limitQuery($sSelSql, 0, 1, false, '', false);
                    $oRes = $db->query($sSelSql, true);
                    $aRow = $db->fetchByAssoc($oRes);
                    if (!empty($aRow)) {
                        $sUpdateSql = "UPDATE ut_docusign_api_keys SET accountid='".$accountId."', host='".$host."' WHERE id='".$aRow['id']."'";
                        $db->query($sUpdateSql, true);
                    }
                    break; // jump to of foreach
                }
                else {
                    $GLOBALS['log']->fatal("Api response has error : Integration authentication to DocuSign failed, No default account found");
                    //clearAuthDetails();
                }
            }
            //$GLOBALS['log']->fatal(print_r($user,true));
        } else {
            $GLOBALS['log']->fatal("Api response has error : Integration authentication to DocuSign failed.");
            clearAuthDetails();
        }
        utRedirectToAuth();
    } catch (DocuSign\eSign\ApiException $ex) {
        $sErrorMsg = $ex->getMessage().' </br>';
        $GLOBALS['log']->fatal("Api response has error : Integration Callback to DocuSign failed.".$sErrorMsg);
        if (!empty($ex->getResponseObject())) {
            $aError = json_decode($ex->getResponseObject(), true);
            $GLOBALS['log']->fatal("Api response has error : Integration Callback to DocuSign failed.".print_r($aError, true));
        }
        clearAuthDetails();
        utRedirectToAuth();
    }
} else {
    clearAuthDetails();
    utRedirectToAuth();
}

function clearAuthDetails()
{
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
