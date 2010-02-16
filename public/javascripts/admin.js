//Admin - System Data Tab

$(function(){
    $("#system_data_type").live('change', function(){
        if($(this).val()==""){
            $("#system_data_main_contents").hide();
            $("#system_data_entries").html("");
            $("#edit_system_data_entry").html("");
        } else {
            $("#system_data_add_entry").css("display","");
            $("#edit_system_data_entry").html("");
            $("#amazon_setting_type").val($(this).val());
            $.ajax({
                type: "GET",
                url: "/amazon_settings/system_settings_finder.js",
                data: 'type=' + $(this).val(),
                dataType: "script"
            });
            $("#system_data_main_contents").show();
        }
        $("#system_data_mode").attr('mode', 'show');
    });
});


$(function(){
    $("#edit_current_system_data_entry").live('click', function(){
        $(".container_selected").removeClass("container_selected");
        $(this).closest('.toggle_options').addClass("container_selected");
        $("#edit_system_data_entry").html("");
        $("#system_data_type").attr("disabled",true);
        $("#system_data_add_entry_form").hide();
        $.ajax({
            type: "GET",
            url: "/amazon_settings/system_data_entry_finder.js",
            data: 'id=' + $(this).attr('system_data_id'),
            dataType: "script"
        });

    });
});

$(function(){
    $("#delete_system_data_entry").live('click', function(){


        var link = $(this);
        if($(this).attr("error_message_field" != null))
        {
            $('#warning_message_text').html("Are you sure you wish to delete this "  + $(this).attr("error_message_field") + " ? ");
        }
        else
        {
            $('#warning_message_text').html("Are you sure you wish to delete ? ");
        }
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
                    $(".container_selected").removeClass("container_selected");
                    $("#edit_system_data_entry").hide();
                    $("#system_data_add_entry_form").hide();
                    $.ajax({
                        type: "GET",
                        url: "/amazon_settings/delete_system_data_entry.js",
                        data: 'id=' + link.attr('system_data_id'),
                        dataType: "script"
                    });
                    $(this).dialog('destroy');
                    return true;
                }
            }

        });

        $('#warning_message').dialog('option', 'title', 'Warning');

        $('#warning_message').parent().find("a").css("display","none");
        $("#warning_message").parent().css('background-color','#D1DDE6');
        $("#warning_message").css('background-color','#D1DDE6');
        //      $("#warning_message").closest("ui-dialog-titlebar").css('background','#97B6CE');

        $('#warning_message').dialog('open');
    });
});

$(function(){
    $("#system_data_add_entry").live('click', function(){
        $("#system_data_add_entry_form").show();
        $("#edit_system_data_entry").html("");
        $('#system_data_close_entry').css("display","");
        $(".system_data_entry_selected").removeClass("system_data_entry_selected");
        $("#system_data_type").attr("disabled",true);
        $("#system_data_submit").attr("disabled",true);
    });
});


$(function(){
    $("#close_edit_system_data_entry").live('click', function(){


        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $(".container_selected").removeClass("container_selected");
                        $("#edit_system_data_entry").hide();
                        $("#system_data_type").attr("disabled",false);
                        $.ajax({
                            type: "GET",
                            url: "/amazon_settings/system_settings_finder.js",
                            data: 'type=' + $("#system_data_type").val(),
                            dataType: "script"
                        });
                        $(this).dialog('destroy');
                        return true;
                    }
                }

            });

            $('#warning_message').dialog('option', 'title', 'Warning');

            $('#warning_message').parent().find("a").css("display","none");
            $("#warning_message").parent().css('background-color','#D1DDE6');
            $("#warning_message").css('background-color','#D1DDE6');
            //      $("#warning_message").closest("ui-dialog-titlebar").css('background','#97B6CE');

            $('#warning_message').dialog('open');

        }
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $('#check_input_change').val("false");
            $(".container_selected").removeClass("container_selected");
            $("#edit_system_data_entry").hide();
            $("#system_data_type").attr("disabled",false);
            $.ajax({
                type: "GET",
                url: "/amazon_settings/system_settings_finder.js",
                data: 'type=' + $("#system_data_type").val(),
                dataType: "script"
            });

        }

    });
});

$(function(){
    $("#system_data_close_entry").live('click', function(){

        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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



                        

                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $("#system_data_add_entry_form").css("display","none");
                        $("#system_data_type").attr("disabled",false);
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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $("#system_data_add_entry_form").css("display","none");
            $("#system_data_type").attr("disabled",false);

        }



    });
});



/* Custom Group Types */
$(function(){
    $("#show_group_meta_type_form").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_types/new.js",
            data: 'id=' + $(this).attr('custom_group_type_id'),
            dataType: "script"
        });
    })
});

$(function(){
    $("#delete_custom_group_type").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_types/delete_custom_group_type.js",
            data: 'id=' + $(this).attr('custom_group_type_id'),
            dataType: "script"
        });

    });
});

$(function(){
    $("#delete_custom_group").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tags/delete_custom_group.js",
            data: 'id=' + $(this).attr('custom_group_id') + '&custom_group_type_id=' + $(this).attr('custom_group_type_id'),
            dataType: "script"
        });

    });
});


$(function(){
    $(".edit_custom_group").live('click', function(){
        $('#edit_sub_group_'+$(this).attr('sub_group_id')).show();
        $('#sub_group_'+$(this).attr('sub_group_id')).hide();
        $("#multilevel_mode_1").attr("mode", "inactive");
        $("#multilevel_mode_2").attr("mode", "inactive");
        $("#multilevel_mode_3").attr("mode", "inactive");
    });
});

$(function(){
    $(".close_edit_custom_group").live('click', function(){
        $('#edit_sub_group_'+$(this).attr('sub_group_id')).hide();
        $('#sub_group_'+$(this).attr('sub_group_id')).show();
        $("#multilevel_mode_1").attr("mode", "inactive");
        $("#multilevel_mode_2").attr("mode", "show");
        $("#multilevel_mode_3").attr("mode", "inactive");
    });
});





$(function(){
    $("#find_data_list_field").live('change', function(){
        $.ajax({
            type: "GET",
            url: "/amazon_settings/data_list_finder.js",
            data: 'type=' + $(this).val() + '&id=' + $("#hiden_id").val(),
            dataType: "script"
        });
    });
});

$(function(){
    $("#data_list_field").live('change', function(){
        if($(this).val()==0){
            $.ajax({
                type: "GET",
                url:
                "/amazon_settings/new.js",
                data:
                'type=' + $("#find_data_list_field").val(),
                dataType: "script"
            });
        }else{
            $.ajax({
                type: "GET",
                url:
                "/amazon_settings/" + $(this).val() + "/edit.js",
                data:
                'id=' + $(this).val(),
                dataType: "script"
            });
        }
    });
});



$(function(){
    $(".delete_system_data").live('click', function(){
        $.ajax({
            type: "DELETE",
            url: "/amazon_settings/" + $(this).attr("data_id"),
            data:'&id=' + $(this).attr("data_id"),
            dataType: "script"
        });
    });
});

/* Admin  -  Role_Condition Tab*/


$(function(){
    $(".show_role").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url: "/roles/show_roles.js",
                data: 'role_type_id='+$(this).val(),
                dataType: "script"

            });

            $('#role_main_contents').show();
        }else{

            $("#downside").html("");
            $("#role_type_description_label").html('');
            $('#role_main_contents').hide();
        }
    });
});


