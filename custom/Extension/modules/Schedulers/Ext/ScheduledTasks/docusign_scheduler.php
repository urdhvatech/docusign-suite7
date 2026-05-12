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
$job_strings[]='docusign_docupdate';
$job_strings[]='docusign_gettemplates';
/***
* Update Right Signatuare documents status
*
*/
function docusign_docupdate()
{
    $GLOBALS['log']->debug("Get status of the documents from DocuSign START");
    require_once("modules/UT_DocuSign/docusign_docupdate.php");
    docusign_docupdate_cron();
    $GLOBALS['log']->debug("Get status of the documents from DocuSign END");
    return true;
}
/***
* Get templates from Docu Sign
*/
function docusign_gettemplates()
{
    $GLOBALS['log']->debug("Get status of the documents from DocuSign START");
    require_once("modules/UT_DocuSign/docusign_gettemplates.php");
    docusign_gettemplates_cron();
    $GLOBALS['log']->debug("Get status of the documents from DocuSign END");
    return true;
}
