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
global $app_strings;

$dashletMeta['UT_DocuSignDashlet'] = array('module'		=> 'UT_DocuSign',
                                          'title'       => translate('LBL_HOMEPAGE_TITLE', 'UT_DocuSign'),
                                          'description' => 'A customizable view into UT_DocuSign',
                                          'category'    => 'Module Views');
