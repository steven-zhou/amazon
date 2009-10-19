$(function() {

    $("#report_list").live('change', function(){
        if($(this).val() != ""){
            $("#report_format").css("display", "block");
        } else {
            $("#report_format").css("display", "none");
            $("#report_details").css("display", "none");
            $("#report_submit_button").css("display", "none");
            $("#report_grid_form_container").css("display","none");
        }
    });

    $("#report_requested_format").live('change', function(){
        if($(this).val() != ""){         
            $("#report_details").css("display", "block");
            $("#report_submit_button").css("display", "block");
            $("#report_sample_image").replaceWith("<img src=\"/images/" + $("#report_requested_format").val() + ".jpg\" >");
            $("#report_grid_form_container").css("display","none");

        } else {
            $("#report_sample_image").css("display", "none");
            $("#report_details").css("display", "none");
            $("#report_submit_button").css("display", "none");

        }
    });

   $("#report_submit_button").live('click',function(){
        $.ajax({
            type: 'GET',
            url: "/reports/person_contacts_report_grid.js",
            data: 'request_format='+$('#report_requested_format').val()+'&list_header_id='+$('#report_list').val(),
            dataType: "script"
             });

    });


// organisation report
$("#report_organisation_requested_format").live('change', function(){
        if($(this).val() != ""){

            $("#organisation_report_submit_button").css("display", "block");
            $("#organisation_report_sample_image").replaceWith("<img src=\"/images/" + $("#report_requested_format").val() + ".jpg\" >");
            $("#organisation_report_grid_form_container").css("display","none");

        } else {
            $("#organisation_report_sample_image").css("display", "none");
            $("#organisation_report_details").css("display", "none");
            $("#organisation_report_submit_button").css("display", "none");

        }
    });

});
