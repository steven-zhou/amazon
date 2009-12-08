$(function() {

    /*
	  Objects withe class toggle_button will
	  toggle the DOM object associated with it
	  via an attribute toggle_id_name
     */
  

    $("#select_contact_type").ready(function(){
        $('form.active').removeClass('active');
        $("form."+$('#select_contact_type option:selected').val()).addClass('active');
    });

    $("#select_contact_type").live('change',function(){
        $('form.active').removeClass('active');
        $("form."+$('#select_contact_type option:selected').val()).addClass('active');
    });



    $(".clear_tab").click(function(){
        if ($(this).attr('field') != ""){

            $("#new_"+$(this).attr('field'))[0].reset();
        }

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

    //    $("#new_employment").submit( function(){
    //        $('#organisation_name_container_0').html('');
    //        $('#recruiter_container_0').html('');
    //        $('#supervisor_container_0').html('');
    //        $('#suspender_container_0').html('');
    //        $('#terminator_container_0').html('');
    //    })

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

   


    //    $("#new_person_role").submit( function(){
    //        $('#assigner_container_0').html('');
    //        $('#approver_container_0').html('');
    //        $('#superviser_container_0').html('');
    //        $('#manager_container_0').html('');
    //
    //    });



   





});


