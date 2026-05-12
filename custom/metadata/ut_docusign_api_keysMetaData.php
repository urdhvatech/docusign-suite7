<?php
if (!defined('sugarEntry') || !sugarEntry) {
    die('Not A Valid Entry Point');
}

$dictionary['ut_docusign_api_keys'] = array(
    'table' => 'ut_docusign_api_keys',
    'fields' => array(
          'id' =>
          array(
            'name' => 'id',
            'vname' => 'LBL_ID',
            'type' => 'id',
            'required'=>true,
            'reportable'=>true,
            'comment' => 'Unique identifier'
          ),
          /*
          'username'=>
          array(
            'name'=>'username',
            'vname'=> 'LBL_USERNAME',
            'type'=>'varchar',
            'dbType' => 'varchar',
            'len'=>100
          ),
          'password'=>
          array(
            'name'=>'password',
            'vname'=> 'LBL_PASSWORD',
            'type'=>'varchar',
            'dbType' => 'varchar',
            'len'=>255
          ),
          */
          'client_secret'=>
          array(
            'name'=>'client_secret',
            'vname'=> 'LBL_CLIENT_SECRET',
            'type'=>'varchar',
            'dbType' => 'varchar',
            'len'=>255
          ),
          'client_key'=>
          array(
            'name'=>'client_key',
            'vname'=> 'LBL_client_key',
            'type'=>'varchar',
            'dbType' => 'varchar',
            'len'=>255
          ),
          'integrator_key'=>
          array(
            'name'=>'integrator_key',
            'vname'=> 'LBL_INTEGRATOR_KEY',
            'type'=>'varchar',
            'dbType' => 'varchar',
            'len'=>255
          ),
          'ds_environment_type'=>
          array(
            'name'=>'ds_environment_type',
            'vname'=> 'LBL_DS_ENVIRONMENT_TYPE',
            'type'=>'enum',
            'options' => 'ds_environment_type_dom',
            'default' => 'Demo',
            'len' => 255,
          ),
          'host'=>
          array(
            'name'=>'host',
            'vname'=> 'LBL_HOST',
            'type'=>'varchar',
            'len'=>255
          ),
          'accountid'=>
          array(
            'name'=>'accountid',
            'vname'=> 'LBL_ACCOUNTID',
            'type'=>'varchar',
            'len'=>255
          ),
          'access_token'=>
          array(
            'name'=>'access_token',
            'vname'=> 'LBL_ACCESS_TOKEN',
            'type'=>'text',
            'dbType' => 'text',
          ),
          'refresh_token'=>
          array(
            'name'=>'refresh_token',
            'vname'=> 'LBL_REFRESH_TOKEN',
            'type'=>'text',
            'dbType' => 'text',
          ),
          'expires_in'=>
          array(
            'name'=>'expires_in',
            'vname'=> 'LBL_EXPIRES_IN',
            'type'=>'varchar',
            'dbType' => 'varchar',
            'len'=>10
          ),
          'token_type'=>
          array(
            'name'=>'token_type',
            'vname'=> 'LBL_TOKEN_TYPE',
            'type'=>'varchar',
            'dbType' => 'varchar',
            'len'=>50
          ),
          'expiration_datetime'=>
          array(
            'name' => 'expiration_datetime',
            'vname' => 'LBL_EXPIRATION_DATETIME',
            'type' => 'datetime',
            'enable_range_search' => true,
            'options' => 'date_range_search_dom',
            'inline_edit' => false,
          ),
          'is_sms_auth' =>
          array(
            'name' => 'is_sms_auth',
            'vname' => 'LBL_IS_SMS_AUTH',
            'type' => 'bool',
            'default' => 0,
            'reportable'=>false,
          ),
          'deleted' =>
          array(
            'name' => 'deleted',
            'vname' => 'LBL_DELETED',
            'type' => 'bool',
            'default' => '0',
            'reportable'=>false,
          )
    ),
    'indices' => array(
        array('name' => 'ut_docusign_api_keys_pk', 'type' =>'primary', 'fields'=>array('id')),
    )
);
