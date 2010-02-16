/* Public*/


$(function() {
    $('a.move_down_address_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_up_address_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_down_phone_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_up_phone_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");


    $('a.move_down_email_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_up_email_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_down_website_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_up_website_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_down_master_doc_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_up_master_doc_priority').live('click', function() {


        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");
 
});
$(function(){
    $(".find_person_field").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url:
                "/people/name_finder.js",
                data:
                'person_id='+$(this).val()+'&update='+$(this).attr('update')+'&employment_id='+$(this).attr('employment_id')+'&input_field_id='+$(this).attr('input_field_id'),
                dataType: "script"
            });
        }else{
            $("#"+$(this).attr('update')+"_"+$(this).attr('employment_id')).val("");
        }
    });
});

$(function()
{
    $(".show_group_type").live('change', function(){
        /*   if($(this).val()!= ""){  */
        $.ajax({
            type: "GET",
            url: "/tag_meta_types/show_group_types.js",
            data: 'group_meta_meta_type_id='+$(this).val()+'&person_group_id='+$(this).attr('person_group_id'),
            dataType: "script"
        });

   
    });


});

/* Show_group */
$(function(){
    $(".find_group_meta_type").live('change',function(){
        $.ajax({
            type: "GET",
            url: "/tag_types/show_types.js",
            data: 'group_meta_type_id='+$(this).val(),
            dataType: "script"

        });
    });
});

/* Show Group Description */

$(function(){
    $("#group_id").live('change',function(){
        $.ajax({
            type: "GET",
            url: "/tags/show_group_description.js",
            data: 'group_id='+$(this).val(),
            dataType: "script"

        });
    });
});

/* MasterDoc */
$(function(){
    $(".find_master_doc_meta_type_field").live('change', function(){
        $.ajax({
            type: "GET",
            url:
            "/people/master_doc_meta_type_finder.js",
            data:
            'id='+$(this).val()+'&master_doc_id='+$(this).attr('master_doc_id'),
            dataType: "script"
        });
    });
});


$(function(){
    $(".find_master_doc_type_field").live('change', function(){
        $.ajax({
            type: "GET",
            url:
            "/people/master_doc_type_finder.js",
            data:
            'id='+$(this).val()+'&master_doc_id='+$(this).attr('master_doc_id'),
            dataType: "script"
        });
    });
});
$(function(){
    $(".clear_find_form").click(function(){

        var link = $(this);
        var temp = "false";
      

        if ($(this).attr('field') == "left_find_by_person")
        {
        
            temp = $('#check_left_input_change').val();


        }
        if ($(this).attr('field') == "right_find_by_email")
        {

            temp = $('#find_email_input_change_or_not').val();


        }
        if ($(this).attr('field') == "right_find_by_phone")
        {

            temp = $('#find_phone_input_change_or_not').val();


        }
        if ($(this).attr('field') == "right_find_by_address")
        {

            temp = $('#find_address_input_change_or_not').val();

        }

        if(temp=="true")
        {
            $('#warning_message_text').html("Are You Sure You Wish to Clear The Entered Data ? ");
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
                        return true;

                    },
                    Yes: function(){
                        $('#'+link.parents("form").get(0).id)[0].reset();
                        //                    $('#check_input_change').val("false");
                        //                    $('#check_left_input_change').val("false");
                        //                    $('#check_right_input_change').val("false");
                        if (link.attr('field') == "left_find_by_person")
                        {

                            $('#check_left_input_change').val("false");

                        }
                        if (link.attr('field') == "right_find_by_email")
                        {
                            $('#find_email_input_change_or_not').val("false");

                        }
                        if (link.attr('field') == "right_find_by_phone")
                        {

                            $('#find_phone_input_change_or_not').val("false");

                        }
                        if (link.attr('field') == "right_find_by_address")
                        {

                            $('#find_address_input_change_or_not').val("false");

                        }


                        if($('#find_email_input_change_or_not').val()=="false" && $('#find_phone_input_change_or_not').val()=="false")
                        {
                            $('#check_right_input_change').val("false");
                        }
                        else
                        {
                            $('#check_right_input_change').val("true");
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



        }
    });
});

$(".clear_tab").click(function(){
    if ($(this).attr('field') != ""){

        $("#new_"+$(this).attr('field'))[0].reset();
    }

});

$(".clear_group_form").click(function(){
    $('.find_group_meta_type').val("").change();
});

clear_employment_form = function()
{
    $("#new_employment")[0].reset();
    $('#organisation_name_container_0').html('');
    $('#recruiter_container_0').html('');
    $('#supervisor_container_0').html('');
    $('#suspender_container_0').html('');
    $('#terminator_container_0').html('');
};


$("#delete_photo").click(function(){

    var link =$(this);
    $('#warning_message_text').html("Are you sure you wish to delete the photo ? ");
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
                return true;

            },
            Yes: function(){
                $.post(link.attr('href'), "_method=delete", null, 'script');
                $("#photo").attr("src", "/images/Icons/System/image-missing.png");
                $("#delete_photo").hide();
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

$(function(){
    $("#contact_phone_submit").live('click', check_empty_value);
});

$(function(){
    $("#contact_phone_submit_edit").live('click', check_empty_value);
});


$(function(){
    $("#submit_email_field").live('click', check_empty_value);
});

$(function(){
    $("#submit_email_field_edit").live('click', check_empty_value);
});



$(function(){
    $("#submit_website_field").live('click', check_empty_value);
});

$(function(){
    $("#submit_website_field_edit").live('click', check_empty_value);
});

$(function(){
    $("#address_submit_button").live('click', check_empty_value);
});

$(function(){
    $("#address_submit_button_edit").live('click', check_empty_value);
});

$(function(){
    $("#submit_email_field").live('click', check_email_field);
});

$(function(){
    $("#submit_email_field_edit").live('click', check_email_field_edit);
});
$(function(){
    $("#submit_website_field").live('click', check_website_field);
});

$(function(){
    $("#submit_website_field_edit").live('click', check_website_field_edit);
});


/*Contact form add button form to default phone form*/
$(function(){
    $(".clear_form_to_phone").live("click", function(){
        $("#select_contact_type").val("Phone").change();

        //        if($("#phone_contact_meta_type_id").val() == null)
        //        {
        //            $("#phone_pre_value").attr('readonly','readonly');
        //            $("#phone_value").attr('readonly','readonly');
        //            $("#phone_post_value").attr('readonly','readonly');
        //            $("#phone_remarks").attr('readonly','readonly');
        //            $("#contact_phone_submit").attr('readonly','readonly');
        if($("#phone_contact_meta_type_id").val() == null)
        {
            $("#phone_pre_value").attr('readonly','readonly');
            $("#phone_value").attr('readonly','readonly');
            $("#phone_post_value").attr('readonly','readonly');
            $("#phone_remarks").attr('readonly','readonly');
            $("#contact_phone_submit").attr('disabled','disabled');

        }

        if($("#email_contact_meta_type_id").val() == null)
        {
            $("#email_remarks").attr('readonly','readonly');
            $("#email_value").attr('readonly','readonly');
            $("#submit_email_field").attr('readonly','readonly')
        }

        if($("#website_contact_meta_type_id").val() == null)
        {
            $("#website_value").attr('readonly','readonly');
            $("#website_remarks").attr('readonly','readonly');
            $("#submit_website_field").attr('readonly','readonly')
        }

        if($("#instant_messaging_contact_meta_type_id").val() == null)
        {
            $("#instant_messaging_value").attr('readonly','readonly');
            $("#instant_messaging_remarks").attr('readonly','readonly');
            $("#submit_instant_messaging_field").attr('readonly','readonly')
        }



    });


    $("#select_contact_type").ready(function(){
        $('form.active').removeClass('active');
        $("form."+$('#select_contact_type option:selected').val()).addClass('active');
    });

    $("#select_contact_type").live('change',function(){
        $('form.active').removeClass('active');
        $("form."+$('#select_contact_type option:selected').val()).addClass('active');
    });
});

$(function(){
    $(".clear_form_to_address").live("click", function(){

        if($("#address_address_type_id").val() == null)
        {
            $("#address_building_name").attr('readonly','readonly');
            $("#address_suite_unit").attr('readonly','readonly');
            $("#address_street_number").attr('readonly','readonly');
            $("#address_street_name").attr('readonly','readonly');
            $("#address_town").attr('readonly','readonly');
            $("#address_state").attr('readonly','readonly');
            $("#address_postal_code").attr('readonly','readonly');
            $("#address_country_id").attr('readonly','readonly');
            $("#address_submit_button").attr('disabled','disabled');

        }
    });
});



/*check contact input field change or not*/

$(function(){
    $("#Contact").find('input').live('change', function(){


        $('#contact_input_change_or_not').val("true");

    });

    $('#Contact input[type="submit"]').live('click', function(){
        $('#contact_input_change_or_not').val("false");
    });

});


$(function(){
    $("#Address").find('input').live('change', function(){
        $('#address_input_change_or_not').val("true")
    });

    $('#Address input[type="submit"]').live('click', function(){
        $('#address_input_change_or_not').val("false");

    });

});

$(function(){
    $("#MasterDocs").find('input').live('change', function(){
        $('#master_doc_input_change_or_not').val("true")
    });

    $('#MasterDocs input[type="submit"]').live('click', function(){
        $('#master_doc_input_change_or_not').val("false");

    });

});


$(function(){
    $("#Rels").find('input').live('change', function(){
        $('#relationship_input_change_or_not').val("true");
    });

    $('#Rels input[type="submit"]').live('click', function(){
        $('#relationship_input_change_or_not').val("false");

    });

});

$(function(){
    $("#Note").find('input').live('change', function(){
        //        $('#check_right_input_change').val("true");

        $('#notes_input_change_or_not').val("true");


    });

    $("#Note").find('textarea').live('change', function(){
        //        $('#check_right_input_change').val("true");

        $('#notes_input_change_or_not').val("true");

    });



    $('#Note input[type="submit"]').live('click', function(){
        $('#notes_input_change_or_not').val("false");

    });

});

$(function(){
    $("#Role").find('input').live('change', function(){
        //        $('#check_right_input_change').val("true");
        $('#role_input_change_or_not').val("true");
    });

    $('#Role input[type="submit"]').live('click', function(){
        $('#role_input_change_or_not').val("false");

    });

});
$(function(){
    $("#Employment").find('input').live('change', function(){
        //        $('#check_right_input_change').val("true");
        $('#employment_input_change_or_not').val("true");
    });

    $('#Employment input[type="submit"]').live('click', function(){
        $('#employment_input_change_or_not').val("false");

    });

});

$(function(){
    $("#Account").find('input').live('change', function(){

        $('#account_input_change_or_not').val("true");
    });

    $('#Account input[type="submit"]').live('click', function(){
        $('#account_input_change_or_not').val("false");

    });

});

/*find clear form*/

$(function(){
    $("#new_email").find('input').live('change', function(){
        //        $('#check_right_input_change').val("true");
        $('#find_email_input_change_or_not').val("true");
    });

    $('#new_email input[type="submit"]').live('click', function(){
        $('#find_email_input_change_or_not').val("false");

    });

});

$(function(){
    $("#new_phone").find('input').live('change', function(){
        //        $('#check_right_input_change').val("true");
        $('#find_phone_input_change_or_not').val("true");
    });

    $('#new_phone input[type="submit"]').live('click', function(){
        $('#find_phone_input_change_or_not').val("false");

    });

});

$(function(){
    $("#new_address").find('input').live('change', function(){
        //        $('#check_right_input_change').val("true");
        $('#find_address_input_change_or_not').val("true");
    });

    $('#new_address input[type="submit"]').live('click', function(){
        $('#find_address_input_change_or_not').val("false");

    });

});


/* Show Person Age*/



$(function(){
    $("#person_birth_date").live('change', function(){

        if($("#person_birth_date").val()!= "")
        {
            var current_year = new Date();
            $('#person_age').html(parseInt(current_year.getFullYear())-parseInt($(this).val().substring(6,10))).change();
        }
        else
        {

            $('#person_age').html('').change();
        }
    }
    );

});

/*System ID Submit*/
system_id_check_input_change_or_not = function()
{

    var link = $('#system_id_tag');
    right_tab = $("#content #right_content").find("#tabs");
    if(right_tab.length > 0)
    {
        check_input_change();
    }

    left_content = $("#content").find("#left_content");
    right_content = $("#content").find("#right_content");
    if (left_content.length > 0 &&  right_content.length > 0)
    {

        if ( $('#check_right_input_change').val() == "true" || $('#check_left_input_change').val() == "true" )
        {

            $('#check_input_change').val("true");
        }
        else
        {

            $('#check_input_change').val("false");
        }
    }

    if($('#check_input_change').val() == "false")
    {

        $('#'+link.attr('form_name')).submit();
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


                    $('#'+link.attr('form_name')).submit();
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

};


/* Bank Look up*/
$(function(){
    $(".bank_lookup").live('click', function(){
        $.ajax({
            type: "GET",
            url:"/banks/lookup.js",
            data:'update_field='+$(this).attr('update_field'),
            dataType: "script"
        });
    });

    $("table#bank tbody tr").live("dblclick", function(){
        $.ajax({
            type: "GET",
            url:"/banks/lookup_fill.js",
            data:'id='+$(this).attr('id').substring(3) + "&update_field=" + $("table#bank").attr('update_field'),
            dataType: "script"
        });

    });

    $("table#bank tbody tr").live("click", function(){
        $('table#bank tbody tr.selected').removeClass('selected');
        $(this).addClass("selected");
    });
    $('table#bank tr').live('mouseover',function(){
        $(this).css("cursor", "pointer");
    });

});



$(function(){
    $(".find_bank_field").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url:
                "/banks/name_finder.js",
                data:
                'bank_id='+$(this).val()+'&update='+$(this).attr('update')+'&account_id='+$(this).attr('account_id')+'&input_field_id='+$(this).attr('input_field_id'),
                dataType: "script"
            });
        }
    });
});


