<?php
$module_name = 'UT_DSFieldMapping';
$listViewDefs [$module_name] =
array(
  'NAME' =>
  array(
    'width' => '32%',
    'label' => 'LBL_NAME',
    'default' => true,
    'link' => true,
  ),
  'SYNCHRONIZING_DIRECTION' =>
  array(
    'type' => 'enum',
    'studio' => 'visible',
    'label' => 'LBL_SYNCHRONIZING_DIRECTION',
    'width' => '10%',
    'default' => true,
  ),
  'DOCUSIGN_TEMPLATES' =>
  array(
    'type' => 'enum',
    'studio' => 'visible',
    'label' => 'LBL_DOCUSIGN_TEMPLATES',
    'width' => '10%',
    'default' => true,
  ),
  'ASSIGNED_USER_NAME' =>
  array(
    'width' => '9%',
    'label' => 'LBL_ASSIGNED_TO_NAME',
    'module' => 'Employees',
    'id' => 'ASSIGNED_USER_ID',
    'default' => true,
  ),
);
;
