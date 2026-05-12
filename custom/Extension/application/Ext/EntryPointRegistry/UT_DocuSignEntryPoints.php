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
$entry_point_registry['DSPushServiceCallback'] = array(
    'file' => 'modules/UT_DocuSign/DSPushServiceCallback.php',
    'auth' => false
);

$entry_point_registry['DS_ResponseOfSenderView'] = array(
    'file' => 'modules/UT_DocuSign/DS_ResponseOfSenderView.php',
    'auth' => false
);

$entry_point_registry['DocuSignAuthorizeApps'] = array(
    'file' => 'modules/UT_DocuSign/UT_AuthorizeApps.php',
    'auth' => true
);