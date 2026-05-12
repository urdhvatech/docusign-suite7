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

class UT_DocuSignViewEdit extends ViewEdit
{
    public function __construct()
    {
        parent::__construct();
    }
    public function display()
    {
        if (isset($this->bean->id)) {
            $this->ss->assign("FILE_OR_HIDDEN", "hidden");
            if (empty($_REQUEST['isDuplicate']) || $_REQUEST['isDuplicate'] == 'false') {
                $this->ss->assign("DISABLED", "disabled");
            }
        } else {
            $this->ss->assign("FILE_OR_HIDDEN", "file");
        }
        parent::display();
    }
}
