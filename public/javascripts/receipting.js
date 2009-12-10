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
