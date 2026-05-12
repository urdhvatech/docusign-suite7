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

require_once('include/Dashlets/DashletGeneric.php');
require_once('modules/UT_DSFieldMapping/UT_DSFieldMapping.php');

class UT_DSFieldMappingDashlet extends DashletGeneric
{
    public function __construct($id, $def = null)
    {
        global $current_user, $app_strings;
        require('modules/UT_DSFieldMapping/metadata/dashletviewdefs.php');

        parent::__construct($id, $def);

        if (empty($def['title'])) {
            $this->title = translate('LBL_HOMEPAGE_TITLE', 'UT_DSFieldMapping');
        }

        $this->searchFields = $dashletData['UT_DSFieldMappingDashlet']['searchFields'];
        $this->columns = $dashletData['UT_DSFieldMappingDashlet']['columns'];

        $this->seedBean = new UT_DSFieldMapping();
    }
}