//make the dropdown select of MasterDoc in Organization active, when open New Pannel
$(function(){
    $('#add_new_master_doc #add_masterdoc').live('click', function(){
        $(".find_master_doc_meta_type_field").change();
    });
});

/*Public*/

/*Person*/
$(function(){
    $("#tabs").tabs();
});


$('a.move_down_address_priority').live('click', function() {
    var link = $(this);
    $.get(link.attr('href'), null ,null, 'script');
    return false;
}).attr("rel", "nofollow");

$('a.move_up_address_priority').live('click', function() {
    var link = $(this);
    $.get(link.attr('href'), null ,null, 'script');
    return false;
}).attr("rel", "nofollow");

$('a.move_down_phone_priority').live('click', function() {
    var link = $(this);
    $.get(link.attr('href'), null ,null, 'script');
    return false;
}).attr("rel", "nofollow");

$('a.move_up_phone_priority').live('click', function() {
    var link = $(this);
    $.get(link.attr('href'), null ,null, 'script');
    return false;
}).attr("rel", "nofollow");


$('a.move_down_email_priority').live('click', function() {
    var link = $(this);
    $.get(link.attr('href'), null ,null, 'script');
    return false;
}).attr("rel", "nofollow");

$('a.move_up_email_priority').live('click', function() {
    var link = $(this);
    $.get(link.attr('href'), null ,null, 'script');
    return false;
}).attr("rel", "nofollow");

$('a.move_down_website_priority').live('click', function() {
    var link = $(this);
    $.get(link.attr('href'), null ,null, 'script');
    return false;
}).attr("rel", "nofollow");

$('a.move_up_website_priority').live('click', function() {
    var link = $(this);
    $.get(link.attr('href'), null ,null, 'script');
    return false;
}).attr("rel", "nofollow");

$('a.move_down_master_doc_priority').live('click', function() {
    var link = $(this);
    $.get(link.attr('href'), null ,null, 'script');
    return false;
}).attr("rel", "nofollow");

$('a.move_up_master_doc_priority').live('click', function() {


    var link = $(this);
    $.get(link.attr('href'), null ,null, 'script');
    return false;
}).attr("rel", "nofollow");
//To use for the person contact edit close button to show the warning message

$('a.get_close').live('click', function() {
    var change_type = "false";
    //    if($(this).attr('field')== "contact")
    //    {
    //        change_type =$('#contact_input_change_or_not').val();
    //
    //    }
    //    if($(this).attr('field')== "address")
    //    {
    //        change_type =$('#address_input_change_or_not').val();
    //
    //    }
    //
    //    if($(this).attr('field')== "master_doc")
    //    {
    //        change_type =$('#master_doc_input_change_or_not').val();
    //
    //    }
    //
    //    if($(this).attr('field')== "relationship")
    //    {
    //        change_type =$('#relationship_input_change_or_not').val();
    //
    //    }
    //
    //    if($(this).attr('field')== "note")
    //    {
    //
    //        change_type =$('#notes_input_change_or_not').val();
    //
    //    }
    //
    //    if($(this).attr('field')== "person_role")
    //    {
    //
    //        change_type =$('#role_input_change_or_not').val();
    //
    //    }
    //
    //    if($(this).attr('field')== "employment")
    //    {
    //        change_type =$('#employment_input_change_or_not').val();
    //
    //    }
    //    if($(this).attr('field')== "group")
    //    {
    //        change_type =$('#group_input_change_or_not').val();
    //
    //    }
    //    if($(this).attr('field')== "account")
    //    {
    //
    //        change_type =$('#account_input_change_or_not').val();
    //
    //    }
    //                if($(this).attr('field')== "organisation_contact")
    //          {
    //            change_type =$('#organisation_contact_input_change_or_not').val();
    //          }
    var link = $(this);

    if($('#check_right_input_change').val() == "true")
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

                    //                    if(link.attr('field')== "contact")
                    //                    {
                    //
                    //                        $('#contact_input_change_or_not').val("false");
                    //                    }
                    //                    if(link.attr('field')== "address")
                    //                    {
                    //
                    //                        $('#address_input_change_or_not').val("false");
                    //                    }
                    //
                    //                    if(link.attr('field')== "master_doc")
                    //                    {
                    //
                    //                        $('#master_doc_input_change_or_not').val("false");
                    //                    }
                    //
                    //                    if(link.attr('field')== "relationship")
                    //                    {
                    //
                    //                        $('#relationship_input_change_or_not').val("false");
                    //                    }
                    //
                    //                    if(link.attr('field')== "note")
                    //                    {
                    //                        $('#notes_input_change_or_not').val("false");
                    //                    }
                    //
                    //                    if(link.attr('field')== "person_role")
                    //                    {
                    //
                    //                        $('#role_input_change_or_not').val("false");
                    //                    }
                    //
                    //                    if(link.attr('field')== "employment")
                    //                    {
                    //
                    //                        $('#employment_input_change_or_not').val("false");
                    //                    }
                    //                    if(link.attr('field')== "group")
                    //                    {
                    //
                    //                        $('#group_input_change_or_not').val("false");
                    //                    }
                    //
                    //                    if(link.attr('field')== "account")
                    //                    {
                    //
                    //                        $('#account_input_change_or_not').val("false");
                    //                    }

                    $.get(link.attr('href'), null ,null, 'script');
                    $('#check_right_input_change').val("false");
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
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }
    return false;
});


/*Keywords*/
showKeyword = function(){
    $("#add_person_keywords option:selected").removeAttr("selected");
    $("#add_person_keywords").find("option").hide();
    //    alert($("#keyword_keyword_type_id").find("option:selected").text());
    $("#keyword_person_types").find("option:selected").each(function(){
        if($(this).val() == ""){
            $("#add_person_keywords").find("option").show();
        }else{
            $("#add_person_keywords option[class=" + $(this).text() + "]").show();
        //             $("#add_person_keywords option[class=" + $(this).text() + "]").css('display','');

        }
    });
};

