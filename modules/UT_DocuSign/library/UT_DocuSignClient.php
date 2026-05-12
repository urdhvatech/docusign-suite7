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
require_once('modules/UT_DocuSign/library/esign-client/autoload.php');
require_once('modules/UT_DocuSign/DocuSignUtils.php');
global $db, $current_user;

class UT_DocuSignClient
{
    /**
      * $integratorKey
      * @var string
      */
    protected $integratorKey;
    
    /**
      * $host
      * @var string
      */
    protected $host;
    
    /**
      * $apiClient
      * @var DocuSign\eSign\Client\ApiClient
      */
    protected $apiClient;

    /**
      * $dsEnviornment
      * @var string
      */
    protected $dsEnvironment;
    
    /**
      * $accountId
      * @var string
      */
    protected $accountId;

    /**
      * $recipientEmail
      * @var string
      */
    protected $recipientEmail;

    /**
      * $recipientName
      * @var string
      */
    protected $recipientName;

    /**
      * $templateRoleName
      * @var string
      */
    protected $templateRoleName;

    /**
      * $templateId
      * @var string
      */
    protected $templateId;

    /**
      * $envelopId
      * @var string
      */
    protected $envelopeId;

    /**
     * $createdEnvelopId
     * @var string
     */
    protected $createdEnvelopId;

    /**
     * $returnUrl
     * @var string
     */
    protected $returnUrl;

    /**
     * $clientUserId
     * @var string
     */
    protected $clientUserId;

    /**
     * $clientSecret
     * @var string
     */
    protected $clientSecret;

    /**
     * $clientKey
     * @var string
     */
    protected $clientKey;

    /**
     * $privateKey
     * @var string
     */
    protected $privateKeyB64;

    protected $userId;

    protected $brandId;

    protected $documentName;
    
    protected $documentFileName;
    
    protected $documentExtension;
    
    protected $CstmSigners;
    
    protected $CstmCarbonCopy;
    
    protected $CstmEnvelopWebHookURL;
    
    protected $CstmEmailSubject;
    
    protected $CstmEmailBlurb;
    
    protected $CstmSenderViewReturnURL;
    
    protected $CstmSignHereTab;
    
    protected $CstmInitialHereTab;
    
    protected $CstmDateSignedTab;
    
    public $is_sms_auth;
    
    //public function __construct($integratorKey = null, $host = null, $returnUrl = null, $envelopeId = null, $secret = null, $key = null, $userId = null, $privateKey = null)
    public function __construct($isCronJob = false, $current_user_id='1')
    {
        global $current_user, $sugar_config;
        //BEGINS: Added By Urdhva Tech
        if ($isCronJob == true && !empty($current_user_id)) {
            $iUserID = $current_user_id;
        } else {
            $iUserID = $current_user->id;
        }
        //$iUserID = 1;
        //$aUToAuthDBSettings = getOAuthDBSettings($Server, $iUserID);
        $aApplicatonKeys = getApplicationKey();
        
        if ($aApplicatonKeys['ds_environment_type'] == 'production' && !empty($aApplicatonKeys['host'])) {
            //$host = $aApplicatonKeys['host'];
            //$host = 'https://www.docusign.net/restapi';
            $host = $aApplicatonKeys['host']."/restapi";
        } else {
            $host = "https://demo.docusign.net/restapi";
        }
        /*
        $this->host = $host;
        $this->username = !empty($aApplicatonKeys['username']) ? $aApplicatonKeys['username'] : 'REQUIRED';
        $this->password = !empty($aApplicatonKeys['password']) ? $aApplicatonKeys['password'] : 'REQUIRED';
        $this->integratorKey = !empty($aApplicatonKeys['integrator_key']) ? $aApplicatonKeys['integrator_key'] : 'REQUIRED';
        $dsEnvironment = !empty($aApplicatonKeys['ds_environment_type']) ? $aApplicatonKeys['ds_environment_type'] : '';
        $this->setDSEnvironment($dsEnvironment);

        // create configuration object and configure custom auth header
        $config = new DocuSign\eSign\Configuration();
        $config->setHost($host);
        $config->addDefaultHeader("X-DocuSign-Authentication", "{\"Username\":\"" . $this->username . "\",\"Password\":\"" . $this->password . "\",\"IntegratorKey\":\"" . $this->integratorKey . "\"}");

        // instantiate a new docusign api client
        //$apiClient = new DocuSign\eSign\ApiClient($config);
        $this->setApiClient(new DocuSign\eSign\ApiClient($config));
        try {
            //*** STEP 1 - Login API: get first Account ID and baseURL
            $authenticationApi = new DocuSign\eSign\Api\AuthenticationApi($this->getApiClient());
            $options = new \DocuSign\eSign\Api\AuthenticationApi\LoginOptions();
            $loginInformation = $authenticationApi->login($options);
            if (isset($loginInformation) && !empty($loginInformation) && count($loginInformation) > 0) {
                $loginAccount = $loginInformation->getLoginAccounts()[0];
                $host = $loginAccount->getBaseUrl();
                $host = explode("/v2", $host);
                $host = $host[0];

                // UPDATE configuration object
                $config->setHost($host);
                // instantiate a NEW docusign api client (that has the correct baseUrl/host)
                $this->setApiClient(new DocuSign\eSign\ApiClient($config));
                $this->setHost($host);

                if (isset($loginInformation)) {
                    $accountId = $loginAccount->getAccountId();
                    if (!empty($accountId)) {
                        $this->setAccountId($accountId);
                    }
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
            $GLOBALS['log']->fatal(print_r($sErrorMsg, true));
        }
        */
        //===============================================================================================================
        $returnUrl = $sugar_config['site_url'].'/UT_DocuSignCallback.php';
        $this->host = !empty($host) ? $host : 'https://demo.docusign.net/restapi';
        $this->integratorKey = !empty($aApplicatonKeys['integrator_key']) ? $aApplicatonKeys['integrator_key'] : 'REQUIRED';
        $this->clientSecret = !empty($aApplicatonKeys['client_secret']) ? $aApplicatonKeys['client_secret'] : 'REQUIRED';
        $this->clientKey = !empty($aApplicatonKeys['client_key']) ? $aApplicatonKeys['client_key'] : '';
        $this->returnUrl = !empty($returnUrl) ? $returnUrl : 'REQUIRED';
        $this->is_sms_auth = !empty($aApplicatonKeys['is_sms_auth']) ? $aApplicatonKeys['is_sms_auth'] : 0;
//        $this->envelopeId = !empty($envelopeId) ? $envelopeId : '';
//        $this->userId = !empty($userId) ? $userId : getenv('USER_ID'); //can be taken from generateAccessToken returned result
//        $this->brandId = !empty($brandId) ? $brandId : getenv('BRAND_ID');
//        $this->clientUserId = "1234";
        
        $config = new DocuSign\eSign\Configuration();
        $config->setHost($this->getHost());
        $this->setApiClient(new DocuSign\eSign\Client\ApiClient($config));
        
        $oAuth = $this->getApiClient()->getOAuth();
        $oAuth->setBasePath($this->getHost());
        
        // only go for the refresh and access token if the client_secret, client_key is filled in the DB
        if (!empty($aApplicatonKeys['client_secret']) && !empty($aApplicatonKeys['client_key']) && !empty($aApplicatonKeys['access_token']) && !empty($aApplicatonKeys['refresh_token'])) {
            try {
                $AccessToken = getAccessTokenFromYourDataStore();
                if (isAccessTokenExpired($AccessToken)) {
                    // Purge old access token and store new access token to your data store.
                    $refreshToken = $AccessToken['refresh_token'];

                    $refreshedOAuthToken = $this->getApiClient()->refreshAccessToken($this->getIntegratorKey(), $this->getClientSecret(), $refreshToken);
                    setAccessTokenToYourDataStore($refreshedOAuthToken[0]);
                    $AccessToken = $refreshedOAuthToken[0];
                }
                $user = $this->getApiClient()->getUserInfo($AccessToken['access_token']);
                if (isset($user) && !empty($user) && count($user) > 0) {
                    $config->setAccessToken($AccessToken['access_token']);
                    
                    $loginAccount = $user[0]['accounts'][0];
                    //$host = $loginAccount->getBaseUri();
                    $accountId = $loginAccount->getAccountId();
                    $this->setAccountId($accountId);
                    
                    // UPDATE configuration object
                    $config->setHost($host);
                    // instantiate a NEW docusign api client (that has the correct baseUrl/host)
                    $this->setApiClient(new DocuSign\eSign\Client\ApiClient($config));
                    $this->setHost($host);
                }
            } catch (DocuSign\eSign\ApiException $ex) {
                $sErrorMsg = $ex->getMessage().' </br>';
                $GLOBALS['log']->fatal("Api response has error : Integration Callback to DocuSign failed.".$sErrorMsg);
                if (!empty($ex->getResponseObject())) {
                    $aError = json_decode($ex->getResponseObject(), true);
                    $GLOBALS['log']->fatal("Api response has error : Integration Callback to DocuSign failed.".print_r($aError, true));
                }
            }
        }
        //ENDS: Added By Urdhva Tech
    }
    
    /**
     * Gets DocuSign Environment
     * @return string
     */
    public function getDSEnvironment()
    {
        return $this->dsEnvironment;
    }
    
