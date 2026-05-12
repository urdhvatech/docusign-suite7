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
.direction_arrow{
    font-size:14pt;
    font-weight:bold;
}
</style>
{/literal}
{$javascript}
<div id="utMappingBody">
<form name="DocusignMapping" id="DocusignMapping" method="post">
    <input type="hidden" name="module" value="UT_DSFieldMapping">
    <input type="hidden" name="action" value="SaveMapping">
    <input type="hidden" name="record" id="record" value="{$record}">
    <input type="hidden" name="isDuplicate" id="isDuplicate" value="{$isDuplicate}">
    
    {$sDummyModuleFldsSelect}
    <div class="container" style="width:auto;">
        {if $MESSAGE}
            <div role="alert" class="alert alert-success offset1 span9" style="text-align:center;">
                <strong style="font-size:13px;">{$MESSAGE}</strong>
            </div>
        {/if}
        {if $ERRORMESSAGE}
            <div role="alert" class="alert alert-danger offset1 span9" style="text-align:center;">
                <strong style="font-size:13px;">{$ERRORMESSAGE}</strong>
            </div>
        {/if}
        <div class="divider medium"></div>
        <div id="login-overlay" class="">
            <div class="modal-content">
                <div class="modal-header" style="padding:5px;">
                    <h4 class="modal-title" id="mappingModalLabel"><img src="modules/UT_DocuSign/images/docusign_144x40.png" /> {$mod.LBL_MAPPING_TITLE}</a>
                </div>
                <div class="modal-body">
                    <div class="row" style="margin-left:0px; margin-right:0px;">
                        <div class="col-md-12">
                            <div class="well" style="margin-bottom:0px;padding:19px 19px 5px 19px;">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-6 edit-view-row-item">
                                            <div class="col-xs-12 col-sm-4 label" data-label="LBL_NAME">
                                                {$mod.LBL_NAME}:<span class="required">*</span>
                                            </div>
                                            <div class="col-xs-12 col-sm-8 edit-view-field " type="name" field="name">
                                                <input type="text" name="name" id="name" value="{$name}">
                                            </div>
                                            <!-- [/hide] -->
                                        </div>
                                        <div class="col-xs-12 col-sm-6 edit-view-row-item">
                                            
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-6 edit-view-row-item">
                                            <div class="col-xs-12 col-sm-4 label" data-label="LBL_SYNCHRONIZING_DIRECTION">
                                                {$mod.LBL_SYNCHRONIZING_DIRECTION}:<span class="required">*</span>
                                            </div>
                                            <div class="col-xs-12 col-sm-8 edit-view-field " type="name" field="name">
                                                <select id='synchronizing_direction' name="synchronizing_direction">{$synchronizing_direction_options}</select>
                                            </div>
                                            <!-- [/hide] -->
                                        </div>
                                        <div class="col-xs-12 col-sm-6 edit-view-row-item">
                                            <div class="col-xs-12 col-sm-4 label" data-label="LBL_DOCUSIGN_TEMPLATES">
                                                {$mod.LBL_DOCUSIGN_TEMPLATES}:<span class="required">*</span>
                                            </div>
                                            <div class="col-xs-12 col-sm-8 edit-view-field " type="name" field="name">
                                                <select id='docusign_templates' name="docusign_templates">{$docusign_templates_options}</select>
                                            </div>
                                            <!-- [/hide] -->
                                        </div>
                                    </div>
                                    
                                    <div id="appendRowsDiv">
                                    </div>
                                    <div id="appendMappingFieldsRow">
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div class="form-group">
                                            &nbsp;&nbsp;&nbsp;
                                            </div>
                                        </div>
                                        <div class="col-xs-8">
                                            <div class="buttons">
                                                <input class="button primary" onclick="var _form = document.getElementById('DocusignMapping'); _form.action.value='SaveMapping'; if(check_form('DocusignMapping'))SUGAR.ajaxUI.submitForm(_form);return false;" type="submit" name="button" value="{$mod.LBL_SAVE_MAPPING_BUTTON}" id="SAVE"> 
                                                <input class="button" onclick="SUGAR.ajaxUI.loadContent('index.php?action={$return_action}&module={$return_module}&record={$return_id}'); return false;" type="button" name="button" value="{$mod.LBL_CANCEL_BUTTON}" id="CANCEL"> 
                                            </div>
                                        </div>
                                    </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="padding:10px;">&nbsp;
                    <span style="float: left;"><a href="http://urdhva-tech.com" target="_blank" title="Urdhva Tech"><img src="modules/UT_DocuSign/images/urdhvatech-horizontal-small.png" alt="Urdhva tech logo" style="width: 130px;"></a></span>
                </div>
            </div>
        </div>
        <div class="divider large"></div>
    </div>
</form>
</div>

{literal}
<script type="text/javascript">
addToValidate('DocusignMapping','name','varchar',true,'{/literal}{$mod.LBL_NAME}{literal}');
addToValidate('DocusignMapping','synchronizing_direction','varchar',true,'{/literal}{$mod.LBL_SYNCHRONIZING_DIRECTION}{literal}');
addToValidate('DocusignMapping','docusign_templates','varchar',true,'{/literal}{$mod.LBL_DOCUSIGN_TEMPLATES}{literal}');

</script>
{/literal}
<script src="modules/UT_DocuSign/js/jquery.blockUI.js"></script>
<link href="modules/UT_DSFieldMapping/js/select2-4.0.5/css/select2.css" rel="stylesheet"/>
<script src="modules/UT_DSFieldMapping/js/select2-4.0.5/js/select2.js"></script>
<script src="modules/UT_DSFieldMapping/js/docusign_mapping.js"></script>