showTooltip = function(){
    $("#add_person_keywords option ,#remove_person_keywords option").each(function(){
        $(this).qtip({
            content: $(this).attr('remark'),
            position: {
                corner: {
                    target: 'leftMiddle',
                    tooltip: 'rightMiddle'
                }
            },
            style : {
                tip: true
            }
        });
    });
};

$("#keyword_person_types").live("change", showKeyword);


/* show other group member */
$(function(){
    $("#show_other_group_members").live('click',function(){
        $.ajax({
            type: "GET",
            url: "/people/"+$(this).attr('person_id')+"/person_groups/show_group_members.js",
            data: 'person_group_id='+$(this).attr('person_group_id'),
            dataType: "script"

        });
    });
});

/* Relationships */
$(function(){
    $("input[type='text']#relationship_related_person_id").change(function(){
        $.ajax({
            type: "GET",
            url: "/people/name_finder.js",
            data: 'person_id='+$(this).val(),

            dataType: "script"
        });
    });
});

$(function(){
    $('table#search_results tbody tr').live('click',function(){
        $.ajax({
            type: 'GET',
            url: "/people/"+$(this).attr('person_id')+"/name_card.js",
            dataType: "script"
        });
        $('table#search_results tbody tr.selected').removeClass('selected');
        $(this).addClass("selected");

    });
});


/* Show Summary list*/

$(function(){
    $('table#search_list_results tbody tr').live('dblclick',function(){
        // alert($('table#search_list_results').attr('current_operation'));
        if ($('table#search_list_results').attr('current_operation') == "edit_list")
        {
            window.open("/people/"+$(this).attr("id").substring(3)+"/edit","_self");
        }
        if ($('table#search_list_results').attr('current_operation') == "show_list")
        {
            window.open("/people/"+$(this).attr("id").substring(3)+"/","_self");

        }
    });
});

$(function(){
    $('table#search_list_results tbody tr').live('click',function(){
        $.ajax({
            type: 'GET',
            url: "/people/show_left.js",
            data: 'person_id='+$(this).attr('id').substring(3)+'&current_operation='+ $('#search_list_results').attr('current_operation')+'&active_tab='+$('#search_list_results').attr('active_tab')+'&active_sub_tab='+$('#search_list_results').attr('active_sub_tab'),
            dataType: "script"
        });
        $('table#search_list_results tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass("trSelected");
    });
});


$(function(){
    $('table#search_list_results tbody tr').live('mouseover',function(){
        $(this).css("cursor","pointer");
    });
});

/*role*/


$(function(){
    $(".find_role_field").live('change',function(){
        $.ajax({
            type: "GET",
            url: "/people/"+$(this).attr('person_id')+"/roles/get_roles.js",
            data: 'role_type_id='+$(this).val()+'&person_role_id='+$(this).attr('person_role_id'),
            dataType: "script"
        });
    });
});



$(function(){
    $(".check_person_field").live('change', function(){
        $.ajax({
            type: "GET",
            url: "/people/role_finder.js",
            data: 'person_id='+$(this).val()+'&update='+$(this).attr('update')+'&person_role_id='+$(this).attr('person_role_id')+'&input_field_id='+$(this).attr('id'),
            dataType: "script"
        });
    });
});

clear_person_role_form = function(){

    $("#new_person_role")[0].reset();
    $('#assigner_container_0').html('');
    $('#approver_container_0').html('');
    $('#approver_container_0').val('');
    $('#superviser_container_0').html('');
    $('#manager_container_0').html('');
    $('#role_role_type_id').change();
};



/* Person Group */


//$('#person_group_close_button').live('click',function(){
//
//    $('.person_group_delete_button').css("display","");
//});

$(".person_group_toggle_button").live('click', function(){
    if ($('.person_group_delete_button').css("display")=="block" || $('.person_group_delete_button').css("display")=="")
        $('.person_group_delete_button').css("display","none");
    else
        $('.person_group_delete_button').css("display","");
    $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    $('.person_group_close').css("display","");
    $(this).css("display","none");
});

$(".person_group_close").live('click',function(){


    var link = $(this);
    if( $('#group_input_change_or_not').val() == "false")
    {
        $('#'+link.attr('toggle_id_name')).toggle('blind');

        if ($('.person_group_delete_button').css("display")=="block" || $('.person_group_delete_button').css("display")=="")
            $('.person_group_delete_button').css("display","none");
        else
            $('.person_group_delete_button').css("display","");

        link.css("display","none");
        $('.person_group_toggle_button').css("display","");


    }
    else
    {
        $('#warning_message_text').html("Some data did not save.Are you sure you wish to close ? ");
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

                    if ($('.person_group_delete_button').css("display")=="block" || $('.person_group_delete_button').css("display")=="")
                        $('.person_group_delete_button').css("display","none");
                    else
                        $('.person_group_delete_button').css("display","");

                    link.css("display","none");
                    $('.person_group_toggle_button').css("display","");

                    $('#group_input_change_or_not').val("false");
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

});

/* Person Group */



/* Person Contact Form  */
$(".person_contact_toggle_button").live('click', function(){

    $('.person_contact_edit_delete').css("display","none");

    $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    $('.person_contact_close').css("display","");
    $(this).css("display","none");
    $('#contact_hidden_tab').attr('mode','new');
});

//$('#person_edit_phone_close_button').live('click',function(){
//    $('.person_contact_edit_delete').css("display","");
//});


$(".person_contact_close").live('click',function(){
    var link = $(this);
    if( $('#check_right_input_change').val() == "false")
    {
        $('#'+link.attr('toggle_id_name')).toggle('blind');
        $('.person_contact_edit_delete').css("display","none");
        link.css("display","none");
        $('.person_contact_toggle_button').css("display","");
        $('#contact_hidden_tab').attr('mode','show');

        $("#new_phone")[0].reset();
        $("#new_email")[0].reset();
        $("#new_website")[0].reset();


    }
    else
    {
        $('#warning_message_text').html("Some data did not save.Are you sure you wish to close ? ");
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
                    $('.person_contact_edit_delete').css("display","none");
                    link.css("display","none");
                    $('.person_contact_toggle_button').css("display","");
                    $('#contact_hidden_tab').attr('mode','show');

                    $("#new_phone")[0].reset();
                    $("#new_email")[0].reset();
                    $("#new_website")[0].reset();
            
                    $('#check_right_input_change').val("false");
                    //                    $('#check_input_change').val("false");
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


});

$("#email_edit_button").live('click',function(){
    //$('.person_contact_toggle_button').css("display","none");
    $('.person_contact_edit_delete').css("display","none");
    $('#contact_hidden_tab').attr('mode','edit');
});

$(".delete_email").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
//    $('.edit_email[email_id='+ $(this).attr('email_id') +']').css("display", "none");
});


$("#phone_edit_button").live('click',function(){
    //$('.person_contact_toggle_button').css("display","none");
    $('#add_new_contact').slideUp(1000);
    $('.person_contact_edit_delete').css("display","none");
    $('#contact_hidden_tab').attr('mode','edit');

});



$(".delete_phone").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
//    $('.edit_phone[phone_id='+ $(this).attr('phone_id') +']').css("display", "none");
});


$(".delete_fax").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
//    $('.edit_fax[fax_id='+ $(this).attr('fax_id') +']').css("display", "none");
});



$("#website_edit_button").live('click',function(){
    //$('.person_contact_toggle_button').css("display","none");
    $('.person_contact_edit_delete').css("display","none");
    $('#contact_hidden_tab').attr('mode','edit');
});

$(".delete_website").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
//    $('.edit_website[website_id='+ $(this).attr('website_id') +']').css("display", "none");
});

/* Person address  */

$(".person_address_toggle_button").live('click', function(){

    $('.person_address_edit_delete').css("display","none");
    $(this).css("display","none");

    $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    $('.person_address_close').css("display","");

    $('#address_hidden_tab').attr('mode','new');
});


$("#address_edit_button").live('click',function(){
    $('.person_address_edit_delete').css("display","none");
    //$('.person_address_toggle_button').css("display","none");
    $('#address_hidden_tab').attr('mode','edit');
});

$(".delete_address").live('click',function(){
    $('.person_address_toggle_button').css("display","");
//    $('.edit_address[address_id='+ $(this).attr('address_id') +']').css("display", "none");
});

$(".person_address_close").live('click',function(){
    var link = $(this);
    if( $('#check_right_input_change').val() == "false")
    {
        $('#'+link.attr('toggle_id_name')).toggle('blind');
        $('.person_address_edit_delete').css("display","none");
        link.css("display","none");
        $('.person_address_toggle_button').css("display","");
        $('#address_hidden_tab').attr('mode','show');
        if (link.attr('field') != ""){

            $("#new_"+link.attr('field'))[0].reset();
        }
    }
    else
    {
        $('#warning_message_text').html("Some data did not save.Are you sure you wish to close ? ");
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
                    $('.person_address_edit_delete').css("display","none");
                    link.css("display","none");
                    $('.person_address_toggle_button').css("display","");

                    $('#check_right_input_change').val("false");
                    $('#address_hidden_tab').attr('mode','show');
                    if (link.attr('field') != ""){
                        $("#new_"+link.attr('field'))[0].reset();
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
    }



    return false;


});


$("#address_edit_close_button").live('click',function(){

    $('#address_hidden_tab').attr('mode','show');
});

/* Person Master Doc*/

$(".person_master_doc_toggle_button").live('click', function(){
    $('.person_master_doc_edit_delete').css("display","none");

    $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    $('.person_master_doc_close').css("display","");
    $(this).css("display","none");
    $('#master_doc_hidden_tab').attr('mode','new');
    $(".find_master_doc_meta_type_field").change();
});

$(".person_master_doc_close").live('click',function(){
    var link = $(this);
    if( $('#check_right_input_change').val() == "false")
    {
        $('#'+link.attr('toggle_id_name')).toggle('blind');
        $('.person_master_doc_edit_delete').css("display","none");
        link.css("display","none");
        $('.person_master_doc_toggle_button').css("display","");
        $('#master_doc_hidden_tab').attr('mode','show');
        if (link.attr('field') != ""){

            $("#new_"+link.attr('field'))[0].reset();
        //$('#master_doc_meta_type_id').html("").change();
        //$('#master_doc_master_doc_type_id').html("").change();

        }

    }
    else
    {
        $('#warning_message_text').html("Some data did not save.Are you sure you wish to close ? ");
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
                    $('.person_master_doc_edit_delete').css("display","none");
                    link.css("display","none");
                    $('.person_master_doc_toggle_button').css("display","");

                    $('#master_doc_hidden_tab').attr('mode','show');
                    $('#check_right_input_change').val("false");
                    if (link.attr('field') != ""){

                        $("#new_"+link.attr('field'))[0].reset();
                    //$('#master_doc_meta_type_id').html("").change();
                    //$('#master_doc_master_doc_type_id').html("").change();
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
    }



});


$("#master_doc_edit_button").live('click',function(){
    //$('.person_master_doc_toggle_button').css("display","none");
    $('.person_master_doc_edit_delete').css("display","none");
    $('#master_doc_hidden_tab').attr('mode','edit');
});

$(".delete_master_doc").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
//    $('.edit_master_doc[master_doc_id='+ $(this).attr('master_doc_id') +']').css("display", "none");
});