$(function(){
    $(".choose_role").live('change', function(){
        if($(this).val()=="0"){
            $.ajax({
                type: "GET",
                url: "/roles/new.js",
                data: 'id='+$(this).val()+'&role_type_id='+$('#role_role_type_id').val(),
                dataType: "script"
            });
        }else{
            $.ajax({
                type: "GET",
                url: "/roles/"+$(this).val()+"/edit.js",
                data: 'id='+$(this).val()+'&role_type_id='+$('#role_role_type_id').val(),
                dataType: "script"
            });
        }
    });
});






$(function(){
    $("#cheatbutton").live('click', function(){
        $("#edit_role").doAjaxSubmit();
    })
});

$(function(){
    $("#rm").live('mousedown', function(){
        $.ajax({
            type: "GET",
            url:"/roles/role_type_finder.js",
            dataType: "script"
        });
    });
});




/*Admin Tag Setting*/

$(function(){
    $("#tag_selection").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url: "/tag_settings/show_all_for_selected_classifier.js",
                data: 'tag='+$(this).val(),
                dataType: "script"
            });
            if($(this).val() != "5"){
                $("#add_tag_meta_type").css("display", "");
            }else{
                $("#add_tag_meta_type").css("display", "none");
            }
        }else{
            $("#add_tag_meta_type").css("display", "none");
            $("#show_tag").html("");
        }

    });
});


$(function(){
    $(".show_tag_types").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_types/show_tag_types.js",
            data:'tag='+$('#tag_selection').val() + '&id='+$(this).attr('tag_meta_types_id'),
            dataType: "script"
        });
    });
});

$(function(){
    $(".show_tags").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tags/show_tags.js",
            data:'tag='+$('#tag_selection').val() + '&id='+$(this).attr('tag_types_id'),
            dataType: "script"
        });
    });
});

$(function(){
    $("#add_tag_meta_type").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_meta_types/new.js",
            data:'tag='+$('#tag_selection').val(),
            dataType: "script"
        });
    });
});

$(function(){
    $(".edit_tag_meta_type").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_meta_types/" + $(this).attr("tag_meta_type_id") + "/edit.js",
            data:'tag='+$('#tag_selection').val()+'&id=' + $(this).attr("tag_meta_type_id"),
            dataType: "script"
        });
    });
});

$(function(){
    $(".delete_tag_meta_type").live('click', function(){
        $.ajax({
            type: "DELETE",
            url: "/tag_meta_types/" + $(this).attr("tag_meta_type_id"),
            data:'tag='+$('#tag_selection').val()+'&id=' + $(this).attr("tag_meta_type_id"),
            dataType: "script"
        });
    });
});



$(function(){
    $(".add_tag_type").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_types/new.js",
            data:'tag='+$('#tag_selection').val()+'&tag_meta_type_id=' + $(this).attr("tag_meta_type_id"),
            dataType: "script"
        });
    });
});

$(function(){
    $(".edit_tag_type").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_types/" + $(this).attr("tag_type_id") + "/edit.js",
            data:'tag='+$('#tag_selection').val()+'&id=' + $(this).attr("tag_type_id"),
            dataType: "script"
        });
    });
});

$(function(){
    $(".delete_tag_type").live('click', function(){
        $.ajax({
            type: "DELETE",
            url: "/tag_types/" + $(this).attr("tag_type_id"),
            data:'tag='+$('#tag_selection').val()+'&id=' + $(this).attr("tag_type_id"),
            dataType: "script"

        });
    });
});


$(function(){
    $(".add_tag").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tags/new.js",
            data:'tag='+$('#tag_selection').val()+'&tag_type_id=' + $(this).attr("tag_type_id"),
            dataType: "script"
        });
    });
});

$(function(){
    $(".edit_tag").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tags/" + $(this).attr("tag_id") + "/edit.js",
            data:'tag='+$('#tag_selection').val()+'&id=' + $(this).attr("tag_id"),
            dataType: "script"
        });
    });
});

$(function(){
    $(".delete_tag").live('click', function(){
        $.ajax({
            type: "DELETE",
            url: "/tags/" + $(this).attr("tag_id"),
            data:'tag='+$('#tag_selection').val()+'&id=' + $(this).attr("tag_id"),
            dataType: "script"
        });
    });
});

$(function(){
    $(".show_tag_types").live('mouseover', function(){
        $(this).animate({
            color: "#FFFF00"
        }, 300)
    });
});

$(function(){
    $(".show_tag_types").live('mouseout', function(){
        $(this).animate({
            color: "#F7F8E0"
        }, 300)
    });
});

/*Admin User management*/
$(function(){
    $("#add_user").live('click', function(){
        $(this).hide();
        $(".user_clear_form").click();
        //$(".show_user_container").hide();
        $("#close_new_account").show();
        $("#user_account_new_submit").attr("disabled", true);
    });
});

$(function(){
    $(".check_login_id").blur(function(){
        if($(this).val()!= ""){
            $.ajax({
                type: "GET",
                url: "/people/login_id_finder.js",
                data: 'person_id='+$(this).val()+'&login_account_id='+$(this).attr('login_account_id'),
                dataType:"script"
            });
        }else{
            $("#login_name_container_"+$(this).attr('login_account_id')).html("");
            $('#error_message_text').html("Please type Person ID");
            $('#error_message_image').css("display","");
            $('#error_message').dialog({
                modal: true,
                resizable: false,
                draggable: true,
                height: 'auto',
                width: 'auto',
                buttons: {
                    "OK":function(){

                        $(this).dialog('destroy');
                        return false;

                    }
                }
            });
            $('#error_message').dialog('option', 'title', 'ERROR');

            $('#error_message').parent().find("a").css("display","none");
            $("#error_message").parent().css('background-color','#D1DDE6');
            $("#error_message").css('background-color','#D1DDE6');

            $('#error_message').dialog('open');


        //            $('#login_name_invalid').dialog( {
        //                modal: true,
        //                resizable: true,
        //                draggable: true,
        //                buttons: {
        //
        //                    OK: function(){
        //
        //                        $(this).dialog('close');
        //                    }
        //                }
        //            });
        //            $('#login_name_invalid').dialog('open');
        }
    });
});




$(function(){

    $(".check_username_unique").blur(function(){

        //        if ($('#login_account_user_name').val().length < 6 ||$('#login_account_user_name').val().length > 30 )
        //     {
        //         return false;
        //     }

        //     else
        //         {
        $.ajax({
            type: "GET",
            url: "/login_accounts/user_name_unique.js",
            data: 'user_name='+$(this).val()+'&login_account_id='+$(this).attr('login_account_id')+'&length='+$(this).val().length,
            dataType:"script"
        });

    //         }




    });

    $('#login_account_user_name').live("focus", function(){
        $(this).qtip(
        {
            content: 'username must between 6~20<br>username can\'t the same as password',
            style: 'dark'
        }
        );
    });
});

