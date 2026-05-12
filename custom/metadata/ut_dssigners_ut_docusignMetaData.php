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
$dictionary["ut_dssigners_ut_docusign"] = array(
  'true_relationship_type' => 'one-to-many',
  'relationships' =>
  array(
    'ut_dssigners_ut_docusign' =>
    array(
      'lhs_module' => 'UT_DocuSign',
      'lhs_table' => 'ut_docusign',
      'lhs_key' => 'id',
      'rhs_module' => 'UT_DSSigners',
      'rhs_table' => 'ut_dssigners',
      'rhs_key' => 'id',
      'relationship_type' => 'many-to-many',
      'join_table' => 'ut_dssigners_ut_docusign_c',
      'join_key_lhs' => 'ut_dssigners_ut_docusignut_docusign_ida',
      'join_key_rhs' => 'ut_dssigners_ut_docusignut_dssigners_idb',
    ),
  ),
  'table' => 'ut_dssigners_ut_docusign_c',
  'fields' =>
  array(
    0 =>
    array(
      'name' => 'id',
      'type' => 'varchar',
      'len' => 36,
    ),
    1 =>
    array(
      'name' => 'date_modified',
      'type' => 'datetime',
    ),
    2 =>
    array(
      'name' => 'deleted',
      'type' => 'bool',
      'len' => '1',
      'default' => '0',
      'required' => true,
    ),
    3 =>
    array(
      'name' => 'ut_dssigners_ut_docusignut_docusign_ida',
      'type' => 'varchar',
      'len' => 36,
    ),
    4 =>
    array(
      'name' => 'ut_dssigners_ut_docusignut_dssigners_idb',
      'type' => 'varchar',
      'len' => 36,
    ),
  ),
  'indices' =>
  array(
    0 =>
    array(
      'name' => 'ut_dssigners_ut_docusignspk',
      'type' => 'primary',
      'fields' =>
      array(
        0 => 'id',
      ),
    ),
    1 =>
    array(
      'name' => 'ut_dssigners_ut_docusign_ida1',
      'type' => 'index',
      'fields' =>
      array(
        0 => 'ut_dssigners_ut_docusignut_docusign_ida',
      ),
    ),
    2 =>
    array(
      'name' => 'ut_dssigners_ut_docusign_alt',
      'type' => 'alternate_key',
      'fields' =>
      array(
        0 => 'ut_dssigners_ut_docusignut_dssigners_idb',
      ),
    ),
  ),
);
