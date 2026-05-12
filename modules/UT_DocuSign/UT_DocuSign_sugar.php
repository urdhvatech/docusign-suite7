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
require_once('include/SugarObjects/templates/file/File.php');

class UT_DocuSign_sugar extends File
{
    public $new_schema = true;
    public $module_dir = 'UT_DocuSign';
    public $object_name = 'UT_DocuSign';
    public $table_name = 'ut_docusign';
    public $importable = false;
    public $disable_row_level_security = true ; // to ensure that modules created and deployed under CE will continue to function under team security if the instance is upgraded to PRO

    public $id;
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
    public $document_name;
    public $filename;
    public $file_ext;
    public $file_mime_type;
    public $uploadfile;
    public $active_date;
    public $exp_date;
    public $status_id;
    public $status;
    public $parent_name;
    public $parent_type;
    public $parent_id;
    public $email_address;
    public $docusign_templates;
    public $sending_type;
    public $recipient_name;
    public $ds_doc_id;
    public $subject;
    public $message;
    public $state;
    public $rs_created_at;
    public $rs_completed_at;
    public $rs_expires_on;
    
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
