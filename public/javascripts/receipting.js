$(function(){
    $("#reply_to_feedback").live('click', function(){
        $("#reply_to_feedback").hide();
        $("#feedback_reply").show();
    });
});

$(function(){
    $("#close_feedback").live('click', function(){
        $("#feedback_reply").hide();
        $("#reply_to_feedback").show();
    });
});


$(function(){
    $("#display_feedback_reply").live('click', function(){
        $("#display_feedback_reply").hide();
        $("#hide_feedback_reply").show();
        $("#feedback_reply").show();
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

/*System ID Submit*/
system_id_check_input_change_or_not_transaction = function()
{

    var link = $('#system_id_tag');

    if($('#check_input_change').val() == "false")
    {
        $('#'+link.attr('form_name')).doAjaxSubmit();
        return false;
    }
    else
    {
        $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT? ");
        $('#warning_message_image').css("display","");
        $('#warning_message').dialog({
            modal: true,
            resizable: false,
            draggable: true,
            height: 'auto',
            width: 'auto',
            buttons: {

                No: function(){
                    $(this).dialog('destroy');
                    $('#transaction_list_header').val($('#transaction_list_header').attr('old_value'));
                    return false;
                },
                Yes: function(){
                    $('#'+link.attr('form_name')).doAjaxSubmit();
                    $('#check_input_change').val("false");
                    $(this).dialog('destroy');
                    return true;
                }
            }
        });
        $('#warning_message').dialog('option', 'title', 'Warning');

        $('#warning_message').parent().find("a").css("display","none");
        $("#warning_message").parent().css('background-color','#D1DDE6');
        $("#warning_message").css('background-color','#D1DDE6');

        $('#warning_message').dialog('open');
        return false;
    }

};

$(function(){
    $('#transaction_list_header').live('change', function(){
        system_id_check_input_change_or_not_transaction();
    });
});

transactionnavigation = function(link){
    if($('#check_input_change').val() == "false")
    {
        $.ajax({
            type: "GET",
            url: link.attr('url')+".js",
            data: 'current_tab_id='+$('#current_tab_id').val()+'&target='+link.attr('title'),
            dataType: "script"
        });
        return false;
    }
    else
    {
        $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT? ");
        $('#warning_message_image').css("display","");
        $('#warning_message').dialog({
            modal: true,
            resizable: false,
            draggable: true,
            height: 'auto',
            width: 'auto',
            buttons: {

                No: function(){
                    $(this).dialog('destroy');
                    return false;

                },
                Yes: function(){
                    $.ajax({
                        type: "GET",
                        url: link.attr('url')+".js",
                        data: 'current_tab_id='+$('#current_tab_id').val()+'&target='+link.attr('title'),
                        dataType: "script"
                    });
                    $('#check_input_change').val("false");
                    $(this).dialog('destroy');
                    return true;
                }
            }
        });
        $('#warning_message').dialog('option', 'title', 'Warning');

        $('#warning_message').parent().find("a").css("display","none");
        $("#warning_message").parent().css('background-color','#D1DDE6');
        $("#warning_message").css('background-color','#D1DDE6');

        $('#warning_message').dialog('open');
        return false;
    }
}

$(function(){
    $('.transaction_navigator').live('click', function(){        
        transactionnavigation($(this));
    }).attr("rel", "nofollow");

});



//person organisation name change


$(function(){
    $('.entity_type_change').live('change', function(){
        var input_field = $('#'+$(this).attr('input_field'));
        var update_field = $('#'+$(this).attr('update_field'));
        input_field.val("");
        update_field.html("");
        if($(this).val() == "Person"){

            input_field.removeClass('org_general_name_show').removeClass('general_name_show').addClass('general_name_show');

        }else{

            input_field.removeClass('org_general_name_show').removeClass('general_name_show').addClass('org_general_name_show');
     
        }
        return false;

    });
});
