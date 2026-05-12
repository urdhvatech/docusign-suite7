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
global $db, $mod_strings;
$aReturn = array(
                'message' => '',
                'status' => 'failed',
                'recipient_exist' => 'Yes',
                'data' => array(
                            'roles_html'=>'',
                            'mergefields_html'=>'',
                          ),
           );
if (empty($_REQUEST['rs_template_id'])) {
    $aReturn['message'] = $mod_strings['LBL_RS_TEMPLATEID_NOT_FOUND'];
    $aReturn['status'] = "failed";
    echo $json->encode($aReturn);
    return;
}
$rs_template_id = $_REQUEST['rs_template_id'];
$iCount = $_REQUEST['count'];
$iCCCount = 0;
$sHTML=$sMergeFieldsHTML=$sFinalMergeFieldHTML=$sCCHtml='';
$iPrePopulateSignerFromDetailView = false;
$iPrePopulatedSignerSet=false;
if (!empty($_REQUEST['prePopFromDetailViewModule']) && !empty($_REQUEST['prePopFromDetailViewId']) && !empty($_REQUEST['prePopFromDetailViewName'])) {
    $iPrePopulateSignerFromDetailView = true;
}

$oDocuSignClient = new UT_DocuSignClient();
$aResponse = $oDocuSignClient->getTemplateDetails($rs_template_id);