$(function(){
    $(".user_email_new").blur(function(){
        _valid = /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-zA-Z]{2,})$/.test($(this).val());
        if($(this).val()!=""){
            if((!_valid)){

                $('#error_message_text').html("Invalid Email Address ");
                $('#error_message_image').css("display","");
                $('#error_message').dialog({
                    modal: true,
                    resizable: false,
                    draggable: true,
                    height: 'auto',
                    width: 'auto',
                    buttons: {
                        "OK": function(){
                            $('#login_account_security_email').val("");
                            $(this).dialog('destroy');
                            return true;
                        }
                    }
                });
                $('#error_message').dialog('option', 'title', 'Error');
                $('#error_message').parent().find("a").css("display","none");
                $("#error_message").parent().css('background-color','#D1DDE6');
                $("#error_message").css('background-color','#D1DDE6');
                $('#error_message').dialog('open');



                //
                //                $('#invalid_email').dialog( {
                //                    modal: true,
                //                    resizable: true,
                //                    draggable: true,
                //                    buttons: {
                //
                //                        OK: function(){
                //
                //                            $(this).dialog('close');
                //                        }
                //                    }
                //                });
                //                $('#invalid_email').dialog('open');
                $('.user_email_new').focus();
                return false;
            }
        }else{

            $('#error_message_text').html("Invalid Email Address ");
            $('#error_message_image').css("display","");
            $('#error_message').dialog({
                modal: true,
                resizable: false,
                draggable: true,
                height: 'auto',
                width: 'auto',
                buttons: {
                    "OK": function(){
                        $(this).dialog('destroy');
                        return true;
                    }
                }
            });
            $('#error_message').dialog('option', 'title', 'Error');
            $('#error_message').parent().find("a").css("display","none");
            $("#error_message").parent().css('background-color','#D1DDE6');
            $("#error_message").css('background-color','#D1DDE6');
            $('#error_message').dialog('open');

        }
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
    $("#login_account_password_confirmation").live('change', function(){

        if ($(this).val()!= $('#login_account_password').val()){

            $('#error_message_text').html("Passwords DO NOT Match ");

            $('#error_message_image').css("display","");
            $('#error_message').dialog({
                modal: true,
                resizable: false,
                draggable: true,
                height: 'auto',
                width: 'auto',
                buttons: {
                    "OK": function(){
                        $(this).dialog('destroy');
                        return true;
                    }
                }
            });
            $('#error_message').dialog('option', 'title', 'Error');
            $('#error_message').parent().find("a").css("display","none");
            $("#error_message").parent().css('background-color','#D1DDE6');
            $("#error_message").css('background-color','#D1DDE6');
            $('#error_message').dialog('open');






        //            $('#password_confirm').dialog( {
        //                modal: true,
        //                resizable: true,
        //                draggable: true
        //            });
        //            $('#password_confirm').dialog('open');
        }
    });
});




$(function(){
    $("#login_account_password").live('change', function(){

        if ($(this).val().length < 6 ||$(this).val().length > 30 ){
            $('#no_password').show();
            $('#yes_password').hide();

        }else{
            $('#no_password').hide();
            $('#yes_password').show();

        }

    });
});

$(function(){
    $("#group_secu_submit").live('click', function(){
        $(".edit_login").doAjaxSubmit();
    })
});



$(function(){
    $(".delete_login_account").live('click', function(){
        $.ajax({
            type: "DELETE",
            url: "/login_accounts/" + $(this).attr("data_id"),
            data:'&id=' + $(this).attr("data_id"),
            dataType: "script"
        });
    });
});


$(function(){
    $("#close_new_account").live('click', function(){

        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are you Sure You Wish to EXIT ?");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $(".user_clear_form").click();
                        $("#new_user").toggle('blind');
                        $(".show_user_container").show();
                        $("#close_new_account").hide();
                        $("#add_user").show();
                        $('#no_password').hide();
                        $('#yes_password').hide();
                        $('#no_username').hide();
                        $('#yes_username').hide();
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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $(".user_clear_form").click();
            $("#new_user").toggle('blind');
            $(".show_user_container").show();
            $("#close_new_account").hide();
            $("#add_user").show();
            $('#no_password').hide();
            $('#yes_password').hide();
            $('#no_username').hide();
            $('#yes_username').hide();

        }











    });
});

$(function(){
    $("#close_edit_account").live('click', function(){

        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $(".add_user").show();
                        $(".container_selected").removeClass("container_selected");
                        $("#edit_user").html('');

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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $(".add_user").show();
            $(".container_selected").removeClass("container_selected");
            $("#edit_user").html('');


        }

    });
});

$(function(){
    $(".select_all").live('click', function(){
        if($(this).attr("checked") == true){
            $(".checkboxes").attr("checked", true);
        }else{
            $(".checkboxes").attr("checked", false);
        }
    });
});

/*Group ---List*/
$(function(){
    $(".show_list").live('change',function(){
        if ($(this).val()!= ""){

            $.ajax({
                type: "GET",
                url: "/group_lists/show_lists.js",
                data: 'group_id='+$(this).val(),
                dataType: "script"
            });
            $(".show_list_container").css("display", "");
            $("#new_group_list_container").css("display", "");
        } else{
            $(".show_list_container").css("display", "none");
            $("#new_group_list_container").css("display", "none")

        }
    });
});

$(function(){
    $("#add_new_list").live('click', function(){
        $(this).css("display", "none");
        $(".group_list_delete").css("display", "none");
        $("#close_new_group_list").css("display", "");
    });
});


$(function(){
    $("#close_new_group_list").live('click', function(){
        $(this).css("display", "none");

        $('#new_group_list').toggle('blind');
        $('#add_new_list').css("display", "");
        $(".group_list_delete").css("display", "");

    });
});


/* Admin - Duplication Formular */
$(function(){
    $("#fields_personal_duplication").live('change', function(){
        $(".descriptions_personal_duplication").css("display", "none");
        $("#description_personal_duplication_"+$(this).val()).css("display", "");
        if($("#description_personal_duplication_"+$(this).val()).html().match("(Integer FK)")){
            $("#is_foreign_key").val(true);
        }else{
            $("#is_foreign_key").val(false);
        }
    });
});

$(function(){
    $('#apply_personal_duplication').live('click', function(){

        $('#warning_message_text').html("You Have Applied a New Duplication Formula Successfully, Do You Wish to Re-Generate the People Duplication Index Now? ");
        $('#warning_message_image').css("display","");
        $('#warning_message').dialog({
            modal: true,
            resizable: false,
            draggable: true,
            height: 'auto',
            width: 'auto',
            buttons: {

                No: function(){
                    $("#personal_duplication_form").doAjaxSubmit();
                    $(this).dialog('destroy');
                    return false;

                },
                Yes: function(){
                    $.ajax({
                        type: "GET",
                        url: "/personal_duplication_formulas/generate.js",
                        dataType: "script"
                    })
                    $("#personal_duplication_form").doAjaxSubmit();
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


    });
});

$(function(){
    $("#fields_organisational_duplication").live('change', function(){
        $(".descriptions_organisational_duplication").css("display", "none");
        $("#description_organisational_duplication_"+$(this).val()).css("display", "");
        if($("#description_organisational_duplication_"+$(this).val()).html().match("(Integer FK)")){
            $("#is_foreign_key_organisational").val(true);
        }else{
            $("#is_foreign_key_organisational").val(false);
        }
    });
});

$(function(){
    $('#apply_organisational_duplication').live('click', function(){
        $("#organisational_duplication_form").doAjaxSubmit();







    });
});

$(function(){
    $("#generate_personal_duplication").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/personal_duplication_formulas/generate.js",
            dataType: "script"
        });
    });
});

