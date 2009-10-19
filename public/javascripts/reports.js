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


//    $(document).ready(function() {
//        $('#report_results_data').dataTable({
//            "iDisplayLength":10,
//            "bLengthChange": false,
//            "bAutoWidth":false,
//            "bFilter":false,
//            "aoColumns": [
//                {"sWidth":"8%"},
//                {"sWidth":"23%"},
//                {"sWidth":"23%"},
//                {"sWidth":"23%"},
//                {"sWidth":"23%"}
//            ]
//        });
//    });
//
});
