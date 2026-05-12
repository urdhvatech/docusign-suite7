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
function UTGetPDFContent($templateID, $task='pdf', $module, $uid)
{
    $sPDFContent = $file_name = '';
    if (!isset($uid) || empty($uid) || !isset($templateID) || empty($templateID)) {
        die('Error retrieving record. This record may be deleted or you may not be authorized to view it.');
    }
    error_reporting(0);
    require_once('modules/AOS_PDF_Templates/PDF_Lib/mpdf.php');
    require_once('modules/AOS_PDF_Templates/templateParser.php');
    require_once('modules/AOS_PDF_Templates/sendEmail.php');
    require_once('modules/AOS_PDF_Templates/AOS_PDF_Templates.php');

    global $mod_strings, $sugar_config;

    $bean = BeanFactory::getBean($module, $uid);

    if (!$bean) {
        sugar_die("Invalid Record");
    }

    $task = $task;
    $variableName = strtolower($bean->module_dir);
    $lineItemsGroups = array();
    $lineItems = array();

    $sql = "SELECT pg.id, pg.product_id, pg.group_id FROM aos_products_quotes pg LEFT JOIN aos_line_item_groups lig ON pg.group_id = lig.id WHERE pg.parent_type = '" . $bean->object_name . "' AND pg.parent_id = '" . $bean->id . "' AND pg.deleted = 0 ORDER BY lig.number ASC, pg.number ASC";
    $res = $bean->db->query($sql);
    while ($row = $bean->db->fetchByAssoc($res)) {
        $lineItemsGroups[$row['group_id']][$row['id']] = $row['product_id'];
        $lineItems[$row['id']] = $row['product_id'];
    }


    $template = new AOS_PDF_Templates();
    $template->retrieve($templateID);

    $object_arr = array();
    $object_arr[$bean->module_dir] = $bean->id;

    //backward compatibility
    $object_arr['Accounts'] = $bean->billing_account_id;
    $object_arr['Contacts'] = $bean->billing_contact_id;
    $object_arr['Users'] = $bean->assigned_user_id;
    $object_arr['Currencies'] = $bean->currency_id;
    if ($bean->module_dir === 'Contacts') {
        $object_arr['Accounts'] = $bean->account_id;
        $object_arr[$bean->module_dir] = $bean->id;
    }
    if ($bean->module_dir === 'Accounts') {
        $object_arr[$bean->module_dir] = $bean->id;
    }
    $search = array('/<script[^>]*?>.*?<\/script>/si',      // Strip out javascript
        '/<[\/\!]*?[^<>]*?>/si',        // Strip out HTML tags
        '/([\r\n])[\s]+/',          // Strip out white space
        '/&(quot|#34);/i',          // Replace HTML entities
        '/&(amp|#38);/i',
        '/&(lt|#60);/i',
        '/&(gt|#62);/i',
        '/&(nbsp|#160);/i',
        '/&(iexcl|#161);/i',
        '/<address[^>]*?>/si',
        '/&(apos|#0*39);/',
        '/&#(\d+);/'
    );

    $replace = array('',
        '',
        '\1',
        '"',
        '&',
        '<',
        '>',
        ' ',
        chr(161),
        '<br>',
        "'",
        'chr(%1)'
    );

    $header = preg_replace($search, $replace, $template->pdfheader);
    $footer = preg_replace($search, $replace, $template->pdffooter);
    $text = preg_replace($search, $replace, $template->description);
    
    $iHasSigner = false;
    $iHasAssignedUserSigner = false;
    $iHasCurrentUserSigner = false;
    $iHasInitials = false;
    $iHasInitialAssignedUser = false;
    $iHasInitialCurrentUser = false;
    $iHasDateSigned = false;
    $iHasAssignedUserDateSigned = false;
    $iHasCurrentUserDateSigned = false;
    $RS_SignatureString = '{DS_BOX}';
    $RS_AssignedUserSignatureString = '{DS_ASSIGNED_USER_BOX}';
    $RS_CurrentUserSignatureString = '{DS_CURRENT_USER_BOX}';
    $DS_InitialsString = '{DS_INITIAL}';
    $DS_InitialAssignedUserString = '{DS_INITIAL_ASSIGNED_USER}';
    $DS_InitialCurrentUserString = '{DS_INITIAL_CURRENT_USER}';
    $DS_DateSignedString = '{DS_DATE_SIGNED}';
    $DS_AssignedUserDateSignedString = '{DS_DATE_SIGNED_ASSIGNED_USER}';
    $DS_CurrentUserDateSignedString = '{DS_DATE_SIGNED_CURRENT_USER}';
    //$RS_SignBoxString = '[                    s:signer:r                    ]';
    //$RS_SignBoxString = '[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s:signer:r&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;]';
    //$text = str_replace($RS_SignatureString, $RS_SignBoxString, $text);
    if (strpos($text, $RS_SignatureString) !== false) {
        $iHasSigner = true;
    }
    if (strpos($text, $RS_AssignedUserSignatureString) !== false) {
        $iHasAssignedUserSigner = true;
    }
    if (strpos($text, $RS_CurrentUserSignatureString) !== false) {
        $iHasCurrentUserSigner = true;
    }
    if (strpos($text, $DS_InitialsString) !== false) {
        $iHasInitials = true;
    }
    if (strpos($text, $DS_InitialAssignedUserString) !== false) {
        $iHasInitialAssignedUser = true;
    }
    if (strpos($text, $DS_InitialCurrentUserString) !== false) {
        $iHasInitialCurrentUser = true;
    }
    if (strpos($text, $DS_DateSignedString) !== false) {
        $iHasDateSigned = true;
    }
    if (strpos($text, $DS_AssignedUserDateSignedString) !== false) {
        $iHasAssignedUserDateSigned = true;
    }
    if (strpos($text, $DS_CurrentUserDateSignedString) !== false) {
        $iHasCurrentUserDateSigned = true;
    }
    
    $text = str_replace("<p><pagebreak /></p>", "<pagebreak />", $text);
    $text = preg_replace_callback(
        '/\{DATE\s+(.*?)\}/',
        function ($matches) {
            return date($matches[1]);
        },
        $text
    );
    $text = str_replace("\$aos_quotes", "\$" . $variableName, $text);
    $text = str_replace("\$aos_invoices", "\$" . $variableName, $text);
    $text = str_replace("\$total_amt", "\$" . $variableName . "_total_amt", $text);
    $text = str_replace("\$discount_amount", "\$" . $variableName . "_discount_amount", $text);
    $text = str_replace("\$subtotal_amount", "\$" . $variableName . "_subtotal_amount", $text);
    $text = str_replace("\$tax_amount", "\$" . $variableName . "_tax_amount", $text);
    $text = str_replace("\$shipping_amount", "\$" . $variableName . "_shipping_amount", $text);
    $text = str_replace("\$total_amount", "\$" . $variableName . "_total_amount", $text);

    $text = populate_group_lines($text, $lineItemsGroups, $lineItems);

    $converted = templateParser::parse_template($text, $object_arr);
    $header = templateParser::parse_template($header, $object_arr);
    $footer = templateParser::parse_template($footer, $object_arr);

    $printable = str_replace("\n", "<br />", $converted);

    if ($task == 'pdf') {
        $file_name = str_replace(" ", "_", $bean->name);
        $file_name = str_replace(".", "_", $file_name);
        $file_name = str_replace("/", "_", $file_name).".pdf";

        ob_clean();
        try {
            $pdf = new mPDF('en', 'A4', '', 'DejaVuSansCondensed', $template->margin_left, $template->margin_right, $template->margin_top, $template->margin_bottom, $template->margin_header, $template->margin_footer);
            $pdf->SetAutoFont();
            $pdf->SetHTMLHeader($header);
            $pdf->SetHTMLFooter($footer);
            $pdf->WriteHTML($printable);
            if ($task == 'pdf') {
                $sPDFContent="";
                //$sPDFContent = $pdf->Output($file_name, "S");
                $directoryName = "UT_DSUploads";
                if (!sugar_is_file($directoryName) && !sugar_is_dir($directoryName)) {
                    sugar_mkdir($directoryName, 0755, true);
                }
                $fp = fopen($directoryName."/".$file_name, 'wb');
                fclose($fp);
                $pdf->Output($directoryName."/".$file_name, 'F');
            }
        } catch (mPDF_exception $e) {
            //echo $e;
        }
    } elseif ($task == 'email') {
    }

    return array(
            'sPDFContent'=>$sPDFContent,
            'file_name'=>$file_name,
            'iHasSigner'=>$iHasSigner,
            'iAssignedUserHasSigner'=>$iHasAssignedUserSigner,
            'iCurrentUserHasSigner'=>$iHasCurrentUserSigner,
            'iHasInitials'=>$iHasInitials,
            'iHasInitialAssignedUser'=>$iHasInitialAssignedUser,
            'iHasInitialCurrentUser'=>$iHasInitialCurrentUser,
            'iHasDateSigned' => $iHasDateSigned,
            'iHasAssignedUserDateSigned' => $iHasAssignedUserDateSigned,
            'iHasCurrentUserDateSigned' => $iHasCurrentUserDateSigned,
            
            );
}

