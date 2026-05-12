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

    rsGetTemplateCallback = function(o){
        try {
            var response = eval("(" + o.responseText + ")");
            if(response.status == "success"){
                if(response.message != '')
                    alert(response.message);
                if(response.data.roles_html !=''){
                    $("#appendRowsDiv").html(response.data.roles_html);
                    //$("#appendRowsDiv").find("script").each(function(i) {
                        //eval($(this).text());
                    //});
                }
                if(response.data.fields_html !=''){
                    $("#appendMappingFieldsRow").html(response.data.fields_html);
                    $(".select2").select2({
                        width: 'resolve', // need to override the changed default
                    });
                }
                $('#synchronizing_direction').trigger('change');
                $.unblockUI();
            }
            else{
                if(response.message != '')
                    alert(response.message);
                else
                    alert(SUGAR.language.get("UT_DSFieldMapping", "LBL_ERRMSG_4"));
                $.unblockUI();
                $("#appendRowsDiv").html('');
                $("#appendMappingFieldsRow").html('');
                $('#synchronizing_direction').trigger('change');
                roles_rowcounter = {};
                
            }
        }
        catch(e) {
            alert(SUGAR.language.get("UT_DSFieldMapping", "LBL_ERRMSG_4"));
            $.unblockUI();
            $("#appendRowsDiv").html('');
            $("#appendMappingFieldsRow").html('');
            roles_rowcounter = {};
        }
    }
    $("#docusign_templates").change(function() {
        selectedVal = $(this).val();
        sTemplateId = $("#docusign_templates").val();
        var srecord = $("#record").val();
        var sChangedModule = '';
        if(sTemplateId != '')
        {
            $(".module_routing").each(function() {
                routingorder=$(this).attr('routingorder');
                sChangedModule += '&'+$(this).attr('id')+'='+$(this).val();
            });
            
            $.blockUI({ message: '<h1>'+SUGAR.language.get("UT_DSFieldMapping", "LBL_LOADING_TEMPLATE")+'</h1>' });
            postData = "sugar_body_only=1&to_pdf=1&module=UT_DSFieldMapping&action=manageFieldMapping&rs_template_id="+sTemplateId;
            if(srecord !=''){
                postData+="&record="+srecord;
            }
            if(sChangedModule != ''){
                postData+=sChangedModule;
            }
            var cObj = YAHOO.util.Connect.asyncRequest('POST','index.php', {success: rsGetTemplateCallback, failure: rsGetTemplateCallback}, postData);
        }
        else{
            alert(SUGAR.language.get("UT_DSFieldMapping", "LBL_NO_TEMPLATED_SELECTED"));
        }
        $('#synchronizing_direction').trigger('change');
    });
    $(document).delegate(".module_routing", "change", function(eventData) {
        routingorder = $(this).attr('routingorder');
        $('#docusign_templates').trigger('change');
    });
    $('#docusign_templates').trigger('change');
    
    $("#synchronizing_direction").change(function() {
        var sDirectionArrow = '';
        if($(this).val() =='ds_crm'){
            sDirectionArrow = ' >> ';
        }
        else{
            sDirectionArrow = ' << ';
        }
        $(".direction_arrow").each(function() {
            $(this).html(sDirectionArrow);
        });
    });
    //$('#synchronizing_direction').trigger('change');
    
    addRowCallback = function(o){
        try {
            var response = eval("(" + o.responseText + ")");
            if(response.status == "success"){
                if(response.message != '')
                    alert(response.message);
                if(response.data.roles_html !=''){
                    $("#appendRowsDiv").html(response.data.roles_html);
                }
                $.unblockUI();
            }
            else{
                if(response.message != '')
                    alert(response.message);
                else
                    alert(SUGAR.language.get("UT_DSFieldMapping", "LBL_ERRMSG_4"));
                $.unblockUI();
            }
        }
        catch(e) {
            alert(SUGAR.language.get("UT_DSFieldMapping", "LBL_ERRMSG_4"));
            $.unblockUI();
        }
    };
    $("body").delegate(".addrowBtn", "click", function(eventData) {
        routingorder = $(this).attr('routingorder');
        orderuniquecnt = $(this).attr('orderuniquecnt');
        var $cloneDSFields = $("#dummy_dsfield___"+routingorder+"___"+orderuniquecnt).clone();
        
        var sModName = $("#crmmod_"+routingorder+"_"+orderuniquecnt).val();
        var sModuleFieldList = 'dummy_'+sModName;
        var $cloneCRMFields = $("#"+sModuleFieldList).clone();
        
        if(typeof(roles_rowcounter) == 'string'){
            roles_rowcounter = JSON.parse(roles_rowcounter);
        }
        
        $.each(roles_rowcounter, function(key, MyObj) {
            
            if(key == routingorder)
            {
                 $.each(MyObj, function (ind, obj) {
                    if(ind == orderuniquecnt)
                    {
                        iNextCounter = obj.rowcounter +1;
                        $cloneDSFields.attr({
                            id: "ds_field___"+routingorder+"___"+orderuniquecnt+"___"+iNextCounter,
                            name: "ds_field___"+routingorder+"___"+orderuniquecnt+"___"+iNextCounter+"[]",
                        });
                        
                        $cloneCRMFields.attr({
                            id: "crm_field___"+routingorder+"___"+orderuniquecnt+"___"+iNextCounter,
                            name: "crm_field___"+routingorder+"___"+orderuniquecnt+"___"+iNextCounter,
                            style: "",
                        });
                        
                        sRow = '<tr id="rowid___'+routingorder+'___'+orderuniquecnt+'___'+iNextCounter+'" class="{ROW_COLOR}S1" height="30">';
                        sRow += '<td>'+$cloneDSFields[0].outerHTML+'</td>';
                        sRow += '<td class="direction_arrow" width="5%"></td>';
                        sRow += '<td>'+$cloneCRMFields[0].outerHTML+'</td>';
                        sRow += '<td width="5%"><span rowindex="'+iNextCounter+'" routingorder="'+routingorder+'" orderuniquecnt="'+routingorder+'" class="deleterowBtn suitepicon suitepicon-action-clear" style="cursor:pointer; padding-left: 15px;font-size:16px;"></span></td>';
                        sRow += '</tr>';
                        $("#tblroute_"+routingorder+"_"+orderuniquecnt+" tbody").append(sRow);
                        
                        TempObj = JSON.parse('{"routing_number":'+routingorder+',"unique_number":'+orderuniquecnt+',"rowcounter":'+iNextCounter+'}');
                        Object.assign(roles_rowcounter[routingorder][orderuniquecnt], TempObj);
                        
                        $("#ds_field___"+routingorder+"___"+orderuniquecnt+"___"+iNextCounter).select2({
                            width: 'resolve', // need to override the changed default
                        });
                    }
                });
            }
        });
        //$('#docusign_templates').trigger('change');
        $('#synchronizing_direction').trigger('change');
    });
    
    $("body").delegate(".deleterowBtn", "click", function(eventData) {
        routingorder = $(this).attr('routingorder');
        orderuniquecnt = $(this).attr('orderuniquecnt');
        rownum = $(this).attr('rowindex');
        if(confirm(SUGAR.language.get("UT_DSFieldMapping", "LBL_CONFIRM_DELETE_KEYWORD"))){
            // Make ajax call to delete the keyword
            $("#rowid___"+routingorder+"___"+orderuniquecnt+"___"+rownum).remove();
            $('#ds_field___'+routingorder+'___'+orderuniquecnt+'___'+rownum).select2('destroy');
        }
    });
    
});
function addValueInObject(object, key, value) {
    var res = {};
    var textObject = JSON.stringify(object);
    if (textObject === '{}') {
        res = JSON.parse('{"' + key + '":"' + value + '"}');
    } else {
        res = JSON.parse('{' + textObject.substring(1, textObject.length - 1) + ',"' + key + '":"' + value + '"}');
    }
    return res;
}