$("#master_doc_edit_close_button").live('click',function(){

    $('#master_doc_hidden_tab').attr('mode','show');
});

/* Person relationship*/

$(".person_relationship_toggle_button").live('click', function(){
    $('.person_tag').css("display","none");

    $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    $('.person_relationship_close').css("display","");
    $(this).css("display","none");
    $('#relationship_hidden_tab').attr('mode','new');
});

$(".person_relationship_close").live('click',function(){

    var link = $(this);
    if( $('#check_right_input_change').val() == "false")
    {
        $('#'+link.attr('toggle_id_name')).toggle('blind');
        $('.person_tag').css("display","none");
        $('#related_person_name_container').html('');
        link.css("display","none");
        $('.person_relationship_toggle_button').css("display","");
        $('#relationship_hidden_tab').attr('mode','show');
        if (link.attr('field') != ""){

            $("#new_"+link.attr('field'))[0].reset();
        }


    }
    else
    {
        $('#warning_message_text').html("Some data did not save.Are you sure you wish to close ? ");
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
                    $('.person_tag').css("display","none");
                    $('#related_person_name_container').html('');

                    link.css("display","none");
                    $('.person_relationship_toggle_button').css("display","");
                    $('#relationship_hidden_tab').attr('mode','show');
                    $('#check_right_input_change').val("false");
                    if (link.attr('field') != ""){

                        $("#new_"+link.attr('field'))[0].reset();
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
    }






});



/*Person Notes*/

$(".person_notes_toggle_button").live('click', function(){

    $('.person_notes_edit_delete').css("display","none");

    $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    $('.person_notes_close').css("display","");
    $(this).css("display","none");
    $('#note_hidden_tab').attr('mode','new');
});

$(".person_notes_close").live('click',function(){


    var link = $(this);
    if($('#check_right_input_change').val() == "false")
    {
        $('#'+link.attr('toggle_id_name')).toggle('blind');

        $('.person_notes_edit_delete').css("display","none");

        link.css("display","none");
        $('.person_notes_toggle_button').css("display","");
        $('#note_hidden_tab').attr('mode','show');
        if (link.attr('field') != ""){

            $("#new_"+link.attr('field'))[0].reset();
        }


    }
    else
    {
        $('#warning_message_text').html("Some data did not save.Are you sure you wish to close ? ");
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

                    $('.person_notes_edit_delete').css("display","none");

                    link.css("display","none");
                    $('.person_notes_toggle_button').css("display","");
                    $('#note_hidden_tab').attr('mode','show');
                    $('#check_right_input_change').val("false");

                    if (link.attr('field') != ""){

                        $("#new_"+link.attr('field'))[0].reset();
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
    }






});

$(".edit_note").live('click',function(){
    $('.person_notes_toggle_button').css("display","none");
    $('.person_notes_edit_delete').css("display","none");
    $('#note_hidden_tab').attr('mode','edit');
});

$(".delete_note").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
//    $('.edit_note[note_id='+ $(this).attr('note_id') +']').css("display", "none");
});

$("#note_edit_close_button").live('click',function(){

    $('#note_hidden_tab').attr('mode','show');
});

/* Person Employment*/
$(".person_employments_toggle_button").live('click', function(){

    $('.person_employments_edit_delete').css("display","none");

    $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    $('.person_employments_close').css("display","");
    $(this).css("display","none");
    $('#employment_hidden_tab').attr('mode','new');
});