if (empty($aResponse['error'])) {
    if (!empty($aResponse['response'])) {
        $oEnvelopeTemplate = $aResponse['response'];
        //$oEnvelopeTemplateDefinition = $oEnvelopeTemplate->getEnvelopeTemplateDefinition();
        
        $sJSroles_rowcounter = array();
        $iOrderUniqueCnt=1;
        $oRecipients = $oEnvelopeTemplate->getRecipients();
        if(!is_object($oRecipients)) {
            $GLOBALS['log']->fatal("No Recipient is exist on DocuSign Template. Please add the recipients into DocuSign Template.");
            $aReturn['message'] = $mod_strings['LBL_NO_RECIPIENT_DOCUSIGN_TEMPLATE'];
            $aReturn['recipient_exist'] = 'No';
            $aReturn['status'] = "failed";
            echo $json->encode($aReturn);
            exit;
        }
        $aSigners = $oRecipients->getSigners();
        $aInPersonSigners = $oRecipients->getInPersonSigners();
        $aCarbonCopies = $oRecipients->getCarbonCopies();
        
        $sDSToCRMMappingOptions = getSyncOption('ds_crm', $rs_template_id, true);
        $sCRMToDSMappingOptions = getSyncOption('crm_ds', $rs_template_id, true);
        
        
        $aRoutingOrder = array();
        if (!empty($aSigners)) {
            foreach ($aSigners as $oSigner) {
                $aRoutingOrder[$oSigner->getRoutingOrder()][$iOrderUniqueCnt][] = $oSigner;
                $iOrderUniqueCnt++;
            }
        }
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
        $aReturn['data']['subject'] = $oEnvelopeTemplate->getEmailSubject();
        $aReturn['data']['description'] = $oEnvelopeTemplate->getEmailBlurb();
        $sFinalHTML='';
        
        if (!empty($aRoutingOrder)) {
            if (count($aRoutingOrder) > 1) {
                $sHTML .= '<input type="hidden" id="signer_sequencing" name="signer_sequencing" class="form-control input-sm" value="1">';
            }
            ksort($aRoutingOrder);
            foreach ($aRoutingOrder as $sRoutingOrderKey => $aUniqueCnt) {
                foreach ($aUniqueCnt as $iOrderUniqueCnt => $aReceipents) {
                    $sJSroles_rowcounter[$sRoutingOrderKey][$iOrderUniqueCnt] = array('routing_number'=>$sRoutingOrderKey,'unique_number'=>$iOrderUniqueCnt,'rowcounter'=>0);
                    foreach ($aReceipents as $sK => $oReceipeint) {
                        $iCount++;
                        $sImgSrc = "";
                        $prePopFromDetailViewModule = $prePopFromDetailViewId = $prePopFromDetailViewName = $prePopFromDetailViewEmail = $prePopFromDetailViewPhone = '';
                        $sInPersonHostName = '';
                        if ($iPrePopulateSignerFromDetailView == true && $iPrePopulatedSignerSet == false) {
                            $prePopFromDetailViewModule = $_REQUEST['prePopFromDetailViewModule'];
                            $prePopFromDetailViewId = $_REQUEST['prePopFromDetailViewId'];
                            $prePopFromDetailViewName = $_REQUEST['prePopFromDetailViewName'];
                            $prePopFromDetailViewEmail = $_REQUEST['prePopFromDetailViewEmail'];
                            $prePopFromDetailViewPhone = $_REQUEST['prePopFromDetailViewPhone'];
                            $iPrePopulatedSignerSet = true;
                        }
                        if(empty($prePopFromDetailViewName)) {
                            $prePopFromDetailViewName = $oReceipeint->getName();
                        }
                        if(empty($prePopFromDetailViewEmail)) {
                            $prePopFromDetailViewEmail = $oReceipeint->getEmail();
                        }
                        $sImgSrc = "docusign_32x32.png";
                        if ($oReceipeint instanceof DocuSign\eSign\Model\Signer) {
                            $sImgSrc = "docusign_32x32.png";
                            $sLabelsInputs = '<label class="sronly" style="white-space:nowrap;">'.$oReceipeint->getRoleName().'</label>
                          <input type="text" id="receipient_name___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="receipient_name___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="'.$prePopFromDetailViewName.'" class="form-control input-sm" placeholder="'.$mod_strings['LBL_RECIPIENT_NAME'].'" required data-validation-required-message="'.$mod_strings['LBL_RECIPIENT_NAME'].'" >
                          <input type="hidden" id="must_sign|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="must_sign|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" class="form-control input-sm" value="">
                          <input type="hidden" id="sequence|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="sequence|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" class="form-control input-sm" value="'.$oReceipeint->getRoutingOrder().'">
                          <input type="hidden" id="role|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="role|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" class="form-control input-sm" value="'.$oReceipeint->getRoleName().'">
                          <input type="hidden" id="sugar_module___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="sugar_module___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="'.$prePopFromDetailViewModule.'">
                          <input type="hidden" id="sugar_module_id___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="sugar_module_id___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="'.$prePopFromDetailViewId.'">';
                        } elseif ($oReceipeint instanceof DocuSign\eSign\Model\InPersonSigner) {
                            $sImgSrc = "docusign_32x32.png";
                            $sLabelsInputs = '<label class="sronly" style="white-space:nowrap;">'.$oReceipeint->getRoleName().'</label>
                          <input type="text" id="receipient_name___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="receipient_name___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="'.$prePopFromDetailViewName.'" class="form-control input-sm" placeholder="'.$mod_strings['LBL_RECIPIENT_NAME'].'" required data-validation-required-message="'.$mod_strings['LBL_RECIPIENT_NAME'].'" >
                          <input type="hidden" id="must_sign|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="must_sign|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" class="form-control input-sm" value="">
                          <input type="hidden" id="sequence|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="sequence|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" class="form-control input-sm" value="'.$oReceipeint->getRoutingOrder().'">
                          <input type="hidden" id="inperson|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="inperson|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" class="form-control input-sm" value="'.$oReceipeint->getRoleName().'">
                          <input type="hidden" id="sugar_module___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="sugar_module___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="'.$prePopFromDetailViewModule.'">
                          <input type="hidden" id="sugar_module_id___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="sugar_module_id___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="'.$prePopFromDetailViewId.'">';
                            $sInPersonHostName = '<input type="text" id="host_name___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="host_name___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="" class="form-control input-sm" placeholder="'.$mod_strings['LBL_INPERSON_HOST_NAME'].'" required data-validation-required-message="'.$mod_strings['LBL_INPERSON_HOST_NAME'].'" >';
                        } else {
                            //DocuSign\eSign\Model\CarbonCopy
                            $sImgSrc = "cc.png";
                            $sLabelsInputs = '<label class="sronly" style="white-space:nowrap;">'.$oReceipeint->getRoleName().'</label>
                          <input type="text" id="receipient_name___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="receipient_name___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="'.$prePopFromDetailViewName.'" class="form-control input-sm" placeholder="'.$mod_strings['LBL_RECIPIENT_NAME'].'" required data-validation-required-message="'.$mod_strings['LBL_RECIPIENT_NAME'].'" >
                          <input type="hidden" id="sequence|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="sequence|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" class="form-control input-sm" value="'.$oReceipeint->getRoutingOrder().'">
                          <input type="hidden" id="cc|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="cc|||'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" class="form-control input-sm" value="'.$oReceipeint->getRoleName().'">
                          <input type="hidden" id="sugar_module___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="sugar_module___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="">
                          <input type="hidden" id="sugar_module_id___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="sugar_module_id___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="">';
                        }
                        $sHTML .= '
                        <table id="emlRow_'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="emlRow_'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" width="80%">
                        <tr>
                            <th colspan="4"></th>
                        </tr>
                        <tr>
                            <td style="vertical-align:bottom;">
                            <img id="img_signer_cc---'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" src="modules/UT_DocuSign/images/'.$sImgSrc.'" width="16">
                            </td>
                            <td style="vertical-align:bottom;padding:0px 5px;" >
                            '.$sLabelsInputs.'
                            </td>
                            <td style="vertical-align:bottom;padding:0px 5px;">
                                <label class="sronly" style="white-space:nowrap;">&nbsp;</label>
                                <input type="email" id="receipient_email___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="receipient_email___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="'.$prePopFromDetailViewEmail.'" class="form-control input-sm" placeholder="'.$mod_strings['LBL_RECIPIENT_EMAIL'].'" required data-validation-required-message="'.$mod_strings['LBL_RECIPIENT_EMAIL'].'" >
                            '.$sInPersonHostName.'
                            </td>';
                        if(!empty($oDocuSignClient->is_sms_auth)){
                            $sHTML .= '
                            <td style="vertical-align:bottom;padding:0px 5px;">
                                <input type="text" id="receipient_phone___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" name="receipient_phone___'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" value="'.$prePopFromDetailViewPhone.'" class="form-control input-sm" placeholder="'.$mod_strings['LBL_RECIPIENT_PHONE'].'" required data-validation-required-message="'.$mod_strings['LBL_RECIPIENT_PHONE'].'" >
                            '.$sInPersonHostName.'
                            </td>';
                        }
                        $sHTML .= '
                            <td style="vertical-align:bottom;">
                                <span class="id-ff multiple">
                                    <button type="button" name="btnSelectSignerFromTemplate" id="btnSelectSignerFromTemplate" clickedCount="'.$sRoutingOrderKey.'_'.$iOrderUniqueCnt.'" title="Select a signer from CRM" class="btnSelectSignerFromTemplate button firstChild" value="'.$mod_strings['LBL_ARROW_SIGNER_FROM_CRM'].'">
                                    <img src="themes/SuiteP/images/id-ff-select.png">
                                    </button>
                                </span>
                            </td>
                        </tr>
                        </table>';
                    }
                }
            }
            $sMergeFieldsHTML='
                            <div class="col-xs-12"> 
                            <div class="form-group col-xs-4" style="margin-bottom:5px;">
                                <label for="map_crmtodocusign" class="control-label" style="display:block">'.$mod_strings['LBL_MAP_CRMTODOCUSIGN'].'</label>
                                <select name="map_crmtodocusign" id="map_crmtodocusign" title="'.$mod_strings['LBL_MAP_CRMTODOCUSIGN'].'" >
                                    '.$sCRMToDSMappingOptions.'
                                </select>
                                <span class="help-block"></span>
                            </div>
                            </div>
                            <div class="col-xs-12"> 
                            <div class="form-group col-xs-4" style="margin-bottom:5px;">
                                <label for="map_docusigntocrm" class="control-label" style="display:block">'.$mod_strings['LBL_MAP_DOCUSIGNTOCRM'].'</label>
                                <select name="map_docusigntocrm" id="map_docusigntocrm" title="'.$mod_strings['LBL_MAP_DOCUSIGNTOCRM'].'" >
                                    '.$sDSToCRMMappingOptions.'
                                </select>
                                <span class="help-block"></span>
                            </div>
                            </div>
                            ';
            $sFinalMergeFieldHTML='<div class="col-xs-3 mergefield_block">
                                    <div class="form-group" style="margin-bottom:5px;">
                                        <p style="font-weight:bold;">Choose Field Mapping for</p>
                                        <p>'.$mod_strings['LBL_REQUIRE_ADDITIONAL_INFO'].'</p>
                                    </div>
                                </div>
                                <div class="col-xs-9 mergefield_block">
                                    '.$sMergeFieldsHTML.'
                                </div>
                                <hr class="mergefield_block">';
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
        $aReturn['count'] = $iCount;
        //$aReturn['roles_rowcounter'] = $iCount;
        $aReturn['data']['roles_html']=$sHTML.$javascript;
        $aReturn['data']['mergefields_html']=$sFinalMergeFieldHTML;
        $aReturn['message'] = "";
        $aReturn['status'] = "success";
    } else {
        $GLOBALS['log']->fatal("No templates exists on DocuSign. Please create templates on DocuSign");
        $aReturn['message'] = $mod_strings['LBL_RS_NO_TEMPLATES'];
        $aReturn['status'] = "failed";
    }
} else {
    $GLOBALS['log']->fatal("DocuSign Client Error : ".$aResponse['error']);
    $aReturn['message'] = "DocuSign Client Error : ".$aResponse['error'];
    $aReturn['status'] = "failed";
}
echo $json->encode($aReturn);
exit();
