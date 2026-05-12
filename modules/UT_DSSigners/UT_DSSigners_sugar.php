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
class UT_DSSigners_sugar extends Basic
{
    public $new_schema = true;
    public $module_dir = 'UT_DSSigners';
    public $object_name = 'UT_DSSigners';
    public $table_name = 'ut_dssigners';
    public $importable = false;
    public $disable_row_level_security = true ; // to ensure that modules created and deployed under CE will continue to function under team security if the instance is upgraded to PRO

    public $id;
    public $name;
    public $date_entered;
    public $date_modified;
    public $modified_user_id;
    public $modified_by_name;
    public $created_by;
    public $created_by_name;
    public $description;
    public $deleted;
    public $created_by_link;
    public $modified_user_link;
    public $assigned_user_id;
    public $assigned_user_name;
    public $assigned_user_link;
    public $SecurityGroups;
    public $recipient_email;
    public $role;
    public $rs_doc_id;
    public $parent_name;
    public $parent_type;
    public $parent_id;
    
    public function __construct()
    {
        parent::__construct();
    }
    
    public function bean_implements($interface)
    {
        switch ($interface) {
            case 'ACL': return true;
        }
        return false;
    }
}
