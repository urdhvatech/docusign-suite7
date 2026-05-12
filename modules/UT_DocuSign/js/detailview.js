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
$(document).ready(function () {
    $(document).delegate("#update_ds_status", "click", function() {
    var record_id = $(this).attr("record_id");
    if (record_id === undefined)
    {
        record_id = $("#update_ds_status_old").attr("record_id");
    }
    var callback = {
            success:function(o) {
                var response = eval("(" + o.responseText + ")");
                if(response.status == "success"){
                    if(response.message != '')
                        alert(response.message);
                }
                else{
                    if(response.message != '')
                        alert(response.message);
                    else
                        alert(SUGAR.language.get("UT_DocuSign", "LBL_ERRMSG_4"));
                }
                SUGAR.ajaxUI.hideLoadingPanel();
                location.reload();
            },
            failure:function(o) {
                location.reload();
            }
        }
        SUGAR.ajaxUI.showLoadingPanel();
        YAHOO.util.Connect.asyncRequest('GET', 'index.php?module=UT_DocuSign&action=ajax_handler&to_pdf=1&id='+record_id, callback, null);
        return false;
    });
});