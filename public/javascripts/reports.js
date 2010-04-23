$(function() {

    $("#report_list").live('change', function(){
        if($(this).val() != ""){
            $("#report_format").css("display", "block");

        } else {
            $("#report_format").css("display", "none");
            $("#report_details").css("display", "none");
            $("#report_submit_button").css("display", "none");
            $("#report_grid_form_container").css("display","none");
            $("#report_requested_format").val("").change();
            
        }
    });

    $("#report_requested_format").live('change', function(){
        if($(this).val() != ""){         
            $("#report_details").css("display", "block");
             $("#report_details").addClass("full_container");
            $("#report_submit_button").css("display", "block");
            $("#report_sample_image").html("<img src=\"/images/" + $("#report_requested_format").val() + ".jpg\" >").show();
            $("#report_grid_form_container").css("display","none");

        } else {
            $("#report_details").css("display", "none");
            $("#report_submit_button").css("display", "none");
            $("#report_grid_form_container").css("display", "none");

        }
    });

   $("#report_submit_button").live('click',function(){
        $(this).attr('disabled',true).after('<div id="spinner" style="height: 24px; float: right; background-image: url(/images/load.gif); background-repeat: no-repeat; background-position: center center; width: 50px; margin-right: 10px;"></div>');
        $.ajax({
            type: 'GET',
            url: "/reports/person_contacts_report_grid.js",
            data: 'request_format='+$('#report_requested_format').val()+'&list_header_id='+$('#report_list').val(),
            dataType: "script"
             });

    });

    $("#organisation_report_list").live('change', function(){
        if($(this).val() != ""){
            $("#organisation_report_format").css("display", "block");

        } else {
            $("#organisation_report_format").css("display", "none");
            $("#organisation_report_details").css("display", "none");
            $("#organisation_report_submit_button").css("display", "none");
            $("#organisation_report_grid_form_container").css("display","none");
            $("#report_organisation_requested_format").val("").change();

        }
    });

$("#report_organisation_requested_format").live('change', function(){
        if($(this).val() != ""){
            $("#organisation_report_submit_button").css("display", "block");
            $("#organisation_report_sample_image").html("<img src=\"/images/" + $("#report_organisation_requested_format").val() + ".jpg\" >").show();
            $("#organisation_report_grid_form_container").css("display","none");
            $("#organisation_report_details").css("display","");
             $("#organisation_report_details").addClass("full_container");

        } else {
            $("#organisation_report_details").css("display", "none");
            $("#organisation_report_submit_button").css("display", "none");
            $("#organisation_report_grid_form_container").css("display", "none");

        }
    });


});
