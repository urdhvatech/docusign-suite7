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
class DSLogicHooksCls
{
    public function colourFields($bean, $event, $arguments)
    {
        global $app_list_strings;
        if ($event == 'process_record' && isset($_REQUEST['method']) && $_REQUEST['method'] =='get_entry_list') {
            return;
        }
        if ($bean->state == "created") {
            $sStyle=" style='padding:0px 10px; background-color:#FF851B; color:white;'";
        } elseif ($bean->state == "sent" || $bean->state == "Send") {
            $sStyle=" style='padding:0px 10px; background-color:#FF851B; color:white;'";
        } elseif ($bean->state == "delivered") {
            $sStyle=" style='padding:0px 10px; background-color:#39CCCC; color:white;'";
        } elseif ($bean->state == "signed") {
            $sStyle=" style='padding:0px 10px; background-color:#2ECC40; color:white;'";
        } elseif ($bean->state == "completed") {
            $sStyle=" style='padding:0px 10px; background-color:#3D9970; color:white;'";
        } elseif ($bean->state == "declined") {
            $sStyle=" style='padding:0px 10px; background-color:#FF4136; color:white;'";
        } elseif ($bean->state == "timedout") {
            $sStyle=" style='padding:0px 10px; background-color:#AAAAAA; color:white;'";
        } elseif ($bean->state == "voided") {
            $sStyle=" style='padding:0px 10px; background-color:#AAAAAA; color:white;'";
        } elseif ($bean->state == "deleted") {
            $sStyle=" style='padding:0px 10px; background-color:#AAAAAA; color:white;'";
        } else {
            $sStyle="";
        }
        $bean->state = "<span ".$sStyle.">".$app_list_strings['ds_state_list'][$bean->state]."</span>";
    }
}
