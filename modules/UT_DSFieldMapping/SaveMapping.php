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
    global $current_user;
    $sTemplateId = $_REQUEST['docusign_templates'];
    $aCRMRowData = array();
    foreach ($_REQUEST as $sReqKey => $sReqValue) {
        if (substr($sReqKey, 0, 13) === "routingorder_") {
            $aTmp = explode('_', $sReqKey);
            $aCRMRolesData[$aTmp[1]][$aTmp[2]]['ds_rolename']=$sReqValue;
        }
        if (substr($sReqKey, 0, 7) === "crmmod_") {
            $aTmp = explode('_', $sReqKey);
            $aCRMRolesData[$aTmp[1]][$aTmp[2]]['crm_module']=$sReqValue;
        }
        if (substr($sReqKey, 0, 11) === "ds_field___") {
            $aTmp = explode('___', $sReqKey);
            //ds_field___1___1___1
            if (count($aTmp) == 4) {
                if (!empty($sReqValue)) {
                    if (is_array($sReqValue)) {
                        $aCRMRowData[$aTmp[1]][$aTmp[2]][$aTmp[3]]['ds_field'] = implode(',', $sReqValue);
                    } else {
                        $aCRMRowData[$aTmp[1]][$aTmp[2]][$aTmp[3]]['ds_field'] = $sReqValue;
                    }
                }
            }
        }
        if (substr($sReqKey, 0, 12) === "crm_field___") {
            $aTmp = explode('___', $sReqKey);
            //crm_field___1___1___1
            if (count($aTmp) == 4) {
                if (!empty($sReqValue)) {
                    $aCRMRowData[$aTmp[1]][$aTmp[2]][$aTmp[3]]['crm_field'] = $sReqValue;
                }
            }
        }
    }
    
    if (!empty($_REQUEST['record'])) {
        $oDSFieldMapping = BeanFactory::getBean('UT_DSFieldMapping', $_REQUEST['record']);
    } else {
        $oDSFieldMapping = BeanFactory::getBean('UT_DSFieldMapping');
    }
    
    $oDSFieldMapping->name = $_REQUEST['name'];
    $oDSFieldMapping->synchronizing_direction = $_REQUEST['synchronizing_direction'];
    $oDSFieldMapping->docusign_templates = $_REQUEST['docusign_templates'];
    $oDSFieldMapping->assigned_user_id = $current_user->id;
    if (!empty($aCRMRolesData) && !empty($aCRMRowData)) {
        $oDSFieldMapping->crmroledata = base64_encode(serialize($aCRMRolesData));
        $oDSFieldMapping->crmrowdata = base64_encode(serialize($aCRMRowData));
    }
    if (!empty($_REQUEST['isDuplicate']) && ($_REQUEST['isDuplicate'] === true || $_REQUEST['isDuplicate'] === 'true')) {
        $oDSFieldMappingNew = BeanFactory::getBean('UT_DSFieldMapping');
        $oDSFieldMappingNew->name = $oDSFieldMapping->name;
        $oDSFieldMappingNew->synchronizing_direction = $oDSFieldMapping->synchronizing_direction;
        $oDSFieldMappingNew->docusign_templates = $oDSFieldMapping->docusign_templates;
        $oDSFieldMappingNew->assigned_user_id = $oDSFieldMapping->assigned_user_id;
        $oDSFieldMappingNew->crmroledata = $oDSFieldMapping->crmroledata;
        $oDSFieldMappingNew->crmrowdata = $oDSFieldMapping->crmrowdata;
        $oDSFieldMappingNew->save();
    } else {
        $oDSFieldMapping->save();
    }
    //echo "<pre>aCRMRolesData=======";
//    print_r($aCRMRolesData);
//    echo "</pre>";
//    echo "<pre>aCRMRowData=======";
//    print_r($aCRMRowData);
//    echo "</pre>";
//    die("aaaa");
    SugarApplication::redirect('index.php?module=UT_DSFieldMapping&action=ListView');
    exit;