$(function(){
    $("#generate_organisational_duplication").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/organisational_duplication_formulas/generate.js",
            dataType: "script"
        });
    });
});

$(function(){
    $('#load_personal_duplication').live('click', function(){

        $('#load_personal_message_text').html("Are You Sure You Wish to Load the System Default Setting? ");

        $('#load_personal_default').dialog({
            modal: true,
            resizable: false,
            draggable: true,
            height: 'auto',
            width: 800,
            buttons: {

                No: function(){
                    $(this).dialog('destroy');
                    return false;

                },
                Yes: function(){
                    window.open("/personal_duplication_formulas/set_default.html", "_self");
                    $(this).dialog('destroy');
                    return true;
                }
            }
        });
        $('#load_personal_default').dialog('option', 'title', 'Warning - Default Setting');

        $('#load_personal_default').parent().find("a").css("display","none");
        $("#load_personal_default").parent().css('background-color','#D1DDE6');
        $("#load_personal_default").css('background-color','#D1DDE6');

        $('#load_personal_default').dialog('open');

    //        $('#load_personal_default').dialog( {
    //            modal: true,
    //            resizable: true,
    //            draggable :true,
    //            height: 250,
    //            width: 700,
    //            buttons: {
    //                NO: function() {
    //                    $(this).dialog('close');
    //                },
    //                YES: function() {
    //                    window.open("/personal_duplication_formulas/set_default.html", "_self");
    //                    return false;
    //                }
    //            }
    //        });
    //        $('#load_personal_default').dialog('open');
    });
});

$(function(){
    $('#load_organisational_duplication').live('click', function(){


        $('#load_organisational_message_text').html("Are You Sure You Wish to Load the System Default Setting? ");

        $('#load_organisational_default').dialog({
            modal: true,
            resizable: false,
            draggable: true,
            height: 'auto',
            width: 900,
            buttons: {

                No: function(){
                    $(this).dialog('destroy');
                    return false;

                },
                Yes: function(){
                    window.open("/organisational_duplication_formulas/set_default.html", "_self");
                    $(this).dialog('destroy');
                    return true;
                }
            }
        });
        $('#load_organisational_default').dialog('option', 'title', 'Warning - Default Setting');

        $('#load_organisational_default').parent().find("a").css("display","none");
        $("#load_organisational_default").parent().css('background-color','#D1DDE6');
        $("#load_organisational_default").css('background-color','#D1DDE6');
        $('#load_organisational_default').css('display','inline');
        $('#load_organisational_default').dialog('open');



    //        $('#load_organisational_default').dialog( {
    //            modal: true,
    //            resizable: true,
    //            draggable :true,
    //            height: 250,
    //            width: 700,
    //            buttons: {
    //                NO: function() {
    //                    $(this).dialog('close');
    //                },
    //                YES: function() {
    //                    window.open("/organisational_duplication_formulas/set_default.html", "_self");
    //                    return false;
    //                }
    //            }
    //        });
    //        $('#load_organisational_default').dialog('open');
    });
});
/*Group---Permission*/

$(function(){
    $(".show_permission_container").live('change',function(){
        if ($(this).val()!= ""){

            $.ajax({
                type:"GET",
                url: "/group_permissions/show_add_container.js",
                data: "group_id="+$(this).val(),
                dataType: "script"
            });
            $(".permission_container").css("display", "");
            $("#old_permissions").show();
        }
        else{

            $(".permission_container").css("display", "none");
            $("#old_permissions").hide();

        }
    });
});


//$(function(){
//
//    $("#system_permission_meta_meta_type_id").live('change',function(){
//
//        if ($(this).val()!= ""){
//            $.ajax({
//                type:"GET",
//                url: "/group_permissions/show_module.js",
//                data:"system_permission_module_id="+$(this).val() + '&group_id=' + $("#group_permission_user_group_id").val(),
//                dataType:"script"
//
//            });
//            $('#permission_form').show();
//        }else{
//
//            $('#permission_form').hide();
//        }
//
//    });
//});
/*user_group  new design*/

$(function(){

    $('.add_flag').live('click', function(){
        $(this).css('display', 'none');
        $('#close_'+ $(this).attr('flag_name')).css('display', '');
    });
});


$(function(){
    $('.close_flag').live('click', function(){

        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {

            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" +link.attr('field')+'_mode').attr('mode','show');
                        link.css('display', 'none');
                        $('#add_'+link.attr('flag_name')).css('display', '');
                        $('#new_'+link.attr('flag_name')).toggle('blind');
                        $('#add_new_role').css("display","");
                        $('#role_role_type_id').attr("disabled", false);
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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" +link.attr('field')+'_mode').attr('mode','show');
            link.css('display', 'none');
            $('#add_'+link.attr('flag_name')).css('display', '');
            $('#new_'+link.attr('flag_name')).toggle('blind');
            $('#check_input_change').val("false");
            $('#add_new_role').css("display","");
            return true;

        }




    });

});



$(function(){
    $('.edit_close_flag').live('click', function(){
        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {

            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" +link.attr('field')+'_mode').attr('mode','show');
                        link.css('display', 'none');
                        $('#edit_'+link.attr('flag_name')+"_container").html('');
                        $('#add_new_role').css("display","");
                        $('#check_input_change').val("false");
                        $('#role_role_type_id').attr("disabled", false);
                        $(".container_selected").removeClass("container_selected");
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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" +link.attr('field')+'_mode').attr('mode','show');
            link.css('display', 'none');
            $('#edit_'+link.attr('flag_name')+"_container").html('');
            $('#add_new_role').css("display","");
            $('#check_input_change').val("false");
            $('#role_role_type_id').attr("disabled", false);
            $(".container_selected").removeClass("container_selected");

            return true;

        }
    });

});

/*role_condition part*/


$(function(){
    $('.edit_role').live('click', function(){

        $(".container_selected").removeClass("container_selected");
        $(this).closest('.toggle_options').addClass("container_selected");
        $.ajax({
            type: "GET",
            url: "/roles/" + $(this).attr('role_id') + "/edit.js",
            data: "role_id="+$(this).attr('role_id'),
            dataType:"script"

        });
    });
});

$(function(){
    $(".role_condition_show_role").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url: "/role_conditions/role_condition_show_roles.js",
                data: 'role_type_id='+$(this).val(),
                dataType: "script"

            });

            $('#role_condition_role_main_contents').show();
        }else{

            $('#role_condition_role_main_contents').hide();

        }
    });
});


$(function(){
    $('#role_condition_role_click').live('click', function(){
        $(".container_selected").removeClass("container_selected");
        $(this).closest('.toggle_options').addClass("container_selected");

        $.ajax({
            type:'GET',
            url: "/role_conditions/" + $(this).attr('role_id') + "/edit.js",
            data: "role_id="+$(this).attr('role_id'),
            dataType:"script"

        });
    });
});


$(function(){
    $(".find_master_doc_meta_type_field_for_role_condition").live('change', function(){
        $.ajax({
            type: "GET",
            url: "/role_conditions/condition_meta_type_finder.js",
            data: 'master_doc_meta_meta_type_id='+$(this).val()+'&id='+$(this).val(),
            dataType: "script"
        });

    });
});

