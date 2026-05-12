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
var count = 0;
var roles_rowcounter = {};
$(document).ready(function () {
    
    $('#UrdhvaTechDocuSign').on('submit', function(event){
       if($("#sending_type").val() == 'external_file')
       {
           var receipientExist = false;
           var isPhoneRequired = false;
           var receipientPhoneExists = false;
           $('[id^=receipient_name___]').each(function() {
                var receipientNumber = this.id.split('___').pop();
                if(receipientNumber != "" && typeof(receipientNumber) != "undefined")
                {
                    if($(this).val().length != 0 && $('#receipient_email___'+receipientNumber).length != 0)
                        receipientExist = true;
                }
           });
           if(!receipientExist)
           {
                $.unblockUI();
                alert(SUGAR.language.get("UT_DocuSign", "LBL_SIGNER_MANDATORY_MSG"));
                return false;
           }
           //BEGINS: Added by Urdhva Tech for SMS
           if($("#sending_option").val() == 'email_sms' || $("#sending_option").val() == 'sms_auth')
           {
               isPhoneRequired=true;
               $('[id^=receipient_phone___]').each(function() {
                    var receipientNumber = this.id.split('___').pop();
                    if(receipientNumber != "" && typeof(receipientNumber) != "undefined")
                    {
                        if($(this).val().length != 0 && $('#receipient_phone___'+receipientNumber).length != 0)
                            receipientPhoneExists = true;
                    }
               });
               if(!receipientPhoneExists)
               {
                    $.unblockUI();
                    alert(SUGAR.language.get("UT_DocuSign", "LBL_SIGNER_MANDATORY_SMS"));
                    return false;
               }
           }
           //ENDS: Added by Urdhva Tech for SMS
           
           event.preventDefault();
           event.stopPropagation();
           showAjaxLoading();
           // Change the submit action to submitToEmbedSenderView
           var $input = $(this).find("input[name=action]");
           $input.val('submitToEmbedSenderView');
           var formData = new FormData(this);
           $.ajax({
                url: 'index.php?sugar_body_only=1&to_pdf=1',
                type: 'POST',
                //enctype: 'multipart/form-data',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $.unblockUI();
                    $('#senderViewIframeModal .modal-body').html('<h1>Loading...</h1>');
                    $('#senderViewIframeModal').modal({show:true});
                    var response = eval("(" + data + ")");
                    if(response.error != ''){
                        $("#senderViewIframeModal .modal-body").html(response.error);
                    }
                    if(response.response != ''){
                        $("#senderViewIframeModal .modal-body").html(response.response);
                    }
                    $(this).attr('action','SendDocumentRS');
                },
                error: function (e) {
                    $.unblockUI();
                    $(this).attr('action','SendDocumentRS');
                }
           });
       }
       else{
           // Submit the form
           return;
       }
    });
    
    $("#sending_type").change(function() {
        selectedVal = $(this).val();
        $("#browsefiles_block").hide();
        $("#rs_template_block_1").hide();
        if(selectedVal =='select_template')
        {
            $("#rs_template_block_1").show();
            $("#signer_cc_btn_row").hide();
            $("#uploadfiles").prop('required',null);
            $("#rs_template_id").prop('required',true);
        }
        else if(selectedVal =='external_file'){
            $("#browsefiles_block").show();
            $("#rs_template_id").val('');
            $("#signer_cc_btn_row").show();
            $("#uploadfiles").prop('required',true);
            $("#rs_template_id").prop('required',null);
        }
        
        for(i=0;i<=count;i++){
            $("#emlRow_"+i).remove();
        }
        if(typeof(roles_rowcounter) == 'string'){
            roles_rowcounter = JSON.parse(roles_rowcounter);
        }
        $.each(roles_rowcounter, function(routingorder, MyObj) {
            $.each(MyObj, function (orderuniquecnt, obj) {
                $("#emlRow_"+routingorder+"_"+orderuniquecnt).remove();
            });
        });
        
        $(".mergefield_block").remove();
    });
    $("#sending_type").change();
    rsGetTemplateCallback = function(o){
        try {
            var response = eval("(" + o.responseText + ")");
            if(response.status == "success"){
                if(response.message != '')
                    alert(response.message);
                
                for(i=0;i<=count;i++){
                    $("#emlRow_"+i).remove();
                }
                if(typeof(roles_rowcounter) == 'string'){
                    roles_rowcounter = JSON.parse(roles_rowcounter);
                }
                $.each(roles_rowcounter, function(routingorder, MyObj) {
                    $.each(MyObj, function (orderuniquecnt, obj) {
                        $("#emlRow_"+routingorder+"_"+orderuniquecnt).remove();
                    });
                });
                
                $(".mergefield_block").remove();
                if(response.data.roles_html !=''){
                    $("#appendRowsDiv").append(response.data.roles_html);
                }
                if(response.data.mergefields_html !=''){
                    $("#appendMappingFieldsRow").append(response.data.mergefields_html);
                }
                $("#subject").val(response.data.subject);
                $("#message").val(response.data.description);
                count= response.count;
                $.unblockUI();
            }
            else{
                if(response.recipient_exist == "No") {
                    alert(response.message);
                }
                else {
                    if(response.message != '')
                        alert(response.message);
                    else
                        alert(SUGAR.language.get("UT_DocuSign", "LBL_ERRMSG_4"));
                }
                $.unblockUI();
            }
        }
        catch(e) {            
            alert(SUGAR.language.get("UT_DocuSign", "LBL_ERRMSG_4"));
            $.unblockUI();
        }
    }
    $("#rs_template_id").change(function() {
        selectedVal = $(this).val();
        sTemplateId = $("#rs_template_id").val();
        if(sTemplateId != '')
        {
            $.blockUI({ message: '<h1>'+SUGAR.language.get("UT_DocuSign", "LBL_LOADING_TEMPLATE")+'</h1>' });
            postData = "sugar_body_only=1&to_pdf=1&module=UT_DocuSign&action=GetRSTemplateDetails&rs_template_id="+sTemplateId+"&count="+count;
            if(prePopFromDetailViewModule!='' && prePopFromDetailViewId !='' && prePopFromDetailViewName !=''){
                postData+="&prePopFromDetailViewModule="+prePopFromDetailViewModule+"&prePopFromDetailViewId="+prePopFromDetailViewId+"&prePopFromDetailViewName="+prePopFromDetailViewName+"&prePopFromDetailViewEmail="+prePopFromDetailViewEmail+"&prePopFromDetailViewPhone="+prePopFromDetailViewPhone;
            }
            var cObj = YAHOO.util.Connect.asyncRequest('POST','index.php', {success: rsGetTemplateCallback, failure: rsGetTemplateCallback}, postData);
        }
        else{
            alert(SUGAR.language.get("UT_DocuSign", "LBL_NO_TEMPLATED_SELECTED"));
        }
    });
    $("body").delegate( ".removeRow", "click", function() {
        iRowIndex = $(this).attr('rowIndex');
        sSugarId = $("#sugarid---"+iRowIndex).val();
        if(sSugarId != ""){
            if(confirm(SUGAR.language.get("UT_DocuSign", "LBL_CONFIRM_DELETE_RECIPIENT"))){
                // Make ajax call to delete the keyword
                $("#emlRow_"+iRowIndex).remove();
            }
        }
        else
            $("#emlRow_"+iRowIndex).remove();
    });
    
    $("#btnaddsigner").click(function(eventData) {
        addKeyword(eventData,'signer');
    });
    $("#btnaddcc").click(function(eventData) {
        addKeyword(eventData,'cc');
    });
    $("#signer_from_crm").click(function(eventData) {
        addSignerCCFromCRM(eventData,'signer');
    });
    $("#cc_from_crm").click(function(eventData) {
        addSignerCCFromCRM(eventData,'cc');
    });
    $( document ).delegate(".btnSelectSignerFromTemplate", "click", function(eventData) {
        clickedCount = $(this).attr('clickedCount');
        addSignerCCFromCRM(eventData,'',true,clickedCount);
    });
    $("#btnSelectSigner").click(function(eventData) {
        SelectedModuleName=$("#parent_type").val();
        SelectedRecordName=$("#parent_name").val();
        SelectedRecordID=$("#parent_id").val();
        SelectedRecordEmail=$("#email_address").val();
        SelectedRecordPhone=$("#phone").val(); // SMS
        if(SelectedRecordPhone == 'undefined'){
            SelectedRecordPhone=''; // SMS
        }

        sForTemplate = $("#for_template").val();
        clickedCount = $("#clickedCount_txt").val();
        if(SelectedRecordID != '')
        {
            if(SelectedRecordEmail==''){
                alert(SUGAR.language.get("UT_DocuSign", "LBL_ERRMSG_1"));
            }
            else
            {
                if(sForTemplate=='1') {
                    $("#receipient_name___"+clickedCount).val(SelectedRecordName);
                    $("#receipient_email___"+clickedCount).val(SelectedRecordEmail);
                    $("#receipient_phone___"+clickedCount).val(SelectedRecordPhone); // SMS
                    $("#sugar_module___"+clickedCount).val(SelectedModuleName);
                    $("#sugar_module_id___"+clickedCount).val(SelectedRecordID);
                    
                    $("#receipient_name___"+clickedCount).prop('readonly', true);
                    $("#receipient_email___"+clickedCount).prop('readonly', true);
                }
                else {
                    actionbtn = $("#txtclickedaction").val();
                    if(actionbtn == 'signer'){
                        addKeyword(eventData,'signer');
                    }
                    else{
                        addKeyword(eventData,'cc');
                    }
                    $("#receipient_name___"+count).val(SelectedRecordName);
                    $("#receipient_email___"+count).val(SelectedRecordEmail);
                    $("#receipient_phone___"+count).val(SelectedRecordPhone); // SMS
                    $("#sugar_module___"+count).val(SelectedModuleName);
                    $("#sugar_module_id___"+count).val(SelectedRecordID);
                    
                    $("#receipient_name___"+count).prop('readonly', true);
                    $("#receipient_email___"+count).prop('readonly', true);
                }
                $("#parent_type").val('');
                $("#parent_name").val('');
                $("#parent_id").val('');
                $("#email_address").val('');
                $("#phone").val(''); // SMS
                $("#for_template").val('0');
                $("#clickedCount_txt").val('-1');
                
                $('#rs_signerfromcrm_modal').modal('hide');
            }
        }
        else{
            alert(SUGAR.language.get("UT_DocuSign", "LBL_SELECT_RECORD"));
        }
    });
    if(prePopulateAction != ''){
        comesFromModuleDetailView(prePopulateAction);
    }
});

