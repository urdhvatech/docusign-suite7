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
  require_once('modules/UT_DocuSign/DocuSignUtils.php');
  global $db,$mod_strings,$current_user;
  $aReturn = array(
        "status" => "failed",
        "data" => array());
  $isSetSocialKey = $isSetSocialAuth = false;
  $sHtml = '';
  if (!empty($_REQUEST['social'])) {
      $sSocial = $_REQUEST['social'];
      $aAppKeys = getApplicationKey();
      if (!empty($aAppKeys['access_token']) || !empty($aAppKeys['refresh_token ']) || !empty($aAppKeys['expires_in']) || !empty($aAppKeys['token_type']) || !empty($aAppKeys['expiration_datetime'])) {
          $sUpdateSql = "UPDATE ut_docusign_api_keys SET access_token='', refresh_token='', expires_in='', token_type='', expiration_datetime=NULL WHERE id='".$aAppKeys['id']."'";
          $db->query($sUpdateSql, true);
      }
      $aAppKeys = getApplicationKey(); // Call again
      if (!empty($aAppKeys['integrator_key']) && !empty($aAppKeys['client_secret']) && !empty($aAppKeys['client_key'])) {
          $isSetSocialKey = true;
      }
        
      if (!empty($aAppKeys['access_token']) && !empty($aAppKeys['refresh_token']) && !empty($aAppKeys['expires_in'])) {
          $isSetSocialAuth = true;
      }
      
      $sLabel="";
      if ($sSocial == "docusign") {
          $sLogInLabel = $mod_strings['LBL_UT_AUTH_LOGIN'];
          $sLogoutLabel = $mod_strings['LBL_UT_AUTH_LOGOUT'];
      }
      
      if ($isSetSocialKey==true && $isSetSocialAuth==true) {
          $sHtml='<a class="btn btn-primary actionsociallogout" social="'.$sSocial.'">
                '.$sLogoutLabel.'&nbsp;&nbsp;&nbsp;<img src="modules/UT_DocuSign/images/docusign_144x40.png" width="120"/>
            </a>';
      } elseif ($isSetSocialKey==true && $isSetSocialAuth==false) {
          $sHtml='<a class="btn btn-primary actionsociallogin" social="'.$sSocial.'" data-toggle="modal" data-target="#myRSModal">
                '.$sLogInLabel.'&nbsp;&nbsp;&nbsp;<img src="modules/UT_DocuSign/images/docusign_144x40.png" width="120"/>
            </a>';
      } elseif ($isSetSocialKey==false) {
          $sHtml='<div class="alert alert-danger" style="font-size:14px;">
              <i class="fa fa-warning fa-lg"></i>&nbsp;&nbsp;<strong>Opps!</strong> The <a href="index.php?module=UT_DocuSign&action=DocuSignAppKeys" class="alert-link">Application keys</a> are missing.
            </div>';
      }
      $aReturn['status'] = "success";
      $aReturn['data']['html'] = $sHtml;
      $aReturn['data']['social'] = $sSocial;
  }
  echo json_encode($aReturn);
