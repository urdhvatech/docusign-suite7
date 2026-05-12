<?php
if (!defined('sugarEntry') || !sugarEntry) {
    die('Not A Valid Entry Point');
}
$layout_defs['UT_DSFieldMapping'] = array(
    'subpanel_setup' => array(
        'ut_dsfieldmapping_ut_docusign_1' => array(
              'order' => 100,
              'module' => 'UT_DocuSign',
              'subpanel_name' => 'default',
              'sort_order' => 'asc',
              'sort_by' => 'id',
              'title_key' => 'LBL_UT_DSFIELDMAPPING_UT_DOCUSIGN_1_FROM_UT_DOCUSIGN_TITLE',
              'get_subpanel_data' => 'ut_dsfieldmapping_ut_docusign_1',
              'top_buttons' =>
              array(
              ),
        ),
        'ut_dsfieldmapping_ut_docusign_2' => array(
              'order' => 100,
              'module' => 'UT_DocuSign',
              'subpanel_name' => 'default',
              'sort_order' => 'asc',
              'sort_by' => 'id',
              'title_key' => 'LBL_UT_DSFIELDMAPPING_UT_DOCUSIGN_2_FROM_UT_DOCUSIGN_TITLE',
              'get_subpanel_data' => 'ut_dsfieldmapping_ut_docusign_2',
              'top_buttons' =>
              array(
              ),
        ),
    ),
);