$(".person_employments_close").live('click',function(){
    var link = $(this);
    if($('#check_right_input_change').val() == "false")
    {
        $('#'+link.attr('toggle_id_name')).toggle('blind');

        $('.person_employments_edit_delete').css("display","none");

        link.css("display","none");
        $('.person_employments_toggle_button').css("display","");
        $('#employment_hidden_tab').attr('mode','show');
        clear_employment_form();

    }
    else
    {
        $('#warning_message_text').html("Some data did not save.Are you sure you wish to close ? ");
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

                    $('.person_employments_edit_delete').css("display","none");

                    link.css("display","none");
                    $('.person_employments_toggle_button').css("display","");
                    $('#employment_hidden_tab').attr('mode','show');
                    $('#check_right_input_change').val("false");

                    clear_employment_form();

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
});

$("#employments_edit_button").live('click',function(){
    //$('.person_employments_toggle_button').css("display","none");
    $('.person_employments_edit_delete').css("display","none");
    $('#employment_hidden_tab').attr('mode','edit');
});

$("#employment_edit_close_button").live('click',function(){

    $('#employment_hidden_tab').attr('mode','show');
});

/* Person Roles */
$(".person_roles_toggle_button").live('click', function(){

    $('.person_roles_edit_delete').css("display","none");
    $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    $('.person_roles_close').css("display","");
    $(this).css("display","none");
    $('#person_role_hidden_tab').attr('mode','new');
});

$("#role_edit_button").live('click',function(){

    //$('.person_roles_toggle_button').css("display","none");
    $('.person_roles_edit_delete').css("display","none");
    $('#person_role_hidden_tab').attr('mode','edit');
});

$(".delete_role").live('click',function(){
    $('.person_roles_toggle_button').css("display","");
//    $('.edit_role[role_id='+ $(this).attr('role_id') +']').css("display", "none");
});

$(".person_roles_close").live('click',function(){


    var link = $(this);
    if( $('#check_right_input_change').val() == "false")
    {
        $('#'+link.attr('toggle_id_name')).toggle('blind');

        $('.person_roles_edit_delete').css("display","none");
        link.css("display","none");
        $('.person_roles_toggle_button').css("display","");
        $('#person_role_hidden_tab').attr('mode','show');
        clear_person_role_form();

    }
    else
    {
        $('#warning_message_text').html("Some data did not save.Are you sure you wish to close ? ");
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

                    $('.person_roles_edit_delete').css("display","none");
                    link.css("display","none");
                    $('.person_roles_toggle_button').css("display","");
                    $('#person_role_hidden_tab').attr('mode','show');
                    $('#check_right_input_change').val("false");

                    clear_person_role_form();
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
});

$("#person_role_edit_close_button").live('click',function(){

    $('#person_role_hidden_tab').attr('mode','show');
});

// Moved address assistant into the application.js file, since it was being used in other modules as well... AW

/* person_primary_salutation @ tao*/
$(function(){
    //adding a new title or changing an exist one

    var title = true;
    var fn = true;
    var ln = true;

    //checking status and then appending person_primary_title_id
    $('select#person_primary_title_id').focus(function(){
        if($('select#person_primary_title_id').find('option:selected').html().length == 0)
            title = false;
    });
    $('select#person_primary_title_id').change(function(){
        if(title == false){
            update_primary();
            title = true;
        }
    });

    //checking status and appending person_first_name after first_name
    $('input#person_first_name').focus(function(){
        if($('input#person_first_name').val().length == 0)
            fn = false;
    });
    $('input#person_first_name').bind("blur", function(){
        if(fn == false){
            update_primary();
            fn = true;
        }
    });

    //checking status and appending person_family_name after title
    $('input#person_family_name').focus(function(){
        if($('input#person_family_name').val().length == 0)
            ln = false;
    });
    $('input#person_family_name').bind("blur", function(){
        if(ln == false){
            update_primary();
            ln = true;
        }
    });

    //if #person_primary_salutation lose focus, check it and it is not allowed to be empty
    $('input#person_primary_salutation').blur(function(){
        if($('input#person_primary_salutation').val().length == 0){
            update_primary();
        }
    });

    //update value of input#person_primary_salutation
    function update_primary(){
        $('input#person_primary_salutation').val($('select#person_primary_title_id').find('option:selected').html()
            + " " + $('input#person_first_name').val()
            + " " + $('input#person_family_name').val());
    }
});

/*Person Banking Tab*/
$(".person_account_close").live('click',function(){


    var link = $(this);
    if( $('#check_right_input_change').val() == "false")
    {
        $('#'+link.attr('toggle_id_name')).toggle('blind');

        $('.person_bank_account_edit_delete').css("display","none");
        link.css("display","none");
        $('.person_bank_account_toggle_button').css("display","");
        $('#person_account_mode').attr('mode','show');
        clear_person_role_form();

    }
    else
    {
        $('#warning_message_text').html("Some data did not save.Are you sure you wish to close ? ");
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

                    $('.person_bank_account_edit_delete').css("display","none");
                    link.css("display","none");
                    $('.person_bank_account_toggle_button').css("display","");
                    $('#person_account_mode').attr('mode','show');
                    $('#check_right_input_change').val("false");

                    //                    clear_person_role_form();
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
});

$(".person_bank_account_toggle_button").live('click', function(){

    $('.person_bank_account_edit_delete').css("display","none");

    $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    $('.person_account_close').css("display","");
    $(this).css("display","none");
    $('#person_account_mode').attr('mode','new');
});

/*for rule use*/

$(function(){
    $(".show_role_table").live('change',function(){

        $.ajax({
            type: "GET",
            url: "/people/"+$(this).attr('person_id')+"/roles/person_role_des.js",
            data: 'id='+$(this).val()+'&person_id='+$(this).attr('person_id')+'&person_role_id='+$(this).attr('person_role_id'),
            dataType: "script"
        });
    });
});

$(function(){
    $("#new_person_submit").live('click', function(){

        if($('#person_emails_attributes_2_value').val()!="" ||  $('#person_websites_attributes_3_value').val()!="")
        {
            _valid = /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-z]{2,})$/.test($('#person_emails_attributes_2_value').val());
            if($('#person_emails_attributes_2_value').val()!=""){
                if((!_valid)){
                    var link = $(this);

                    $('#error_message_text').html("Invalid Email Address");


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

                                $(this).dialog('destroy');
                                return false;
                            }
                        }
                    });
                    $('#error_message').dialog('option', 'title', 'Error');
                    $('#error_message').parent().find("a").css("display","none");
                    $("#error_message").parent().css('background-color','#D1DDE6');
                    $("#error_message").css('background-color','#D1DDE6');
                    $('#error_message').dialog('open');
                    return false;
                }

            }
            var valid_temp;
            _valid1 = /^((https|http|ftp|rtsp|mms)?:\/\/)(([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\.[a-z]{2,6})(:[0-9]{1,4})?((\/?)|(\/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+\/?)$/.test($("#person_websites_attributes_3_value").val());
            _valid2 = /^(([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\.[a-z]{2,6})(:[0-9]{1,4})?((\/?)|(\/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+\/?)$/.test($("#person_websites_attributes_3_value").val());
            // _valid1 = /^(http|https|ftp):\/\/[\w-]+[\.\w-]*\.[\w-]+(\/[^\s]*)?$/.test($("#person_websites_attributes_3_value").val());
            if (_valid1==true || _valid2 ==true)
            {
                valid_temp = true;
            }
            if($('#person_websites_attributes_3_value').val()!="" && $('#person_websites_attributes_3_value').val()!="http://"  ){
                if((!valid_temp)){
                    var link1 = $(this);

                    $('#error_message_text').html("Invalid Website Address");


                    $('#error_message_image').css("display","");
                    $('#error_message').dialog({
                        modal: true,
                        resizable: false,
                        draggable: true,
                        height: 'auto',
                        width: 'auto',
                        buttons: {
                            "OK": function(){
                                link1.focus();

                                $(this).dialog('destroy');
                                return false;
                            }
                        }
                    });
                    $('#error_message').dialog('option', 'title', 'Error');
                    $('#error_message').parent().find("a").css("display","none");
                    $("#error_message").parent().css('background-color','#D1DDE6');
                    $("#error_message").css('background-color','#D1DDE6');
                    $('#error_message').dialog('open');
                    return false;
                }

            }


        }
        return true;
    });
});


/* Show list*/
$(function(){
    $("#show_all_list_member").live('click',function(){
        var link= $(this);

        right_tab = $("#content #right_content").find("#tabs");
        //         alert(right_tab.length);
        if(right_tab.length > 0)
        {
            check_input_change();
        }


        left_content = $("#content").find("#left_content");
        right_content = $("#content").find("#right_content");
        //     alert( left_content.length);
        //     alert( right_content.length);
        if (left_content.length > 0 &&  right_content.length > 0)
        {
            //          $('#check_input_change').val("true");
            //          alert( $('#check_input_change').val());

            if ( $('#check_right_input_change').val() == "true" || $('#check_left_input_change').val() == "true" )
            {

                $('#check_input_change').val("true");
            }
            else
            {

                $('#check_input_change').val("false");
            }
        }
        var link = $(this);
        if($('#check_input_change').val() == "false")
        {
            $.ajax({
                type: "GET",
                url: "/people/show_list.js",
                data: 'person_id='+link.attr('person_id')+'&current_operation='+link.attr('current_operation')+'&active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.person_edit_tab.active').attr('field'),
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
                            url: "/people/show_list.js",
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


$(function(){
    $("#people_search_grid").flexigrid({
        url: '/grids/people_search_grid',
        dataType: 'json',
        colModel : [
        {
            display: 'ID',
            name : 'grid_object_id',
            width : 40,
            sortable : true,
            align: 'left'
        },

        {
            display: 'First Name',
            name : 'field_1',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Family Name',
            name : 'field_2',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Address',
            name : 'field_3',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Phone',
            name : 'field_4',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Email',
            name : 'field_5',
            width : 180,
            sortable : true,
            align: 'left'
        }
        ],
        searchitems : [
        {
            display: 'First Name',
            name : 'field_1'
        },

        {
            display: 'Family Name',
            name : 'field_2'
        },

        {
            display: 'Address',
            name : 'field_3'
        },

        {
            display: 'Phone',
            name : 'field_4'
        },

        {
            display: 'Email',
            name : 'field_5'
        }
        ],
        sortname: "grid_object_id",
        sortorder: "asc",
        usepager: true,
        title: 'People Search Result',
        useRp: true,
        rp: 20,
        showTableToggleBtn: false,
        width: 'auto',
        height: 'auto'
    });
});

$(function(){
    $('table#people_search_grid tbody tr').live('click',function(){
        $('table#people_search_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
        $.ajax({
            type: 'GET',
            url: "/people/"+$(this).attr('id').substring(3)+"/name_card.js",
            dataType: "script"
        });
    });
});

$(function(){
    $('table#people_search_grid tbody tr').live('dblclick',function(){
    {
        window.open("/people/"+$(this).attr("id").substring(3)+"/edit","_self");
    }
    });
});

$(function(){
    $('table#people_search_grid tbody tr').live('mouseover', function(){
        $(this).css('cursor',"pointer");
    });
});


/* person check dup feild*/

$(function(){
    $('.personal_check_field').blur(function(){

        var personal_check_fields=[];
        var personal_data_string ="";

        for(var k=0; k < $('.personal_check_field').get().length;k++)
        {
            if($('.personal_check_field').eq(k).attr("id").indexOf("_id")>0)
            {

                personal_check_fields.push($('.personal_check_field').eq(k).attr("id").substring(7,$('.personal_check_field').eq(k).attr("id").indexOf("_id")));
                personal_check_fields.push($('.personal_check_field').eq(k).val());
            }
            else
            {
                personal_check_fields.push($('.personal_check_field').eq(k).attr("id").substring(7));
                personal_check_fields.push($('.personal_check_field').eq(k).val());
            }
        }

        for (var z=0; z< personal_check_fields.length;z++)
        {

            if(z > 0)
            {
                personal_data_string += "&"

            }
            personal_data_string += personal_check_fields[z++] + "=" + personal_check_fields[z];
        }

        $.ajax({
            type: 'GET',
            url: "/people/check_duplication.js",
            data: personal_data_string + "&id="+$("#person_id").val(),
            dataType: "script"

        });
    });
});

$(function(){
    $('table#person_check_field tbody tr').live('click',function(){
        $('table#person_check_field tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
    });
});
$(function(){
    $('table#person_check_field tbody tr').live('mouseover',function(){
        $(this).css('cursor',"pointer");
    });
});
/*personal check field restart button*/
personal_check_duplication_restart_button = function(){


    //alert($('#system_id_tag').val());
    if($('#system_id_tag').val() != null)
    {
        window.open("/people/"+ $('#system_id_tag').val()+"/edit", "_self");
    }
    else
    {
        window.open("/people/new", "_self");
    }
    return false;
};

$(function(){
    $('table#person_check_field tbody tr.trSelected').live('dblclick',function(){

        window.open("/people/"+$(this).attr("id").substring(3)+"/edit","_self");
    });
});


//person eidt tabs image change
$(function(){
    $(".person_edit_tab:not(.active)").live("mouseover", function(){
        $(this).find("img").attr("src","/images/Icons/Core/Person/tabs/"+$(this).attr("field")+".png");
    });

    $(".person_edit_tab:not(.active)").live("mouseout", function(){
        $(this).find("img").attr("src","/images/Icons/Core/Person/tabs/"+$(this).attr("field")+"_BW.png");
    });
});

/*Keyword double click*/

$(function(){
    $("#add_person_keywords").live('dblclick', function(){

        $.ajax({
            type: "POST",
            url: "/keyword_links/add_key.js",
            data: 'person_id=' + $('#person_id').val()+"&add_person_keywords="+$(this).val(),
            dataType: "script"
        });
    });
});

$(function(){
    $("#remove_person_keywords").live('dblclick', function(){

        $.ajax({
            type: "POST",
            url: "/keyword_links/remove_key.js",
            data: 'person_id=' + $('#person_id').val()+"&remove_person_keywords="+$(this).val(),
            dataType: "script"
        });
    });
});

/*find keyword*/
$(function(){
    $('.keywordtype_change').live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url: "/keywords/keyword_name_show.js",
                data:'keyword_type_id='+$(this).val(),
                dataType: "script"
            });
        }else{
            $("#keyword_id").html(" ");
            $("#person_find_keyword_des").html(" ");
        }
    });
});

$(function(){
    $('#keyword_id').live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url: "/keywords/keyword_des_show.js",
                data:'id='+$(this).val(),
                dataType: "script"
            });
        }else{
            $("#person_find_keyword_des").html(" ");
        }
    });
});



/*Person*/

/*Organisation*/
$(function(){
    $("#tabs2").tabs();
});


/*organisation keyword*/
showOrganisationKeyword = function(){
    $("#add_organisation_keywords option:selected").removeAttr("selected");
    $("#add_organisation_keywords").find("option").hide();
    $("#keyword_organisation_types").find("option:selected").each(function(){
        if($(this).val() == ""){
            $("#add_organisation_keywords").find("option").show();
        }else{
            $("#add_organisation_keywords option[class=" + $(this).text() + "]").show();
        }
    });
};

showOrganisationTooltip = function(){
    $("#add_organisation_keywords option ,#remove_organisation_keywords option").each(function(){
        $(this).qtip({
            content: $(this).attr('remark'),
            position: {
                corner: {
                    target: 'leftMiddle',
                    tooltip: 'rightMiddle'
                }
            },
            style : {
                tip: true
            }
        });
    });
};

$("#keyword_organisation_types").live("change", showOrganisationKeyword);

/* Employment Tab*/

$(function(){
    $(".find_organisation_field").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url:
                "/organisations/name_finder.js",
                data:
                'organisation_id='+$(this).val()+'&employment_id='+$(this).attr('employment_id')+'&object_id='+$(this).attr('object_id'),
                dataType: "script"
            });
        }else{
            $("#organisation_name_container_"+$(this).attr('employment_id')).html(" ");
        }
    });
});


