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

require_once('include/MVC/View/views/view.detail.php');

class UT_DocuSignViewDetail extends ViewDetail
{
    public function __construct()
    {
        parent::__construct();
    }

    public function display()
    {
        if (empty($this->bean->id)) {
            global $app_strings;
            sugar_die($app_strings['ERROR_NO_RECORD']);
        }

        require_once('modules/AOS_PDF_Templates/formLetter.php');
        formLetter::DVPopupHtml('Accounts');

        $this->dv->process();
        global $mod_strings, $app_list_strings;

        if (empty($this->bean->id)) {
            global $app_strings;
            sugar_die($app_strings['ERROR_NO_RECORD']);
        }
        
        if ($this->bean->state == "created") {
            $sStyle=" style='padding:0px 10px; background-color:#FF851B; color:white;'";
        } elseif ($this->bean->state == "sent" || $this->bean->state == "Send") {
            $sStyle=" style='padding:0px 10px; background-color:#FF851B; color:white;'";
        } elseif ($this->bean->state == "delivered") {
            $sStyle=" style='padding:0px 10px; background-color:#39CCCC; color:white;'";
        } elseif ($this->bean->state == "signed") {
            $sStyle=" style='padding:0px 10px; background-color:#2ECC40; color:white;'";
        } elseif ($this->bean->state == "completed") {
            $sStyle=" style='padding:0px 10px; background-color:#3D9970; color:white;'";
        } elseif ($this->bean->state == "declined") {
            $sStyle=" style='padding:0px 10px; background-color:#FF4136; color:white;'";
        } elseif ($this->bean->state == "timedout") {
            $sStyle=" style='padding:0px 10px; background-color:#AAAAAA; color:white;'";
        } elseif ($this->bean->state == "voided") {
            $sStyle=" style='padding:0px 10px; background-color:#AAAAAA; color:white;'";
        } elseif ($this->bean->state == "deleted") {
            $sStyle=" style='padding:0px 10px; background-color:#AAAAAA; color:white;'";
        } else {
            $sStyle="";
        }
            
        $sStateHTML = "<span ".$sStyle.">".$app_list_strings['ds_state_list'][$this->bean->state]."</span>";

        $this->ss->assign('sStateHTML', $sStateHTML);
        echo $this->dv->display();
    }
}