function populate_group_lines($text, $lineItemsGroups, $lineItems, $element = 'table')
{
    $firstValue = '';
    $firstNum = 0;

    $lastValue = '';
    $lastNum = 0;

    $startElement = '<' . $element;
    $endElement = '</' . $element . '>';


    $groups = new AOS_Line_Item_Groups();
    foreach ($groups->field_defs as $name => $arr) {
        if (!((isset($arr['dbType']) && strtolower($arr['dbType']) == 'id') || $arr['type'] == 'id' || $arr['type'] == 'link')) {
            $curNum = strpos($text, '$aos_line_item_groups_' . $name);
            if ($curNum) {
                if ($curNum < $firstNum || $firstNum == 0) {
                    $firstValue = '$aos_line_item_groups_' . $name;
                    $firstNum = $curNum;
                }
                if ($curNum > $lastNum) {
                    $lastValue = '$aos_line_item_groups_' . $name;
                    $lastNum = $curNum;
                }
            }
        }
    }
    if ($firstValue !== '' && $lastValue !== '') {
        //Converting Text
        $parts = explode($firstValue, $text);
        $text = $parts[0];
        $parts = explode($lastValue, $parts[1]);
        if ($lastValue == $firstValue) {
            $groupPart = $firstValue . $parts[0];
        } else {
            $groupPart = $firstValue . $parts[0] . $lastValue;
        }

        if (count($lineItemsGroups) != 0) {
            //Read line start <tr> value
            $tcount = strrpos($text, $startElement);
            $lsValue = substr($text, $tcount);
            $tcount = strpos($lsValue, ">") + 1;
            $lsValue = substr($lsValue, 0, $tcount);


            //Read line end values
            $tcount = strpos($parts[1], $endElement) + strlen($endElement);
            $leValue = substr($parts[1], 0, $tcount);

            //Converting Line Items
            $obb = array();

            $tdTemp = explode($lsValue, $text);

            $groupPart = $lsValue . $tdTemp[count($tdTemp) - 1] . $groupPart . $leValue;

            $text = $tdTemp[0];

            foreach ($lineItemsGroups as $group_id => $lineItemsArray) {
                $groupPartTemp = populate_product_lines($groupPart, $lineItemsArray);
                $groupPartTemp = populate_service_lines($groupPartTemp, $lineItemsArray);

                $obb['AOS_Line_Item_Groups'] = $group_id;
                $text .= templateParser::parse_template($groupPartTemp, $obb);
                $text .= '<br />';
            }
            $tcount = strpos($parts[1], $endElement) + strlen($endElement);
            $parts[1] = substr($parts[1], $tcount);
        } else {
            $tcount = strrpos($text, $startElement);
            $text = substr($text, 0, $tcount);

            $tcount = strpos($parts[1], $endElement) + strlen($endElement);
            $parts[1] = substr($parts[1], $tcount);
        }

        $text .= $parts[1];
    } else {
        $text = populate_product_lines($text, $lineItems);
        $text = populate_service_lines($text, $lineItems);
    }


    return $text;
}

