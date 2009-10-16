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

    $(".show_hide_button").click(function(){
        $('#'+$(this).attr('show_id_name')).css("display","");
        $('#'+$(this).attr('hide_id_name')).css("display","none");
        $(".container_icon").removeClass("container_icon_color");
        $(this).parent().addClass("container_icon_color");
          
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

   
    $(".clear_form").click(function(){
        $('#'+$(this).parents("form").get(0).id)[0].reset();
                
    })


   

    $(".clear_tab").click(function(){
        if ($(this).attr('field') != ""){

            $("#new_"+$(this).attr('field'))[0].reset();
        }

    })

    $(".clear_group_form").click(function(){
        $('.find_group_meta_type').val("").change();
    })

    $(".clear_employment_form").click(function () {
        $("#new_employment")[0].reset();
        $('#organisation_name_container_0').html('');
        $('#recruiter_container_0').html('');
        $('#supervisor_container_0').html('');
        $('#suspender_container_0').html('');
        $('#terminator_container_0').html('');
    })

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

    $(".clear_person_role_form").click(function(){
        $("#new_person_role")[0].reset();
        $('#assigner_container_0').html('');
        $('#approver_container_0').html('');
        $('#approver_container_0').val('');
        $('#superviser_container_0').html('');
        $('#manager_container_0').html('');
        $('#role_role_type_id').change();
    })


    $("#new_person_role").submit( function(){
        $('#assigner_container_0').html('');
        $('#approver_container_0').html('');
        $('#superviser_container_0').html('');
        $('#manager_container_0').html('');
  
    })

    $("#delete_photo").click(function(){
        $("#photo").attr("src", "/images/no_photo.jpeg");
        $("#delete_photo").hide();
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

$('#person_group_close_button').live('click',function(){
    $('.person_group_delete_button').css("display","");
});

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
    if ($('.person_group_delete_button').css("display")=="block" || $('.person_group_delete_button').css("display")=="")
        $('.person_group_delete_button').css("display","none");
    else
        $('.person_group_delete_button').css("display","");

    $(this).css("display","none");
    $('.person_group_toggle_button').css("display","");
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
  
    $('.person_contact_edit_delete').css("display","none");

    $(this).css("display","none");
    $('.person_contact_toggle_button').css("display","");
    $('#contact_hidden_tab').attr('mode','show');

    $("#new_phone")[0].reset();
    $("#new_email")[0].reset();
    $("#new_website")[0].reset();
    
});
    
$("#email_edit_button").live('click',function(){
    $('.person_contact_toggle_button').css("display","none");
    $('.person_contact_edit_delete').css("display","none");
    $('#contact_hidden_tab').attr('mode','edit');
});

$(".delete_email").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
    $('.edit_email[email_id='+ $(this).attr('email_id') +']').css("display", "none");
});

    
$("#phone_edit_button").live('click',function(){
    $('.person_contact_toggle_button').css("display","none");
    $('.person_contact_edit_delete').css("display","none");
    $('#contact_hidden_tab').attr('mode','edit');
});




$(".delete_phone").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
    $('.edit_phone[phone_id='+ $(this).attr('phone_id') +']').css("display", "none");
});


$(".delete_fax").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
    $('.edit_fax[fax_id='+ $(this).attr('fax_id') +']').css("display", "none");
});



$("#website_edit_button").live('click',function(){
    $('.person_contact_toggle_button').css("display","none");
    $('.person_contact_edit_delete').css("display","none");
    $('#contact_hidden_tab').attr('mode','edit');
});

$(".delete_website").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
    $('.edit_website[website_id='+ $(this).attr('website_id') +']').css("display", "none");
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
    $('.edit_address[address_id='+ $(this).attr('address_id') +']').css("display", "none");
});

$(".person_address_close").live('click',function(){
    $('.person_address_edit_delete').css("display","none");

    $(this).css("display","none");
    $('.person_address_toggle_button').css("display","");
    $('#address_hidden_tab').attr('mode','show');
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
    $('.person_master_doc_edit_delete').css("display","none");

    $(this).css("display","none");
    $('.person_master_doc_toggle_button').css("display","");
    $('#master_doc_hidden_tab').attr('mode','show');
});


$("#master_doc_edit_button").live('click',function(){
    $('.person_master_doc_toggle_button').css("display","none");
    $('.person_master_doc_edit_delete').css("display","none");
    $('#master_doc_hidden_tab').attr('mode','edit');
});

$(".delete_master_doc").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
    $('.edit_master_doc[master_doc_id='+ $(this).attr('master_doc_id') +']').css("display", "none");
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
    $('.person_tag').css("display","none");
    $('#related_person_name_container').html('');

    $(this).css("display","none");
    $('.person_relationship_toggle_button').css("display","");
    $('#relationship_hidden_tab').attr('mode','show');
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
 
    $('.person_notes_edit_delete').css("display","none");

    $(this).css("display","none");
    $('.person_notes_toggle_button').css("display","");
    $('#note_hidden_tab').attr('mode','show');
});

$(".edit_note").live('click',function(){
    $('.person_notes_toggle_button').css("display","none");
    $('.person_notes_edit_delete').css("display","none");
    $('#note_hidden_tab').attr('mode','edit');
});

$(".delete_note").live('click',function(){
    $('.person_notes_toggle_button').css("display","");
    $('.edit_note[note_id='+ $(this).attr('note_id') +']').css("display", "none");
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
    
    $('.person_employments_edit_delete').css("display","none");

    $(this).css("display","none");
    $('.person_employments_toggle_button').css("display","");
    $('#employment_hidden_tab').attr('mode','show');
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
    $('.edit_role[role_id='+ $(this).attr('role_id') +']').css("display", "none");
});

$(".person_roles_close").live('click',function(){
    $('.person_roles_edit_delete').css("display","none");
    $(this).css("display","none");
    $('.person_roles_toggle_button').css("display","");
    $('#person_role_hidden_tab').attr('mode','show');
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

    $('#launch_address_assistant').live('click', function() {
        $('#address_form_assistant').dialog({
            modal: true,
            width: 650,
            height: 500,
            resizable: true,
            draggable :true,
            buttons: {
                Select: function() {
                    $('#address_town').val($('tr.selected > td')[0].innerHTML);
                    $('#address_state').val($('tr.selected > td')[1].innerHTML);
                    $('#address_postal_code').val($('tr.selected > td')[2].innerHTML);

                    $('#person_addresses_attributes_0_town').val($('tr.selected > td')[0].innerHTML);
                    $('#person_addresses_attributes_0_state').val($('tr.selected > td')[1].innerHTML);
                    $('#person_addresses_attributes_0_postal_code').val($('tr.selected > td')[2].innerHTML);

                    $('#organisation_addresses_attributes_0_town').val($('tr.selected > td')[0].innerHTML);
                    $('#organisation_addresses_attributes_0_state').val($('tr.selected > td')[1].innerHTML);
                    $('#organisation_addresses_attributes_0_postal_code').val($('tr.selected > td')[2].innerHTML);

                    $(this).dialog('close');
                }
            }
        });
        $('#address_form_assistant').dialog('open');
    });
});

$(function(){
    $('table#address_assistant tbody tr').live('click',function(){
        $('table#address_assistant tbody tr.selected').removeClass('selected');
        $(this).addClass("selected");

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