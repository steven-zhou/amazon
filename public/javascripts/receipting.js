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





/* Show list*/
$(function(){
    $("#show_all_list_member").live('click',function(){   
        var link = $(this);
        if($('#check_input_change').val() == "false")
        {
            $.ajax({
                type: "GET",
                url: "/people/general_show_list.js",
                data: 'person_id='+link.attr('person_id')+'&current_operation='+link.attr('current_operation'),
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
                            url: "/people/general_show_list.js",
                            data: 'person_id='+link.attr('person_id')+'&current_operation='+link.attr('current_operation')+'&active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.person_edit_tab.active').attr('field'),
                            dataType: "script"

                        });
                        $('#check_left_input_change').val("false");
                        $('#check_right_input_change').val("false");
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



    });
});


$(function(){
    $("#show_all_list_member").live('mouseover',function(){
        $(this).css("cursor","pointer");
    });
});






/* Show Summary list*/


$(function(){
    $('table.selectable_grid tbody tr').live('click',function(){
        var form_id = $(this).closest('table').get(0).id
        if ($('#'+ form_id).attr('click_function') == "true"){
            $.ajax({
                type: 'GET',
                url: $('#'+ form_id).attr('click_url'),
                data: 'grid_object_id='+$(this).attr('id').substring(3)+'&params1='+$('#'+ form_id).attr('params1'),
                dataType: "script"
            });
        }
        $('table.selectable_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass("trSelected");
    });
});

$(function(){
    $('table.selectable_grid tbody tr').live('dblclick',function(){
        //        alert($('table#general_search_list_results').attr('db_click_function'))
        var form_id = $(this).closest('table').get(0).id
     
        
        if ($('#'+ form_id).attr('db_click_function') == "true")
        {
            $.ajax({
                type: 'GET',
                url: $('#'+ form_id).attr('db_click_url'),
                data: 'grid_object_id='+$(this).attr('id').substring(3)+'&params2='+$('#'+ form_id).attr('params2')+'&target='+$('#'+ form_id).attr('target'),
                dataType: "script"
            });
        }

        if ($('#'+ form_id).attr('db_close') == "true")
        {
            $('.ui-icon-closethick').click();


        }
    });
});




$(function(){
    $('table.selectable_grid tbody tr').live('mouseover',function(){   
            $(this).css("cursor","pointer");

        
    });
});