function populate_product_lines($text, $lineItems, $element = 'tr')
{
    $firstValue = '';
    $firstNum = 0;

    $lastValue = '';
    $lastNum = 0;

    $startElement = '<' . $element;
    $endElement = '</' . $element . '>';

    //Find first and last valid line values
    $product_quote = new AOS_Products_Quotes();
    foreach ($product_quote->field_defs as $name => $arr) {
        if (!((isset($arr['dbType']) && strtolower($arr['dbType']) == 'id') || $arr['type'] == 'id' || $arr['type'] == 'link')) {
            $curNum = strpos($text, '$aos_products_quotes_' . $name);

            if ($curNum) {
                if ($curNum < $firstNum || $firstNum == 0) {
                    $firstValue = '$aos_products_quotes_' . $name;
                    $firstNum = $curNum;
                }
                if ($curNum > $lastNum) {
                    $lastValue = '$aos_products_quotes_' . $name;
                    $lastNum = $curNum;
                }
            }
        }
    }

    $product = new AOS_Products();
    foreach ($product->field_defs as $name => $arr) {
        if (!((isset($arr['dbType']) && strtolower($arr['dbType']) == 'id') || $arr['type'] == 'id' || $arr['type'] == 'link')) {
            $curNum = strpos($text, '$aos_products_' . $name);
            if ($curNum) {
                if ($curNum < $firstNum || $firstNum == 0) {
                    $firstValue = '$aos_products_' . $name;


                    $firstNum = $curNum;
                }
                if ($curNum > $lastNum) {
                    $lastValue = '$aos_products_' . $name;
                    $lastNum = $curNum;
                }
            }
        }
    }

    if ($firstValue !== '' && $lastValue !== '') {

        //Converting Text
        $tparts = explode($firstValue, $text);
        $temp = $tparts[0];

        //check if there is only one line item
        if ($firstNum == $lastNum) {
            $linePart = $firstValue;
        } else {
            $tparts = explode($lastValue, $tparts[1]);
            $linePart = $firstValue . $tparts[0] . $lastValue;
        }


        $tcount = strrpos($temp, $startElement);
        $lsValue = substr($temp, $tcount);
        $tcount = strpos($lsValue, ">") + 1;
        $lsValue = substr($lsValue, 0, $tcount);

        //Read line end values
        $tcount = strpos($tparts[1], $endElement) + strlen($endElement);
        $leValue = substr($tparts[1], 0, $tcount);
        $tdTemp = explode($lsValue, $temp);

        $linePart = $lsValue . $tdTemp[count($tdTemp) - 1] . $linePart . $leValue;
        $parts = explode($linePart, $text);
        $text = $parts[0];

        //Converting Line Items
        if (count($lineItems) != 0) {
            foreach ($lineItems as $id => $productId) {
                if ($productId != null && $productId != '0') {
                    $obb['AOS_Products_Quotes'] = $id;
                    $obb['AOS_Products'] = $productId;
                    $text .= templateParser::parse_template($linePart, $obb);
                }
            }
        }

        $text .= $parts[1];
    }
    return $text;
}