    /**
     * Sets DocuSign Environment
     * @param string $dsEnvironment
     * @return $this
     */
    public function setDSEnvironment($dsEnvironment)
    {
        $this->dsEnvironment = $dsEnvironment;
        return $this;
    }
    
    /**
     * Gets integratorKey
     * @return string
     */
    public function getIntegratorKey()
    {
        return $this->integratorKey;
    }
  
    /**
     * Sets integratorKey
     * @param string $integratorKey
     * @return $this
     */
    public function setIntegratorKey($integratorKey)
    {
        $this->integratorKey = $integratorKey;
        return $this;
    }

    /**
     * Gets host
     * @return string
     */
    public function getHost()
    {
        return $this->host;
    }
  
    /**
     * Sets host
     * @param string $host
     * @return $this
     */
    public function setHost($host)
    {
        $this->host = $host;
        return $this;
    }

    /**
     * Gets apiClient
     * @return DocuSign\eSign\Client\ApiClient
     */
    public function getApiClient()
    {
        return $this->apiClient;
    }
  
    /**
     * Sets apiClient
     * @param DocuSign\eSign\Client\ApiClient $apiClient
     * @return $this
     */
    public function setApiClient($apiClient)
    {
        $this->apiClient = $apiClient;
        return $this;
    }
  
    /**
     * Gets accountId
     * @return string
     */
    public function getAccountId()
    {
        return $this->accountId;
    }

    /**
     * Sets accountId
     * @param string $accountId
     * @return $this
     */
    public function setAccountId($accountId)
    {
        $this->accountId = $accountId;
        return $this;
    }

    /**
     * Gets recipientEmail
     * @return string
     */
    public function getRecipientEmail()
    {
        return $this->recipientEmail;
    }
  
    /**
     * Sets recipientEmail
     * @param string $recipientEmail
     * @return $this
     */
    public function setRecipientEmail($recipientEmail)
    {
        $this->recipientEmail = $recipientEmail;
        return $this;
    }

    /**
     * Gets recipientName
     * @return string
     */
    public function getRecipientName()
    {
        return $this->recipientName;
    }
  
    /**
     * Sets recipientName
     * @param string $recipientName
     * @return $this
     */
    public function setRecipientName($recipientName)
    {
        $this->recipientName = $recipientName;
        return $this;
    }

    /**
     * Gets templateRoleName
     * @return string
     */
    public function getTemplateRoleName()
    {
        return $this->templateRoleName;
    }
  
    /**
     * Sets templateRoleName
     * @param string $templateRoleName
     * @return $this
     */
    public function setTemplateRoleName($templateRoleName)
    {
        $this->templateRoleName = $templateRoleName;
        return $this;
    }

    /**
     * Gets templateId
     * @return string
     */
    public function getTemplateId()
    {
        return $this->templateId;
    }
  
    /**
     * Sets templateId
     * @param string $templateId
     * @return $this
     */
    public function setTemplateId($templateId)
    {
        $this->templateId = $templateId;
        return $this;
    }

    /**
     * Gets envelopeId
     * @return string
     */
    public function getEnvelopeId()
    {
        return $this->envelopeId;
    }

    /**
     * Sets envelopeId
     * @param string $envelopeId
     * @return $this
     */
    public function setEnvelopeId($envelopeId)
    {
        $this->envelopeId = $envelopeId;
        return $this;
    }

    /**
     * Gets createdEnvelopeId
     * @return string
     */
    public function getCreatedEnvelopeId()
    {
        return $this->createdEnvelopId;
    }

    /**
     * Sets createdEnvelopeId
     * @param string $createdEnvelopeId
     * @return $this
     */
    public function setCreatedEnvelopeId($envelopeId)
    {
        $this->createdEnvelopId = $envelopeId;
        return $this;
    }

    /**
     * Gets returnUrl
     * @return string
     */
    public function getReturnUrl()
    {
        return $this->returnUrl;
    }

    /**
     * Sets returnUrl
     * @param string $returnUrl
     * @return $this
     */
    public function setReturnUrl($returnUrl)
    {
        $this->returnUrl = $returnUrl;
        return $this;
    }

    /**
     * Gets clientUserId
     * @return string
     */
    public function getClientUserId()
    {
        return $this->clientUserId;
    }

    /**
     * Sets clientUserId
     * @param string $clientUserId
     * @return $this
     */
    public function setClientUserId($clientUserId)
    {
        $this->clientUserId = $clientUserId;
        return $this;
    }

    /**
     * Gets client secret
     * @return string
     */
    public function getClientSecret()
    {
        return $this->clientSecret;
    }

    /**
     * Sets client secret
     * @param string $clientSecret
     * @return $this
     */
    public function setClientSecret($clientSecret)
    {
        $this->clientSecret = $clientSecret;
        return $this;
    }

    /**
     * Gets client key
     * @return string
     */
    public function getClientKey()
    {
        return file_get_contents($this->clientKey);
    }

    /**
     * Sets client key
     * @param string $clientKey
     * @return $this
     */
    public function setClientKey($clientKey)
    {
        $this->clientKey = $clientKey;
        return $this;
    }

    /**
     * @return string
     */
    public function getPrivateKeyB64()
    {
        return $this->privateKeyB64;
    }

    /**
     * @param string $privateKeyB64
     */
    public function setPrivateKeyB64($privateKeyB64)
    {
        $this->privateKeyB64 = $privateKeyB64;
    }
    /**
     * Gets client key
     * @return string
     */
    public function getUserId()
    {
        return $this->userId;
    }

    /**
     * UserId
     * @param string $userId
     * @return $this
     */
    public function setUserId($userId)
    {
        $this->userId = $userId;
        return $this;
    }

    /**
     * Gets BrandId
     * @return string
     */
    public function getBrandId()
    {
        return $this->brandId;
    }

    /**
     * BrandId
     * @param string $brandId
     * @return $this
     */
    public function setBrandId($brandId)
    {
        $this->brandId = $brandId;
        return $this;
    }
    
    //BEGIN: ADDED BY URDHVA TECH
    public function getDocumentName()
    {
        return $this->documentName;
    }
    
    public function setDocumentName($documentName)
    {
        $this->documentName = $documentName;
        return $this;
    }
    
    public function getDocumentFileName()
    {
        return $this->documentFileName;
    }
    
    public function setDocumentFileName($documentFileName)
    {
        $this->documentFileName = $documentFileName;
        return $this;
    }
    
    public function getDocumentExtension()
    {
        return $this->documentExtension;
    }
    
    public function setDocumentExtension($documentExtension)
    {
        $this->documentExtension = $documentExtension;
        return $this;
    }
    
    public function getCstmSigners()
    {
        return $this->CstmSigners;
    }
    
    public function setCstmSigners($aCstmSigners)
    {
        $this->CstmSigners = $aCstmSigners;
        return $this;
    }
    
    public function getCstmCarbonCopy()
    {
        return $this->CstmCarbonCopy;
    }
    
    public function setCstmCarbonCopy($aCstmCarbonCopy)
    {
        $this->CstmCarbonCopy = $aCstmCarbonCopy;
        return $this;
    }
    
    public function getCstmEnvelopWebHookURL()
    {
        return $this->CstmEnvelopWebHookURL;
    }
    
    public function setCstmEnvelopWebHookURL($sCstmEnvelopWebHookURL)
    {
        $this->CstmEnvelopWebHookURL = $sCstmEnvelopWebHookURL;
        return $this;
    }
    
    public function getCstmEmailSubject()
    {
        return $this->CstmEmailSubject;
    }

    public function setCstmEmailSubject($sCstmEmailSubject)
    {
        $this->CstmEmailSubject = $sCstmEmailSubject;
        return $this;
    }
    
    public function getCstmEmailBlurb()
    {
        return $this->CstmEmailBlurb;
    }

    public function setCstmEmailBlurb($sCstmEmailBlurb)
    {
        $this->CstmEmailBlurb = $sCstmEmailBlurb;
        return $this;
    }
    
    public function getCstmSenderViewReturnURL()
    {
        return $this->CstmSenderViewReturnURL;
    }

    public function setCstmSenderViewReturnURL($sSenderViewReturnURL)
    {
        $this->CstmSenderViewReturnURL = $sSenderViewReturnURL;
        return $this;
    }
    
    public function getCstmSignHereTab()
    {
        return $this->CstmSignHereTab;
    }
    
    public function setCstmSignHereTab($aCstmSignHereTab)
    {
        $this->CstmSignHereTab = $aCstmSignHereTab;
        return $this;
    }
    public function getCstmInitialHereTab()
    {
        return $this->CstmInitialHereTab;
    }
    
    public function setCstmInitialHereTab($aCstmInitialHereTab)
    {
        $this->CstmInitialHereTab = $aCstmInitialHereTab;
        return $this;
    }
    
    
    public function getCstmDateSignedTab()
    {
        return $this->CstmDateSignedTab;
    }
    
    public function setCstmDateSignedTab($aCstmDateSignedHereTab)
    {
        $this->CstmDateSignedTab = $aCstmDateSignedHereTab;
        return $this;
    }
    
