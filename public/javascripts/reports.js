$(function() {

    $("#report_list").live('change', function(){
        if($(this).val() != ""){
            $("#report_format").css("display", "block");
        } else {
            $("#report_format").css("display", "none");
            $("#report_details").css("display", "none");
            $("#report_submit_button").css("display", "none");

        }
    });

    $("#report_requested_format").live('change', function(){
        if($(this).val() != ""){
            $("#report_details").css("display", "block");
            $("#report_submit_button").css("display", "block");
            $("#report_sample_image").replaceWith("<img src=\"/images/" + $("#report_requested_format").val() + ".jpg\">");

        } else {
            $("#report_sample_image").css("display", "none");
            $("#report_details").css("display", "none");
            $("#report_submit_button").css("display", "none");

        }
    });

    $(document).ready(function() {
        $('#report_results_data').dataTable({
            "iDisplayLength":10,
            "bLengthChange": false,
            "bAutoWidth":false,
            "bFilter":false,
            "aoColumns": [
                {"sWidth":"8%"},
                {"sWidth":"23%"},
                {"sWidth":"23%"},
                {"sWidth":"23%"},
                {"sWidth":"23%"}
            ]
        });
    });

});
