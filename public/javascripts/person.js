$(function() {
	
    /*
	  Objects withe class toggle_button will 
	  toggle the DOM object associated with it
	  via an attribute toggle_id_name
     */
    $(".toggle_button").live('click', function(){
        $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    });



    $(".toggle_button1").click(function(){
        $('#'+$(this).attr('toggle_id_name1')).toggle('blind');
        $('#'+$(this).attr('toggle_id_name2')).toggle('blind');
        
    });

    $(".toggle_button2").click(function(){
        $('#'+$(this).attr('toggle_id_name')).css("display","");
        $('#'+$(this).attr('toggle_id_name1')).css("display","none");
        $('#'+$(this).attr('toggle_id_name2')).css("display","none");

    });

    $(".close_image").live('click', function(){
        $(this).children('img').attr('src', '/images/open_accordion.png');
        $(this).removeClass('close_image');
        $(this).addClass('open_image');
    });

    $(".open_image").live('click', function(){
        $(this).children('img').attr('src', '/images/closed_accordion.png');
        $(this).removeClass('open_image');
        $(this).addClass('close_image');
    });

    $(".show_hide_button").live('click', function(){
        $('#'+$(this).attr('show_id_name')).css("display","");
        $('.profile_tab_right[field='+ $(this).attr('show_id_name') +']').css("background-image","url(/images/round_right.png)");
        $('.profile_tab_left[field='+ $(this).attr('show_id_name') +']').css("background-image","url(/images/round_left.png)");
        //    $('.pppp[field='+ $(this).attr('show_id_name') +']').css("display","");
        $('#'+$(this).attr('hide_id_name')).css("display","none");
        $('.profile_tab_right[field='+ $(this).attr('hide_id_name') +']').css("background-image","none");
        $('.profile_tab_left[field='+ $(this).attr('hide_id_name') +']').css("background-image","none");
        // $('.pppp[field='+ $(this).attr('hide_id_name') +']').css("display","none");
        $(".container_icon").removeClass("container_icon_color");
        $(this).parent().addClass("container_icon_color");
         

        $('.pppp[field='+ $(this).attr('show_id_name') +']').removeClass('hidden');
    });
    /*
	  Replaces text of the toggle link, with the alt_text,
	  and toggles an object with the class assigned to
	  toggle_more_id
     */
	
    $(".toggle_more").click(function(){
        var $alt_text = $(this).attr('alt_text')
        $(this).attr({
            alt_text: $(this).html()
        })
        $(this).html($alt_text)
        $('#'+$(this).attr('toggle_more_id')).toggle();
    })

    $("#select_contact_type").ready(function(){
        $('form.active').removeClass('active');
        $("form."+$('#select_contact_type option:selected').val()).addClass('active');
    });

    $("#select_contact_type").change(function(){
        $('form.active').removeClass('active');
        $("form."+$('#select_contact_type option:selected').val()).addClass('active');
    });

   
    $(".clear_form").live('click',function(){
  
        var link = $(this);
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


        if($('#check_input_change').val()=="true")
        {
           
            $('#warning_message_text').html("Are You Sure You Wish to Clear The Entered Data? ");
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
                        $('#check_input_change').val("false");
                        $('#check_left_input_change').val("false");
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
               
                 $('#'+link.parents("form").get(0).id)[0].reset();

            }
    });


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




   

    $(".clear_tab").click(function(){
        if ($(this).attr('field') != ""){

            $("#new_"+$(this).attr('field'))[0].reset();
        }

    })

    $(".clear_group_form").click(function(){
        $('.find_group_meta_type').val("").change();
    })
    //
    //    $(".clear_employment_form").click(function () {
    //        $("#new_employment")[0].reset();
    //        $('#organisation_name_container_0').html('');
    //        $('#recruiter_container_0').html('');
    //        $('#supervisor_container_0').html('');
    //        $('#suspender_container_0').html('');
    //        $('#terminator_container_0').html('');
    //    })
    //
    clear_employment_form = function()
    {
        $("#new_employment")[0].reset();
        $('#organisation_name_container_0').html('');
        $('#recruiter_container_0').html('');
        $('#supervisor_container_0').html('');
        $('#suspender_container_0').html('');
        $('#terminator_container_0').html('');
    }

    $("#new_employment").submit( function(){
        $('#organisation_name_container_0').html('');
        $('#recruiter_container_0').html('');
        $('#supervisor_container_0').html('');
        $('#suspender_container_0').html('');
        $('#terminator_container_0').html('');
    })

    $("#accordion").accordion();
    $("#accordion01").accordion();
    $("#accordion02").accordion();

    //    $(".clear_person_role_form").click(function(){
    //        $("#new_person_role")[0].reset();
    //        $('#assigner_container_0').html('');
    //        $('#approver_container_0').html('');
    //        $('#approver_container_0').val('');
    //        $('#superviser_container_0').html('');
    //        $('#manager_container_0').html('');
    //        $('#role_role_type_id').change();
    //    })

    clear_person_role_form = function(){

        $("#new_person_role")[0].reset();
        $('#assigner_container_0').html('');
        $('#approver_container_0').html('');
        $('#approver_container_0').val('');
        $('#superviser_container_0').html('');
        $('#manager_container_0').html('');
        $('#role_role_type_id').change();
    }


    $("#new_person_role").submit( function(){
        $('#assigner_container_0').html('');
        $('#approver_container_0').html('');
        $('#superviser_container_0').html('');
        $('#manager_container_0').html('');
  
    });



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
                    $("#photo").attr("src", "/images/no_photo.jpeg");
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



    $(".user_clear_form").click(function(){
        $('#'+$(this).parents("form").get(0).id)[0].reset();
        $('#login_name_container_0').html('');
        $('#user_name_container_0').html('');

        $('#no_password').hide();
        $('#yes_password').hide();
        $('#no_username').hide();
        $('#yes_username').hide();

    })

});


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
    if( $('#contact_input_change_or_not').val() == "false")
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
                    $('#contact_input_change_or_not').val("false");
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
    $('.person_contact_toggle_button').css("display","none");
    $('.person_contact_edit_delete').css("display","none");
    $('#contact_hidden_tab').attr('mode','edit');
});

