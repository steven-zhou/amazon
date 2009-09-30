$(function() {

    $("#report_format").live('change', function(){
        if($(this).val() != ""){
            $("#report_select_list").css("display", "block");
        } else {
            $("#report_select_list").css("display", "none");
            $("#report_details").css("display", "none");
            $("#report_submit_button").css("display", "none");

        }
    });

    $("#report_list").live('change', function(){
        if($(this).val() != ""){
            $("#report_details").css("display", "block");
            $("#report_submit_button").css("display", "block");

        } else {
            $("#report_details").css("display", "none");
            $("#report_submit_button").css("display", "none");

        }
    });


});
