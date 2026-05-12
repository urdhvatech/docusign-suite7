<?php
if (!defined('sugarEntry') || !sugarEntry) {
    die('Not A Valid Entry Point');
}
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
$module_name='UT_DSActivities';
$subpanel_layout = array(
    'top_buttons' => array(
        array('widget_class' => 'SubPanelTopCreateButton'),
        array('widget_class' => 'SubPanelTopSelectButton', 'popup_module' => $module_name),
    ),

    'where' => '',

    'list_fields' => array(
        'rs_summary'=>array(
            'vname' => 'LBL_SUMMARY',
            'widget_class' => '',
            'width' => '40%',
        ),
        'description'=>array(
            'vname' => 'LBL_DESCRIPTION',
            'widget_class' => '',
            'width' => '30%',
        ),
        /*'rs_keyword'=>array(
             'vname' => 'LBL_KEYWORD',
            'widget_class' => '',
             'width' => '10%',
        ),*/
        'rs_created_at'=>array(
             'vname' => 'LBL_RS_CREATED_AT',
             'width' => '10%',
        ),
        'date_modified'=>array(
            'vname' => 'LBL_DATE_MODIFIED',
            'width' => '10%',
        ),
        'edit_button'=>array(
            'vname' => 'LBL_EDIT_BUTTON',
            'widget_class' => 'SubPanelEditButton',
            'module' => $module_name,
            'width' => '4%',
        ),
        'remove_button'=>array(
            'vname' => 'LBL_REMOVE',
            'widget_class' => 'SubPanelRemoveButton',
            'module' => $module_name,
            'width' => '5%',
        ),
    ),
);
