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
$dictionary["ut_dsfieldmapping_ut_docusign_2"] = array(
  'true_relationship_type' => 'one-to-many',
  'from_studio' => true,
  'relationships' =>
  array(
    'ut_dsfieldmapping_ut_docusign_2' =>
    array(
      'lhs_module' => 'UT_DSFieldMapping',
      'lhs_table' => 'ut_dsfieldmapping',
      'lhs_key' => 'id',
      'rhs_module' => 'UT_DocuSign',
      'rhs_table' => 'ut_docusign',
      'rhs_key' => 'id',
      'relationship_type' => 'many-to-many',
      'join_table' => 'ut_dsfieldmapping_ut_docusign_2_c',
      'join_key_lhs' => 'ut_dsfieldmapping_ut_docusign_2ut_dsfieldmapping_ida',
      'join_key_rhs' => 'ut_dsfieldmapping_ut_docusign_2ut_docusign_idb',
    ),
  ),
  'table' => 'ut_dsfieldmapping_ut_docusign_2_c',
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
      'name' => 'ut_dsfieldmapping_ut_docusign_2ut_dsfieldmapping_ida',
      'type' => 'varchar',
      'len' => 36,
    ),
    4 =>
    array(
      'name' => 'ut_dsfieldmapping_ut_docusign_2ut_docusign_idb',
      'type' => 'varchar',
      'len' => 36,
    ),
  ),
  'indices' =>
  array(
    0 =>
    array(
      'name' => 'ut_dsfieldmapping_ut_docusign_2spk',
      'type' => 'primary',
      'fields' =>
      array(
        0 => 'id',
      ),
    ),
    1 =>
    array(
      'name' => 'ut_dsfieldmapping_ut_docusign_2_ida1',
      'type' => 'index',
      'fields' =>
      array(
        0 => 'ut_dsfieldmapping_ut_docusign_2ut_dsfieldmapping_ida',
      ),
    ),
    2 =>
    array(
      'name' => 'ut_dsfieldmapping_ut_docusign_2_alt',
      'type' => 'alternate_key',
      'fields' =>
      array(
        0 => 'ut_dsfieldmapping_ut_docusign_2ut_docusign_idb',
      ),
    ),
  ),
);
