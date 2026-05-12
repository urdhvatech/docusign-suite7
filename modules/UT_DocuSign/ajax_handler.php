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
if (!empty($_REQUEST['id'])) {
    $json = getJSONobj();
    $aReturn = array(
                    'message' => '',
                    'status' => 'failed'
               );
    //Update status of selected record
    global $mod_strings,$current_user;
    if (ACLAction::userHasAccess($current_user->id, 'UT_DocuSign', 'edit', 'module', true, true)) {
        require_once("modules/UT_DocuSign/docusign_docupdate.php");
        $status = docusign_docupdate_cron($_REQUEST['id']);
        if ($status == true) {
            $aReturn['message'] = $mod_strings['LBL_STATUS_UPDATED'];
            $aReturn['status'] = 'success';
        }
    } else {
        $aReturn['message'] = $mod_strings['LBL_NOT_AUTHORIZED'];
        $aReturn['status'] = 'failed';
    }
    echo $json->encode($aReturn);
    exit();
}