function addKeyword(event,actionbtn){
    count++;
    var $clone = $("#closerHidden").clone();
    $clone.attr({
        id: "emlRow_" + count,
        name: "emlRow_" + count,
        style: "" // remove "display:none"
    });
    $clone.find("input,select,textarea").each(function(){
        sValue = '';
        isCheckbox = false;
        isTextArea = false;
        if($(this).attr("id") == "must_sign|||" && actionbtn == 'signer'){
            sValue = 1;
        }
        $(this).attr({
            id: $(this).attr("id") + count,
            name: $(this).attr("name") + count,
            value: sValue,
            required: 'required'
        });
    });
    $clone.find("#divCollapse---").each(function(){
        sdivCollapse = "divCollapse---"+count;
        $(this).attr({
            id: sdivCollapse,
            name: sdivCollapse
        });
    });
    $clone.find("a").each(function(){
        if($(this).attr("data-target") ){
            if($(this).attr("data-target") == "#divCollapse---") {
                sString1 = "#divCollapse---"+count;
                $(this).attr({
                    "data-target": sString1
                });
            }
        }
    });
    $clone.find("span").each(function(){
        if($(this).hasClass("removeRow")) {
            $(this).attr({
                rowindex: count
            });
        }
    });
    $clone.find("img").each(function(){
        if($(this).attr("id") == "img_signer_cc---"){
            imgsrc = '';
            if(actionbtn == 'signer')
                imgsrc = 'modules/UT_DocuSign/images/docusign_32x32.png';
            else
                imgsrc = 'modules/UT_DocuSign/images/cc.png';
            $(this).attr({
                src: imgsrc,
            });
        }
    });
    //if count == 1 then do not add the first horizontal line
    if(count==1){
        $clone.find("#dividerRow---").each(function(){
            sdivDividerRow = "dividerRow---"+count;
            $(this).attr({
                id: sdivDividerRow,
                style: 'padding-bottom:10px',
            });
        });
    }
    else
    {
        $clone.find("#dividerRow---").each(function(){
            sdivDividerRow = "dividerRow---"+count;
            $(this).attr({
                id: sdivDividerRow,
            });
        });
    }
    $("#appendRowsDiv").append($clone);
}
function addSignerCCFromCRM(event,actionbtn,sForTemplate,clickedCount) {
    $("#for_template").val('0');
    $("#clickedCount_txt").val('-1');
    if(actionbtn == 'signer'){
        $("#txtclickedaction").val('signer');
    }
    else if(actionbtn == 'cc'){
        $("#txtclickedaction").val('cc');
    }
    if(sForTemplate==true){
        $("#for_template").val('1');
        $("#clickedCount_txt").val(clickedCount);
    }
    $('#rs_signerfromcrm_modal').modal('show',{backdrop: 'static'});
    return false;
}
function comesFromModuleDetailView(sending_type)
{
    $("#sending_type").val(sending_type);
    $('#sending_type').trigger('change');
    if(sending_type == 'external_file'){
        addSignerCCFromCRM('','signer');
        $("#parent_type").val(prePopFromDetailViewModule);
        $("#parent_name").val(prePopFromDetailViewName);
        $("#parent_id").val(prePopFromDetailViewId);
        $("#email_address").val(prePopFromDetailViewEmail);
        $("#phone").val(prePopFromDetailViewPhone); // SMS
        $("#for_template").val('0');
        $("#clickedCount_txt").val('-1');
        $('#btnSelectSigner').trigger('click');
    }
    else if(sending_type == 'select_template'){
    }
}
function showAjaxLoading(){
    $.blockUI({ message: '<h1>'+SUGAR.language.get("UT_DocuSign", "LBL_PROCESSING")+'</h1>' });
    return false;
}