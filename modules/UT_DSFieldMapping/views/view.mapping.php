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
require_once('include/MVC/View/SugarView.php');
require_once('modules/UT_DocuSign/DocuSignUtils.php');
class Viewmapping extends SugarView
{
    public function __construct()
    {
        parent::__construct();
    }

    public function display()
    {
        global $app_strings, $app_list_strings, $mod_strings,$current_user,$db,$sugar_config;
        if (!checkDocuSignLicense()) {
            $msg = "Invalid License";
            SugarApplication::appendErrorMessage($msg);
            SugarApplication::redirect('index.php?module=UT_DocuSign&action=license');
            exit;
        }
        $json = getJSONobj();
        $isSetDocuSignKey = false;
        $aAppKeys = getApplicationKey();
        if (!empty($aAppKeys) && !empty($aAppKeys['host']) && !empty($aAppKeys['accountid'])) {
            $isSetDocuSignKey = true;
        }
        if ($isSetDocuSignKey == false) {
            SugarApplication::redirect('index.php?module=UT_DocuSign&action=DocuSignAppKeys');
            exit;
        }
        $sName = '';
        if (!empty($_REQUEST['isDuplicate'])) {
            $this->ss->assign('isDuplicate', $_REQUEST['isDuplicate']);
        }
        if (!empty($_REQUEST['record'])) {
            $this->ss->assign('record', $_REQUEST['record']);
            $oDSFieldMapping = BeanFactory::getBean("UT_DSFieldMapping", $_REQUEST['record']);
            $sName = $oDSFieldMapping->name;
        } else {
            $oDSFieldMapping = BeanFactory::getBean("UT_DSFieldMapping");
        }
        if (!empty($oDSFieldMapping->synchronizing_direction)) {
            $synchronizing_direction_options = get_select_options_with_id($app_list_strings['synchronizing_direction_list'], $oDSFieldMapping->synchronizing_direction);
        } else {
            $synchronizing_direction_options = get_select_options_with_id($app_list_strings['synchronizing_direction_list'], "");
        }
        
        if (!empty($oDSFieldMapping->docusign_templates)) {
            $docusign_templates_options = get_select_options_with_id($app_list_strings['docusign_templates_list'], $oDSFieldMapping->docusign_templates);
        } else {
            $docusign_templates_options = get_select_options_with_id($app_list_strings['docusign_templates_list'], "");
        }
            
        $this->ss->assign("app", $app_strings);
        $this->ss->assign("mod", $mod_strings);
        $this->ss->assign("name", $sName);
        $this->ss->assign("synchronizing_direction_options", $synchronizing_direction_options);
        $this->ss->assign("docusign_templates_options", $docusign_templates_options);

        if (empty($_REQUEST['return_action'])) {
            $_REQUEST['return_action'] = 'index';
        }
        $this->ss->assign("return_module", $_REQUEST['return_module']);
        $this->ss->assign("return_action", $_REQUEST['return_action']);
        $this->ss->assign("return_id", $_REQUEST['return_id']);
        
        if (empty($oDSFieldMapping->assigned_user_id)) {
            $oDSFieldMapping->assigned_user_id = $current_user->id;
        }

        $sDummyModuleFldsSelect='';
        $aSupportedModule = array('Accounts'=>'Accounts','Contacts'=>'Contacts','Leads'=>'Leads','Prospects'=>'Prospects','Users'=>'Users');
        foreach ($aSupportedModule as $sMKey => $sMValue) {
            $oModBean = BeanFactory::getBean($sMKey);
            $aRequest = array(
                            'view_module' => $sMKey,
                            'view_package' => 'studio',
                        );
            $aFieldList = utDS_getModuleFields($aRequest);
            if (!empty($aFieldList)) {
                $sDummyModuleFldsSelect.='<select id="dummy_'.$sMKey.'" name="dummy_'.$sMKey.'" style="display:none;">';
                foreach ($aFieldList as $field_name => $field_label) {
                    $sDummyModuleFldsSelect .= '<option value="'.$field_name.'">'.$field_label.'</option>';
                }
                $sDummyModuleFldsSelect.='</select>';
            }
        }
        $this->ss->assign('sDummyModuleFldsSelect', $sDummyModuleFldsSelect);
        $aCRMRolesData = array();
        if (!empty($_REQUEST['record'])) {
            //$aCRMRolesData = unserialize(base64_decode($this->bean->crmroledata));
            $aCRMRolesData = unserialize(base64_decode($oDSFieldMapping->crmroledata));
        }
        $RoleCount=$aCRMRolesData;
        $javascript =  '<script type="text/javascript" language="javascript">
                            var roles_rowcounter = ' . $json->encode($RoleCount) .';
                        </script>';
        $this->ss->assign('javascript', $javascript);
        $this->ss->display('modules/UT_DSFieldMapping/tpls/mapping.tpl');
    }
}
