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
if (!isset($hook_array) || !is_array($hook_array)) {
    $hook_array = array();
}

if (!isset($hook_array['after_ui_frame']) || !is_array($hook_array['after_ui_frame'])) {
    $hook_array['after_ui_frame'] = array();
}

$hook_array['after_ui_frame'][] =  array(15, 'custom action button for docusign', 'modules/UT_DocuSign/logic_hooks/display_action_button.php','UT_DS_DisplayActionButton', 'UT_DS_DisplayActionButtonProcess'); ;