    //ENDS: ADDED BY URDHVA TECH
    public function getTemplates()
    {
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        $aTemplates = array();
        $iFlag=true;
        if (empty($this->getAccountId())) {
            $aReturn['error'] = 'Configuration error, Please check the DocuSign settings';
            return $aReturn;
        }
        $iStartPosition=0;
        try {
            // Get the template details
            $templateApi = new DocuSign\eSign\Api\TemplatesApi($this->getApiClient());
            $options = new \DocuSign\eSign\Api\TemplatesApi\ListTemplatesOptions();
            do {
                // optional template parameters
                $options->setStartPosition($iStartPosition);
                $oEnvelopeTemplateResults = $templateApi->listTemplates($this->getAccountId(), $options);
                $aEnvelopeTemplateResult = $oEnvelopeTemplateResults->getEnvelopeTemplates();
                if (!empty($aEnvelopeTemplateResult)) {
                    foreach ($aEnvelopeTemplateResult as $oEnvelopeTemplateResult) {
                        $aTemplates[$oEnvelopeTemplateResult->getTemplateId()]=$oEnvelopeTemplateResult->getName();
                    }
                    $iStartPosition = $oEnvelopeTemplateResults->getEndPosition()+1;
                } else {
                    $iFlag = false;
                }
            } while ($iFlag);
            $aReturn['response'] =  $aTemplates;
        } catch (DocuSign\eSign\ApiException $ex) {
            $sErrorMsg = $ex->getMessage().' </br>';
            if (!empty($ex->getResponseObject())) {
                $aError = json_decode($ex->getResponseObject(), true);
                if (!empty($aError['errorCode'])) {
                    $sErrorMsg .= $aError['message']." (". $aError['errorCode'].") </br>";
                }
            }
            $aReturn['error'] = $sErrorMsg;
        }
        return $aReturn;
    }
    public function getTemplateDetails($rs_template_id)
    {
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        if (empty($this->getAccountId())) {
            $aReturn['error'] = 'Configuration error, Please check the DocuSign settings';
            return $aReturn;
        }
        try {
            // Get the template details
            $templateApi = new DocuSign\eSign\Api\TemplatesApi($this->getApiClient());
            $options = new DocuSign\eSign\Api\TemplatesApi\GetOptions();
            $options->setInclude('tabs');
            $oEnvelopeTemplate = $templateApi->get($this->getAccountId(), $rs_template_id, $options);
            $aReturn['response'] = $oEnvelopeTemplate;
            //$templateApi->getDocuments();
        } catch (DocuSign\eSign\ApiException $ex) {
            $sErrorMsg = $ex->getMessage().' </br>';
            if (!empty($ex->getResponseObject())) {
                $aError = json_decode($ex->getResponseObject(), true);
                if (!empty($aError['errorCode'])) {
                    $sErrorMsg .= $aError['message']." (". $aError['errorCode'].") </br>";
                }
            }
            $aReturn['error'] = $sErrorMsg;
        }
        return $aReturn;
    }
    public function getEnvelopStatus($sEnvelopeId)
    {
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        if (empty($this->getAccountId())) {
            $aReturn['error'] = 'Configuration error, Please check the DocuSign settings';
            return $aReturn;
        }
        try {
            // Get the template details
            $envelopeApi = new DocuSign\eSign\Api\EnvelopesApi($this->getApiClient());
            
            $oEnvelopeIdsRequest = new DocuSign\eSign\Model\EnvelopeIdsRequest();
            $oEnvelopeIdsRequest->setEnvelopeIds(array($sEnvelopeId));
            //$sEnvelopeIds = json_encode($oEnvelopeIdsRequest->getEnvelopeIds());
            $oStatusOption = new DocuSign\eSign\Api\EnvelopesApi\ListStatusOptions();
            $oStatusOption->setEnvelopeIds('request_body');
            $aReturn['response'] = $envelopeApi->listStatus($this->getAccountId(), $oEnvelopeIdsRequest, $oStatusOption);
        } catch (DocuSign\eSign\ApiException $ex) {
            $sErrorMsg = $ex->getMessage().' </br>';
            if (!empty($ex->getResponseObject())) {
                $aError = json_decode($ex->getResponseObject(), true);
                if (!empty($aError['errorCode'])) {
                    $sErrorMsg .= $aError['message']." (". $aError['errorCode'].") </br>";
                }
            }
            $aReturn['error'] = $sErrorMsg;
        }
        return $aReturn;
    }
    public function getEnvelope($sEnvelopeId)
    {
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        if (empty($this->getAccountId())) {
            $aReturn['error'] = 'Configuration error, Please check the DocuSign settings';
            return $aReturn;
        }
        try {
            // Get the template details
            $envelopeApi = new DocuSign\eSign\Api\EnvelopesApi($this->getApiClient());
            $aReturn['response'] = $envelopeApi->getEnvelope($this->getAccountId(), $sEnvelopeId);
        } catch (DocuSign\eSign\ApiException $ex) {
            $sErrorMsg = $ex->getMessage().' </br>';
            if (!empty($ex->getResponseObject())) {
                $aError = json_decode($ex->getResponseObject(), true);
                if (!empty($aError['errorCode'])) {
                    $sErrorMsg .= $aError['message']." (". $aError['errorCode'].") </br>";
                }
            }
            $aReturn['error'] = $sErrorMsg;
        }
        return $aReturn;
    }
    public function listAuditEvents($sEnvelopeId)
    {
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        $aAuditLists = array();
        if (empty($this->getAccountId())) {
            $aReturn['error'] = 'Configuration error, Please check the DocuSign settings';
            return $aReturn;
        }
        try {
            // Get the template details
            $envelopeApi = new DocuSign\eSign\Api\EnvelopesApi($this->getApiClient());
            $oEnvelopeAuditEventResponse = $envelopeApi->listAuditEvents($this->getAccountId(), $sEnvelopeId);
            $aAuditEvents = $oEnvelopeAuditEventResponse->getAuditEvents();
            
            $i=1;
            foreach ($aAuditEvents as $sK => $oEnvelopeAuditEvent) {
                //$oEnvelopeAuditEvent->getEventFields();
                if (!empty($oEnvelopeAuditEvent->getEventFields())) {
                    foreach ($oEnvelopeAuditEvent->getEventFields() as $sIdx => $oEventFields) {
                        $aAuditLists[$i][$oEventFields->getName()] = $oEventFields->getValue();
                    }
                }
                $i++;
            }
            $aReturn['response'] = $aAuditLists;
        } catch (DocuSign\eSign\ApiException $ex) {
            $sErrorMsg = $ex->getMessage().' </br>';
            if (!empty($ex->getResponseObject())) {
                $aError = json_decode($ex->getResponseObject(), true);
                if (!empty($aError['errorCode'])) {
                    $sErrorMsg .= $aError['message']." (". $aError['errorCode'].") </br>";
                }
            }
            $aReturn['error'] = $sErrorMsg;
        }
        return $aReturn;
    }
    public function listDocuments($sEnvelopeId)
    {
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        if (empty($this->getAccountId())) {
            $aReturn['error'] = 'Configuration error, Please check the DocuSign settings';
            return $aReturn;
        }
        try {
            // Get the template details
            $envelopeApi = new DocuSign\eSign\Api\EnvelopesApi($this->getApiClient());
            $aReturn['response'] = $envelopeApi->listDocuments($this->getAccountId(), $sEnvelopeId);
        } catch (DocuSign\eSign\ApiException $ex) {
            $sErrorMsg = $ex->getMessage().' </br>';
            if (!empty($ex->getResponseObject())) {
                $aError = json_decode($ex->getResponseObject(), true);
                if (!empty($aError['errorCode'])) {
                    $sErrorMsg .= $aError['message']." (". $aError['errorCode'].") </br>";
                }
            }
            $aReturn['error'] = $sErrorMsg;
        }
        return $aReturn;
    }
    public function getDocument($document_id, $sEnvelopeId)
    {
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        if (empty($this->getAccountId())) {
            $aReturn['error'] = 'Configuration error, Please check the DocuSign settings';
            return $aReturn;
        }
        try {
            // Get the template details
            $envelopeApi = new DocuSign\eSign\Api\EnvelopesApi($this->getApiClient());
            $aReturn['response'] = $envelopeApi->getDocument($this->getAccountId(), $document_id, $sEnvelopeId);
        } catch (DocuSign\eSign\ApiException $ex) {
            $sErrorMsg = $ex->getMessage().' </br>';
            if (!empty($ex->getResponseObject())) {
                $aError = json_decode($ex->getResponseObject(), true);
                if (!empty($aError['errorCode'])) {
                    $sErrorMsg .= $aError['message']." (". $aError['errorCode'].") </br>";
                }
            }
            $aReturn['error'] = $sErrorMsg;
        }
        return $aReturn;
    }
    /**
     * @depends testSignatureRequestOnDocumentCreated
     */
    public function CreateEmbeddedSendingView()
    {
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        //$this->SignatureRequestOnDocument("created", true);
        $aResp = $this->testSignatureRequestOnDocumentCreated(false);
        if (!empty($aResp['error'])) {
            return $aResp;
        }
        try {
            $envelopeApi = new DocuSign\eSign\Api\EnvelopesApi($this->getApiClient());
            $returnUrl = $this->getCstmSenderViewReturnURL();
            $return_url_request = new \DocuSign\eSign\Model\ReturnUrlRequest();
            $return_url_request->setReturnUrl($returnUrl);
            
            $senderView = $envelopeApi->createSenderView($this->getAccountId(), $this->getCreatedEnvelopeId(), $return_url_request);
            $aReturn['response'] = $senderView->getUrl();
        } catch (DocuSign\eSign\ApiException $ex) {
            $sErrorMsg = $ex->getMessage().' </br>';
            if (!empty($ex->getResponseObject())) {
                $aError = json_decode($ex->getResponseObject(), true);
                if (!empty($aError['errorCode'])) {
                    $sErrorMsg .= $aError['message']." (". $aError['errorCode'].") </br>";
                }
            }
            $aReturn['error'] = $sErrorMsg;
        }
        return $aReturn;
    }
    /**
     * @depends testLogin
     */
    public function testSignatureRequestOnDocument($embeddedSigning = false)
    {
        return $this->signatureRequestOnDocument("sent", $embeddedSigning);
    }
    public function testSignatureRequestOnDocumentCreated($embeddedSigning = false)
    {
        return $this->signatureRequestOnDocument("created", $embeddedSigning);
    }
    
