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
    require_once("modules/UT_DocuSign/docusign_docupdate.php");
    global $db,$timedate,$mod_strings, $current_language,$sugar_config;
    $aModString_RSActivities = return_module_language($current_language, 'UT_DSActivities');
    $aModString_RSDocusign = return_module_language($current_language, 'UT_DocuSign');
    if (!empty($_REQUEST['envelopeId']) && !empty($_REQUEST['event'])) {
        if (!empty($_REQUEST['crmfile'])) {
            $sFilePathName = "UT_DSUploads/".$_REQUEST['crmfile'];
            if (sugar_is_file($sFilePathName)) {
                @unlink($sFilePathName);
            }
        }
        $sSql = "SELECT id, rs_doc_id 
                FROM ut_docusign 
                WHERE rs_doc_id='".$_REQUEST['envelopeId']."' AND deleted=0";
        $oRes = $db->query($sSql, true);
        $aRow = $db->fetchByAssoc($oRes);
        if (!empty($aRow['id'])) {
            $oUTDocuSign = BeanFactory::getBean('UT_DocuSign', $aRow['id']);
            $oUTDocuSign->state = $_REQUEST['event'];
            $oUTDocuSign->save();
            //$status = docusign_docupdate_cron($aRow['id']);
        }
        $_SESSION['urdhvadocusign']['message'] = $aModString_RSDocusign['LBL_DOC_SENT_FOR_SIGNATURE'].' <a href="index.php?module=UT_DocuSign&action=DetailView&record='.$oUTDocuSign->id.'"> here</a>';
    } else {
        $_SESSION['urdhvadocusign']['message'] = 'An error occured';
    }
    $sScript="<script type='text/javascript'>
                alert('".$aModString_RSDocusign['LBL_DOC_SENT_UPDATE_INFO']."');
                window.parent.location.href = 'index.php?module=UT_DocuSign&action=SendDocumentRS';
              </script>";
    echo $sScript;
