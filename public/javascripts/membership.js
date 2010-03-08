/* Membership Menu Module*/
$(function(){
    $(".membership_person_lookup").live('change', function(){
        $.ajax({
            type: "GET",
            url: "/membership/membership_person_lookup/",
            data: 'id=' + $(this).val(),
            dataType: "script"
        });
    });
});


$(function(){
    $(".membership_intiator_lookup").live('change', function(){
   var link=$(this);
      if($(this).val()!=$(".membership_person_lookup").val()){
        $.ajax({
            type: "GET",
            url: "/membership/membership_intiator_lookup/",
            data: 'id=' + $(this).val()+"&update_field="+$(this).attr("update_field"),
            dataType: "script"
        });
      }
      else
        {
            $('#error_message_text').html("Can Not Be Same As The Applicant ID");
            $('#error_message_image').css("display","");
            $('#error_message').dialog({
                modal: true,
                resizable: false,
                draggable: true,
                height: 'auto',
                width: 'auto',
                buttons: {
                    "OK": function(){
                        $(this).focus();

                        $(this).dialog('destroy');
                        return true;
                    }
                }
            });
            $('#error_message').dialog('option', 'title', 'ERROR');
            $('#error_message').parent().find("a").css("display","none");
            $("#error_message").parent().css('background-color','#D1DDE6');
            $("#error_message").css('background-color','#D1DDE6');
            $('#error_message').dialog('open');
           link.val("");
           $("#"+link.attr("update_field")).html("");
          
        }
    });
});

$(function(){
  $(".mail_template").live('change', function(){
    if($(this).val()==""){
      $("#"+$(this).attr('check_box_id')).removeAttr('checked').parent().hide();
    }else{
      $("#"+$(this).attr('check_box_id')).parent().show();
    }
  });
});