$(function(){

    $("#master_doc_meta_type_id_for_role_condition").live('change', function(){
        $.ajax({
            type: "GET",
            url:"/role_conditions/doc_type_finder.js",
            data:'master_doc_meta_type_id='+$(this).val(),
            dataType: "script"
        });
    });
});


$(function(){

    $("#edit_role_condition_form").live('click', function(){
        $(".container_selected").removeClass("container_selected");
        $("#role_condition_edit_role_container").hide();
        $('#role_condition_role_type_id').attr("disabled", false);
    });
});

$(function(){
    $("#click_condition").live('mousedown', function(){
        $.ajax({
            type: "GET",
            url:"/roles/role_type_finder.js",
            dataType: "script"
        });
    });
});

/*group----list*/
$(function(){
    $(".edit_logo").live('click', function(){

        $(".container_selected").removeClass("container_selected");
        $(this).closest('.toggle_options').addClass("container_selected");

        $(this).closest('.options').css("display","none");
        $.ajax({
            type:'GET',
            url: "/"+$(this).attr('controller')+"/" + $(this).attr('data_id') + "/edit.js",
            data: "data_id="+$(this).attr('data_id'),
            dataType:"script"

        });
    });
});

$(function(){
    $(".edit_bank").live('click', function(){

        $(".container_selected").removeClass("container_selected");
        $(this).closest('.toggle_options').addClass("container_selected");
    });
});

$(function(){
    $(".close_edit_bank").live('click', function(){
        $(".container_selected").removeClass("container_selected");
    });
});


$(function(){
    $('.new_logo').live('click', function(){
        $("#new_" + $(this).attr('field')+ "_form").toggle('blind');
        $('.close_logo').css('display','');

    });
});


$(function(){
    $('.close_logo').live('click', function(){


        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $("#new_" + link.attr('field')+ "_form").toggle('blind');
                        //                       $('#new_user_group_form').css('display','none');
                        $("#" + link.attr('field')+ "_edit_container").html('');
                        if (link.attr('change_color') == "false"){

                        }else{
                            $(".container_selected").removeClass("container_selected");
                        }
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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            //            $('#new_user_group_form').css('display','none');

            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $("#new_" + link.attr('field')+ "_form").toggle('blind');
            $("#" + link.attr('field')+ "_edit_container").html('');
            if (link.attr('change_color') == "false"){

            }else{
                $(".container_selected").removeClass("container_selected");
            }
        }

    });
});
$(function(){
    $('.show_list_description').live('change', function(){
        $.ajax({
            type: "GET",
            url: "/group_lists" + "/show_list_des.js",
            data: "list_id=" + $(this).val(),
            dataType:"script"
        });


    });
});

/*user--list*/

$(function(){
    $('.show_user_list_description').live('change', function(){
        $.ajax({
            type: "GET",
            url: "/user_lists" + "/show_list_des.js",
            data: "list_id=" + $(this).val(),
            dataType:"script"

        });

    });



});

/*user account*/

$(function(){
    $('#generate_new_password').live('click', function(){

        $.ajax({
            type: "Post",
            url: "/login_accounts/generate_password.js",
            data: "login_account_id=" + $(this).attr('login_account_id'),
            dataType:"script"

        });

    });

});

/*new-design--group permission*/

$(function(){

    $(".show_module_form").live('change',function(){

        if ($(this).val()!= ""){
            $.ajax({
                type:"GET",
                url: "/group_permissions/show_module.js",
                data:"system_permission_module_id="+$(this).val() + '&group_id=' + $("#group_permission_user_group_id").val(),
                dataType:"script"

            });
            $('#permission_form').show();
        }else{

            $('#permission_form').hide();
        }

    });
});



$(function(){
    $(".group_permission_color").live('mouseover', function(){
        $(this).addClass("color_change");
    });
});

$(function(){
    $(".group_permission_color").live('mouseout', function(){
        $(this).removeClass("color_change");
    });
});

/*use for click the module show the whole thing*/
$(function(){
    $("#show_controllers").live('click', function(){
        $.ajax({
            type:"GET",
            url:"/group_permissions/show_controllers.js",
            data:"main_module_id="+$(this).attr('main_module_id'),
            dataType:"script"

        });

    });

});

$(function(){
    $(".module_select_all").live('click', function(){
        if ($(this).attr("checked") == true){
            $('.controller_select_all').attr("checked", true);
            $('.method_select_all').attr("checked", true);
            check_access_checkbox(); //check the checkbox status
        }else{
            $('.controller_select_all').attr("checked", false);
            $('.method_select_all').attr("checked", false);
            check_access_checkbox(); //check the checkbox status
        }

    });
});

$(function(){
    $("#new_group_permission").live('click', function(){
        $(this).css("display", "none");
        $(".group_permission_delete").css("display", "none");

        $.ajax({
            type: "GET",
            url: "/group_permissions/new.js",
            data:"group_id="+$(this).attr('group_id'),
            dataType: "script"
        });
        $("#close_new_module").css("display", "");
    });
});

/*when you slecet the controller , all the method will be on*/
$(function(){
    $('.controller_select_all').live('click', function(){
        if ($(this).attr('checked') == true){
            $('.method_select_all[controller_id = ' + $(this).val() +']').attr("checked", true);
            check_access_checkbox(); //check the checkbox status
        }else{
            $('.method_select_all[controller_id='+ $(this).val()+']').attr("checked", false);
            $('.module_select_all').attr("checked", false);
            check_access_checkbox(); //check the checkbox status
        }
    });
});

$(function(){
    $('.method_select_all').live('click', function(){
        if ($(this).attr('checked') == false){
            $('.module_select_all').attr("checked", false);
            $('.controller_select_all[controller_id='+ $(this).attr("controller_id")+ ']').attr("checked", false);
        }
        check_access_checkbox(); //check the checkbox status
    });
});
//check the status of all the checkbox in permission_form,
//submit button in the #permission_form (this is a div, not form) will be enalbed only when there is one checkbox is checked at least
//this function can be make further reusable, i.e. make the div name as a argument for this function.
check_access_checkbox = function(){
    var checkbox_list = new Array;
    checkbox_list = $("#permission_form").find("input[checked='true']");
    if(checkbox_list.length > 0 )
        $("#permission_form input[type='submit']").attr("disabled", false);
    else
        $("#permission_form input[type='submit']").attr("disabled", true);
};
$(function(){
    $("#close_new_module").live('click', function(){
        $(this).css("display", "none");
        $('#hide_module').html('');
        $('#new_group_permission').css("display", "");
        $(".group_permission_delete").css("display", "");
    });
});

/* Admin Add Keyword*/

$(function(){
    $("#keyword_add_entry").live('click', function(){
        $("#keyword_add_entry_form").show();

        $("#edit_keyword_entry").html("");

        //        $("#keyword_add_entry_form").attr("type_id", $("#keyword_type").val());
        $("#type_id").val($("#keyword_type").val());
        $("#keyword_type").attr("disabled",true);
        $("#keyword_new_submit").attr("disabled",true);
        $("#keyword_close_entry").css("display","");

        $(".keyword_entry_selected").removeClass("keyword_entry_selected");

    });
});

