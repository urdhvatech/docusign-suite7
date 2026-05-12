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
require_once('modules/UT_DSActivities/UT_DSActivities_sugar.php');
class UT_DSActivities extends UT_DSActivities_sugar
{
    public function __construct()
    {
        parent::__construct();
    }
    public function get_list_view_data($filter_fields = array())
    {
        global $db, $app_list_strings, $mod_strings, $current_language;
        $temp_array = parent::get_list_view_data();

        $aModString_RSActivities = return_module_language($current_language, 'UT_DSActivities');
        $sUTRSSql = "SELECT ut_docusign.id, ut_docusign.document_name, ut_dsactivities.id as rsact_id, ut_dsactivities.name as rs_name, ut_dsactivities.rs_keyword, ut_dsactivities.recipient_name, ut_dsactivities.recipient_email 
                    FROM ut_docusign 
                    INNER JOIN ut_docusign_ut_dsactivities_c rel ON rel.ut_docusign_ut_dsactivitiesut_docusign_ida = ut_docusign.id 
                    INNER JOIN ut_dsactivities ON ut_dsactivities.id=rel.ut_docusign_ut_dsactivitiesut_dsactivities_idb AND ut_dsactivities.deleted=0 AND ut_dsactivities.id='".$temp_array['ID']."'
                    WHERE ut_docusign.deleted=0";
        $sUTRSSql = $db->limitQuery($sUTRSSql, 0, 1, false, '', false);
        $oRes = $db->query($sUTRSSql, true);
        $aRow = $db->fetchByAssoc($oRes);
        $sRSName = $sRSId = $sRSActi_RecipientName = "";
        if (!empty($aRow['id'])) {
            $sRSName = $aRow['document_name'];
            $sRSId = $aRow['id'];
            $sRSActId = $aRow['rsact_id'];
            $sRSActi_RecipientName = $aRow['rs_name'];
            $sActivitiesName = '';
            $sStyleFront=" style='padding:0px 10px; background-color:grey; color:white;'";
            $sStyleBack=" style='padding:0px 10px; background-color:green; color:white;'";
            $sActivitiesName = "<span ".$sStyleFront."><a href='index.php?module=UT_DocuSign&action=DetailView&record=".$sRSId."' style='color:white;'>".$aModString_RSActivities['LBL_DOC_PACKET']." ".$sRSName."</a></span> <span ".$sStyleBack."><a href='index.php?module=UT_DSActivities&action=DetailView&record=".$sRSActId."' style='color:white;'>".$sRSActi_RecipientName."</a></span>";
            
            $temp_array['RS_SUMMARY'] = $sActivitiesName;
        }
        return $temp_array;
    }
}
