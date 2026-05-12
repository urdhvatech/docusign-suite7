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
function getApplicationKey()
{
    global $db,$sugar_config;
    $results = array();
    $sSql = "SELECT * FROM ut_docusign_api_keys WHERE deleted=0 ";
    $sSql = $db->limitQuery($sSql, 0, 1, false, '', false);
    $oRes = $db->query($sSql, true);
    $aRow = $db->fetchByAssoc($oRes);
    if (!empty($aRow)) {
        $results = $aRow;
    }
    return $results;
    //return $aRow;
}
function getOAuthDBSettings($sugar_user_id=1)
{
    $sugar_user_id=1;
    global $db;
    $results = array();
    $sSql = "SELECT * FROM ut_oauth_session WHERE user_fld='".$sugar_user_id."' AND server='DocuSign'";
    $oRes = $db->query($sSql, true);
    $aRow = $db->fetchByAssoc($oRes);
    //if(!empty($aRow['session']) && !empty($aRow['state']) && !empty($aRow['access_token'])
//        && !empty($aRow['access_token_secret']) && !empty($aRow['authorized']) && ($aRow['authorized'] == 'Y' || $aRow['authorized'] == 1))
    if (!empty($aRow['session']) && !empty($aRow['state']) && !empty($aRow['access_token'])
            && !empty($aRow['authorized']) && ($aRow['authorized'] == 'Y' || $aRow['authorized'] == 1)) {
        $results = $aRow;
    }
    return $results;
}

function convertAllObjectToArray($obj)
{
    // Convert object to array
    if (is_object($obj)) {
        $obj = (array) $obj;
    }

    // If variable is array then loop each values inside it
    if (is_array($obj)) {
        foreach ($obj as $key => $val) {
            // if $val is object then call same function again
            if (is_object($val)) {
                $obj[$key] = convertAllObjectToArray($val);
            }
            // if $val is array then also call same function again
            elseif (is_array($val)) {
                $obj[$key] = convertAllObjectToArray($val);
            }
            // if $val is not array or object then fill the return array with $val
            else {
                $obj[$key] = $val;
            }
        }
    }
    return $obj;
}

function update_rs_dropdown($dropdown_name, $newArray)
{
    require_once('modules/ModuleBuilder/MB/ModuleBuilder.php');
    require_once('modules/ModuleBuilder/parsers/parser.dropdown.php');
    global $app_list_strings,$current_language;
    $_REQUEST['view_package'] = 'studio'; //need this in parser.dropdown.php
    $parser = new ParserDropDown();
    $params = array();
    $params['view_package'] = 'studio';
    $params['dropdown_name'] = $dropdown_name;
    $params['dropdown_lang'] = (!empty($params['dropdown_lang'])?$params['dropdown_lang']:$current_language);
    //$dropdownvalue =array_merge($app_list_strings[$params['dropdown_name']],$newArray);
    $dropdownvalue =$newArray;
    foreach ($dropdownvalue as $key => $sValue) {
        $drop_list[] = array($key, $sValue);
    }
    if (count($drop_list) > 0) {
        $json = getJSONobj();
        $params['list_value'] = $json->encode($drop_list);
        $parser->saveDropDown($params);
    }
}

/**
 * Convert input data for other fields to database friendly type
 *
 * @param array $data - post data
 * @return string - serialized array
 */
function prepare_other_fields($data)
{
    $result = array();
    foreach (array('include', 'exclude') as $key) {
        //isset($array[$key]) ? $array[$key] : $default;
        $aOutput = isset($data[$key]) ? $data[$key] : array();
        $arr = explode(',', $aOutput);
        $result[$key] = array_filter(array_map('trim', $arr));
    }
    return base64_encode(serialize($result));
}

/**
 * Unserialize other fields (include/exclude words), return by key as string or array
 *
 * @param string|FALSE $key 'exclude' or 'include'
 * @param bool $as_string - return data as comma-separated string
 * @return array|string
 */
