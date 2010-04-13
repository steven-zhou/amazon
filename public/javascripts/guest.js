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

    $("#signin_form").fadeOut();
    $("#register_container").fadeIn();
    return false;
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

  $(".compulsory_field").live('keyup', function(){
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
    submit_button.after('<div id="spinner" style="height: 24px; float: right; background-image: url(/images/load.gif); background-repeat: no-repeat; background-position: center center; width: 50px; margin-top: 15px;"></div>');

  };

  $('form').live('submit', function(){
    disable_form_after_submit($(this));
  });

  $('form').keypress(function(e){
    if(e.which == 13){
      return false;
    }else{
      return true;
    }
  });
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


$(function() {
  $('.try_again').live('click', function(){
    $("#create_guest input[type='text']").val('').blur()

    $('#regenerate_captcha').click();
  });
});


