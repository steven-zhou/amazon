/* Powernet Menu Module*/
$(function(){
    $(".switch_module_status").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/available_modules/switch_status.js",
            data: 'id=' + $(this).attr("module_id"),
            dataType: "script"
        });
    });
});


$(function() {
    $(".password").jpassword({
        lang: {
            please: "please type password over 6 characters",
            low: "Low security.",
            correct: "Correct security.",
            high: "High security.",
            length: "-X- characters would be a plus.",
            number: "Why not numbers?",
            uppercase: "And caps?",
            lowercase: "Some tiny?",
            punctuation: "Punctuations?",
            special: "Best, special characters?"
        },
        length: 6
    });
});



$(function(){
    $("#hide_feedback_reply").live('click', function(){
        $("#hide_feedback_reply").hide();
        $("#display_feedback_reply").show();
        $("#feedback_reply").hide();
    });
});

//Member Zone Super User Password Confirmation
$(function(){
    $("#repeat_password").live('change', function(){
        if ($(this).val()!= $('#password').val()){
            $('#password_error').dialog( {
                modal: true,
                resizable: true,
                draggable: true,
                buttons: {
                    OK: function(){
                        $(this).dialog('destroy');
                        return true;

                    }
                }
            });
            $('#password_error').parent().find("a").css("display","none");
            $("#password_error").parent().css('background-color','#D1DDE6');
            $("#password_error").css('background-color','#D1DDE6');
            $('#password_error').dialog('option', 'title', 'Error');
            $('#password_error').dialog('open');
        }else{
            $('#password_submit').attr('disabled',false);
        }
    });


});

$(function(){
    $("#user_name").blur(function(){
        $.ajax({
            type: "GET",
            url: "/client_setups/system_log_verify_user_name.js",
            data: 'user_name='+$(this).val(),
            dataType: "script"
        });

    });
});



$(function(){
    $("#archive_user_name").blur(function(){
        $.ajax({
            type: "GET",
            url: "/client_setups/system_log_archive_verify_user_name.js",
            data: 'user_name='+$(this).val(),
            dataType: "script"
        });

    });
});

/* Campaign Grid*/
$(function(){
    $('table#show_campaigns_grid tbody tr').live('click',function(){
        if($('#campaign_mode').attr('mode')=="show"){
            $('table#show_campaigns_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_campaigns_grid tbody tr').live('dblclick',function(){
        if($('#campaign_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/receipting/edit_campaign/"+$(this).attr('id').substring(3),
                dataType: "script"
            });
        }
    });

    $('table#show_campaigns_grid tbody tr').live('mouseover',function(){
        if($('#campaign_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });
});

$(function() {
    $('#copy_campaign').live('click', function() {

        $.ajax({
            type: "GET",
            url: "/receipting/copy_campaign.js",
            data: 'id=' + $(this).attr('campaign'),
            dataType: "script"
        });
    });
});

/* Campaign Source Grid*/
$(function(){
    $('table#show_sources_by_campaign_grid tbody tr').live('click',function(){
        if($('#sources_mode').attr('mode')=="show"){
            $('table#show_sources_by_campaign_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_sources_by_campaign_grid tbody tr').live('dblclick',function(){
        if($('#sources_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/receipting/edit_source/"+$(this).attr('id').substring(3),
                dataType: "script"
            });
            $('#campaign_campaign_id').attr('disabled', true);
        }
    });

    $('table#show_campaigns_grid tbody tr').live('mouseover',function(){
        if($('#campaign_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });
});


/* Receipt Account Grid*/
$(function(){
    $('table#show_receipt_accounts_grid tbody tr').live('click',function(){
        if($('#receipt_account_mode').attr('mode')=="show"){
            $('table#show_receipt_accounts_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_receipt_accounts_grid tbody tr').live('dblclick',function(){
        if($('#receipt_account_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/receipt_accounts/edit_receipt_account/"+$(this).attr('id').substring(3),
                dataType: "script"
            });
        }
    });

    $('table#show_receipt_accounts_grid tbody tr').live('mouseover',function(){
        if($('#receipt_account_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });
});

$(function() {
    $('#copy_receipt_account').live('click', function() {

        $.ajax({
            type: "GET",
            url: "/receipt_accounts/copy.js",
            data: 'id=' + $(this).attr('receipt_account'),
            dataType: "script"
        });
    });
});

/* Receipt Method Grid*/
$(function(){
    $('table#show_receipt_methods_grid tbody tr').live('click',function(){
        if($('#receipt_method_mode').attr('mode')=="show"){
            $('table#show_receipt_methods_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_receipt_methods_grid tbody tr').live('dblclick',function(){
        if($('#receipt_method_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/receipt_methods/edit_receipt_method/"+$(this).attr('id').substring(3),
                dataType: "script"
            });
        }
    });


    $('table#show_receipt_methods_grid tbody tr').live('mouseover',function(){
        if($('#receipt_method_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });
});

$(function() {
    $('#copy_receipt_method').live('click', function() {
        $.ajax({
            type: "GET",
            url: "/receipt_methods/copy_receipt_method.js",
            data: 'id=' + $(this).attr('receipt_method'),
            dataType: "script"
        });
    });
});



/* Client Bank Account Grid*/
$(function(){
    $('table#show_client_bank_accounts_grid tbody tr').live('click',function(){
        if($('#client_bank_account_mode').attr('mode')=="show"){
            $('table#show_client_bank_accounts_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_client_bank_accounts_grid tbody tr').live('dblclick',function(){
        if($('#client_bank_account_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/client_setups/edit_client_bank_account/"+$(this).attr('id').substring(3),
                dataType: "script"
            });
        }
    });

    $('table#show_client_bank_accounts_grid tbody tr').live('mouseover',function(){
        if($('#client_bank_account_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });
});