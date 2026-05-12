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

/**
 * THIS CLASS IS FOR DEVELOPERS TO MAKE CUSTOMIZATIONS IN
 */
require_once('modules/UT_DocuSign/UT_DocuSign_sugar.php');
require_once('modules/UT_DocuSign/DocuSignUtils.php');
class UT_DocuSign extends UT_DocuSign_sugar
{
    public function __construct()
    {
        parent::__construct();
    }
    
    public function save($check_notify = false)
    {
        global $sugar_config, $app_list_strings;

        if (empty($this->id)  || $this->new_with_id) {
            if ($sugar_config['dbconfig']['db_type'] == 'mssql') {
                $this->number = $this->db->getOne("SELECT MAX(CAST(number as INT))+1 FROM ut_docusign");
            } else {
                $this->number = $this->db->getOne("SELECT MAX(CAST(number as UNSIGNED))+1 FROM ut_docusign");
            }
            if (empty($this->number)) {
                $this->number=1;
            }
        }
        $sState = $app_list_strings['ds_state_list'][$this->state];
        //$this->document_name = 'DS : '.$this->number;
        $this->document_name = "DS {$this->number} : {$this->subject}";
        parent::save($check_notify);
    }
    
    public function get_list_view_data()
    {
        $temp_array = parent::get_list_view_data();
        
        $downloadNotesIcon = '';
        if ($this->load_relationship('ut_docusign_notes_1')) {
            $relatedNoteBeans = $this->ut_docusign_notes_1->getBeans();
            if (is_array($relatedNoteBeans) && count($relatedNoteBeans) > 0) {
                $totalNotes = count($relatedNoteBeans);
                $notesCounter = 1;
                foreach ($relatedNoteBeans as $noteId => $noteDetail) {
                    $downloadNotesIcon .= "<a title='".$noteDetail->name."' href='index.php?entryPoint=download&id=".$noteId."&type=Notes'>".SugarThemeRegistry::current()->getImage('attachment' . '', 'border="0"', null, null, '.gif', 'attachment')."</a>";
                    if ($notesCounter != $totalNotes) {
                        $downloadNotesIcon .= "&nbsp;&nbsp;";
                    }
                    
                    $notesCounter++;
                }
            }
        }
        $temp_array["DOWNLOAD_DS_NOTES"] = $downloadNotesIcon;
        $signedDetails = getSignerDetails($this->id);
        $temp_array["RECIPIENT_NAME"] = $signedDetails["recipient_name"];
        $temp_array["EMAIL_ADDRESS"] = $signedDetails["recipient_email"];
        return $temp_array;
    }
}
