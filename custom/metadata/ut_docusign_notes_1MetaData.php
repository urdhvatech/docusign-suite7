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
$dictionary["ut_docusign_notes_1"] = array(
  'true_relationship_type' => 'one-to-many',
  'from_studio' => true,
  'relationships' =>
  array(
    'ut_docusign_notes_1' =>
    array(
      'lhs_module' => 'UT_DocuSign',
      'lhs_table' => 'ut_docusign',
      'lhs_key' => 'id',
      'rhs_module' => 'Notes',
      'rhs_table' => 'notes',
      'rhs_key' => 'id',
      'relationship_type' => 'many-to-many',
      'join_table' => 'ut_docusign_notes_1_c',
      'join_key_lhs' => 'ut_docusign_notes_1ut_docusign_ida',
      'join_key_rhs' => 'ut_docusign_notes_1notes_idb',
    ),
  ),
  'table' => 'ut_docusign_notes_1_c',
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
      'name' => 'ut_docusign_notes_1ut_docusign_ida',
      'type' => 'varchar',
      'len' => 36,
    ),
    4 =>
    array(
      'name' => 'ut_docusign_notes_1notes_idb',
      'type' => 'varchar',
      'len' => 36,
    ),
  ),
  'indices' =>
  array(
    0 =>
    array(
      'name' => 'ut_docusign_notes_1spk',
      'type' => 'primary',
      'fields' =>
      array(
        0 => 'id',
      ),
    ),
    1 =>
    array(
      'name' => 'ut_docusign_notes_1_ida1',
      'type' => 'index',
      'fields' =>
      array(
        0 => 'ut_docusign_notes_1ut_docusign_ida',
      ),
    ),
    2 =>
    array(
      'name' => 'ut_docusign_notes_1_alt',
      'type' => 'alternate_key',
      'fields' =>
      array(
        0 => 'ut_docusign_notes_1notes_idb',
      ),
    ),
  ),
);
