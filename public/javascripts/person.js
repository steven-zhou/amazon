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

    $(".clear_group_form").click(function(){
        $('#show_group_type').val("").change();
    })

    $(".clear_employment_form").click(function () {
        $('#'+$(this).parents("form").get(0).id)[0].reset();
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
        $('#'+$(this).parents("form").get(0).id)[0].reset();
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
        
      
      



    })

});


// Address assistant //

$(document).ready(function() {
    $('#address_assistant').dataTable( {
        "iDisplayLength":10,
        "bLengthChange": false,
        "bAutoWidth":false,
        "aoColumns":[{
            'sWidth':"50"
        },{
            'sWidth':"15%"
        },{
            'sWidth':"15%"
        },{
            'sWdith':"20%"
        }]
    }
    );
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
                Close: function() {
                    $(this).dialog('close');
                }
            }
        });
        $('#address_form_assistant').dialog('open');
    });
});