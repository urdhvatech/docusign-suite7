{*
* This file is part of package DocuSign By Urdhva Tech.
* Developed by : Urdhva Tech (http://www.urdhva-tech.com)
* Module : DocuSign
* Contact : contact@urdhva-tech.com
* All rights(c) by Urdhva Tech
* This package is licensed software and may only be used in alignment
* with the License Agreement received with this Package.
* This Software is copyrighted and may not be further distributed without
* written consent of Urdhva Tech
*}
{literal}
<style type="text/css">
.btn-success:focus {
    background-color: #bbe6a5;
    color: #f5f5f5;
    border: 1px solid #bbe6a5;
}
.btn-success:hover {
    background-color: #449d44;
    color: #ffffff;
    border: 1px solid #398439;
}
</style>
{/literal}
<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
<div id="utBody" style="background-color: rgb(215, 215, 215); padding:30px 0px;">
<form name="UrdhvaTechDocuSign" method="post" role="form">
    <input type="hidden" name="module" value="UT_DocuSign">
    <input type="hidden" name="action" value="DocuSignAppKeys">
    <div class="">
        {if $MESSAGE}
            <div role="alert" class="alert alert-success offset1 span9" style="text-align:center;">
                <strong style="font-size:13px;">{$MESSAGE}</strong>
            </div>
        {/if}
        <div class="divider medium"></div>
        <div id="login-overlay" class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="padding:8px;">
                    <h4 class="modal-title" id="myModalLabel">{$mod.LBL_SYNCHRONIZE_DOCUSIGN_TEMPLATES}</h4>
                </div>
                <div class="modal-body">
                        <div class="row" style="margin-left:0px; margin-right:0px;">
                            <div class="col-xs-12">
                                <h5 style="padding-bottom: 15px;"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> {$mod.LBL_TITLE_INFORMATION}</h5>
                                <div style="padding:0px 10px;">
                                  {$mod.LBL_SYNCHRONIZE_TEMPLATES_DESCRIPTION}
                                </div>
                            </div>
                        </div>
                        <div class="row">        
                            <div class="col-xs-4">
                            </div>
                            <div class="col-xs-4">
                                 <input type="button" value="{$mod.LBL_SYNCHRONIZE_TEMPLATES}" class="fetch_ds_template"> 
                            </div>
                            <div class="col-xs-4">
                            </div>
                              
                        </div>
                    <div class="modal-footer" style="padding:10px;">&nbsp;
                        <span style="float: left;"><a href="http://urdhva-tech.com" target="_blank" title="Urdhva Tech"><img src="modules/UT_DocuSign/images/urdhvatech-horizontal-small.png" alt="Urdhva tech logo" style="width: 130px;"></a></span>
                    </div>
            </div>
        </div>
        <div class="divider large"></div>
    </div>
    
    <div id="ut_docusign_validation_popup" class="modal fade" role="dialog">
        <div class="modal-dialog">

          <!-- Modal content-->
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
              <button type="button" class="btn-primary btn " data-dismiss="modal">{$app.LBL_CLOSE_BUTTON_TITLE}</button>
            </div>
          </div>

        </div>
    </div>
                              
</form>
</div>
{literal}
<script>
$(document).ready(function () {
    $(".fetch_ds_template").on('click', function(e){
        e.stopPropagation();
        e.stopImmediatePropagation();
        
        var callback = { 
            success: function(result) {
                SUGAR.ajaxUI.hideLoadingPanel();
                var resp = YAHOO.lang.JSON.parse(result.responseText);
                if(resp.status == "success")
                {
                    if(resp.license_valid == "Yes")
                    {
                        var errorTitle = "<b>"+SUGAR.language.get('app_strings','LBL_EMAIL_SUCCESS')+"</b>";
                        var errorText = "<b>"+SUGAR.language.get('UT_DocuSign', 'LBL_SYNCHRONIZE_DOCUSIGN_TEMPLATES_SUCCESS_MSG')+"&nbsp;&nbsp;<a href='index.php?module=UT_DocuSign&action=index&return_module=UT_DocuSign&return_action=DetailView'>"+SUGAR.language.get('UT_DocuSign', 'LNK_LIST')+"</a></b>";
                        displayDocusignMessagePopup("Success",errorTitle,errorText);
                    }
                    else
                    {
                        var errorTitle = "<b>"+SUGAR.language.get('UT_DocuSign','LBL_DOCUSIGN_NO_ACTIVE_MSG')+"</b>";
                        var errorText = "<b>"+SUGAR.language.get('UT_DocuSign','LBL_DOCUSIGN_RENEW_LICENSE_MSG').replace("license","<a href='index.php?module=UT_DocuSign&action=license'>license</a>")+"</b>";
                        displayDocusignMessagePopup("Error",errorTitle,errorText);
                    }
                }
                else
                {
                    SUGAR.ajaxUI.hideLoadingPanel();
                    var errorTitle = "<b>"+SUGAR.language.get('UT_DocuSign','LBL_SETTINGS_FAILED')+"</b>";
                    var errorText = "<b>"+resp.message+"</b>";
                    displayDocusignMessagePopup("Error",errorTitle,errorText);
                }
            },
            failure: function(result) {
                SUGAR.ajaxUI.hideLoadingPanel();
                alert(SUGAR.language.get('UT_DocuSign', 'LBL_SYNCHRONIZE_DOCUSIGN_TEMPLATES_AJAX_ERROR'));
            }
        }
        SUGAR.ajaxUI.showLoadingPanel();
        YAHOO.util.Connect.asyncRequest("POST","index.php?",callback,SUGAR.util.paramsToUrl( {module:"UT_DocuSign",action:"fetchDocusignTemplates",to_pdf:1}));
        return false;
    });
});
function displayDocusignMessagePopup(type,errorTitle,errorText)
{
    var cssClass = 'required';
    if(type == "Success")
        cssClass = 'success';
    $('#ut_docusign_validation_popup .modal-title').html("<p class='"+cssClass+"'>"+errorTitle+"</p>");
    $('#ut_docusign_validation_popup .modal-body').html("<p class='"+cssClass+"'>"+errorText+"</p>");
    $('#ut_docusign_validation_popup .modal-body').css("text-align","center");
    $('#ut_docusign_validation_popup').modal('show', {backdrop: 'static'});
}
</script>
{/literal}