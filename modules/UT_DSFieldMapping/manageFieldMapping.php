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
require_once('modules/UT_DocuSign/library/UT_DocuSignClient.php');
$json = getJSONobj();
global $db, $mod_strings, $current_language;
$mod_strings_docusign = return_module_language($current_language, 'UT_DocuSign');
$aReturn = array(
                'message' => '',
                'status' => 'failed',
                'data' => array(
                            'roles_html'=>'',
                            'fields_html'=>'',
                          ),
           );
if (!checkDocuSignLicense()) {
    $msg = "Invalid License";
    $GLOBALS['log']->fatal($msg);
    $aReturn['message'] = $msg;
    $aReturn['status'] = "failed";
    echo $json->encode($aReturn);
    return;
}


$aSupportedSignerModule = array('Accounts'=>'Accounts','Contacts'=>'Contacts','Leads'=>'Leads','Prospects'=>'Prospects','Users'=>'Users');
if (empty($_REQUEST['rs_template_id'])) {
    $aReturn['message'] = $mod_strings_docusign['LBL_RS_TEMPLATEID_NOT_FOUND'];
    $aReturn['status'] = "failed";
    echo $json->encode($aReturn);
    return;
}
$aCRMRolesData = array();
$aCRMRowData = array();

$aRunTimeCRMModule = array();

foreach ($_REQUEST as $sReqKey => $sCRMModuleName) {
    if (substr($sReqKey, 0, 7) === "crmmod_") {
        $aRoute = explode('_', $sReqKey);
        $aRunTimeCRMModule[$aRoute[1]][$aRoute[2]]=$sCRMModuleName;
    }
}

if (!empty($_REQUEST['record'])) {
    $oDSFieldMapping = BeanFactory::getBean('UT_DSFieldMapping', $_REQUEST['record']);
    
    if (!empty($_REQUEST['record'])) {
        $aCRMRolesData = unserialize(base64_decode($oDSFieldMapping->crmroledata));
        $aCRMRowData = unserialize(base64_decode($oDSFieldMapping->crmrowdata));
    }
    //$aCRMRolesData[1]['ds_rolename'] = 'Provider';
//    $aCRMRolesData[1]['crm_module'] = 'Accounts';
//    $aCRMRolesData[2]['ds_rolename'] = 'Receiver';
//    $aCRMRolesData[2]['crm_module'] = 'Contacts';
    
    //$aCRMRolesData[1][1]['ds_rolename'] = 'Provider';
//    $aCRMRolesData[1][1]['crm_module'] = 'Accounts';
//    $aCRMRolesData[2][2]['ds_rolename'] = 'Receiver';
//    $aCRMRolesData[2][2]['crm_module'] = 'Contacts';
    
    if (!empty($aRunTimeCRMModule)) {
        foreach ($aRunTimeCRMModule as $sRoutingOrd => $aOrderUniqueCnt) {
            foreach ($aOrderUniqueCnt as $iOrderUniqueCnt => $sCRMModuleName) {
                if (array_key_exists($sRoutingOrd, $aCRMRolesData) && array_key_exists($iOrderUniqueCnt, $aCRMRolesData[$sRoutingOrd])) {
                    $aCRMRolesData[$sRoutingOrd][$iOrderUniqueCnt]['crm_module'] = $sCRMModuleName;
                }
            }
        }
    }
    /*
    $aCRMRowData[1][1][1] = array(
                            'ds_field' => 'salutation,first_name,last_name',
                            'crm_field'=> 'first_name',
                            //'crm_module'=> 'Accounts'
                            );
    $aCRMRowData[1][1][2] = array(
                            'ds_field' => 'salutation,first_name,last_name',
                            'crm_field'=> 'last_name',
                            //'crm_module'=> 'Contacts'
                            );
    $aCRMRowData[2][2][1] = array(
                            'ds_field' => 'salutation,first_name,last_name',
                            'crm_field'=> 'first_name',
                            //'crm_module'=> 'Accounts'
                            );
    $aCRMRowData[2][2][2] = array(
                            'ds_field' => 'salutation,first_name,last_name',
                            'crm_field'=> 'last_name',
                            //'crm_module'=> 'Contacts'
                            );
    */
}
$aCRMFieldList = array();
foreach ($aSupportedSignerModule as $sMKey => $sMValue) {
    $oModBean = BeanFactory::getBean($sMKey);
    $aRequest = array(
                    'view_module' => $sMKey,
                    'view_package' => 'studio',
                );
    $aCRMFieldList[$sMKey] = utDS_getModuleFields($aRequest);
}