$(".delete_email").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
//    $('.edit_email[email_id='+ $(this).attr('email_id') +']').css("display", "none");
});

    
$("#phone_edit_button").live('click',function(){
    $('.person_contact_toggle_button').css("display","none");
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
    $('.person_contact_toggle_button').css("display","none");
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

    $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    $('.person_address_close').css("display","");
    $(this).css("display","none");
    $('#address_hidden_tab').attr('mode','new');
});


$("#address_edit_button").live('click',function(){
    $('.person_address_toggle_button').css("display","none");
    $('.person_address_edit_delete').css("display","none");
    $('#address_hidden_tab').attr('mode','edit');
});

$(".delete_address").live('click',function(){
    $('.person_address_toggle_button').css("display","");
//    $('.edit_address[address_id='+ $(this).attr('address_id') +']').css("display", "none");
});

$(".person_address_close").live('click',function(){
    var link = $(this);
    if( $('#address_input_change_or_not').val() == "false")
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
                    $('#address_input_change_or_not').val("false");
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
});

$(".person_master_doc_close").live('click',function(){
    var link = $(this);
    if( $('#master_doc_input_change_or_not').val() == "false")
    {
        $('#'+link.attr('toggle_id_name')).toggle('blind');
        $('.person_master_doc_edit_delete').css("display","none");
        link.css("display","none");
        $('.person_master_doc_toggle_button').css("display","");
        $('#master_doc_hidden_tab').attr('mode','show');
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
                    $('.person_master_doc_edit_delete').css("display","none");
                    link.css("display","none");
                    $('.person_master_doc_toggle_button').css("display","");
                    $('#master_doc_input_change_or_not').val("false");
                    $('#master_doc_hidden_tab').attr('mode','show');
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


$("#master_doc_edit_button").live('click',function(){
    $('.person_master_doc_toggle_button').css("display","none");
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
    if( $('#relationship_input_change_or_not').val() == "false")
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
                    $('#relationship_input_change_or_not').val("false");
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
    if( $('#notes_input_change_or_not').val() == "false")
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
                    $('#notes_input_change_or_not').val("false");
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
    if( $('#employment_input_change_or_not').val() == "false")
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
                    $('#employment_input_change_or_not').val("false");
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
    $('.person_employments_toggle_button').css("display","none");
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

    $('.person_roles_toggle_button').css("display","none");
    $('.person_roles_edit_delete').css("display","none");
    $('#person_role_hidden_tab').attr('mode','edit');
});

$(".delete_role").live('click',function(){
    $('.person_roles_toggle_button').css("display","");
//    $('.edit_role[role_id='+ $(this).attr('role_id') +']').css("display", "none");
});

$(".person_roles_close").live('click',function(){


    var link = $(this);
    if( $('#role_input_change_or_not').val() == "false")
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
                    $('#role_input_change_or_not').val("false");
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


// Address assistant //

$(document).ready(function() {
    $('#address_assistant').dataTable( {
        "iDisplayLength":10,
        "bLengthChange": false,
        "bAutoWidth":false,
        "bFilter":false,
        "aoColumns": [
        {
            "sWidth":"40%"
        },

        {
            "sWidth":"13%"
        },

        {
            "sWidth":"22%"
        },

        {
            "sWidth":"25%"
        }
        ]
    });
});

$(document).ready(function() {

    $('.launch_address_assistant').live('click', function() {

        $.ajax({
            type: "GET",
            url: "/people/show_postcode.js",
            dataType: "script"
        });
        $('#address_postcode_input').attr("update_field1", $(this).attr("update_field1"));
        $('#address_postcode_input').attr("update_field2", $(this).attr("update_field2"));
        $('#address_postcode_input').attr("update_field3", $(this).attr("update_field3"));
        $('#address_postcode_input').attr("update_field4", $(this).attr("update_field4"));

    });
});

$(function(){
    $('table#address_assistant tbody tr').live('click',function(){
        $('table#address_assistant tbody tr.selected').removeClass('selected');
        $(this).addClass("selected");

    });

    $('table#address_assistant tbody tr').live('mouseover',function(){
        $(this).css("cursor", "pointer");
    });
});

$(function(){
    $('.address_assistant_search').keyup(function() {
        $.ajax({
            type: "GET",
            url: "/addresses/0/search_postcodes.js",
            data: 'suburb='+$('#address_assistant_suburb').val()+'&state='+$('#address_assistant_state').val()+'&postcode='+$('#address_assistant_postcode').val(),
            dataType: "script"
        });
    });
});

$(function(){
    $('.list_assistant_search').live('keyup', function() {
        $.ajax({
            type: "GET",
            url: "/people/search_lists.js",
            data: 'name='+$('#list_assistant_name').val()+'&phone='+$('#list_assistant_phone').val()+'&email='+$('#list_assistant_email').val(),
            dataType: "script"
        });
    });
});


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