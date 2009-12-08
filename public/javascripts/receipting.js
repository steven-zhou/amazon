$(function(){
    $("#reply_to_feedback").live('click', function(){
        $("#reply_to_feedback").hide();
        $("#feedback_reply").show();
    });
});

$(function(){
    $("#close_feedback").live('click', function(){
        $("#feedback_reply").hide();
        $("#reply_to_feedback").show();
    });
});


$(function(){
    $("#display_feedback_reply").live('click', function(){
        $("#display_feedback_reply").hide();
        $("#hide_feedback_reply").show();
        $("#feedback_reply").show();
    });
});