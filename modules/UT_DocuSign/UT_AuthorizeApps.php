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

include_once("include/entryPoint.php");
require_once('modules/UT_DocuSign/library/esign-client/autoload.php');
require_once('modules/UT_DocuSign/DocuSignUtils.php');

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

if (!empty($_REQUEST['entryPoint']) && $_REQUEST['entryPoint']=='DocuSignAuthorizeApps') {
    require_once('modules/UT_DocuSign/library/UT_DocuSignClient.php');
    $aApplicatonKeys = getApplicationKey();
    $host = '';
    if ($aApplicatonKeys['ds_environment_type'] == 'production') {
        $host = 'https://www.docusign.net/restapi';
    }
    $returnUrl = $sugar_config['site_url'].'/UT_DocuSignCallback.php';
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
    //https://developers.docusign.com/platform/auth/reference/scopes/
    $scope = [
        $oApiClient::$SCOPE_SIGNATURE,
        //ApiClient::$SCOPE_IMPERSONATION
        $oApiClient::$SCOPE_EXTENDED,
        'organization_read',
        'group_read',
        'user_read',
        'user_write',
        'account_read',
    ];
    $uri = $oApiClient->getAuthorizationURI($aApplicatonKeys['integrator_key'], $scope, $returnUrl, 'code');
    header('Location: ' . $uri);
    exit;
} else {
    $GLOBALS['log']->fatal("Incorrect Entrypoint argument provided for Integration");
    //utRedirectToAuth();
}
