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
    $("a[href^='#demo']").click(function (evt){
        evt.preventDefault();
        var scroll_to = $($(this).attr("href")).offset().top;
        $("html,body").animate({ scrollTop: scroll_to - 80 }, 600);
    });
    $("a[href='#']").click(function (evt){
        evt.preventDefault();
    });
    $(".actionsociallogout").click(function (evt){
        social = $(this).attr('social');
        SUGAR.ajaxUI.showLoadingPanel();
        url = "index.php?module=UT_DocuSign&action=logoutFromApplication&to_pdf=1&sugar_body_only=1";
        $.ajax({
            type: "POST",
            url: url,
            data: {social: social},
            dataType: 'json',
            async : true,
            success: function(e) {
                if(e.status == "success"){
                    sSocialDiv = e.data.social;
                    $("#"+sSocialDiv+"_divreplace").html(e.data.html);
                }
                SUGAR.ajaxUI.hideLoadingPanel();
            },
            failure: function(e) {
                SUGAR.ajaxUI.hideLoadingPanel();
            }
        });
    });
    $(".actionsociallogin").click(function (evt){
        social = $(this).attr('social');
    });
    $('#btnYesDocuSign').click(function() {
        $("#oauth2_docusign").submit();
    });
});