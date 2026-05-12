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

global $app_strings, $current_language;

$dashletMeta['DSDetailChart'] = array('title'       => 'LBL_TITLE', // array index in language pack
                                      'description' => 'LBL_DESCRIPTION', // array index in language pack
                                      'icon'        => 'icon_Charts_Vertical_32.svg',
                                      'category'    => 'Charts');
