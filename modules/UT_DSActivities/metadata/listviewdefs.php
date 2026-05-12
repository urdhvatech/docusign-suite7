<?php
if (!defined('sugarEntry') || !sugarEntry) {
    die('Not A Valid Entry Point');
}
$module_name = 'UT_DSActivities';
$listViewDefs[$module_name] = array(
    'RS_SUMMARY'=>array(
        'label' => 'LBL_SUMMARY',
        'width' => '20',
        'default' => true,
        'sortable' => false,
    ),
    'DESCRIPTION'=>array(
        'label' => 'LBL_DESCRIPTION',
        'width' => '20',
        'default' => true,
        'sortable' => false,
    ),
    'ASSIGNED_USER_NAME' => array(
        'width' => '9',
        'label' => 'LBL_ASSIGNED_TO_NAME',
        'module' => 'Employees',
        'id' => 'ASSIGNED_USER_ID',
        'default' => true
    ),
);
