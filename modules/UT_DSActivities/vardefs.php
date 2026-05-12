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
$dictionary['UT_DSActivities'] = array(
    'table'=>'ut_dsactivities',
    'audited'=>true,
    'inline_edit'=>true,
        'duplicate_merge'=>true,
        'fields'=>array(
            'rs_keyword' =>
              array(
                'required' => false,
                'name' => 'rs_keyword',
                'vname' => 'LBL_KEYWORD',
                'type' => 'enum',
                'massupdate' => 0,
                'no_default' => false,
                'comments' => '',
                'help' => '',
                'importable' => 'true',
                'duplicate_merge' => 'disabled',
                'duplicate_merge_dom_value' => '0',
                'audited' => false,
                'inline_edit' => '',
                'reportable' => true,
                'unified_search' => false,
                'merge_filter' => 'disabled',
                'len' => 100,
                'size' => 20,
                'options' => 'rs_activity_kewords',
              ),
              'recipient_name'=>
                array(
                    'name'=>'recipient_name',
                    'vname'=> 'LBL_RECIPIENT_NAME',
                    'type'=>'name',
                    'link' => false, // bug 39288
                    'dbType' => 'varchar',
                    'len'=>255,
                    'unified_search' => true,
                    'full_text_search' => array('boost' => 3),
                    'required'=>false,
                    'importable' => 'false',
                    'duplicate_merge' => 'enabled',
                    'merge_filter' => 'selected',
                ),
              'recipient_email'=>
                array(
                    'name'=>'recipient_email',
                    'vname'=> 'LBL_RECIPIENT_EMAIL',
                    'type'=>'name',
                    'link' => false, // bug 39288
                    'dbType' => 'varchar',
                    'len'=>255,
                    'unified_search' => true,
                    'full_text_search' => array('boost' => 3),
                    'required'=>false,
                    'importable' => 'false',
                    'duplicate_merge' => 'enabled',
                    'merge_filter' => 'selected',
                ),
              'rs_summary' =>
              array(
                'required' => false,
                'name' => 'rs_summary',
                'vname' => 'LBL_SUMMARY',
                'type' => 'varchar',
                'massupdate' => 0,
                'no_default' => false,
                'comments' => '',
                'help' => '',
                'importable' => 'true',
                'duplicate_merge' => 'disabled',
                'duplicate_merge_dom_value' => '0',
                'audited' => false,
                'inline_edit' => '',
                'reportable' => true,
                'unified_search' => false,
                'merge_filter' => 'disabled',
                'len' => 5,
                'size' => 5
              ),
              'rs_created_at' =>
              array(
                'required' => false,
                'name' => 'rs_created_at',
                'vname' => 'LBL_RS_CREATED_AT',
                'type' => 'datetimecombo',
                'massupdate' => 0,
                'no_default' => false,
                'comments' => '',
                'help' => '',
                'importable' => 'true',
                'duplicate_merge' => 'disabled',
                'duplicate_merge_dom_value' => '0',
                'audited' => false,
                'inline_edit' => '',
                'reportable' => true,
                'unified_search' => false,
                'merge_filter' => 'disabled',
                'size' => '20',
                'enable_range_search' => false,
                'dbType' => 'datetime',
              ),
              'ut_docusign_ut_dsactivities' =>
              array(
                  'name' => 'ut_docusign_ut_dsactivities',
                  'type' => 'link',
                  'relationship' => 'ut_docusign_ut_dsactivities',
                  'source' => 'non-db',
                  'module' => 'UT_DocuSign',
                  'bean_name' => 'UT_DocuSign',
                  'vname' => 'LBL_UT_DOCUSIGN_UT_RSACTIVITIES_FROM_UT_DOCUSIGN_TITLE',
                  'id_name' => 'ut_docusign_ut_dsactivitiesut_docusign_ida',
              ),
              'ut_docusign_ut_dsactivities_name' =>
              array(
                  'name' => 'ut_docusign_ut_dsactivities_name',
                  'type' => 'relate',
                  'source' => 'non-db',
                  'vname' => 'LBL_UT_DOCUSIGN_UT_RSACTIVITIES_FROM_UT_DOCUSIGN_TITLE',
                  'save' => true,
                  'id_name' => 'ut_docusign_ut_dsactivitiesut_docusign_ida',
                  'link' => 'ut_docusign_ut_dsactivities',
                  'table' => 'ut_docusign',
                  'module' => 'UT_DocuSign',
                  'rname' => 'document_name',
              ),
              'ut_docusign_ut_dsactivitiesut_docusign_ida' =>
              array(
                'name' => 'ut_docusign_ut_dsactivitiesut_docusign_ida',
                'type' => 'link',
                'relationship' => 'ut_docusign_ut_dsactivities',
                'source' => 'non-db',
                'reportable' => false,
                'side' => 'right',
                'vname' => 'LBL_UT_DOCUSIGN_UT_RSACTIVITIES_FROM_UT_RSACTIVITIES_TITLE',
              ),
),
    'relationships'=>array(
),
    'optimistic_locking'=>true,
        'unified_search'=>true,
    );
if (!class_exists('VardefManager')) {
    require_once('include/SugarObjects/VardefManager.php');
}
VardefManager::createVardef('UT_DSActivities', 'UT_DSActivities', array('basic','assignable','security_groups'));