$(function(){
    $("#show_other_group_members_organisations").live('click',function(){
        $.ajax({
            type: "GET",
            url: "/organisations/"+$(this).attr('organisation_id')+"/organisation_groups/show_group_members.js",
            data: 'organisation_group_id='+$(this).attr('organisation_group_id'),
            dataType: "script"

        });
    });
});

$(function(){
    $("#new_organisation_submit").live('click', function(){


        if($('#organisation_emails_attributes_2_value').val()!="" ||  $('#organisation_websites_attributes_3_value').val()!="")
        {
            _valid = /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-z]{2,})$/.test($('#organisation_emails_attributes_2_value').val());
            if($('#organisation_emails_attributes_2_value').val()!=""){
                if((!_valid)){
                    var link = $(this);

                    $('#error_message_text').html("Invalid Email Address");

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

                                $(this).dialog('destroy');
                                return false;
                            }
                        }
                    });
                    $('#error_message').dialog('option', 'title', 'Error');
                    $('#error_message').parent().find("a").css("display","none");
                    $("#error_message").parent().css('background-color','#D1DDE6');
                    $("#error_message").css('background-color','#D1DDE6');
                    $('#error_message').dialog('open');
                    return false;
                }
            }

            var valid_temp_organisation;

            _valid1 = /(https|http|ftp|rtsp|mms)?:\/\/?(([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\.[a-z]{2,6})(:[0-9]{1,4})?((\/?)|(\/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+\/?)$/.test($("#organisation_websites_attributes_3_value").val());
            _valid2 = /(([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\.[a-z]{2,6})(:[0-9]{1,4})?((\/?)|(\/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+\/?)$/.test($("#organisation_websites_attributes_3_value").val());
            if (_valid1==true || _valid2 ==true)
            {
                valid_temp_organisation = true;
            }
            if($('#organisation_websites_attributes_3_value').val()!=""&& $('#organisation_websites_attributes_3_value').val()!="http://" ){
                if((!valid_temp_organisation)){
                    var link1 = $(this);

                    $('#error_message_text').html("Invalid Website Address");

                    $('#error_message_image').css("display","");
                    $('#error_message').dialog({
                        modal: true,
                        resizable: false,
                        draggable: true,
                        height: 'auto',
                        width: 'auto',
                        buttons: {
                            "OK": function(){
                                link1.focus();

                                $(this).dialog('destroy');
                                return false;
                            }
                        }
                    });
                    $('#error_message').dialog('option', 'title', 'Error');
                    $('#error_message').parent().find("a").css("display","none");
                    $("#error_message").parent().css('background-color','#D1DDE6');
                    $("#error_message").css('background-color','#D1DDE6');
                    $('#error_message').dialog('open');
                    return false;
                }
            }

        }
        return true;
    });
});


/*Organisation-part*/


$(function(){

    $(".industry_sector_change").live('change', function(){

        if ($(this).val()!= ""){
            $.ajax({
                type:"GET",
                url: "/organisations/show_industrial_code.js",
                data:"industrial_id="+$(this).val(),
                dataType:"script"

            });

        }else{

            $('#organisation_industrial_code').val('');
        }

    });
});

$(function(){

    $(".business_category_change").live('change', function(){

        if ($(this).val()!= ""){
            $.ajax({
                type:"GET",
                url: "/organisations/show_sub_category.js",
                data:"sub_category_id="+$(this).val(),
                dataType:"script"

            });

        }else{

            $('#organisation_business_sub_category').val('');
        }
    });
});

$(function(){
    $("#show_all_organisations").live('click',function(){

        var link= $(this);

        right_tab = $("#content #right_content").find("#tabs");
        //         alert(right_tab.length);
        if(right_tab.length > 0)
        {
            check_input_change();
        }


        left_content = $("#content").find("#left_content");
        right_content = $("#content").find("#right_content");
        //     alert( left_content.length);
        //     alert( right_content.length);
        if (left_content.length > 0 &&  right_content.length > 0)
        {
            //          $('#check_input_change').val("true");
            //          alert( $('#check_input_change').val());

            if ( $('#check_right_input_change').val() == "true" || $('#check_left_input_change').val() == "true" )
            {

                $('#check_input_change').val("true");
            }
            else
            {

                $('#check_input_change').val("false");
            }
        }
        var link = $(this);
        if($('#check_input_change').val() == "false")
        {

            $.ajax({
                type: "GET",
                url: "/organisations/show_list.js",
                data: 'organisation_id='+link.attr('organisation_id')+'&current_operation='+link.attr('current_operation')+'&active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.organisation_edit_tab.active').attr('field'),
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
                            url: "/organisations/show_list.js",
                            data: 'organisation_id='+link.attr('organisation_id')+'&current_operation='+link.attr('current_operation')+'&active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.organisation_edit_tab.active').attr('field'),
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
    $("#show_all_organisations").live('mouseover',function(){

        $(this).css("cursor","pointer");
    });
});


/*Organisation Grid*/

$(function(){
    $('table#search_organisations_list_results tbody tr').live('dblclick',function(){
        if ($('table#search_organisations_list_results').attr('current_operation') == "edit_organisation_list")
        {
            window.open("/organisations/"+$(this).attr("id").substring(3)+"/edit","_self");
        }
        if ($('table#search_organisations_list_results').attr('current_operation') == "show_organisation_list")
        {
            window.open("/organisations/"+$(this).attr("id").substring(3)+"/","_self");
        }

    });
});


$(function(){
    $('table#search_organisations_list_results tbody tr').live('click',function(){
        $.ajax({
            type: 'GET',
            url: "/organisations/show_left.js",
            data: 'organisation_id='+$(this).attr('id').substring(3)+'&current_operation='+ $('#search_organisations_list_results').attr('current_operation')+'&active_tab='+$('#search_organisations_list_results').attr('active_tab')+'&active_sub_tab='+$('#search_organisations_list_results').attr('active_sub_tab'),
            dataType: "script"
        });
        $('table#search_organisations_list_results tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass("trSelected");
    });
});

$(function(){
    $('table#search_organisations_list_results tbody tr').live('mouseover', function(){
        $(this).css('cursor',"pointer");
    });
});

$(function(){
    $("#organisation_search_grid").flexigrid({
        url: '/grids/organisation_search_grid',
        dataType: 'json',
        colModel : [
        {
            display: 'ID',
            name : 'grid_object_id',
            width : 40,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Trading As',
            name : 'field_1',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Registered Name',
            name : 'field_2',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Address',
            name : 'field_3',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Phone',
            name : 'field_4',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Website',
            name : 'field_5',
            width : 180,
            sortable : true,
            align: 'left'
        }
        ],
        searchitems : [
        {
            display: 'Trading As',
            name : 'field_1'
        },

        {
            display: 'Registered Name',
            name : 'field_2'
        },

        {
            display: 'Address',
            name : 'field_3'
        },

        {
            display: 'Phone',
            name : 'field_4'
        },

        {
            display: 'Website',
            name : 'field_5'
        }
        ],
        sortname: "grid_object_id",
        sortorder: "asc",
        usepager: true,
        title: 'Organisation Search Result',
        useRp: true,
        rp: 20,
        showTableToggleBtn: false,
        width: 'auto',
        height: 'auto'
    });
});

$(function(){
    $('table#organisation_search_grid tbody tr').live('click',function(){
        $('table#organisation_search_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
        $.ajax({
            type: 'GET',
            url: "/organisations/"+$(this).attr('id').substring(3)+"/name_card.js",
            dataType: "script"
        });
    });
});

$(function(){
    $('table#organisation_search_grid tbody tr').live('dblclick',function(){
    {
        window.open("/organisations/"+$(this).attr("id").substring(3)+"/edit","_self");
    }
    });
});

$(function(){
    $('table#organisation_search_grid tbody tr').live('mouseover',function(){
        $(this).css('cursor',"pointer");
    });
});


/*Organisational Duplication Check*/
$(function(){
    $('.organisational_check_field').blur(function(){
        var check_fields = [];
        var data_string = "";
        for (var i = 0; i < $('.organisational_check_field').get().length; i++){
            if($('.organisational_check_field').eq(i).attr("id").indexOf("_id")>0){
                check_fields.push($('.organisational_check_field').eq(i).attr("id").substring(13, $('.organisational_check_field').eq(i).attr("id").indexOf("_id")));
                check_fields.push($('.organisational_check_field').eq(i).val());
            }else{
                check_fields.push($('.organisational_check_field').eq(i).attr("id").substring(13));
                check_fields.push($('.organisational_check_field').eq(i).val());
            }
        }
        for (var j = 0; j < check_fields.length; j++){
            if (j >0){
                data_string += "&";
            }
            data_string += check_fields[j++] + "=" + check_fields[j];
        }
        $.ajax({
            type: 'GET',
            url: "/organisations/check_duplication.js",
            data: data_string + "&id=" + $("#organisation_id").val(),
            dataType: "script"
        });
    });
});

$(function(){
    $('table#duplication_organisations_grid tbody tr').live('click',function(){
        $('table#duplication_organisations_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
    });
});

$(function(){
    $('table#duplication_organisations_grid tbody tr').live('dblclick',function(){
        window.open("/organisations/"+ $(this).attr('id').substring(3) +"/edit", "_self");
    });
});
$(function(){
    $('table#duplication_organisations_grid tbody tr').live('mouseover',function(){
        $(this).css('cursor',"pointer");
    });
});

/*organisation info tab*/
$(function(){
    $('.active_organisation_info_tab').live('click',function(){
        $('.organisation_info_tab').removeClass('hidden_tab');
        $("#"+$(this).attr("hidden_id_name")).addClass('hidden_tab');
        $(".container_icon").removeClass("container_icon_color");
        $(this).parent().addClass("container_icon_color");
    });
});

//organisatiomn eidt tabs image change
$(function(){
    $(".organisation_edit_tab:not(.active)").live("mouseover", function(){
        $(this).find("img").attr("src","/images/Icons/Core/Org/tabs/"+$(this).attr("field")+".png");
    });

    $(".organisation_edit_tab:not(.active)").live("mouseout", function(){
        $(this).find("img").attr("src","/images/Icons/Core/Org/tabs/"+$(this).attr("field")+"_BW.png");
    });

//    $(".organisation_edit_tab:not(.active)").live("mouseup", function(){
//        $(".organisation_edit_tab.active").find("img").attr("src", "/images/Icons/Core/Org/tabs/"+$(".organisation_edit_tab.active").attr("field")+"_BW.png");
//        $(".organisation_edit_tab").removeClass("active");
//        $(this).addClass("active");
//        $(this).find("img").attr("src","/images/Icons/Core/Org/tabs/"+$(this).attr("field")+"_title.png");
//    });
});

$(function(){
    $("#add_organisation_keywords").live('dblclick', function(){

        $.ajax({
            type: "POST",
            url: "/keyword_links/add_key.js",
            data: 'organisation_id=' + $('#organisation_id').val()+"&add_organisation_keywords="+$(this).val(),
            dataType: "script"
        });
    });
});

$(function(){
    $("#remove_organisation_keywords").live('dblclick', function(){

        $.ajax({
            type: "POST",
            url: "/keyword_links/remove_key.js",
            data: 'organisation_id=' + $('#organisation_id').val()+"&remove_organisation_keywords="+$(this).val(),
            dataType: "script"
        });
    });
});
/* check oganisation level before submit*/

$(function(){
    $("#organisation_edit_level").live('change', function(){

        $.ajax({
            type: "GET",
            url: "/organisations/check_level_change.js",
            data: 'organisation_id=' + $('#organisation_id').val()+"&organisation_level="+$(this).val(),
            dataType: "script"
        });
    });
});

/*Organisation*/

/*Query*/

/* Admin List Management - Query*/

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

$(function(){
    $("#fields_criteria").live('change', function(){
        $(".descriptions_criteria").css("display", "none");
        $("#description_criteria_"+$(this).val()).css("display", "");
        if ($(this).val()!=null && $(this).val().indexOf("date") > 0){
            if ($(this).val() == "birth_date"){
                $("#query_criteria_value").datepicker({
                    dateFormat: 'dd-mm-yy',
                    altFormat: 'mm-dd-yy',
                    changeMonth: true,
                    changeYear: true,
                    maxDate: '+0d',
                    yearRange: '-150:+0'
                });
            }else{
                $("#query_criteria_value").datepicker({
                    dateFormat: 'dd-mm-yy',
                    altFormat: 'mm-dd-yy',
                    changeMonth: true,
                    changeYear: true
                });
            }
        }else{
            $("#query_criteria_value").datepicker('destroy');
        }
    });
});

$(function(){
    $("#fields_selection").live('change', function(){
        $(".descriptions_selection").css("display", "none");
        $("#description_selection_"+$(this).val()).css("display", "");
    });
});

$(function(){
    $("#fields_sorter").live('change', function(){
        $(".descriptions_sorter").css("display", "none");
        $("#description_sorter_"+$(this).val()).css("display", "");
    });
});

$(function(){
    $("#show_new_query").live('click', function(){
        $(this).css("display", "none");
        $.ajax({
            type: "GET",
            url: "/query_headers/new.js",
            dataType: "script"
        });
    });
});

$(function(){
    $("#close_new_query").live('click', function(){
        $(this).css("display", "none");
        $("#current_action").val("");
        $('#new_query_form').html('');
        $('#new_query_list').html('');
        $('#new_selection_form').html('');
        $('#new_selection_list').html('');
        $('#new_sorter_form').html('');
        $('#new_sorter_list').html('');
        $('#save_form').html('');
        $('#new_form').css("display", "none");
        $("#show_new_query").css("display", "");
        $("#existing_query").css("display", "");
    });
});

$(function(){
    $("#save_button").live('click', function(){
        if($(this).attr("action")=="new"){
            $('#save_form').toggle('blind');
            $('#save_form').dialog( {
                modal: true,
                resizable: true,
                draggable: true
            });
            $('#save_form').dialog('option', 'title', 'New Query');
            $('#save_form').dialog('open');
            $("#save_form").parent().css('background-color','#D1DDE6');
            $("#save_form").css('background-color','#D1DDE6');
        }else{
            $('#edit_query_header').doAjaxSubmit();
        }
    });
});


$(function(){
    $("#run_button").live('click', function(){
        var temp = "";
        temp += 'id=' + $("#query_header_id").val();
        if($("#query_top_number").attr("checked")==true){
            temp += "&top=number&top_number=" + $("#query_top_value").val();
        }else{
            temp += "&top=percent&top_percent=" + $("#query_top_value").val();
        }
        $.ajax({
            type: "GET",
            url: "/query_headers/check_runtime.js",
            data: temp,
            dataType: "script"
        });
    });
});

$(function(){
    $("#run_button_edit").live('click', function(){
        var temp = "";
        temp += 'id=' + $("#query_header_id").val();
        if($("#query_top_number").attr("checked")==true){
            temp += "&top=number&top_number=" + $("#query_top_value").val();
        }else{
            temp += "&top=percent&top_percent=" + $("#query_top_value").val();
        }
        $.ajax({
            type: "GET",
            url: "/query_headers/check_runtime.js",
            data: temp,
            dataType: "script"
        });
    });
});

$(function(){
    $("#clear_button").live('click', function(){

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
                    $('#query_top_value').val("").change();
                    $('#check_input_change').val("false");
                    $('#check_left_input_change').val("false");
                    $('#check_right_input_change').val("false");
                    //make save_button & run_button to disabled
                    $("#save_button").attr("disabled", true);
                    $("#run_button").attr("disabled", true);
                    $.ajax({
                        type: "GET",
                        url: "/query_headers/clear.js",
                        data:'id=' + $("#query_header_id").val(),
                        dataType: "script"
                    });

                    $(this).dialog('destroy');

                    return true;
                }
            }

        });
        $('#warning_message_text').html("Are You Sure You Wish to Clear ?  ");
        $('#warning_message').dialog('option', 'title', 'Warning');

        $('#warning_message').parent().find("a").css("display","none");
        $("#warning_message").parent().css('background-color','#D1DDE6');
        $("#warning_message").css('background-color','#D1DDE6');
        //      $("#warning_message").closest("ui-dialog-titlebar").css('background','#97B6CE');

        $('#warning_message').dialog('open');



    });
});

$(function(){
    $("#new_runtime").live('click', function(){
        if ($("#query_criteria_value").attr("readonly")==false){
            $("#query_criteria_value").val("?");
            $("#query_criteria_value").attr("readonly", true);
        }else{
            $("#query_criteria_value").val("");
            $("#query_criteria_value").attr("readonly", false);
        }
    });
});

$(function(){
    $("#show_sql_statements").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/query_headers/show_sql_statement.js",
            data:'id=' + $("#query_header_id").val(),
            dataType: "script"
        });
    });
});