$rs_template_id = $_REQUEST['rs_template_id'];

$sHTML=$sMergeFieldsHTML=$sFinalMergeFieldHTML=$sCCHtml='';

$oDocuSignClient = new UT_DocuSignClient();
$aResponse = $oDocuSignClient->getTemplateDetails($rs_template_id);

if (empty($aResponse['error'])) {
    if (!empty($aResponse['response'])) {
        $sJSroles_rowcounter = array();
        $oEnvelopeTemplate = $aResponse['response'];
        //$oEnvelopeTemplateDefinition = $oEnvelopeTemplate->getEnvelopeTemplateDefinition();

        $iOrderUniqueCnt=1;
        
        $oRecipients = $oEnvelopeTemplate->getRecipients();
        $aSigners = $oRecipients->getSigners();
        $aInPersonSigners = $oRecipients->getInPersonSigners();
        //$aCarbonCopies = $oRecipients->getCarbonCopies();
        
        $aRoutingOrder = array();
        if (!empty($aSigners)) {
            foreach ($aSigners as $oSigner) {
                $aRoutingOrder[$oSigner->getRoutingOrder()][$iOrderUniqueCnt][] = $oSigner;
                $iOrderUniqueCnt++;
            }
        }
        // Allow variable to set, but will not be used for mappings as CC cannot have any tabs.
        if (!empty($aCarbonCopies)) {
            foreach ($aCarbonCopies as $oCarbonCopy) {
                $aRoutingOrder[$oCarbonCopy->getRoutingOrder()][$iOrderUniqueCnt][] = $oCarbonCopy;
                $iOrderUniqueCnt++;
            }
        }
        
        if (!empty($aInPersonSigners)) {
            foreach ($aInPersonSigners as $oInPersonSigner) {
                $aRoutingOrder[$oInPersonSigner->getRoutingOrder()][$iOrderUniqueCnt][] = $oInPersonSigner;
                $iOrderUniqueCnt++;
            }
        }
        
        
        //$aReturn['data']['guid'] = $oEnvelopeTemplateDefinition->getTemplateId();
        $aReturn['data']['guid'] = $oEnvelopeTemplate->getTemplateId();
        $sFinalHTML='';
        $aDSRoles=array();
        //$aCRMRolesData=array();
        $sRoleHTML = '';
        $sFieldRowsPerRoleHTML = '';
        if (!empty($aRoutingOrder)) {
            if (count($aRoutingOrder) > 1) {
            }
            ksort($aRoutingOrder);

            $iRoleCount = 1;
            $sRoleHTML = '';
            $sFieldsHTML = '';
            //$sRoleHTML = '';
            $sAllReceipientRowDivs = '';
            foreach ($aRoutingOrder as $sRoutingOrderKey => $aUniqueCnt) {
                foreach ($aUniqueCnt as $iOrderUniqueCnt => $aReceipents) {
                    $sJSroles_rowcounter[$sRoutingOrderKey][$iOrderUniqueCnt] = array('routing_number'=>$sRoutingOrderKey,'unique_number'=>$iOrderUniqueCnt,'rowcounter'=>0);
                    foreach ($aReceipents as $sK => $oReceipeint) {
                        $sInPersonHostName = '';
                        $aDSTemplateReceipientFieldList = array();
                        $sDSTemplateReceipientFieldOptions = '';
                        $sFieldRowsPerRoleHTML = '';
                        if ($oReceipeint instanceof DocuSign\eSign\Model\Signer ||
                            $oReceipeint instanceof DocuSign\eSign\Model\InPersonSigner) {
                            // || $oReceipeint instanceof DocuSign\eSign\Model\CarbonCopy)
                            $sSelectedModule = '';
                            if (!empty($_REQUEST['crmmod_'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt])) {
                                $sSelectedModule = $_REQUEST['crmmod_'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt];
                            }
                            $supportedmodule_options = get_select_options_with_id($aSupportedSignerModule, $sSelectedModule);
                            if (!empty($aCRMRolesData) && !empty($aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['ds_rolename']) && $aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['ds_rolename'] == $oReceipeint->getRoleName()) {
                                $sSelectedModule = $aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['crm_module'];
                                $supportedmodule_options = get_select_options_with_id($aSupportedSignerModule, $sSelectedModule);
                            }
                            $sRoleHTML .= '<div class="row" >
                                                <div class="col-xs-12 col-sm-6 edit-view-row-item">
                                                    <div class="col-xs-12 col-sm-4 label" data-label="LBL_SYNCHRONIZING_DIRECTION">
                                                        Map the role : "'.$oReceipeint->getRoleName().'" to
                                                        <input type="hidden" name="routingorder_'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" id="routingorder_'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="'.$oReceipeint->getRoleName().'" >'.$sSelectedModule.'
                                                    </div>
                                                    <div class="col-xs-12 col-sm-8 edit-view-field " type="name" field="name">
                                                        <select name="crmmod_'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" id="crmmod_'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" class="module_routing" routingorder="'.$sRoutingOrderKey.'" orderuniquecnt="'.$iOrderUniqueCnt.'">'.$supportedmodule_options.'</select>
                                                    </div>
                                                </div>
                                                <div class="col-xs-12 col-sm-6 edit-view-row-item">
                                                   
                                                </div>
                                               </div>';
                            /*
                            $sRoleHTML .= '<div class="row" >
                                            <div class="col-xs-12 col-sm-6 edit-view-row-item">
                                                <div class="col-xs-12 col-sm-4 label" data-label="LBL_SYNCHRONIZING_DIRECTION">
                                                    '.$mod_strings['LBL_SYNCHRONIZING_DIRECTION'].':
                                                </div>
                                                <div class="col-xs-12 col-sm-8 edit-view-field " type="name" field="name">
                                                    '.$oReceipeint->getRoleName().'
                                                    <input type="text" name="routingorder_'.$sRoutingOrderKey.'" id="routingorder_'.$sRoutingOrderKey.'" value="'.$oReceipeint->getRoleName().'" >'.$supportedmodule_options.'
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 edit-view-row-item">
                                                <div class="col-xs-12 col-sm-4 label" data-label="LBL_DOCUSIGN_TEMPLATES">
                                                    '.$mod_strings['LBL_DOCUSIGN_TEMPLATES'].':
                                                </div>
                                                <div class="col-xs-12 col-sm-8 edit-view-field " type="name" field="name">
                                                    <select name="module_'.$sRoutingOrderKey.'" id="module_'.$sRoutingOrderKey.'" >'.$supportedmodule_options.'</select>
                                                </div>
                                            </div>
                                           </div>';
                            */
                            $sRowFieldsHTML = '<tbody>';
                            $oTabs = $oReceipeint->getTabs();
                            $aListAllTabs = $oDocuSignClient->getReceipeintSupportedTabLabels($oTabs);
                            if (!empty($aListAllTabs['response'])) {
                                $sRoleHTML .= '<select id="dummy_dsfield___'.$sRoutingOrderKey.'___'.$iOrderUniqueCnt.'" name="dummy_dsfield___'.$sRoutingOrderKey.'___'.$iOrderUniqueCnt.'[]" multiple="multiple" style="width: 75%; display:none;">';
                                foreach ($aListAllTabs['response'] as $sTabType => $aTabs) {
                                    foreach ($aTabs as $sidd => $sTabFldLbl) {
                                        $aDSTemplateReceipientFieldList[] = $sTabFldLbl;
                                        $sDSTemplateReceipientFieldOptions .= '<option value="'.$sTabFldLbl.'">'.$sTabFldLbl.'</option>';
                                    }
                                }
                                if (!empty($sDSTemplateReceipientFieldOptions)) {
                                    $sRoleHTML.=$sDSTemplateReceipientFieldOptions;
                                }
                                $sRoleHTML .= '</select>';
                            } else {
                                continue;
                            }

                            if (!empty($aCRMRowData) && !empty($aCRMRowData[$sRoutingOrderKey][$iOrderUniqueCnt])) {
                                foreach ($aCRMRowData[$sRoutingOrderKey][$iOrderUniqueCnt] as $iRow => $aFields) {
                                    $sJSroles_rowcounter[$sRoutingOrderKey][$iOrderUniqueCnt]['rowcounter']=$iRow;
                                    $sRowFieldsHTML .= '<tr id="rowid___'.$sRoutingOrderKey.'___'.$iOrderUniqueCnt.'___'.$iRow.'" height="30" class="{ROW_COLOR}S1">';
                                    if (!empty($aFields['ds_field']) && !empty($aFields['crm_field'])) {
                                        $sDSTemplateSelectedFieldOptions = $sCRMFieldOptions = '';
                                        $aDSFields = explode(',', $aFields['ds_field']);
                                        $sRId = 'ds_field___'.$sRoutingOrderKey.'___'.$iOrderUniqueCnt.'___'.$iRow;
                                        $sCRMId = 'crm_field___'.$sRoutingOrderKey.'___'.$iOrderUniqueCnt.'___'.$iRow;
                                            
                                        foreach ($aDSTemplateReceipientFieldList as $sdsk => $sDSField) {
                                            if (in_array($sDSField, $aDSFields)) {
                                                $sDSTemplateSelectedFieldOptions .= '<option selected value="'.$sDSField.'">'.$sDSField.'</option>';
                                            } else {
                                                $sDSTemplateSelectedFieldOptions .= '<option value="'.$sDSField.'">'.$sDSField.'</option>';
                                            }
                                        }
                                        if (empty($sDSTemplateSelectedFieldOptions)) {
                                            $sDSTemplateSelectedFieldOptions = $sDSTemplateReceipientFieldOptions;
                                        }
                                            
                                        $aCRMSelectedFields = explode(',', $aFields['crm_field']);
                                        if (!empty($aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['crm_module'])) {
                                            foreach ($aCRMFieldList[$aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['crm_module']] as $field_name => $field_label) {
                                                //foreach ($sMFldList as $field_name => $field_label) {
                                                $sSelected = '';
                                                if (in_array($field_name, $aCRMSelectedFields)) {
                                                    $sSelected = ' selected ';
                                                }
                                                $sCRMFieldOptions .= '<option '.$sSelected.' value="'.$field_name.'">'.$field_label.'</option>';
                                                //}
                                            }
                                        }

                                        $sRowFieldsHTML .= '<td>
                                                                    <select id="'.$sRId.'" name="'.$sRId.'[]" class="select2" multiple="multiple" style="width: 75%">
                                                                        '.$sDSTemplateSelectedFieldOptions.'
                                                                    </select>
                                                               </td>
                                                               <td class="direction_arrow" width="5%">
                                                               </td>
                                                               <td>
                                                                    <select id="'.$sCRMId.'" name="'.$sCRMId.'">
                                                                        '.$sCRMFieldOptions.'
                                                                    </select>
                                                               </td>
                                                               <td width="5%">
                                                                    <span rowindex="'.$iRow.'" routingorder="'.$sRoutingOrderKey.'" orderuniquecnt="'.$iOrderUniqueCnt.'" class="deleterowBtn suitepicon suitepicon-action-clear" style="cursor:pointer; padding-left: 15px;font-size:16px;"></span>
                                                               </td>
                                                               ';
                                    }
                                    $sRowFieldsHTML .= '</tr>';
                                }
                                $sSelectedModule = $aCRMRolesData[$sRoutingOrderKey][$iOrderUniqueCnt]['crm_module'];
                                $supportedmodule_options = get_select_options_with_id($aSupportedSignerModule, $sSelectedModule);
                            }
                            $sRowFieldsHTML .='</tbody>
                                                    <tfoot id="tablefooter_'.$sRoutingOrderKey.'" routingorder="'.$sRoutingOrderKey.'" orderuniquecnt="'.$iOrderUniqueCnt.'">
                                                        <tr>
                                                            <td colspan="4">
                                                            <button type="button" class="addrowBtn btn btn-danger email-address-add-button" id="" routingorder="'.$sRoutingOrderKey.'" orderuniquecnt="'.$iOrderUniqueCnt.'">
    <span class="suitepicon suitepicon-action-plus"></span><span></span>
    </button>
                                                            </td>
                                                        </tr>
                                                    <tfoot>';
                            $sFieldRowsPerRoleHTML .= '<div class="panel panel-default" style="margin-bottom:5px !important;">
                                                             <div class="panel-heading collapsed" data-toggle="collapse" style="cursor:pointer;" data-parent="#accordion" href="#mod_'.$oReceipeint->getRoleName().'" aria-expanded="false">
                                                                <a role="button" aria-expanded="false">
                                                                    <div class="col-xs-10 col-sm-11 col-md-11">'.$oReceipeint->getRoleName().'</div>
                                                                </a>
                                                             </div>
                                                             <div id="mod_'.$oReceipeint->getRoleName().'" class="panel-collapse collapse in" aria-expanded="true" style="">
                                                                <div class="panel-body" style="padding:15px 15px 5px 15px;">
                                                                    <table id="tblroute_'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" cellpadding="0" cellspacing="0" width="100%" border="0" class="list view" style="table-layout:fixed">
                                                                        '.$sRowFieldsHTML.'
                                                                    </table>
                                                                </div>
                                                             </div>
                                                            </div>';
                        } else {
                            continue;
                            $iRoleCount++;
                        }
                        $iRoleCount++;
                    
                        $sAllReceipientRowDivs .= '<div class="row edit-view-row">
                                                        <div class="panel-group" id="accordion" style="margin-bottom:0px;">
                                                            <div>
                                                               '.$sFieldRowsPerRoleHTML.'
                                                           </div>
                                                        </div>
                                                    </div>';
                    }
                }
            }
            $sRoleHTML .= '';
        }
        if (!empty($sJSroles_rowcounter)) {
            $sJSroles_rowcounter = $json->encode($sJSroles_rowcounter);
            $javascript =  '<script type="text/javascript" language="javascript">
                                roles_rowcounter = ' . $json->encode($sJSroles_rowcounter) .';
                            </script>';
        } else {
            $javascript =  '<script type="text/javascript" language="javascript">
                                roles_rowcounter = {};
                            </script>';
        }
        //$aReturn['count'] = $iCount;
        $aReturn['data']['roles_html']=$sRoleHTML.$javascript;
        $aReturn['data']['fields_html']=$sAllReceipientRowDivs;
        $aReturn['message'] = "";
        $aReturn['status'] = "success";
    } else {
        $GLOBALS['log']->fatal("No templates exists on DocuSign. Please create templates on DocuSign");
        $aReturn['message'] = $mod_strings_docusign['LBL_RS_NO_TEMPLATES'];
        $aReturn['status'] = "failed";
    }
} else {
    $GLOBALS['log']->fatal("DocuSign Client Error : ".$aResponse['error']);
    $aReturn['message'] = "DocuSign Client Error : ".$aResponse['error'];
    $aReturn['status'] = "failed";
}
echo $json->encode($aReturn);
exit();