function populate_service_lines($text, $lineItems, $element = 'tr')
{
    $firstValue = '';
    $firstNum = 0;

    $lastValue = '';
    $lastNum = 0;

    $startElement = '<' . $element;
    $endElement = '</' . $element . '>';

    $text = str_replace("\$aos_services_quotes_service", "\$aos_services_quotes_product", $text);

    //Find first and last valid line values
    $product_quote = new AOS_Products_Quotes();
    foreach ($product_quote->field_defs as $name => $arr) {
        if (!((isset($arr['dbType']) && strtolower($arr['dbType']) == 'id') || $arr['type'] == 'id' || $arr['type'] == 'link')) {
            $curNum = strpos($text, '$aos_services_quotes_' . $name);
            if ($curNum) {
                if ($curNum < $firstNum || $firstNum == 0) {
                    $firstValue = '$aos_products_quotes_' . $name;
                    $firstNum = $curNum;
                }
                if ($curNum > $lastNum) {
                    $lastValue = '$aos_products_quotes_' . $name;
                    $lastNum = $curNum;
                }
            }
        }
    }
    if ($firstValue !== '' && $lastValue !== '') {
        $text = str_replace("\$aos_products", "\$aos_null", $text);
        $text = str_replace("\$aos_services", "\$aos_products", $text);

        //Converting Text
        $tparts = explode($firstValue, $text);
        $temp = $tparts[0];

        //check if there is only one line item
        if ($firstNum == $lastNum) {
            $linePart = $firstValue;
        } else {
            $tparts = explode($lastValue, $tparts[1]);
            $linePart = $firstValue . $tparts[0] . $lastValue;
        }

        $tcount = strrpos($temp, $startElement);
        $lsValue = substr($temp, $tcount);
        $tcount = strpos($lsValue, ">") + 1;
        $lsValue = substr($lsValue, 0, $tcount);

        //Read line end values
        $tcount = strpos($tparts[1], $endElement) + strlen($endElement);
        $leValue = substr($tparts[1], 0, $tcount);
        $tdTemp = explode($lsValue, $temp);

        $linePart = $lsValue . $tdTemp[count($tdTemp) - 1] . $linePart . $leValue;
        $parts = explode($linePart, $text);
        $text = $parts[0];

        //Converting Line Items
        if (count($lineItems) != 0) {
            foreach ($lineItems as $id => $productId) {
                if ($productId == null || $productId == '0') {
                    $obb['AOS_Products_Quotes'] = $id;
                    $text .= templateParser::parse_template($linePart, $obb);
                }
            }
        }

        $text .= $parts[1];
    }
    return $text;
}