$(function(){
    $('a.get_query').live('click', function() {
        container = $(this).parent().parent().parent();
        $("#current_action").val("edit");
        $(".highlight").removeClass("highlight");

        container.addClass("highlight");
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    jQuery('a.get_query').removeAttr('onclick');
});

$(function(){
    $("#close_edit_query").live('click', function(){
        var link = $(this);
        if($('#check_input_change').val()=="true")
        {
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


                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('.close_option[field='+ link.attr('field') +']').css("display","none");
                        
                        $("#new_query").css('display','');
                        $(".highlight").removeClass("highlight");
                        link.css("display", "none");
                        $("#edit_query").css("display", "none");
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        $('#edit_query_form').html('');
                        $('#edit_query_list').html('');
                        $('#edit_selection_form').html('');
                        $('#edit_selection_list').html('');
                        $('#edit_sorter_form').html('');
                        $('#edit_sorter_list').html('');
                        $('#check_input_change').val('false');

                        $(this).dialog('destroy');
                        return true;
                    }
                }

            });
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
            $('#warning_message').dialog('option', 'title', 'Warning');

            $('#warning_message').parent().find("a").css("display","none");
            $("#warning_message").parent().css('background-color','#D1DDE6');
            $("#warning_message").css('background-color','#D1DDE6');
            //      $("#warning_message").closest("ui-dialog-titlebar").css('background','#97B6CE');

            $('#warning_message').dialog('open');
            return false;





        }
        else
        {

            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $('.close_option[field='+ link.attr('field') +']').css("display","none");



            $("#new_query").css('display','');
            $(".highlight").removeClass("highlight");
            $(this).css("display", "none");
            $("#edit_query").css("display", "none");
            $('#edit_query_form').html('');
            $('#edit_query_list').html('');
            $('#edit_selection_form').html('');
            $('#edit_selection_list').html('');
            $('#edit_sorter_form').html('');
            $('#edit_sorter_list').html('');

        }
    });
});

$(function(){
    $("#query_top_number").live('click', function(){
        $("#query_top_value").val('');
        $("#query_top_value.precent_field").removeClass("precent_field").addClass("integer_field");
    });
    $("#query_top_percent").live('click', function(){
        $("#query_top_value").val('');
        $("#query_top_value.integer_field").removeClass("integer_field").addClass("precent_field");
    });
});

