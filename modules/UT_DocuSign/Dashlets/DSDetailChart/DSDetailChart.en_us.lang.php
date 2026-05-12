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

$defaultText = "DocuSign Chart";
$dashletStrings['DSDetailChart'] = array('LBL_TITLE'            => 'DocuSign Chart',
                                         'LBL_DESCRIPTION'      => 'A dashlet to see graphical status of Signature activities',
                                         'LBL_SAVING'           => 'Saving DocuSign dashlet ...',
                                         'LBL_SAVED'            => 'Saved',
                                         'LBL_CONFIGURE_TITLE'  => 'Title',
                                         'LBL_CONFIGURE_HEIGHT' => 'Height (1 - 300)',
                                         'LBL_DBLCLICK_HELP'    => 'Double click below to Edit.',
                                         'LBL_DEFAULT_TEXT'     => $defaultText,
);
