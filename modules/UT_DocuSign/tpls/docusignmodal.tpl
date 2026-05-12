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
<div id="myRSModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header" style="padding:15px;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" id="myModalLabel1"><img src="modules/UT_DocuSign/images/docusign_144x40.png" width="140"/> {$mod.LBL_UT_AUTH_PERMISSION_TITLE}</h4>
      </div>
      <div class="modal-body">
        <form method="POST" action="{$sSubmitURL}" name="oauth2_docusign" id="oauth2_docusign">
        </form>
        <div class="content">
            <h3 class="modal-title">{$mod.LBL_UT_AUTH_REQUEST_ACCESS}</h3>
            <p>{$mod.LBL_UT_AUTH_REQUEST_ACCESS_MSG}</p>
        </div>
      </div>
      <div class="modal-footer">
        <a id="btnYesDocuSign" href="javascript:void(0)" class="btn btn-primary" style="color:#fffff; text-decoration:none;">
            {$mod.LBL_UT_AUTH_PROCEED}&nbsp;&nbsp;&nbsp;<img src="modules/UT_DocuSign/images/docusign_144x40.png" width="130"/>
        </a>
        <a href="javascript:void(0)" class="btn secondary" data-dismiss="modal" aria-hidden="true" style="text-decoration:none;">{$mod.LBL_CANCEL_BUTTON}</a>
      </div>
    </div>
  </div>
</div>