    public function signatureRequestOnDocument($status = "sent", $embeddedSigning = false)
    {
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        $envelop_summary = null;
        $workflow_id = '';
        try {
            $documentFileName = $this->getDocumentFileName();
            $documentName = $this->getDocumentName();
            $documentExtension = $this->getDocumentExtension();
            if (!empty($this->getAccountId())) {
                $envelopeApi = new DocuSign\eSign\Api\EnvelopesApi($this->getApiClient());
                
                //BEGINS: Added by Urdhva Tech SMS
                if(!empty($this->is_sms_auth) && !empty($_REQUEST['sending_option']) && $_REQUEST['sending_option'] == 'sms_auth')
                {
                    $oAccountsAPI = new DocuSign\eSign\Api\AccountsApi($this->getApiClient());
                    $oIdentityVerificationOptions = new DocuSign\eSign\Api\AccountsApi\GetAccountIdentityVerificationOptions();
                    $oIdentityVerificationOptions->setIdentityVerificationWorkflowStatus('all');
                    $oIdentityVerifation = $oAccountsAPI->getAccountIdentityVerification($this->getAccountId(),$oIdentityVerificationOptions);
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
                        $aReturn['error'] = $sDesc;
                        return $aReturn;
                    }
                }

                //ENDS: Added by Urdhva Tech SMS
                
                // Add a document to the envelope
                $document = new DocuSign\eSign\Model\Document();
                $document->setDocumentBase64(base64_encode(file_get_contents($documentFileName)));
                $document->setName($documentName);
                $document->setFileExtension($documentExtension);
                $document->setDocumentId("1");

                // Create a |SignHere| tab somewhere on the document for the recipient to sign
                //$signHere = new \DocuSign\eSign\Model\SignHere();
//                $signHere->setXPosition("100");
//                $signHere->setYPosition("100");
//                $signHere->setDocumentId("1");
//                $signHere->setPageNumber("1");
//                $signHere->setRecipientId("1");
                $aCstmSignHereTab = $this->getCstmSignHereTab();
                $aCstmInitialHereTab = $this->getCstmInitialHereTab();
                $aCstmDateSignedTab = $this->getCstmDateSignedTab();
                $aCstmSigners = $this->getCstmSigners();
                $aSigners = array();
                $iCnt=1;
                $iCstmSignHereCount= 0;
                if (!empty($aCstmSigners)) {
                    foreach ($aCstmSigners as $sk => $aSigner) {
                        $oTabs = new DocuSign\eSign\Model\Tabs();
                        if (!empty($aCstmSignHereTab)) {
                            //$oTabs->setSignHereTabs($aCstmSignHereTab);
                            $oTabs->setSignHereTabs(array($aCstmSignHereTab[$iCstmSignHereCount]));
                        }
                        if (!empty($aCstmInitialHereTab)) {
                            //$oTabs->setInitialHereTabs($aCstmInitialHereTab);
                            $oTabs->setInitialHereTabs(array($aCstmInitialHereTab[$iCstmSignHereCount]));
                        }
                        if (!empty($aCstmDateSignedTab) && array_key_exists($iCstmSignHereCount, $aCstmDateSignedTab)) {
                            $oTabs->setDateSignedTabs(array($aCstmDateSignedTab[$iCstmSignHereCount]));
                        }
                        
                        $aListAllTabs = array();
                        $iFlagTabs=false;
                        $signer = new \DocuSign\eSign\Model\Signer();
                        $signer->setEmail($aSigner['signer_email']);
                        $signer->setName($aSigner['signer_name']);
                        $signer->setRoutingOrder($iCnt);
                        $signer->setRoleName($aSigner['cstm_roletype']);
                        //BEGINS: Added by Urdhva Tech SMS
                        if(!empty($aSigner['sms_otp_auth']) && $aSigner['sms_otp_auth'] == true && !empty($aSigner['signer_phone'])) {
                            $SignerCountryCode = !empty($sugar_config['docusign_sms_country_code']) ? $sugar_config['docusign_sms_country_code'] : '1';
                            $signer_country_code = preg_replace('/([^\w \-\@\.\,])+/', '', $SignerCountryCode);
                            $aSigner['signer_phone'] = preg_replace('/([^\w \-\@\.\,])+/', '', $aSigner['signer_phone']);
                            
                            $phoneNumber = new DocuSign\eSign\Model\RecipientIdentityPhoneNumber();
                            $phoneNumber->setCountryCode($signer_country_code);
                            $phoneNumber->setNumber($aSigner['signer_phone']);

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
                        }
                        if(!empty($aSigner['sms_sending']) && $aSigner['sms_sending'] == true && !empty($aSigner['signer_phone'])) 
                        {
                            //$signer_country_code = preg_replace('/([^\w \-\@\.\,])+/', '', $_POST['countryCode']);
                            $aSigner['signer_phone'] = preg_replace('/([^\w \-\@\.\,])+/', '', $aSigner['signer_phone']);
                            $delivery_method = 'sms';
                            /*
                            $SMSDelivery = new DocuSign\eSign\Model\RecipientAdditionalNotification();
                            $SMSDelivery->setSecondaryDeliveryMethod("SMS");
                            $signerPhone = new DocuSign\eSign\Model\RecipientPhoneNumber([
                                'country_code' => '1',
                                'number' => $aSigner['signer_phone']
                            ]);
                            $SMSDelivery->setPhoneNumber($signerPhone);
                            */
                            //$SMSDelivery = new DocuSign\eSign\Model\RecipientAdditionalNotification();
//                            $SMSDelivery->setSecondaryDeliveryMethod("SMS");
                            $signerPhone = new DocuSign\eSign\Model\RecipientPhoneNumber([
                                'country_code' => '1',
                                'number' => $aSigner['signer_phone']
                            ]);
                            //$SMSDelivery->setPhoneNumber($signerPhone);
                            //$signer->setAdditionalNotifications($SMSDelivery);
                            $signer->setDeliveryMethod($delivery_method); // Added by Urdhva Tech SMS
                            $signer->setPhoneNumber($signerPhone); // Added by Urdhva Tech SMS
                        }
                        //ENDS: Added by Urdhva Tech SMS
                        //BEGIN: Recipient Authentication Settings :
                        // Settings available on Admin->Security Settings -> "Account Security"
                        // 1) Any recipient must authenticate on every envelope sent from this account
                        // 2) The sender can require that a recipient must authenticate on any envelope sent from this account
                        // 3) Disable recipient authentication for this account
                        //$signer->setIdCheckConfigurationName('ID Check');
                        //END: Recipient Authentication Settings :
                        $signer->setRecipientId($iCnt);
                        if ($embeddedSigning) {
                            $signer->setClientUserId($this->getClientUserId());
                        }
                        if (!empty($aCstmSignHereTab[$iCstmSignHereCount])) {
                            $iFlagTabs=true;
                        }
                        // As this is the CreateSenderView for uploading and sending. Parsing the CRM fields on to docusign is not possible. As the Tabs are being sent before and then on the iframe the admin creates the textfields(or other tabs)
                        /*
                        if(!empty($aSigner['cstm_sugar_id']) && !empty($aSigner['cstm_sugar_module']))
                            $aListAllTabs = $this->getCRMTabsToSend($aSigner['cstm_sugar_id'],$aSigner['cstm_sugar_module']);
                        if(!empty($aListAllTabs['response']))
                        {
                            $iFlagTabs=true;
                            foreach($aListAllTabs['response'] as $sTabType => $aTabs){
                                if($sTabType == 'TextTabs'){
                                    $oTabs->setTextTabs($aTabs);
                                }
                            }

                        }
                        */
                        if ($iFlagTabs == true) {
                            $signer->setTabs($oTabs);
                        }
                        array_push($aSigners, $signer);
                        $iCnt++;
                        $iCstmSignHereCount++;
                    }
                }
                
                
                $aCstmCarbonCopy = $this->getCstmCarbonCopy();
                $aCarbonCopy = array();
                if (!empty($aCstmCarbonCopy)) {
                    foreach ($aCstmCarbonCopy as $sk => $aCopy) {
                        $carboncopy = new \DocuSign\eSign\Model\CarbonCopy();
                        $carboncopy->setEmail($aCopy['signer_email']);
                        $carboncopy->setName($aCopy['signer_name']);
                        $carboncopy->setRecipientId($iCnt);
                        
                        //BEGINS: Added by Urdhva Tech SMS
                        if(!empty($aCopy['sms_otp_auth']) && $aCopy['sms_otp_auth'] == true && !empty($aCopy['signer_phone'])) {
                            $SignerCountryCode = !empty($sugar_config['docusign_sms_country_code']) ? $sugar_config['docusign_sms_country_code'] : '1';
                            $signer_country_code = preg_replace('/([^\w \-\@\.\,])+/', '', $SignerCountryCode);
                            $aCopy['signer_phone'] = preg_replace('/([^\w \-\@\.\,])+/', '', $aCopy['signer_phone']);
                            
                            $phoneNumber = new DocuSign\eSign\Model\RecipientIdentityPhoneNumber();
                            $phoneNumber->setCountryCode($signer_country_code);
                            $phoneNumber->setNumber($aCopy['signer_phone']);

                            $inputOption = new DocuSign\eSign\Model\RecipientIdentityInputOption();
                            $inputOption->setName('phone_number_list');
                            $inputOption->setValueType('PhoneNumberList');
                            $inputOption->setPhoneNumberList(array($phoneNumber));

                            $identityVerification = new DocuSign\eSign\Model\RecipientIdentityVerification();
                            $identityVerification->setWorkflowId($workflow_id);
                            $identityVerification->setInputOptions(array($inputOption));
                            
                            $delivery_method = 'email';
                            $carboncopy->setDeliveryMethod($delivery_method);
                            $carboncopy->setIdentityVerification($identityVerification);
                        }
                        if(!empty($aCopy['sms_sending']) && $aCopy['sms_sending'] == true && !empty($aCopy['signer_phone'])) {
                            //$signer_country_code = preg_replace('/([^\w \-\@\.\,])+/', '', $_POST['countryCode']);
                            $aCopy['signer_phone'] = preg_replace('/([^\w \-\@\.\,])+/', '', $aCopy['signer_phone']);
                            $delivery_method = 'sms';
                            //$SMSDelivery = new DocuSign\eSign\Model\RecipientAdditionalNotification();
//                            $SMSDelivery->setSecondaryDeliveryMethod("SMS");
                            $signerPhone = new DocuSign\eSign\Model\RecipientPhoneNumber([
                                'country_code' => '1',
                                'number' => $aCopy['signer_phone']
                            ]);
//                            $SMSDelivery->setPhoneNumber($signerPhone);
                            //$carboncopy->setAdditionalNotifications($SMSDelivery);
                            $carboncopy->setDeliveryMethod($delivery_method); // Added by Urdhva Tech SMS
                            $carboncopy->setPhoneNumber($signerPhone); // Added by Urdhva Tech SMS
                        }
                        //ENDS: Added by Urdhva Tech SMS
                        
                        if ($embeddedSigning) {
                            $carboncopy->setClientUserId($this->getClientUserId());
                        }
                        //$carboncopy->setTabs($tabs);
                        array_push($aCarbonCopy, $carboncopy);
                        $iCnt++;
                    }
                }
                // Add a recipient to sign the document
                $recipients = new DocuSign\eSign\Model\Recipients();
                if (!empty($aSigners)) {
                    $recipients->setSigners($aSigners);
                }
                if (!empty($aCarbonCopy)) {
                    $recipients->setCarbonCopies($aCarbonCopy);
                }
                
                $envelop_definition = new DocuSign\eSign\Model\EnvelopeDefinition();
                $envelop_definition->setEmailSubject($this->getCstmEmailSubject());
                $envelop_definition->setEmailBlurb($this->getCstmEmailBlurb());

                // set envelope status to "sent" to immediately send the signature request
                $envelop_definition->setStatus($status);
                $envelop_definition->setRecipients($recipients);
                $envelop_definition->setDocuments(array($document));
                
                // When we submit application from demo to production. We need to stop makig calls to webhooks, and other extra calls, It use to give Polling error.
                if ($this->getDSEnvironment() != "submit_for_review") {
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
                    if (!empty($this->getCstmEnvelopWebHookURL())) {
                        $eventNotification->setUrl($this->getCstmEnvelopWebHookURL());
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

                $options = new \DocuSign\eSign\Api\EnvelopesApi\CreateEnvelopeOptions();
                $options->setCdseMode(null);
                $options->setMergeRolesOnDraft(null);

                $envelop_summary = $envelopeApi->createEnvelope($this->getAccountId(), $envelop_definition, $options);
                if (!empty($envelop_summary)) {
                    if ($status == "created") {
                        $this->setCreatedEnvelopeId($envelop_summary->getEnvelopeId());
                    } else {
                        $this->setEnvelopeId($envelop_summary->getEnvelopeId());
                    }
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
            $aReturn['error'] = $sErrorMsg;
        } catch (Throwable $ex) {
                // Catching other Throwables (including Errors)
                $sErrorMsg = '';
                if (!empty($ex->getResponseObject())) {
                    $aError = json_decode($ex->getResponseObject(), true);
                    if (!empty($aError['errorCode'])) {
                        $sErrorMsg .= $aError['message']." (". $aError['errorCode'].") </br>";
                    }
                }
                $aReturn['error'] = $sErrorMsg;
            }
        return $aReturn;
    }
    
    public function getCRMTabsToSend($sSugarRecId, $sSugarModule)
    {
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        if (empty($sSugarRecId) || empty($sSugarModule)) {
            $aReturn['error'] = 'Missing arguments';
            return $aReturn;
        }
        $aTabs = array();
        
        $oMyTextTab = new DocuSign\eSign\Model\Text();
        $oMyTextTab->setTabLabel('first_name');
        //$oMyTextTab->setValue($oSugarBean->$sSugarFieldName);
        $oMyTextTab->setValue('Test value');
        $oMyTextTab->setRecipientId($sSugarRecId);
        $aTabs['TextTabs'][]=$oMyTextTab;
        
        $aReturn['response']=$aTabs;
        return $aReturn;
    }
    
    public function getReceipeintSupportedTabLabels($oTabs)
    {
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        if (empty($oTabs)) {
            $aReturn['error'] = 'Missing arguments';
            return $aReturn;
        }
        $aTabs = array();
        //getCheckboxTabs()
//      getCompanyTabs() //This value cannot be set.
//      getDateSignedTabs() //This value cannot be set.
//      getDateTabs()
//      getEmailAddressTabs() //This value cannot be set.
//      getEmailTabs()
//      getFirstNameTabs() //This value cannot be set.
//      getFullNameTabs() //This value cannot be set.
//      getLastNameTabs() //This value cannot be set.
//      getListTabs();
//      getNoteTabs()
//      getNumberTabs()
//      getRadioGroupTabs()
//      getTextTabs()
//      getTitleTabs() //This value cannot be set.
//      getSSNTabs()
//      getZipTabs()
        // TextTabs
        $aTextTabs = $oTabs->getTextTabs();
        if (!empty($aTextTabs)) {
            foreach ($aTextTabs as $sk => $oTextTab) {
                $aTabs['TextTabs'][] = $oTextTab->getTabLabel();
            }
        }
        // RadioGroupTabs
        $aRadioGroupTabs = $oTabs->getRadioGroupTabs();
        if (!empty($aRadioGroupTabs)) {
            foreach ($aRadioGroupTabs as $sk => $oRadioGroupTab) {
                $aTabs['RadioGroupTabs'][]=$oRadioGroupTab->getGroupName();
            }
        }
        // CheckboxTabs
        $aCheckboxTabs = $oTabs->getCheckboxTabs();
        if (!empty($aCheckboxTabs)) {
            foreach ($aCheckboxTabs as $sk => $oCheckboxTab) {
                $aTabs['CheckboxTabs'][]=$oCheckboxTab->getTabLabel();
            }
        }
        // DateTabs (On Docusign Template create a textbox and set the validation rule to date)
        $aDateTabs = $oTabs->getDateTabs();
        if (!empty($aDateTabs)) {
            foreach ($aDateTabs as $sk => $oDateTab) {
                $aTabs['DateTabs'][]=$oDateTab->getTabLabel();
            }
        }
        //getEmailTabs
        $aEmailTabs = $oTabs->getEmailTabs();
        if (!empty($aEmailTabs)) {
            foreach ($aEmailTabs as $sk => $oEmailTab) {
                $aTabs['EmailTabs'][]=$oEmailTab->getTabLabel();
            }
        }
        //getListTabs // Note when dropdown is kept on Docusign Template, the API fails, The issue is registered on github
        $aListTabs = $oTabs->getListTabs();
        if (!empty($aListTabs)) {
            foreach ($aListTabs as $sk => $oListTab) {
                $aTabs['ListTabs'][]=$oListTab->getTabLabel();
            }
        }
        //NoteTabs
        $aNoteTabs = $oTabs->getNoteTabs();
        if (!empty($aNoteTabs)) {
            foreach ($aNoteTabs as $sk => $oNoteTab) {
                $aTabs['NoteTabs'][]=$oNoteTab->getTabLabel();
            }
        }
        //NumberTabs
        $aNumberTabs = $oTabs->getNumberTabs();
        if (!empty($aNumberTabs)) {
            foreach ($aNumberTabs as $sk => $oNumberTab) {
                $aTabs['NumberTabs'][]=$oNumberTab->getTabLabel();
            }
        }
        //SSNTabs
        $aSSNTabs = $oTabs->getSSNTabs();
        if (!empty($aSSNTabs)) {
            foreach ($aSSNTabs as $sk => $oSSNTab) {
                $aTabs['SSNTabs'][]=$oSSNTab->getTabLabel();
            }
        }
        //getZipTabs
        $aZipTabs = $oTabs->getZipTabs();
        if (!empty($aZipTabs)) {
            foreach ($aZipTabs as $sk => $oZipTab) {
                $aTabs['ZipTabs'][]=$oZipTab->getTabLabel();
            }
        }
        $aReturn['response']=$aTabs;
        return $aReturn;
    }
    
    public function getParsedTabsToSend($sTemplateId, $oEnvelopeTemplate, $aRoleName = array(), $aCRMRolesData, $aCRMRowData)
    {
        global $timedate;
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        if (empty($oEnvelopeTemplate) || empty($sTemplateId) || empty($aRoleName) || empty($aRoleName['name'])
            || empty($aRoleName['cstm_roletype']) || empty($aRoleName['cstm_sugar_id']) || empty($aRoleName['cstm_sugar_module']) || empty($aCRMRolesData) || empty($aCRMRowData)) {
            $aReturn['error'] = 'Missing arguments';
            return $aReturn;
        }
        $aRout_Sequence = explode('_', $aRoleName['rout_sequence']);
        //$oEnvelopeTemplateDefinition = $oEnvelopeTemplate->getEnvelopeTemplateDefinition();

        $oRecipients = $oEnvelopeTemplate->getRecipients();
        $aSigners = $oRecipients->getSigners();
        $aInPersonSigners = $oRecipients->getInPersonSigners();
        //$aCarbonCopies = $oRecipients->getCarbonCopies();
        $aSupportedParsing=array();
        if (!empty($aSigners)) {
            $aSupportedParsing[] = $aSigners;
        }
        if (!empty($aInPersonSigners)) {
            $aSupportedParsing[] = $aInPersonSigners;
        }

        $aTabs = array();
        $oSugarBean = BeanFactory::getBean($aRoleName['cstm_sugar_module'], $aRoleName['cstm_sugar_id']);
        
        if (!empty($aSupportedParsing)) {
            foreach ($aSupportedParsing as $sK => $aSigners) {
                foreach ($aSigners as $oSigner) {
                    if (empty($aRoleName['sequence'])) {
                        continue;
                    }
                    $sSignerRoleName = $oSigner->getRoleName();
                    //$aRoutingAndUnique = explode('_',$aRoleName['sequence']);
                    $aRoutingAndUnique = $aRout_Sequence;
                    if (empty($aRoutingAndUnique)) {
                        continue;
                    }
                    $sSequenceNumber = $aRoutingAndUnique[0];
                    if ($oSigner->getRoutingOrder() == $sSequenceNumber && $aRoleName['name'] == $sSignerRoleName) {
                        $sRoutingOrderKey = $aRoutingAndUnique[0];
                        $iOrderUniqueCnt = $aRoutingAndUnique[1];
                        if (!empty($aCRMRowData[$sRoutingOrderKey][$iOrderUniqueCnt])) {
                            if (!empty($aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['crm_module'])) {
                                //$ModName = $aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['crm_module'];
                                //$oSugarBean = BeanFactory::getBean($ModName,$aRoleName['cstm_sugar_id']);
                                $oTabs = $oSigner->getTabs();
                                //getCheckboxTabs()
                                //                    getCompanyTabs() //This value cannot be set.
                                //                    getDateSignedTabs() //This value cannot be set.
                                //                    getDateTabs()
                                //                    getEmailAddressTabs() //This value cannot be set.
                                //                    getEmailTabs()
                                //                    getFirstNameTabs() //This value cannot be set.
                                //                    getFullNameTabs() //This value cannot be set.
                                //                    getLastNameTabs() //This value cannot be set.
                                //                    getListTabs();
                                //                    getNoteTabs()
                                //                    getNumberTabs()
                                //                    getRadioGroupTabs()
                                //                    getTextTabs()
                                //                    getTitleTabs() //This value cannot be set.
                                //                    getSSNTabs()
                                //                    getZipTabs()
                                foreach ($aCRMRowData[$sRoutingOrderKey][$iOrderUniqueCnt] as $sMapRowId => $aMappData) {
                                    $aDsField = explode(',', $aMappData['ds_field']);
                                    $sSugarFieldName = $aMappData['crm_field'];
                                    foreach ($aDsField as $sDsFieldName) {
                                        // TextTabs
                                        $aTextTabs = $oTabs->getTextTabs();
                                        if (!empty($aTextTabs)) {
                                            foreach ($aTextTabs as $sk => $oTextTab) {
                                                $sTabName = $oTextTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $oTextTab->setValue($oSugarBean->$sSugarFieldName);
                                                    $aTabs['TextTabs'][]=$oTextTab;
                                                }
                                            }
                                        }
                                        // RadioGroupTabs
                                        $aRadioGroupTabs = $oTabs->getRadioGroupTabs();
                                        if (!empty($aRadioGroupTabs)) {
                                            foreach ($aRadioGroupTabs as $sk => $oRadioGroupTab) {
                                                $sTabName = $oRadioGroupTab->getGroupName();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $aRadios = $oRadioGroupTab->getRadios();
                                                    foreach ($aRadios as $sRk => $oRadio) {
                                                        if ($oRadio->getValue() == $oSugarBean->$sSugarFieldName) {
                                                            $oRadio->setSelected('true');
                                                        }
                                                        $radios[]=$oRadio;
                                                    }
                                                    $aTabs['RadioGroupTabs'][]=$oRadioGroupTab;
                                                }
                                            }
                                        }
                                        // CheckboxTabs
                                        $aCheckboxTabs = $oTabs->getCheckboxTabs();
                                        if (!empty($aCheckboxTabs)) {
                                            foreach ($aCheckboxTabs as $sk => $oCheckboxTab) {
                                                $sTabName = $oCheckboxTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    if ($oSugarBean->$sSugarFieldName == 1 || $oSugarBean->$sSugarFieldName == true) {
                                                        $oCheckboxTab->setSelected('true');
                                                    }
                                                    $aTabs['CheckboxTabs'][]=$oCheckboxTab;
                                                }
                                            }
                                        }
                                        // DateTabs (On Docusign Template create a textbox and set the validation rule to date)
                                        $aDateTabs = $oTabs->getDateTabs();
                                        if (!empty($aDateTabs)) {
                                            foreach ($aDateTabs as $sk => $oDateTab) {
                                                $sTabName = $oDateTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    if (!empty($oSugarBean->$sSugarFieldName)) {
                                                        $sValidationPattern = $oDateTab->getValidationPattern();

                                                        if (!empty($sValidationPattern) && $oSugarBean->field_defs[$sSugarFieldName]['type'] == 'date') {
                                                            $sDateValue = $timedate->to_db_date($oSugarBean->$sSugarFieldName, false);
                                                            //DD/MM/YYYY
                                                            if ($sValidationPattern == '^(|by DocuSign)((|0)[1-9]|[1-2][0-9]|3[0-1])/((|0)[1-9]|1[0-2])/[0-9]{4}$') {
                                                                $aTmpDate = explode('-', $sDateValue);
                                                                $sDateValue = $aTmpDate[2].'/'.$aTmpDate[1].'/'.$aTmpDate[0];
                                                            }
                                                            //MM/DD/YYYY
                                                            elseif ($sValidationPattern == '^(|by DocuSign)((|0)[1-9]|1[0-2])/((|0)[1-9]|[1-2][0-9]|3[0-1])/[0-9]{4}$') {
                                                                $aTmpDate = explode('-', $sDateValue);
                                                                $sDateValue = $aTmpDate[1].'/'.$aTmpDate[2].'/'.$aTmpDate[0];
                                                            }
                                                            //YYYY/MM/DD
                                                            elseif ($sValidationPattern == '^(|by DocuSign)[0-9]{4}/((|0)[1-9]|1[0-2])/((|0)[1-9]|[1-2][0-9]|3[0-1])$') {
                                                                $aTmpDate = explode('-', $sDateValue);
                                                                $sDateValue = $aTmpDate[0].'/'.$aTmpDate[1].'/'.$aTmpDate[2];
                                                            }
                                                            $oDateTab->setValue($sDateValue);
                                                        } elseif ($oSugarBean->field_defs[$sSugarFieldName]['type'] == 'datetime' || $oSugarBean->field_defs[$sSugarFieldName]['type'] == 'datetimecombo') {
                                                            //datetime
                                                            $aTmpDateTime = explode(' ', $oSugarBean->$sSugarFieldName);
                                                            $sDateValue = $timedate->to_db_date($aTmpDateTime[0], false);
                                                            //DD/MM/YYYY
                                                            if ($sValidationPattern == '^(|by DocuSign)((|0)[1-9]|[1-2][0-9]|3[0-1])/((|0)[1-9]|1[0-2])/[0-9]{4}$') {
                                                                $aTmpDate = explode('-', $sDateValue);
                                                                $sDateValue = $aTmpDate[2].'/'.$aTmpDate[1].'/'.$aTmpDate[0];
                                                            }
                                                            //MM/DD/YYYY
                                                            elseif ($sValidationPattern == '^(|by DocuSign)((|0)[1-9]|1[0-2])/((|0)[1-9]|[1-2][0-9]|3[0-1])/[0-9]{4}$') {
                                                                $aTmpDate = explode('-', $sDateValue);
                                                                $sDateValue = $aTmpDate[1].'/'.$aTmpDate[2].'/'.$aTmpDate[0];
                                                            }
                                                            //YYYY/MM/DD
                                                            elseif ($sValidationPattern == '^(|by DocuSign)[0-9]{4}/((|0)[1-9]|1[0-2])/((|0)[1-9]|[1-2][0-9]|3[0-1])$') {
                                                                $aTmpDate = explode('-', $sDateValue);
                                                                $sDateValue = $aTmpDate[0].'/'.$aTmpDate[1].'/'.$aTmpDate[2];
                                                            }
                                                            $oDateTab->setValue($sDateValue. " ".$aTmpDateTime[1]);
                                                        }
                                                    }
                                                    $aTabs['DateTabs'][]=$oDateTab;
                                                }
                                            }
                                        }
                                        //getEmailTabs
                                        $aEmailTabs = $oTabs->getEmailTabs();
                                        if (!empty($aEmailTabs)) {
                                            foreach ($aEmailTabs as $sk => $oEmailTab) {
                                                $sTabName = $oEmailTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    if (!empty($oSugarBean->$sSugarFieldName)) {
                                                        $oEmailTab->setValue($oSugarBean->$sSugarFieldName);
                                                    }
                                                    $aTabs['EmailTabs'][]=$oEmailTab;
                                                }
                                            }
                                        }
                                        //getListTabs // Note when dropdown is kept on Docusign Template, the API fails, The issue is registered on github
                                        $aListTabs = $oTabs->getListTabs();
                                        if (!empty($aListTabs)) {
                                            foreach ($aListTabs as $sk => $oListTab) {
                                                $sTabName = $oListTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $aTest = array();
                                                    foreach($oListTab['list_items'] as $utListKey => $oUTListItem) 
                                                    {
                                                        $docuSignText = $oUTListItem->getValue();
                                                        if($docuSignText == $oSugarBean->$sSugarFieldName)
                                                            $oUTListItem->setSelected(true);
                                                        
                                                        $aTest[] = $oUTListItem;
                                                    }
                                                    if(!empty($aTest)){
                                                        $oListTab['list_items']  = $aTest;
                                                    }
                                                    $oListTab->setValue($oSugarBean->$sSugarFieldName);
                                                    $aTabs['ListTabs'][]=$oListTab;
                                                }
                                            }
                                        }
                                        //NoteTabs
                                        $aNoteTabs = $oTabs->getNoteTabs();
                                        if (!empty($aNoteTabs)) {
                                            foreach ($aNoteTabs as $sk => $oNoteTab) {
                                                $sTabName = $oNoteTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $oNoteTab->setValue($oSugarBean->$sSugarFieldName);
                                                    $aTabs['NoteTabs'][]=$oNoteTab;
                                                }
                                            }
                                        }
                                        //NumberTabs
                                        $aNumberTabs = $oTabs->getNumberTabs();
                                        if (!empty($aNumberTabs)) {
                                            foreach ($aNumberTabs as $sk => $oNumberTab) {
                                                $sTabName = $oNumberTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $oNumberTab->setValue($oSugarBean->$sSugarFieldName);
                                                    $aTabs['NumberTabs'][]=$oNumberTab;
                                                }
                                            }
                                        }
                                        //SSNTabs
                                        $aSSNTabs = $oTabs->getSSNTabs();
                                        if (!empty($aSSNTabs)) {
                                            foreach ($aSSNTabs as $sk => $oSSNTab) {
                                                $sTabName = $oSSNTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName &&  property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $oSSNTab->setValue($oSugarBean->$sSugarFieldName);
                                                    $aTabs['SSNTabs'][]=$oSSNTab;
                                                }
                                            }
                                        }
                                        //ZipTabs
                                        $aZipTabs = $oTabs->getZipTabs();
                                        if (!empty($aZipTabs)) {
                                            foreach ($aZipTabs as $sk => $oZipTab) {
                                                $sTabName = $oZipTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName &&  property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $oZipTab->setValue($oSugarBean->$sSugarFieldName);
                                                    $aTabs['ZipTabs'][]=$oZipTab;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        $aReturn['response']=$aTabs;
        return $aReturn;
    }
    
    public function getParsedTabsToReceive($sTemplateId, $oEnvelope, $oEnvelopeTemplate, $aRoleName = array(), $aCRMRolesData, $aCRMRowData)
    {
        global $datetime, $current_user;
        $aReturn = array(
                    'error' => '',
                    'response' => array()
                    );
        if (empty($oEnvelopeTemplate) || empty($sTemplateId) || empty($aRoleName) || empty($aCRMRolesData) || empty($aCRMRowData)) {
            $aReturn['error'] = 'Missing arguments';
            return $aReturn;
        }
        $aSentRecipientsSupportedParsing = $aSugarData = array();
        //$oEnvelopeTemplateDefinition = $oEnvelopeTemplate->getEnvelopeTemplateDefinition();
        //$aSentRecipients = $oEnvelope->getRecipients();
        try {
            $envelopeApi = new DocuSign\eSign\Api\EnvelopesApi($this->getApiClient());
            //$options = new DocuSign\eSign\Api\EnvelopesApi\ListRecipientsOptions();
            //$options->setIncludeTabs('true');
            $oSentRecipients = $envelopeApi->listRecipients($this->getAccountId(), $oEnvelope->getEnvelopeId());
            if (!empty($oSentRecipients)) {
                $aSigners = $oSentRecipients->getSigners();
                $aInPersonSigners = $oSentRecipients->getInPersonSigners();
                if (!empty($aSigners)) {
                    $aSentRecipientsSupportedParsing[] = $aSigners;
                }
                if (!empty($aInPersonSigners)) {
                    $aSentRecipientsSupportedParsing[] = $aInPersonSigners;
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
            $aReturn['error'] = $sErrorMsg;
            return $aReturn;
        }
        
        $aRoutingOrder=array();
        $aRoutingOrderProcessed=array();
        $aRoutingOrderPrepared=array();
        // Loop through the saved roles and if any match found then get its tab data
        foreach ($aRoleName as $SequenceKey => $aRole) {
            $aTailHasValue = explode('sequence|||', $SequenceKey);
            $aRoutingAndUnique = explode('_', $aTailHasValue[1]);// 1_1 or 1_2
            $sSequenceNumber = $aRoutingAndUnique[0];
            $aRoutingOrder[$aRoutingAndUnique[0]][$aRoutingAndUnique[1]] = $aRole;
        }

        if (!empty($aSentRecipientsSupportedParsing)) {
            foreach ($aSentRecipientsSupportedParsing as $sK => $aSigners) {
                foreach ($aSigners as $oSigner) {
                    foreach ($aRoutingOrder as $sRoutingOrderKey => $aUniqueCnt) {
                        foreach ($aUniqueCnt as $iOrderUniqueCnt => $aRole) {
                            if (empty($aRoutingOrderProcessed[$sRoutingOrderKey][$iOrderUniqueCnt])
                                && $oSigner->getRoleName() == $aRole['name'] && $oSigner->getRoutingOrder() == $aRole['sequence']) {
                                $aRoutingOrderProcessed[$sRoutingOrderKey][$iOrderUniqueCnt] = true;
                                $aRoutingOrderPrepared[$sRoutingOrderKey][$iOrderUniqueCnt]['saved_role'] = $aRole;
                                $aRoutingOrderPrepared[$sRoutingOrderKey][$iOrderUniqueCnt]['sent_signer'] = $oSigner;
                            }
                        }
                    }
                }
            }
            if (!empty($aRoutingOrderPrepared)) {
                foreach ($aRoutingOrderPrepared as $sRoutingOrderKey => $aUniqueCnt) {
                    foreach ($aUniqueCnt as $iOrderUniqueCnt => $aInfo) {
                        // Saved Mapping module and Document sent to module differs.
                        if ($aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['crm_module'] != $aInfo['saved_role']['cstm_sugar_module']) {
                            $GLOBALS['log']->fatal("Docusign: Saved Mapping module and Document sent to module differs. Fields for module ".$aInfo['saved_role']['cstm_sugar_module']." didnt got updated.");
                            $aReturn['error'] .= "Docusign: Saved Mapping module and Document sent to module differs. Fields for module ".$aInfo['saved_role']['cstm_sugar_module']." didnt got updated.";
                            continue;
                        }
                        $sRecipientId = $aRoutingOrderPrepared[$sRoutingOrderKey][$iOrderUniqueCnt]['sent_signer']->getRecipientId();
                        try {
                            $oSentRecipientsTabs = $envelopeApi->listTabs($this->getAccountId(), $oEnvelope->getEnvelopeId(), $sRecipientId);
                        } catch (DocuSign\eSign\ApiException $ex) {
                            $sErrorMsg = $ex->getMessage().' </br>';
                            if (!empty($ex->getResponseObject())) {
                                $aError = json_decode($ex->getResponseObject(), true);
                                if (!empty($aError['errorCode'])) {
                                    $sErrorMsg .= $aError['message']." (". $aError['errorCode'].") </br>";
                                }
                            }
                            $aReturn['error'] .= $sErrorMsg;
                            return $aReturn;
                        }

                        $sCRMKey = '';
                        if (!empty($aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['crm_module'])) {
                            $sCRMKey = $aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['crm_module'].'_'.$aInfo['saved_role']['cstm_sugar_id'];
                        }
                        
                        $oTabs[$sCRMKey] = $oSentRecipientsTabs;
                        //getCheckboxTabs()
                        //                    getCompanyTabs() //This value cannot be set.
                        //                    getDateSignedTabs() //This value cannot be set.
                        //                    getDateTabs()
                        //                    getEmailAddressTabs() //This value cannot be set.
                        //                    getEmailTabs()
                        //                    getFirstNameTabs() //This value cannot be set.
                        //                    getFullNameTabs() //This value cannot be set.
                        //                    getLastNameTabs() //This value cannot be set.
                        //                    getListTabs();
                        //                    getNoteTabs()
                        //                    getNumberTabs()
                        //                    getRadioGroupTabs()
                        //                    getTextTabs()
                        //                    getTitleTabs() //This value cannot be set.
                        //                    getSSNTabs()
                        //                    getZipTabs()
                        if (!empty($aCRMRowData[$sRoutingOrderKey][$iOrderUniqueCnt])) {
                            if (!empty($aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['crm_module'])) {
                                $ModName = $aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['crm_module'];
                                $oSugarBean = BeanFactory::getBean($ModName, $aInfo['saved_role']['cstm_sugar_id']);
                                foreach ($aCRMRowData[$sRoutingOrderKey][$iOrderUniqueCnt] as $sMapRowId => $aMappData) {
                                    if (empty($aMappData['ds_field'])) {
                                        continue;
                                    }
                                    $aDsField = explode(',', $aMappData['ds_field']);
                                    $sSugarFieldName = $aMappData['crm_field'];
                                    foreach ($aDsField as $sDsFieldName) {
                                        // TextTabs
                                        $aTextTabs = $oTabs[$sCRMKey]->getTextTabs();
                                        if (!empty($aTextTabs)) {
                                            foreach ($aTextTabs as $sk => $oTextTab) {
                                                $sTabName = $oTextTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    if (!empty($aSugarData[$sCRMKey][$sSugarFieldName])) {
                                                        // append empty space
                                                        $aSugarData[$sCRMKey][$sSugarFieldName] .= ' '.$oTextTab->getValue();
                                                    } else {
                                                        $aSugarData[$sCRMKey][$sSugarFieldName] = $oTextTab->getValue();
                                                    }
                                                }
                                            }
                                        }
                                        // RadioGroupTabs
                                        $aRadioGroupTabs = $oTabs[$sCRMKey]->getRadioGroupTabs();
                                        if (!empty($aRadioGroupTabs)) {
                                            foreach ($aRadioGroupTabs as $sk => $oRadioGroupTab) {
                                                $sTabName = $oRadioGroupTab->getGroupName();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $aRadios = $oRadioGroupTab->getRadios();
                                                    foreach ($aRadios as $sRk => $oRadio) {
                                                        if ($oRadio->getSelected() === true || $oRadio->getSelected() === 'true') {
                                                            $aSugarData[$sCRMKey][$sSugarFieldName] = $oRadio->getValue();
                                                        }
                                                        $radios[]=$oRadio;
                                                    }
                                                }
                                            }
                                        }
                                        // CheckboxTabs
                                        $aCheckboxTabs = $oTabs[$sCRMKey]->getCheckboxTabs();
                                        if (!empty($aCheckboxTabs)) {
                                            foreach ($aCheckboxTabs as $sk => $oCheckboxTab) {
                                                $sTabName = $oCheckboxTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    //if($oSugarBean->$sSugarFieldName == 1 || $oSugarBean->$sSugarFieldName == true){
                                                    if ($oCheckboxTab->getSelected() === true || $oCheckboxTab->getSelected() === 'true') {
                                                        $aSugarData[$sCRMKey][$sSugarFieldName] = 1;
                                                    }
                                                    //}
                                                }
                                            }
                                        }
                                        // DateTabs (On Docusign Template create a textbox and set the validation rule to date)
                                        $aDateTabs = $oTabs[$sCRMKey]->getDateTabs();
                                        if (!empty($aDateTabs)) {
                                            foreach ($aDateTabs as $sk => $oDateTab) {
                                                $sTabName = $oDateTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $sValidationPattern = $oDateTab->getValidationPattern();
                                                    if (!empty($sValidationPattern)) {
                                                        $sDateValue = $oDateTab->getValue();
                                                        //DD/MM/YYYY
                                                        if ($sValidationPattern == '^(|by DocuSign)((|0)[1-9]|[1-2][0-9]|3[0-1])/((|0)[1-9]|1[0-2])/[0-9]{4}$') {
                                                            $aTmpDate = explode('/', $sDateValue);
                                                            $sDateValue = $aTmpDate[2].'-'.$aTmpDate[1].'-'.$aTmpDate[0];
                                                        }
                                                        //MM/DD/YYYY
                                                        elseif ($sValidationPattern == '^(|by DocuSign)((|0)[1-9]|1[0-2])/((|0)[1-9]|[1-2][0-9]|3[0-1])/[0-9]{4}$') {
                                                            $aTmpDate = explode('/', $sDateValue);
                                                            $sDateValue = $aTmpDate[2].'-'.$aTmpDate[0].'-'.$aTmpDate[1];
                                                        }
                                                        //YYYY/MM/DD
                                                        elseif ($sValidationPattern == '^(|by DocuSign)[0-9]{4}/((|0)[1-9]|1[0-2])/((|0)[1-9]|[1-2][0-9]|3[0-1])$') {
                                                            $aTmpDate = explode('/', $sDateValue);
                                                            $sDateValue = $aTmpDate[0].'-'.$aTmpDate[1].'-'.$aTmpDate[2];
                                                        }
                                                        $aSugarData[$sCRMKey][$sSugarFieldName] = $sDateValue;
                                                    } else {
                                                        $aSugarData[$sCRMKey][$sSugarFieldName] = $oDateTab->getValue();
                                                    }
                                                }
                                            }
                                        }
                                        
                                        //getEmailTabs
                                        $aEmailTabs = $oTabs[$sCRMKey]->getEmailTabs();
                                        if (!empty($aEmailTabs)) {
                                            foreach ($aEmailTabs as $sk => $oEmailTab) {
                                                $sTabName = $oEmailTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $aSugarData[$sCRMKey][$sSugarFieldName] = $oEmailTab->getValue();
                                                }
                                            }
                                        }
                                        //getListTabs // Note when dropdown is kept on Docusign Template, the API fails, The issue is registered on github
                                        $aListTabs = $oTabs[$sCRMKey]->getListTabs();
                                        if (!empty($aListTabs)) {
                                            foreach ($aListTabs as $sk => $oListTab) {
                                                $sTabName = $oListTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    //$aSugarData[$sCRMKey][$sSugarFieldName] = $oListTab->getValue();
                                                    $aSugarData[$sCRMKey][$sSugarFieldName] = $oListTab->getListSelectedValue();
                                                }
                                            }
                                        }
                                        //NoteTabs
                                        $aNoteTabs = $oTabs[$sCRMKey]->getNoteTabs();
                                        if (!empty($aNoteTabs)) {
                                            foreach ($aNoteTabs as $sk => $oNoteTab) {
                                                $sTabName = $oNoteTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $aSugarData[$sCRMKey][$sSugarFieldName] = $oNoteTab->getValue();
                                                }
                                            }
                                        }
                                        //NumberTabs
                                        $aNumberTabs = $oTabs[$sCRMKey]->getNumberTabs();
                                        if (!empty($aNumberTabs)) {
                                            foreach ($aNumberTabs as $sk => $oNumberTab) {
                                                $sTabName = $oNumberTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName && property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $aSugarData[$sCRMKey][$sSugarFieldName] = $oNumberTab->getValue();
                                                }
                                            }
                                        }
                                        //SSNTabs
                                        $aSSNTabs = $oTabs[$sCRMKey]->getSSNTabs();
                                        if (!empty($aSSNTabs)) {
                                            foreach ($aSSNTabs as $sk => $oSSNTab) {
                                                $sTabName = $oSSNTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName &&  property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $aSugarData[$sCRMKey][$sSugarFieldName] = $oSSNTab->getValue();
                                                }
                                            }
                                        }
                                        //ZipTabs
                                        $aZipTabs = $oTabs[$sCRMKey]->getZipTabs();
                                        if (!empty($aZipTabs)) {
                                            foreach ($aZipTabs as $sk => $oZipTab) {
                                                $sTabName = $oZipTab->getTabLabel();
                                                if ($sDsFieldName == $sTabName &&  property_exists($oSugarBean, $sSugarFieldName)) {
                                                    $aSugarData[$sCRMKey][$sSugarFieldName] = $oZipTab->getValue();
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        $aReturn['response']=$aSugarData;
        return $aReturn;
    }
}
