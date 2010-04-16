/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {
    xhr.setRequestHeader("Accept", "text/javascript")
  }
});

/* Authenticity token*/
$(document).ready(function() {
  // All non-GET requests will add the authenticity token
  // if not already present in the data packet
  $("body").bind("ajaxSend", function(elm, xhr, s) {
    if (s.type == "GET") return;
    if (s.data && s.data.match(new RegExp("\\b" + window._auth_token_name + "="))) return;
    if (s.data) {
      s.data = s.data + "&";
    } else {
      s.data = "";
      // if there was no data, jQuery didn't set the content-type
      xhr.setRequestHeader("Content-Type", s.contentType);
    }
    s.data = s.data + encodeURIComponent(window._auth_token_name)
    + "=" + encodeURIComponent(window._auth_token);
  });
});


$(function() {  
  $('form').live('submit', function(){
    disable_form_after_submit($(this));
  });

  jQuery.fn.submitWithAjax = function($callback) {
    this.live('submit', function() {
      $.post($(this).attr("action"), $(this).serialize(), $callback, "script");
      return false;
    });
    return this;
  };

});
$(function() {
  $(document).ready(function() {
    $(".ajax_form").submitWithAjax();
  });
}
);




$(function() {
  $("#register_guest_account").click(function(){
    $("#login_fail_message_container").hide();
    $("#captcha").addClass("compulsory_field");
    $("#signin_form").fadeOut(1);
    $("#register_container").fadeIn();
    return false;
  });

}
);




$(function() {
  $("#captcha").addClass("compulsory_field");
  $("#forgot_password").click(function(){
    $("#captcha").addClass("compulsory_field");

  });

}
);

/* new compulsory field setting for controlling submit button*/
$(function(){
  compulsory_check = function(link){
    var current_form = $('#'+link.closest('form').attr('id'));
    var compulsory_fields = current_form.find('.compulsory_field');
    var length = compulsory_fields.length;
    var disable = true;
    for(i=0; i<length; i++){
      if ($('#'+compulsory_fields[i].id).val()=='' || $('#'+compulsory_fields[i].id).val()== null ){
        disable = true;
        break;
      }else{
        disable = false;
      }
    }
    if (disable){
      $('#'+current_form.attr('submit_button_id')).attr('disabled', true);
    }else{
      $('#'+current_form.attr('submit_button_id')).removeAttr('disabled');
    }
    return false;
  };

  compulsory_check($('#username'));

  $(".compulsory_field").live('keyup', function(e){

   
    var current_form = $('#'+$(this).closest('form').attr('id'));

    if ($.trim($(this).val())!="" && e.which !=13)
    {
      compulsory_check($(this));
    }
    else
    {
      $('#'+current_form.attr('submit_button_id')).attr('disabled', true);
    }
  });

  $(".compulsory_field").live('change', function(){
    var current_form = $('#'+$(this).closest('form').attr('id'));

    if ($.trim($(this).val())!="")
    {
      compulsory_check($(this));
    }
    else
    {
      $('#'+current_form.attr('submit_button_id')).attr('disabled', true);
    }

  });

  $(".compulsory_field").blur(function(){
    var current_form = $('#'+$(this).closest('form').attr('id'));
    if ($.trim($(this).val())!="")
    {
      compulsory_check($(this));
    }
    else
    {
      $('#'+current_form.attr('submit_button_id')).attr('disabled', true);
    }
  });

  disable_form_after_submit = function(target_form){
    target_form.find("input").attr("readonly", true);
    target_form.find("input[type = 'submit']").attr("disabled", true);
    target_form.find("select").attr("readonly", true);
    target_form.find("textarea").attr("readonly", true);
    if (target_form.attr('submit_button_id') != undefined){
      submit_button = $('#'+target_form.attr('submit_button_id'));
    }else{
      submit_button = target_form.find("input[type = 'submit']");
    }
    submit_button.attr("disabled", true);
    submit_button.after('<div id="spinner" style="height: 24px; float: right; background-image: url(/images/load.gif); background-repeat: no-repeat; background-position: center center; width: 50px; margin-top: 5px;"></div>');

  };

  enable_form_after_submit_finish = function(){
    $("form :input").removeAttr("readonly");
    $("form :select").removeAttr("readonly");
    $("form :textarea").removeAttr("readonly");
    $('form :input[type="submit"]').removeAttr("disabled");
    $('.fake_submit_button').removeAttr("disabled");
    $('#spinner').remove();
  };

});

$(function() {
  $('#regenerate_captcha').live('click', function(){
    $.ajax({
      type: "GET",
      url: "/guests/captcha",
      data: '',
      dataType: "script"
    });
    return false;
  });
});



$(function(){
  check_email_field = function(target){
    if(target.val()!=""){
      _valid = /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-zA-Z]{2,})$/.test(target.val());
      if((!_valid)){
        $("#signup_submit").attr('disabled', true);
        alert("Invalid Email Address");
      }
    }
  };

  $(".email_field").live('change', function(){
    check_email_field($(this));
  });
});


$(function() {

  $('#potential_member_first_name').blur(function(){
    $('#captcha').addClass('compulsory_field');
  });

  $('#captcha').click(function(){
    $(this).addClass('compulsory_field');
  })
});


$(function() {
  $('.try_again').live('click', function(){
    $("#create_guest input[type='text']").val('').blur();
    $("#fail_message_container").css('display', 'none');
    $("#feedback_area").hide();
    $('#regenerate_captcha').click();
  });
});


$(function(){
  $("#change_password").live('click',function(){
    $(this).hide();
    $("#feedback_area").attr("id","feedback_area_backup");
    $("#feedback_area_backup").hide();
    $('#profile_submit').hide();
    $('#successful_message_container').hide();
    $('#fail_message_container').hide();
    $('#person_change_password').show();

    $(".compulsory_field").keyup();

  });

  $('#cancel_change_password').live("click",function(){
    $("#change_password").show();

    $("#feedback_area_backup").attr("id","feedback_area");
    
    $('#profile_submit').show();
    $('#person_change_password').hide();
  });
});


$(function(){
  $(".submit_hide_cancel").live('click', function(){
    $(".cancel_disappear").hide();




  })

});