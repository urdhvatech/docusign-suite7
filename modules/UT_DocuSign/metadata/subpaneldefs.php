<?php
if (!defined('sugarEntry') || !sugarEntry) {
    die('Not A Valid Entry Point');
}
$layout_defs['UT_DocuSign'] = array(
    'subpanel_setup' => array(
        'ut_docusign_ut_dsactivities' => array(
          'order' => 100,
          'module' => 'UT_DSActivities',
          'subpanel_name' => 'default',
          'sort_order' => 'asc',
          'sort_by' => 'id',
          'title_key' => 'LBL_UT_DOCUSIGN_UT_RSACTIVITIES_FROM_UT_RSACTIVITIES_TITLE',
          'get_subpanel_data' => 'ut_docusign_ut_dsactivities',
          'top_buttons' =>
          array( ),
        ),
        'ut_dssigners_ut_docusign' => array(
          'order' => 110,
          'module' => 'UT_DSSigners',
          'subpanel_name' => 'default',
          'sort_order' => 'asc',
          'sort_by' => 'id',
          'title_key' => 'LBL_UT_SIGNERS_UT_DOCUSIGN_FROM_UT_SIGNERS_TITLE',
          'get_subpanel_data' => 'ut_dssigners_ut_docusign',
          'top_buttons' => array(),
        ),
        
        'ut_docusign_accounts_1' => array(
          'order' => 100,
          'module' => 'Accounts',
          'subpanel_name' => 'default',
          'sort_order' => 'asc',
          'sort_by' => 'id',
          'title_key' => 'LBL_UT_DOCUSIGN_ACCOUNTS_1_FROM_ACCOUNTS_TITLE',
          'get_subpanel_data' => 'ut_docusign_accounts_1',
          'top_buttons' =>
          array( ),
        ),
         'ut_docusign_contacts_1' => array(
          'order' => 100,
          'module' => 'Contacts',
          'subpanel_name' => 'default',
          'sort_order' => 'asc',
          'sort_by' => 'id',
          'title_key' => 'LBL_UT_DOCUSIGN_CONTACTS_1_FROM_CONTACTS_TITLE',
          'get_subpanel_data' => 'ut_docusign_contacts_1',
          'top_buttons' =>
          array( ),
        ),
        'ut_docusign_leads_1' => array(
          'order' => 100,
          'module' => 'Leads',
          'subpanel_name' => 'default',
          'sort_order' => 'asc',
          'sort_by' => 'id',
          'title_key' => 'LBL_UT_DOCUSIGN_LEADS_1_FROM_LEADS_TITLE',
          'get_subpanel_data' => 'ut_docusign_leads_1',
          'top_buttons' =>
          array( ),
        ),
        'ut_docusign_prospects_1' => array(
          'order' => 100,
          'module' => 'Prospects',
          'subpanel_name' => 'default',
          'sort_order' => 'asc',
          'sort_by' => 'id',
          'title_key' => 'LBL_UT_DOCUSIGN_PROSPECTS_1_FROM_PROSPECTS_TITLE',
          'get_subpanel_data' => 'ut_docusign_prospects_1',
          'top_buttons' =>
          array( ),
        ),
        'ut_docusign_aos_contracts_1' => array(
          'order' => 100,
          'module' => 'AOS_Contracts',
          'subpanel_name' => 'default',
          'sort_order' => 'asc',
          'sort_by' => 'id',
          'title_key' => 'LBL_UT_DOCUSIGN_AOS_CONTRACTS_1_FROM_AOS_CONTRACTS_TITLE',
          'get_subpanel_data' => 'ut_docusign_aos_contracts_1',
          'top_buttons' =>
          array( ),
        ),
        'ut_docusign_aos_quotes_1' => array(
          'order' => 100,
          'module' => 'AOS_Quotes',
          'subpanel_name' => 'default',
          'sort_order' => 'asc',
          'sort_by' => 'id',
          'title_key' => 'LBL_UT_DOCUSIGN_AOS_QUOTES_1_FROM_AOS_QUOTES_TITLE',
          'get_subpanel_data' => 'ut_docusign_aos_quotes_1',
          'top_buttons' =>
          array( ),
        ),
        'ut_docusign_notes_1' => array(
          'order' => 100,
          'module' => 'Notes',
          'subpanel_name' => 'default',
          'sort_order' => 'asc',
          'sort_by' => 'id',
          'title_key' => 'LBL_UT_DOCUSIGN_NOTES_1_FROM_NOTES_TITLE',
          'get_subpanel_data' => 'ut_docusign_notes_1',
          'top_buttons' =>
          array(
          ),
        ),
       'ut_docusign_users_1' =>
       array(
          'order' => 100,
          'module' => 'Users',
          'subpanel_name' => 'default',
          'sort_order' => 'asc',
          'sort_by' => 'id',
          'title_key' => 'LBL_UT_DOCUSIGN_USERS_1_FROM_USERS_TITLE',
          'get_subpanel_data' => 'ut_docusign_users_1',
          'top_buttons' =>
          array(
          ),
       ),
       /*
       'ut_docusign_documents_1' =>
       array(
          'order' => 100,
          'module' => 'Documents',
          'subpanel_name' => 'default',
          'sort_order' => 'asc',
          'sort_by' => 'id',
          'title_key' => 'LBL_UT_DOCUSIGN_DOCUMENTS_1_FROM_DOCUMENTS_TITLE',
          'get_subpanel_data' => 'ut_docusign_documents_1',
          'top_buttons' =>
          array(
          ),
       )
       */
    ),
);