$(function(){
    $("#keyword_close_entry").live('click', function(){
        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $("#keyword_add_entry_form").css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");

                        $("#edit_keyword_entry").html("");
                        $("#keyword_type").attr("disabled",false);
                        $(".keyword_entry_selected").removeClass("keyword_entry_selected");
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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $("#keyword_add_entry_form").hide();
            $("#edit_keyword_entry").html("");
            $("#keyword_type").attr("disabled",false);
            $(".keyword_entry_selected").removeClass("keyword_entry_selected");

        }
    });
});

$(function(){
    $("#close_edit_keyword_entry").live('click', function(){

        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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

                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $(".container_selected").removeClass("container_selected");
                        $("#keyword_add_entry").css("display","");
                        $("#keyword_mode").attr('mode', 'show');
                        $("#keyword_add_entry_form").hide();
                        $("#keyword_type").attr("disabled",false);
                        $("#edit_keyword_entry").html("");
                        $(".keyword_entry_selected").removeClass("keyword_entry_selected");
                        $.ajax({
                            type: "GET",
                            url: "/keywords/keywords_finder.js",
                            data: 'type=' + $("#keyword_type").val(),
                            dataType: "script"
                        });

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

        }
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $('#check_input_change').val("false");
            $(".container_selected").removeClass("container_selected");
            $("#keyword_add_entry").css("display","");
            $("#keyword_mode").attr('mode', 'show');
            $("#keyword_add_entry_form").hide();
            $("#keyword_type").attr("disabled",false);
            $("#edit_keyword_entry").html("");
            $(".keyword_entry_selected").removeClass("keyword_entry_selected");
            $.ajax({
                type: "GET",
                url: "/keywords/keywords_finder.js",
                data: 'type=' + $("#keyword_type").val(),
                dataType: "script"
            });

        }

    });
});


$(function(){
    $("#keyword_type").live('change', function(){
        if($(this).val()==""){
            $("#keyword_main_contents").hide();
            $("#keyword_entries").html("");
            $("#edit_keyword_entry").html("");
        } else {
            $("#edit_keyword_entry").html("");


            $("#amazon_setting_type").val($(this).val());
            $.ajax({
                type: "GET",
                url: "/keywords/keywords_finder.js",
                data: 'type=' + $(this).val(),
                dataType: "script"
            });
            $("#keyword_main_contents").show();
        }
        $("#keyword_mode").attr('mode', 'show');
    });
});

// Postcode stuff

$(function(){
    $('.check_postcode_columns').blur(function(){

        if( ($('#suburb').val() != '') && ($('#state').val() != '') && ($('#postcode').val() != '') ) {
            if( ($('#suburb').val() != $('#state').val()) && ($('#suburb').val() != $('#postcode').val()) && ($('#state').val() != $('#postcode').val()) ) {
                $('#import_postcode_submit').attr("disabled", false);
            } else {

                var link = $(this);

                $('#error_message_text').html("Every column number must be unique, please check your entries. ");

                $('#error_message_image').css("display","");
                $('#error_message').dialog({
                    modal: true,
                    resizable: false,
                    draggable: true,
                    height: 'auto',
                    width: 'auto',
                    buttons: {
                        "OK": function(){
                            link.focus();
                            //                            link.val('');
                            $(this).dialog('destroy');
                            return true;
                        }
                    }
                });
                $('#error_message').dialog('option', 'title', 'ERROR');
                $('#error_message').parent().find("a").css("display","none");
                $("#error_message").parent().css('background-color','#D1DDE6');
                $("#error_message").css('background-color','#D1DDE6');
                $('#error_message').dialog('open');


                $('#import_postcode_submit').attr("disabled", true);
            }
        } else {
            $('#import_postcode_submit').attr("disabled", true);
        }

    });
});

$(function(){
    // Ensure that the person entered at least one column
    $("#show_import_postcode_parameters").live('click', function(){
        var total = '';
        var l = $('.check_postcode_columns').length;

        for (i = 0; i < l; i++) {
            total = total + $('#'+$('.check_postcode_columns')[i].id).val();
        }
        if(total != '') {
            $('#import_postcodes_columns').dialog('close');
            $('#import_postcode_parameters').dialog( {
                modal: true,
                resizable: false,
                width: 600,
                height: 275,
                draggable: true
            });
            $('#import_postcode_parameters').dialog('open');
            $('#import_postcode_parameters').dialog('option', 'title', 'Postcode upload parameters');
        } else {
            alert("All Fields Must be Filled")
        }
    });
});

/*Person check duplication active status*/
$(function(){
    $("#switch_personal_formula_status").live('change', function(){

        $.ajax({
            type: "GET",
            url: "/personal_duplication_formulas/change_status.js",
            data: 'check_status='+$(this).val(),
            dataType: "script"
        });

    });
});

//add_new_role in Role Manager for control role_type dropdown list
$(function(){
    $("#new_role_bar #add_new_role").live('click',function(){
        $('#role_role_type_id').attr("disabled", true);
        $("#role_new_submit").attr("disabled",true);
    });
    $("#new_role_bar #close_role").live('click', function(){
        $('#role_role_type_id').attr("disabled", false);
    });
});

//Country Data
$(function(){
    $(".show_languages").live('click', function(){
        if($('.update_flag[filed="'+$(this).attr('field')+'"]').val()=="true"){
            $.ajax({
                type: "GET",
                url: "/languages/show_languages.js",
                data: 'update='+$(this).attr('update'),
                dataType: "script"
            });
            $('.update_flag[filed="'+$(this).attr('field')+'"]').val("false");
        }else{
            $('.update_flag[filed="'+$(this).attr('field')+'"]').val("true");
        }
    });
});