function get_other_fields($OtherFields, $key = false, $as_string = false)
{
    $data = unserialize(base64_decode($OtherFields));
    if ($key) {
        $data = $data[$key];
        return $as_string ? implode(', ', $data) : $data;
    }
    return $data;
}
function decStrNum($n)
{
    $n = (string)$n;
    if ((int)$n == 0 || 0 === strpos($n, '-')) {
        return false;
    }
    $result = $n;
    $len = strlen($n);
    $i = $len - 1;
    while ($i > -1) {
        if ($n[$i] === "0") {
            $end = substr($result, $i + 1);
            if ($end === false) {
                $end = '';
            }
            $result = substr($result, 0, -($len - $i)) . "9" . $end;
            $i--;
        } else {
            $end = substr($result, $i + 1);
            if ($end === false) {
                $end = '';
            }
            return substr($result, 0, -($len - $i)) . ((int)$n[$i] - 1) . $end;
        }
    }
    return $result;
}
function utDS_getModuleFields($aRequest)
{
    global $mod_strings,$current_language;
    $bak_mod_strings=$mod_strings;
    $mod_strings_modulebuilder = return_module_language($current_language, 'ModuleBuilder');
    $Returnfields = array();
    $module_name = $aRequest['view_module'];

    global $current_language;
    $module_strings = return_module_language($current_language, $module_name);

    $fieldsData = array();
    $customFieldsData = array();

    //use fieldTypes variable to map field type to displayed field type
    $fieldTypes = $mod_strings_modulebuilder['fieldTypes'];
    //add datetimecombo type field from the vardef overrides to point to Datetime type
    $fieldTypes['datetime'] = $fieldTypes['datetimecombo'];

    if (!isset($aRequest['view_package']) || $aRequest['view_package'] == 'studio') {
        $objectName = BeanFactory::getObjectName($module_name);
        VardefManager::loadVardef($module_name, $objectName, true);
        global $dictionary;
        //$f = array($mod_strings_modulebuilder['LBL_HCUSTOM']=>array(), $mod_strings_modulebuilder['LBL_HDEFAULT']=>array());

        foreach ($dictionary[$objectName]['fields'] as $def) {
            if (ut_isValidStudioField($def)) {
                $def['label'] = translate($def['vname'], $module_name);
                //Custom relate fields will have a non-db source, but custom_module set
                if (isset($def['source']) && $def['source'] == 'custom_fields' || isset($def['custom_module'])) {
                    //$f[$mod_strings_modulebuilder['LBL_HCUSTOM']][$def['name']] = $def;
                    $def['custom'] = true;
                } else {
                    //$f[$mod_strings_modulebuilder['LBL_HDEFAULT']][$def['name']] = $def;
                    $def['custom'] = false;
                }
                $def['type'] = isset($fieldTypes[$def['type']]) ? $fieldTypes[$def['type']] : ucfirst($def['type']);
                $fieldsData[] = $def;
                $Returnfields[$def['name']] = $def['label'];
                $customFieldsData[$def['name']] = $def['custom'];
            }
        }
    }
    return $Returnfields;
}
function ut_isValidStudioField($def)
{
    if (isset($def['studio'])) {
        if (is_array($def [ 'studio' ])) {
            if (isset($def['studio']['editField']) && $def['studio']['editField'] == true) {
                return true;
            }
            if (isset($def['studio']['required']) && $def['studio']['required']) {
                return true;
            }
        } else {
            if ($def['studio'] == 'visible') {
                return true;
            }
            if ($def['studio'] == 'hidden' || $def['studio'] == 'false' || !$def['studio']) {
                return false;
            }
        }
    }
    if (empty($def ['source']) || $def ['source'] == 'db' || $def ['source'] == 'custom_fields') {
        if ($def ['type'] != 'id' && (empty($def ['dbType']) || $def ['dbType'] != 'id')) {
            return true;
        }
    }
    
    return false;
}

function getSyncOption($sSyncDirection, $ds_template_id, $iOption = false)
{
    global $db, $app_list_strings;
    $aMappingList = array(''=>'--Choose Mapping--');
    $sSql = "SELECT id, name 
            FROM ut_dsfieldmapping 
            WHERE deleted=0 AND synchronizing_direction='".$sSyncDirection."' AND docusign_templates='".$ds_template_id."'";
    $oRes = $db->query($sSql);
    while ($aRow = $db->fetchByAssoc($oRes)) {
        $aMappingList[$aRow['id']]=$aRow['name'];
    }
    
    if ($iOption == true) {
        $sMappingListOptions = get_select_options_with_id($aMappingList, '');
        return $sMappingListOptions;
    } else {
        return $aMappingList;
    }
}

