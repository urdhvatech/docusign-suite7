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
$admin_option_defs=array();
$admin_option_defs['Administration']['ut_docusign_info']= array('','LBL_ESIGN_DOCUSIGN_LICENSE_TITLE','LBL_ESIGN_DOCUSIGN_LICENSE','./index.php?module=UT_DocuSign&action=license');
$admin_option_defs['Administration']['UT_DocuSign_Key']= array('UrdhvaTech','LBL_UT_DOCUSIGN_KEY_ICON','LBL_UT_DOCUSIGN_KEY_TITLE','./index.php?module=UT_DocuSign&action=DocuSignAppKeys');
$admin_option_defs['Administration']['ut_docusign_templates']= array('','LBL_SYNCHRONIZE_DOCUSIGN_TEMPLATES','LBL_SYNCHRONIZE_DOCUSIGN_TEMPLATES_DESC','./index.php?module=UT_DocuSign&action=syncDocusignTemplates');

$admin_group_header[]= array('LBL_UT_DOCUSIGN_TITLE','',false,$admin_option_defs, 'LBL_UT_DOCUSIGN_DESC');
