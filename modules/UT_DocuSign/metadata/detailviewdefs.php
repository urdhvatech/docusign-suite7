<?php
$module_name = 'UT_DocuSign';
$_object_name = 'ut_docusign';
$viewdefs [$module_name] =
array(
  'DetailView' =>
  array(
    'templateMeta' =>
    array(
      'maxColumns' => '2',
      'form' =>
      array(
        'buttons' =>
        array(
          0 => 'DELETE',
          1 =>
          array(
            'customCode' => '<input title="{$MOD.LBL_UPDATE_STATUS_BUTTON}" class="button" record_id="{$fields.id.value}" id="update_ds_status" name="update_ds_status" value="{$MOD.LBL_UPDATE_STATUS_BUTTON}" type="button">',
          ),
        ),
      ),
      'widths' =>
      array(
        0 =>
        array(
          'label' => '10',
          'field' => '30',
        ),
        1 =>
        array(
          'label' => '10',
          'field' => '30',
        ),
      ),
      'useTabs' => false,
      'includes' =>
      array(
        0 =>
        array(
          'file' => 'modules/UT_DocuSign/js/detailview.js',
        ),
      ),
      'tabDefs' =>
      array(
        'DEFAULT' =>
        array(
          'newTab' => false,
          'panelDefault' => 'expanded',
        ),
      ),
      'syncDetailEditViews' => true,
    ),
    'panels' =>
    array(
      'default' =>
      array(
        0 =>
        array(
          0 => 'document_name',
        ),
        1 =>
        array(
          0 =>
          array(
            'name' => 'sending_type',
            'studio' => 'visible',
            'label' => 'LBL_SENDING_TYPE',
          ),
          1 =>
          array(
            'name' => 'docusign_templates',
            'studio' => 'visible',
            'label' => 'LBL_RIGHTSIGNATURE_TEMPLATES',
          ),
        ),
        2 =>
        array(
          0 =>
          array(
            'name' => 'ut_dsfieldmapping_ut_docusign_2_name',
            'label' => 'LBL_UT_DSFIELDMAPPING_UT_DOCUSIGN_2_FROM_UT_DSFIELDMAPPING_TITLE',
          ),
          1 =>
          array(
            'name' => 'ut_dsfieldmapping_ut_docusign_1_name',
            'label' => 'LBL_UT_DSFIELDMAPPING_UT_DOCUSIGN_1_FROM_UT_DSFIELDMAPPING_TITLE',
          ),
        ),
        3 =>
        array(
          0 =>
          array(
            'name' => 'subject',
            'label' => 'LBL_SUBJECT',
          ),
          1 =>
          array(
            'name' => 'message',
            'studio' => 'visible',
            'label' => 'LBL_MESSAGE',
          ),
        ),
        4 =>
        array(
          0 =>
          array(
            'name' => 'state',
            'customCode' => '{$sStateHTML}',
            'label' => 'LBL_STATE',
          ),
          1 => null,
        ),
        5 =>
        array(
          0 =>
          array(
            'name' => 'rs_created_at',
            'label' => 'LBL_RS_CREATED_AT',
          ),
          1 =>
          array(
            'name' => 'rs_completed_at',
            'label' => 'LBL_RS_COMPLETED_AT',
          ),
        ),
        6 =>
        array(
          0 =>
          array(
            'name' => 'rs_declined_on',
            'label' => 'LBL_RS_DECLINED_ON',
          ),
          1 =>
          array(
            'name' => 'rs_voided_on',
            'label' => 'LBL_RS_VOIDED_ON',
          ),
        ),
        7 =>
        array(
          0 => 'active_date'
        ),
        8 =>
        array(
          0 => 'assigned_user_name',
          1 => 'description',
        ),
      ),
    ),
  ),
);