function getSignerDetails($dsRecordId)
{
    global $db;
    $returnSignerDetails = array('recipient_name'=>'','recipient_email'=>'');
    $selectSignerSql = "SELECT ut_dssigners.* FROM ut_dssigners INNER JOIN ut_dssigners_ut_docusign_c ON ut_dssigners_ut_docusign_c.ut_dssigners_ut_docusignut_dssigners_idb = ut_dssigners.id AND ut_dssigners_ut_docusign_c.deleted='0' AND ut_dssigners_ut_docusign_c.ut_dssigners_ut_docusignut_docusign_ida = '".$dsRecordId."'"
            . " INNER JOIN ut_docusign ON ut_docusign.id = ut_dssigners_ut_docusign_c.ut_dssigners_ut_docusignut_docusign_ida AND ut_docusign.deleted = '0' AND ut_docusign.id = '".$dsRecordId."'"
            . " WHERE ut_dssigners.deleted = '0'";
    $selectSignerRs = $db->query($selectSignerSql, true);
    while ($selectSignerRow = $db->fetchByAssoc($selectSignerRs)) {
        if (!empty($selectSignerRow["parent_type"]) && !empty($selectSignerRow["parent_id"])) {
            $oModule = BeanFactory::getBean($selectSignerRow["parent_type"], $selectSignerRow["parent_id"]);
            if (!empty($oModule->id)) {
                $returnSignerDetails["recipient_name"] .= "<a target='_blank' href='index.php?module=".$oModule->module_name."&action=DetailView&record=".$oModule->id."'>".$oModule->name."</a>, ";
            } else {
                $returnSignerDetails["recipient_name"] .= !empty($selectSignerRow["name"])?$selectSignerRow["name"].", ":"";
            }
        } else {
            $returnSignerDetails["recipient_name"] .= !empty($selectSignerRow["name"])?$selectSignerRow["name"].", ":"";
        }
        
        $returnSignerDetails["recipient_email"] .= !empty($selectSignerRow["recipient_email"])?$selectSignerRow["recipient_email"].", ":"";
    }
    if (!empty($returnSignerDetails["recipient_name"])) {
        $returnSignerDetails["recipient_name"] = substr($returnSignerDetails["recipient_name"], 0, -2);
    }
    
    if (!empty($returnSignerDetails["recipient_email"])) {
        $returnSignerDetails["recipient_email"] = substr($returnSignerDetails["recipient_email"], 0, -2);
    }
    
    return $returnSignerDetails;
}

function checkDocuSignLicense()
{
    global $db, $app_strings, $app_list_strings, $current_user, $sugar_config, $current_language;
    require_once('modules/UT_DocuSign/license/OutfittersLicense.php');
    $oUTDocusignLicense = new UTDocusignLicense();
    $valid = $oUTDocusignLicense::isValid('UT_DocuSign');
    if ($valid !== true) {
        return false;
    } else {
        return true;
    }
}

function getAccessTokenFromYourDataStore()
{
    global $db;
    
    //Get the access_token, refresh token, expires_in and token_type from DB.
    $aResult = array(
        'access_token' => '',
        'refresh_token' => '',
        'expires_in' => '',
        'token_type' => '',
        'expiration_datetime' => '',
    );
    $sSql = "SELECT * FROM ut_docusign_api_keys WHERE deleted=0 ";
    $sSql = $db->limitQuery($sSql, 0, 1, false, '', false);
    $oRes = $db->query($sSql, true);
    $aRow = $db->fetchByAssoc($oRes);
    if (!empty($aRow)) {
        $aResult = $aRow;
    }
    return $aResult;
}
function setAccessTokenToYourDataStore($initialOAuthToken)
{
    global $db;
    
    $sSelSql = "SELECT * FROM ut_docusign_api_keys WHERE deleted=0 ";
    $sSelSql = $db->limitQuery($sSelSql, 0, 1, false, '', false);
    $oRes = $db->query($sSelSql, true);
    $aRow = $db->fetchByAssoc($oRes);
    $iExpirationDate = getExpirationDate($initialOAuthToken->getExpiresIn());
    if (!empty($aRow)) {
        $sUpdateSql = "UPDATE ut_docusign_api_keys SET access_token='".$initialOAuthToken->getAccessToken()."', refresh_token='".$initialOAuthToken->getRefreshToken()."', expires_in='".$initialOAuthToken->getExpiresIn()."', token_type='".$initialOAuthToken->getTokenType()."', expiration_datetime='".$iExpirationDate."' WHERE id='".$aRow['id']."'";
        $db->query($sUpdateSql, true);
    }
}

function isAccessTokenExpired($existingAccessToken)
{
    //global $timedate;
    if (empty($existingAccessToken['expiration_datetime'])) {
        return true; // Access token is expired.
    }
    $sExpirationDateTime = $existingAccessToken['expiration_datetime'];
    $datetime = new DateTime();
    $oCurrentDate = new DateTime();
    $oExpirationDate = $datetime->createFromFormat('Y-m-d H:i:s', $sExpirationDateTime);
    $sExpriationTimeStamp = $oExpirationDate->getTimestamp();
    // Instead of waiting for an access token to expire, DocuSign recommends that you refresh the access token when it is close to expiring (within 30 minutes, for example).
    $sExpriationTimeStamp = $sExpriationTimeStamp - 1800; // 1800 seconds = 30 minutes
    $sCurrentTimeStamp = $oCurrentDate->getTimestamp();
    
    if ($sExpriationTimeStamp <= $sCurrentTimeStamp) {
        return true;// Access token is expired.
    }
    return false;
}
function getExpirationDate($sExpiresIn)
{
    $date = new DateTime();
    //echo $date->getTimestamp(). "<br>";
    //echo $date->format('Y-m-d H:i:s'). "<br>";
    $date->add(new DateInterval('PT'.$sExpiresIn.'S')); // adds 28800 secs
    //echo $date->getTimestamp(). "<br>";
    //echo $date->format('Y-m-d H:i:s'). "<br>";
    return $date->format('Y-m-d H:i:s');
}