/* Country Grid*/
$(function(){
    $('table#show_countries_grid tbody tr').live('click',function(){
        if($('#country_mode').attr('mode')=="show"){
            $('table#show_countries_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_countries_grid tbody tr').live('dblclick',function(){
        if($('#country_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/countries/"+$(this).attr('id').substring(3)+"/edit.js",
                dataType: "script"
            });
        }
    });

    $('table#show_countries_grid tbody tr').live('mouseover',function(){
        if($('#country_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });
});


/* Language Grid*/
$(function(){
    $('table#show_languages_grid tbody tr').live('click',function(){
        if($('#language_mode').attr('mode')=="show"){
            $('table#show_languages_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_languages_grid tbody tr').live('dblclick',function(){
        if($('#language_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/languages/"+$(this).attr('id').substring(3)+"/edit.js",
                dataType: "script"
            });
        }
    });

    $('table#show_languages_grid tbody tr').live('mouseover',function(){
        if($('#language_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });
});

/*GeographicalArea_grid*/

$('table#show_geographicalarea_grid tbody tr').live('click',function(){
    if( $('#geo_area_mode').attr('mode') == "show"){
        $('table#show_geographicalarea_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
    }else{
        $(this).removeClass('trSelected');
    }
});

$('table#show_geographicalarea_grid tbody tr').live('dblclick',function(){
    if( $('#geo_area_mode').attr('mode') == "show"){
        $.ajax({
            type: 'GET',
            url: "/post_areas/"+$(this).attr('id').substring(3)+"/edit.js",
            data: '&type=GeographicalArea',
            dataType: "script"
        });
    }else{}
});

$('table#show_geographicalarea_grid tbody tr').live('mouseover',function(){
    if( $('#geo_area_mode').attr('mode') == "show"){
        $(this).css('cursor',"pointer");
    }else{
        $(this).css('cursor',"");
    }
});

/* Religion Grid*/
$(function(){
    $('table#show_religions_grid tbody tr').live('click',function(){
        if($('#religion_mode').attr('mode')=="show"){
            $('table#show_religions_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_religions_grid tbody tr').live('dblclick',function(){
        if($('#religion_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/religions/"+$(this).attr('id').substring(3)+"/edit.js",
                dataType: "script"
            });
        }
    });

    $('table#show_religions_grid tbody tr').live('mouseover',function(){
        if($('#religion_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });

});

/*ElectoralArea_grid*/

$('table#show_electoral_area_grid tbody tr').live('click',function(){
    if( $('#electoral_area_mode').attr('mode') == "show"){
        $('table#show_electoral_area_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
    }else{
        $(this).removeClass('trSelected');
    }
});

$('table#show_electoral_area_grid tbody tr').live('dblclick',function(){
    if( $('#electoral_area_mode').attr('mode') == "show"){
        $.ajax({
            type: 'GET',
            url: "/post_areas/"+$(this).attr('id').substring(3)+"/edit.js",
            data: '&type=ElectoralArea',
            dataType: "script"
        });
    }else{}
});

$('table#show_electoral_area_grid tbody tr').live('mouseover',function(){
    if( $('#electoral_area_mode').attr('mode') == "show"){
        $(this).css('cursor',"pointer");
    }else{
        $(this).css('cursor',"");
    }
});


/*select change*/

$(function(){
    $(".select_renew_tab").live('mousedown', function(){
        $.ajax({
            type: "GET",
            url:"/countries/select_renew.js",
            data: 'param1='+ $(this).attr('param1'),
            dataType: "script"
        });
    });
});



$(function(){

    $('#delete_bank_entry').live('click', function(){

        var link = $(this);
        $('#warning_message_text').html("Are You Sure You Wish to Delete This Bank?");
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
                        url: "/banks/delete_bank_entry",
                        data: 'id=' + link.attr('bank_id'),
                        dataType: "script"
                    });
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

    });
});

$(function(){
    $('#edit_bank_entry').live('click', function(){
        $.ajax({
            type: "GET",
            url: "/banks/edit_bank_entry",
            data: 'id=' + $(this).attr('bank_id'),
            dataType: "script"
        });
    });
});

$(function(){
    $('#edit_bank_entry_close_form').live('click', function(){
        // $('#edit_bank_entry_form').hide();
        });
});


/* Show postcode by country Grid*/
$(function(){
    $('table#show_postcodes_by_country_grid tbody tr').live('click',function(){
        if($('#postcode_mode').attr('mode')=="show"){
            $('table#show_postcodes_by_country_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_postcodes_by_country_grid tbody tr').live('dblclick',function(){
        if($('#postcode_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/postcodes/"+$(this).attr('id').substring(3)+"/edit.js",
                dataType: "script"
            });
        }
    });

    $('table#show_postcodes_by_country_grid tbody tr').live('mouseover',function(){
        if($('#postcode_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });
});


/*Maintenance-country- message*/

//$(function(){
//    $('a.tab_switch_with_page_initial').live('click', function(){
//
//        var link = $(this);
//        if($('#check_input_change').val() == "false")
//        {
//            $('.page_initial[field='+ link.attr('field')+']').click();
//            $('.page_initial[field='+ link.attr('field')+']').mousedown();
//        }
//        else
//        {
//            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT? ");
//            $('#warning_message_image').css("display","");
//            $('#warning_message').dialog({
//                modal: true,
//                resizable: false,
//                draggable: true,
//                height: 'auto',
//                width: 'auto',
//                buttons: {
//
//                    No: function(){
//                        $(this).dialog('destroy');
//                        return false;
//
//                    },
//                    Yes: function(){
//                        $('.page_initial[field='+ link.attr('field')+']').click();
//                        $('.page_initial[field='+ link.attr('field')+']').mousedown();
//                        $('#check_input_change').val("false");
//                        $(this).dialog('destroy');
//                        return true;
//                    }
//                }
//            });
//            $('#warning_message').dialog('option', 'title', 'Warning');
//
//            $('#warning_message').parent().find("a").css("display","none");
//            $("#warning_message").parent().css('background-color','#D1DDE6');
//            $("#warning_message").css('background-color','#D1DDE6');
//
//            $('#warning_message').dialog('open');
//            return false;
//        }
//    });
//});

/* check keyword before delete */
$(function(){
    $(".check_delete ").live('click', function(){

        $.ajax({
            type: "GET",
            url: "/keywords/check_destroy.js",
            data: 'id=' + $(this).attr("keyword_id"),
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

$(function(){
    $('#data_restore').live('click', function(){
        var link = $(this);
        $('#warning_message_text').html("Are You Sure You Wish to Restore Database?");
        $('#warning_message_image').css("display","");
        $('#warning_message').dialog({
            modal: true,
            resizable: false,
            draggable: true,
            height: 300,
            width: 550,
            buttons: {
                No: function(){
                    $(this).dialog('destroy');
                    return false;

                },
                Yes: function(){
                    $('#warning_message_text').html("Processing......<div class='spinner'></div>");
                    $('.ui-dialog-buttonpane').hide();
                    $.ajax({
                        type: 'GET',
                        url: "/maintenance/restore/",
                        data: 'file_name=' + link.attr("file_name"),
                        dataType: "script"
                    });
                    return true;
                }
            }

        });

        $('#warning_message').dialog('option', 'title', 'Warning');

        $('#warning_message').parent().find("a").css("display","none");
        $("#warning_message").parent().css('background-color','#D1DDE6');
        $("#warning_message").css('background-color','#D1DDE6');
        //      $("#warning_message").closest("ui-dialog-titlebar").css('background','#97B6CE');

        $('#warning_message').dialog('open');
        return false;
    });
});



$(function(){
    $(".show_fields").live('change', function(){
        if($(this).val()){
            $.ajax({
                type: "GET",
                url: "/tag_types/show_fields.js",
                data:'table_name=' + $(this).val() + '&update_field=' + $(this).attr("update_field") + '&update_value=' + $(this).attr("update_value"),
                dataType: "script"
            });
        }else{
            $("#fields_"+$(this).attr("update_field")).html("");
            $("#attribute_description_"+$(this).attr("update_field")).html("<label class='descriptions'>&nbsp;</label>")
        }
    });
});

// Global Change
$(function(){
    $('.global_change').live('click',function(){
        var data = "";
        if ($(this).attr("source")=="Person")
        {
            data ="source_id="+$("#list_header_name").val()+"&table_name="+$('#global_change_table_name').val()+"&table_field="+$('#table_field_id').val()+"&change_value="+$('#global_change_value').val()+"&type="+$("#table_action_id").val()+"&add_front="+$('#add_to_front').attr("checked")+"&add_end="+$('#add_to_end').attr("checked")+"&select_data="+$('#system_data_id').val()+"&source_type="+$(this).attr("source") ;

        }
        else
        {
            data = "source_id="+$("#org_list_header_name").val()+"&table_name="+$('#org_global_change_table_name').val()+"&table_field="+$('#org_table_field_id').val()+"&change_value="+$('#org_global_change_value').val()+"&type="+$("#org_table_action_id").val()+"&add_front="+$('#org_add_to_front').attr("checked")+"&add_end="+$('#org_add_to_end').attr("checked")+"&select_data="+$('#org_system_data_id').val()+"&source_type="+$(this).attr("source");

        }
        $.ajax({
            type: "GET",
            url: "/global_changes/change_value.js",
            data: data,
            dataType: "script"
        })

    });

});


$(function(){
    $('.table_field').live('change',function(){

        var data ="";
        if ($(this).attr("source")=="Person")
        {

            data = "table_name="+$('#global_change_table_name').val()+"&table_field="+$('#table_field_id').val();
      
        }
        else
        {

            data="table_name="+$('#org_global_change_table_name').val()+"&table_field="+$('#org_table_field_id').val()+"&type=Org";


        }


        $.ajax({
            type: "GET",
            url: "/global_changes/check_field_type.js",
            data: data,
            dataType: "script"
        });

    });

    $('#global_change_value').live('keyup',function(){
    {

        if( $(this).val()=="")
        {
            $("#global_run").attr('disabled',true);
        }
        else
        {
            $("#global_run").attr('disabled',false);
        }
    }
    });

});

$(function(){
    $(".global_change_fields").live('change',function(){
        var data ="";
        if ($(this).attr("source")=="Person")
        {

            data = "select_type="+$("#global_change_table_name").val();

        }
        else
        {

            data="select_type="+$("#org_global_change_table_name").val()+"&type=Org"


        }



        $.ajax({
            type: "GET",
            url: "/global_changes/show_type.js",
            data: data,
            dataType: "script"

        });
   
    })



    $("#system_data_id").live('change',function(){

        if ($(this).val()==null)
        {
            $("#global_run").attr('disabled',true);
      
        }
        else
        {
            $("#global_run").attr('disabled',false);

        }

    });


    $('#list_header_name').live('change',function(){
 
        if ($(this).val()=="")
        {
 
            $('#global_change_table_name').val("").change();
            $('#table_action_id').val("");

            $('#global_change_table_name').attr('disabled',true);
            $('#table_field_id').attr('disabled',true);
            $('#table_action_id').attr('disabled',true);
        }
        else
        {

            $('#global_change_table_name').attr('disabled',false);
            $('#table_field_id').attr('disabled',false);
            $('#table_action_id').attr('disabled',false);

        }

    });

    $('#table_action_id').live('change',function(){


        if(!($('#global_change_table_name').val()=="" || $('#table_field_id').val()==""))
        {
            if ($(this).val()=="Add")

            {
                $('#global_change_value').val("");
                $("#global_run").attr('disabled',true);
                if($('#select_system_data').css('display')=='')
                {
                    $('#input_data_value').css('display','none');
                    $("#global_run").attr('disabled',false);
                }


                if($('#select_system_data').css('display')=='none')
                {
                    $('#global_change_label').css('display','');
                    $('#input_data_value').css('display','');
                    $('#global_change_checkbox').css('display','');
                }
     
                if ($('#global_change_table_name').val()=="note")
                {
                    $('#input_data_value').css('display','');
                    $('#global_change_label').css('display','none');
                    $('#global_change_checkbox').css('display','none');
                }


            }
            else if ($(this).val()=="Change")
            {
                $('#global_change_value').val("");
                $("#global_run").attr('disabled',true);
                $('#input_data_value').css('display','');
                $('#global_change_label').css('display','none');
                $('#global_change_checkbox').css('display','none');
            }
            else
            {
                $('#global_change_value').val("");
                $('#input_data_value').css('display','none');
                $("#global_run").attr('disabled',false);
                if($('#select_system_data').css('display')=='none')
                {
                    $('#global_change_label').css('display','none');
                    $('#global_change_checkbox').css('display','none');
                }
                if ($('#global_change_table_name').val()=="note")
                {
                    $('#input_data_value').css('display','');
                    $('#global_change_label').css('display','none');
                    $('#global_change_checkbox').css('display','none');
                    $("#global_run").attr('disabled',true);
                }
         


            }


   
        }
        else{
            $('#input_data_value').css('display','none');
            $('#global_change_label').css('display','none');
            $('#global_change_checkbox').css('display','none');
            $("#global_run").attr('disabled',true);
     
        }


    });
});
// org global change



$(function(){


    $('#org_global_change_value').live('keyup',function(){
    {

        if( $(this).val()=="")
        {
            $("#org_global_run").attr('disabled',true);
        }
        else
        {
            $("#org_global_run").attr('disabled',false);
        }
    }
    });

});

$(function(){

    $("#org_system_data_id").live('change',function(){

        if ($(this).val()==null)
        {
            $("#org_global_run").attr('disabled',true);

        }
        else
        {
            $("#org_global_run").attr('disabled',false);

        }

    });


    $('#org_list_header_name').live('change',function(){

        if ($(this).val()=="")
        {

            $('#org_global_change_table_name').val("").change();
            $('#org_table_action_id').val("");

            $('#org_global_change_table_name').attr('disabled',true);
            $('#org_table_field_id').attr('disabled',true);
            $('#org_table_action_id').attr('disabled',true);
        }
        else
        {

            $('#org_global_change_table_name').attr('disabled',false);
            $('#org_table_field_id').attr('disabled',false);
            $('#org_table_action_id').attr('disabled',false);

        }

    });

    $('#org_table_action_id').live('change',function(){
        if(!($('#org_global_change_table_name').val()=="" || $('#org_table_field_id').val()==""))
        {
            if ($(this).val()=="Add")
            {
                $('#org_global_change_value').val("");

                $("#org_global_run").attr('disabled',true);

   
                if($('#org_select_system_data').css('display')=='none')
                {
                    $('#org_global_change_label').css('display','');
                    $('#org_input_data_value').css('display','');
                    $('#org_global_change_checkbox').css('display','');
                }
                else
                {
                    $('#org_input_data_value').css('display','none');
                    $("#org_global_run").attr('disabled',false);
                }

                if ($('#org_global_change_table_name').val()=="note")
                {
                    $('#org_input_data_value').css('display','');
                    $('#org_global_change_label').css('display','none');
                    $('#org_global_change_checkbox').css('display','none');
                }


            }
            else if ($(this).val()=="Change")
            {
                $('#org_global_change_value').val("");
                $("#org_global_run").attr('disabled',true);
                $('#org_input_data_value').css('display','');
                $('#org_global_change_label').css('display','none');
                $('#org_global_change_checkbox').css('display','none');
            }
            else
            {
                $('#org_global_change_value').val("");
                $('#org_input_data_value').css('display','none');
                $("#org_global_run").attr('disabled',false);
                if($('#org_select_system_data').css('display')=='none')
                {
                    $('#org_global_change_label').css('display','none');
                    $('#org_global_change_checkbox').css('display','none');
                }
                if ($('#org_global_change_table_name').val()=="note")
                {


                    $('#org_input_data_value').css('display','');
                    $('#org_global_change_label').css('display','none');
                    $('#org_global_change_checkbox').css('display','none');
                    $("#org_global_run").attr('disabled',true);
          
         
                }

            }

        }else
        {
          
            $('#org_input_data_value').css('display','none');
            $('#org_global_change_label').css('display','none');
            $('#org_global_change_checkbox').css('display','none');
            $("#org_global_run").attr('disabled',true);
        }


    });
});