$(function(){
    $("#query_edit_top_number").click(function(){
        $("#query_edit_top_percent_value").val('');
        $("#query_edit_top_percent_value").attr("disabled",true);
        $("#query_edit_top_number_value").attr("disabled",false);
    });
    $("#query_edit_top_percent").click(function(){
        $("#query_edit_top_number_value").val('');
        $("#query_edit_top_number_value").attr("disabled",true);
        $("#query_edit_top_percent_value").attr("disabled",false);
    });
});


$(function(){
    $('table#query_result_grid tbody tr').live('click',function(){
        $('table#query_result_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
    });
});

$(function(){
    $('table#query_result_grid tbody tr').live('mouseover', function(){
        $(this).css('cursor',"pointer");
    });
});

/*Query*/

/*List of list*/
/*List Header of Person*/

$(function(){
    $("#list_header_name").live('change',function(){
        $("#person_list_edit").submit();
    });
});

$(function(){
    $("#list_header_name2").live('change',function(){
        $("#person_list").submit();
    });
});

$(function(){
    $("#org_lists_name").live('change', function(){
        $("#organisation_list").submit();
    });
});

/*Admin List Management - List Manager*/
$(function(){
    $('a.get_list').live('click', function() {
        container = $(this).parent().parent().parent();
        $(".highlight").removeClass("highlight");
        container.addClass("highlight");
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");
    jQuery('a.get_list').removeAttr('onclick');
});


$(function(){
    $('#show_list_compiler').live('click', function(){
        $(this).css("display","none");
        $("#close_list_compiler").css("display", "");
        $("#list_compiler_form").css("display","");
        $("#existing_list").css("display","none");
        $("#clear_compile_list").click();
        $.ajax({
            type: "GET",
            url: "/list_headers",
            dataType: "script"
        });
    });
});

$(function(){
    $('#close_list_compiler').live('click', function(){
        $(this).css("display","none");
        $("#show_list_compiler").css("display", "");
        $("#existing_list").css("display","");
        $("#list_compiler_form").css("display","none");
        $("#clear_compile_list").click();
    });
});

$(function(){
    $("#add_to_include").live('click', function(){
        if($("#compiler_options").val() != null){
            $.ajax({
                type: "POST",
                url: "/include_lists",
                data:'list_header_id=' + $("#compiler_options").val() + '&login_account_id=' + $("#login_account_id").val()+'&type=person',
                dataType: "script"
            });

        }
    });
});



$(function(){
    $("#add_to_exclude").live('click', function(){
        if($("#compiler_options").val() != null){
            $.ajax({
                type: "POST",
                url: "/exclude_lists",
                data:'list_header_id=' + $("#compiler_options").val() + '&login_account_id=' + $("#login_account_id").val()+'&type=person',
                dataType: "script"
            });
        }
    });
});


$(function(){
    $("#org_add_to_include").live('click', function(){
        if($("#compiler_options").val() != null){
            $.ajax({
                type: "POST",
                url: "/include_lists",
                data:'list_header_id=' + $("#compiler_options").val() + '&login_account_id=' + $("#login_account_id").val()+'&type=org',
                dataType: "script"
            });

        }
    });
});



$(function(){
    $("#org_add_to_exclude").live('click', function(){
        if($("#compiler_options").val() != null){
            $.ajax({
                type: "POST",
                url: "/exclude_lists",
                data:'list_header_id=' + $("#compiler_options").val() + '&login_account_id=' + $("#login_account_id").val()+'&type=org',
                dataType: "script"
            });
        }
    });
});


$(function(){
    $("#clear_compile_list").live('click', function(){

        $('#top_value').val("").change();
        $('#check_input_change').val("false");
        $('#check_left_input_change').val("false");
        $('#check_right_input_change').val("false");
        $('#compile_button').attr('disabled',true);
        $.ajax({
            type: "POST",
            url: "/compile_lists/clear.js",
            data: "login_account_id=" + $("#login_account_id").val(),
            dataType: "script"
        });
    });
});

$(function(){
    $("#compile_button").live('click', function(){
        var temp = "";
        temp += "login_account_id=" + $("#login_account_id").val();
        temp += "&allow_duplication=" + $("#allow_duplication").attr("checked");
        if($("#top_number").attr("checked")==true){
            temp += "&top=number&top_number=" + $("#top_value").val();
        }else{
            temp += "&top=percent&top_percent=" + $("#top_value").val();
        }

        $.ajax({
            type: "POST",
            url: "/compile_lists/compile.js",
            data: temp,
            dataType: "script"
        });
    });
});

$(function(){
    $("#org_compile_button").live('click', function(){
        var temp = "";
        temp += "login_account_id=" + $("#login_account_id").val();
        temp += "&allow_duplication=" + $("#allow_duplication").attr("checked");
        if($("#top_number").attr("checked")==true){
            temp += "&top=number&top_number=" + $("#top_value").val();
        }else{
            temp += "&top=percent&top_percent=" + $("#top_value").val();
        }

        $.ajax({
            type: "POST",
            url: "/compile_lists/org_compile.js",
            data: temp,
            dataType: "script"
        });
    });
});


$(function(){
    $("#top_number").click(function(){
        $("#top_value").val('');
        $("#top_value.precent_field").removeClass("precent_field").addClass("integer_field");
    });
    $("#top_percent").click(function(){
        $("#top_value").val('');
        $("#top_value.integer_field").removeClass("integer_field").addClass("precent_field");
    });
});

/*List of list*/

/*Report*/

/* Import and Export */
$(function(){
    $('.export_button').live('click',function(){

        var source_id = ""
        var file_name = ""
        var source = $(this).attr("source");
        if (source == 'person'){
            source_id = $('#source_id').val();
            file_name = $("#file_name").val();
        }else{
            source_id = $('#org_source_id').val();
            file_name = $("#org_file_name").val();
        }

        if (source_id != "")
        {
            var format = $(this).attr("value").toLowerCase();            
            window.open("/data_managers/export."+format+"?source="+source+"&source_id="+source_id+"&file_name="+file_name);
        }

    });
});

/*Report*/

/*Import Outport*/

/* Reporting*/
$(function(){
    $('#report_person_pdf_submit_button').live('click', function(){

        window.open("/reports/generate_person_report_pdf?request_format="+$('#report_requested_format').val()+"&list_header_id="+$('#report_list').val());
    });

});

$(function(){
    $('#report_organisation_pdf_submit_button').live('click', function(){

        window.open("/reports/generate_organisation_report_pdf?request_format="+$('#report_requested_format').val()+"&list_header_id="+$('#organisation_report_list').val());
    });

});
/*Import Outport*/


/* Message Template Grid*/
$(function(){
    $('table#show_message_templates_grid tbody tr').live('click',function(){
        if($('#message_template_mode').attr('mode')=="show"){
            $('table#show_message_templates_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_message_templates_grid tbody tr').live('dblclick',function(){
        if($('#message_template_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/communication/edit_message_template/"+$(this).attr('id').substring(3),
                dataType: "script"
            });
        }
    });

    $('table#show_message_templates_grid tbody tr').live('mouseover',function(){
        if($('#message_template_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });
});


/*For mail variable use*/
$(function(){
    $(".insert_word").live('click', function(){
        insert_name_in_email($(this));

    });
});

insert_name_in_email = function(this_form){
    var current_form = this_form.closest('form').attr('id');
    //var value = $("#select_word").val();
    var value = "#"+$("#"+current_form).find(".select_word").val()+"#"

    window.tinyMCE.execCommand('mceInsertContent', false, value);
};
/*For General mail merge use*/
$(function(){
    $(".mail_merge_insert_word").live('click', function(){
        mail_merge_insert_name($(this));

    });
});

//mail_merge_insert_name = function(this_form){
//    var current_form = this_form.closest('form').attr('id');
//    var table = $("#"+current_form).find(".select_table_word").val();
//    var field = $("#"+current_form).find(".select_field_word").val();
//    var data_type = $("#"+current_form).find(".data_type").val();
//    if (table == "people"){
//        if(data_type == "Integer FK"){
//
//            var value = "<%=@"+table+"."+field+".try(:name)"+"%>";
//
//
//        }else{
//
//            var value = "<%=@"+table+"."+field+"%>";
//
//        }
//
//    }else{
//
//         if(data_type == "Integer FK"){
//
//          if(field == "country"){
//
//                var value = "<%=@people."+table+".first.try(:"+field+")"+".try(:short_name)"+"%>";
//
//
//          }else{
//
//               var value = "<%=@people."+table+".first.try(:"+field+")"+".try(:name)"+"%>";
//
//          }
//
//
//        }else{
//
//            var value = "<%=@people."+table+".first.try(:"+field+")"+"%>";
//
//        }
//
//    }
//
//
//    //var value = $("#select_word").val();
//
//
//    window.tinyMCE.execCommand('mceInsertContent', false, value);
//};


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





mail_merge_insert_name = function(this_form){
    var current_form = this_form.closest('form').attr('id');
    var prefix_table_name = $("#"+current_form).find("#prefix_table_name").val();
    var table = $("#"+current_form).find(".select_table_word").val();
    var field = $("#"+current_form).find(".select_field_word").val();
    var data_type = $("#"+current_form).find(".data_type").val();
    if (table == "people" || table == "organisations"){
        if(data_type == "Integer FK"){

            var value = "<%=@"+table+"."+field+".try(:name)"+"%>";


        }else{

            var value = "<%=@"+table+"."+field+"%>";

        }

    }else{

         if(data_type == "Integer FK"){

          if(field == "country"){

                var value = "<%="+prefix_table_name+table+".first.try(:"+field+")"+".try(:short_name)"+"%>";


          }else{

               var value = "<%="+prefix_table_name+table+".first.try(:"+field+")"+".try(:name)"+"%>";

          }


        }else{

            var value = "<%="+prefix_table_name +table+".first.try(:"+field+")"+"%>";

        }

    }


    //var value = $("#select_word").val();


    window.tinyMCE.execCommand('mceInsertContent', false, value);
};

