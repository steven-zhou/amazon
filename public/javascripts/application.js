// All ajax requests will trigger the wants.js block
// of +respond_to do |wants|+ declarations

$(function(){
  $('form').live('submit', function(){
    disable_form_after_submit($(this));
  });

});

$(function(){
  $("#datepicker").datepicker();
});

$(function(){
  $(".focus_on_open").focus();
});

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {
    xhr.setRequestHeader("Accept", "text/javascript")
  }
});

/* Authenticity token*/
$(document).ready(function(){

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




$(function(){
  // All A tags with class 'get', 'post', 'put' or 'delete' will perform an ajax call
  $('a.get').live('click', function(e) {
    var link = $(this);
    $.get(link.attr('href'), null ,null, 'script');
    return false;
  }).attr("rel", "nofollow");




  //To use this function, please add data_id attributes to the link and the element id point to should be the form
  $('a.post').live('click', function(){
    $.post($(this).attr('href'), $("#" + $(this).attr("data_id")).serialize(),null,'script');
    return false;
  }).attr("rel", "nofollow");

  $('a.put').live('click', function(){
    var link = $(this);
    $.post($(this).attr('href'), "_method=put", null, 'script');
    return false;
  }).attr("rel", "nofollow");


  $('a.delete').live('click', function(){

    var link = $(this);
    if($(this).attr("error_message_field" != null))
    {
      $('#warning_message_text').html("Are You Sure You Wish to Delete This "  + $(this).attr("error_message_field") + " ? ");
    }
    else
    {
      $('#warning_message_text').html("Are you sure you wish to delete ? ");
    }
    $('#warning_message_image').css("display","");
    $('#warning_message').dialog({
      modal: true,
      resizable: false,
      draggable: true,
      height: 'auto',
      width: 'auto',
      buttons: {

        No: function(){
          $(this).dialog('destroy');
          return false;

        },
        Yes: function(){
          //$("#query_mode").attr("mode","show");
          $.post(link.attr('href'), "_method=delete", null, 'script');
          $(this).dialog('destroy');
          return true;
        }
      }

    });

    $('#warning_message').dialog('option', 'title', 'Warning');

    $('#warning_message').parent().find("a").css("display","none");
    $("#warning_message").parent().css('background-color','#D1DDE6');
    $("#warning_message").css('background-color','#D1DDE6');
    //      $("#warning_message").closest("ui-dialog-titlebar").css('background','#97B6CE');

    $('#warning_message').dialog('open');

    //    a.css("display","none");
    //  a.attr("class","ui-dialog-titlebar-lock");
    //  a.find("span").attr("class","ui-icon ui-icon-lock");
    return false;

  }).attr("rel", "nofollow");

  jQuery('a.get, a.post, a.put, a.delete').removeAttr('onclick');
});



jQuery.fn.submitWithAjax = function($callback){
  this.live('submit', function() {
    $.post($(this).attr("action"), $(this).serialize(), $callback, "script");
    return false;
  });
  return this;
};


jQuery.fn.doAjaxSubmit = function($callback){
  $.post($(this).attr("action"), $(this).serialize(), $callback, "script");
  return false;
};


$(document).ready(function(){
  $(".ajax_form").submitWithAjax();
});








/*Date picker */
datapick_config = function(){
  $(".birthdatepick").datepicker({
    showOn: 'button',
    buttonImage: '/images/Icons/System/calendar.png',
    buttonImageOnly: true,
    dateFormat: 'dd-mm-yy',
    altFormat: 'mm-dd-yy',
    changeMonth: true,
    changeYear: true,
    maxDate: '+0d',
    yearRange: '-200:'+ (new Date).getFullYear()
  });


  $('.datepick').datepicker({
    showOn: 'button',
    buttonImage: '/images/Icons/System/calendar.png',
    buttonImageOnly: true,
    dateFormat: 'dd-mm-yy',
    altFormat: 'mm-dd-yy',
    changeMonth: true,
    changeYear: true,
    yearRange: '-200:+20',
    onClose: function(){
      $(this).keyup();
    }
  });

    
  $('.beforestartdatepick').datepicker({
    showOn: 'button',
    buttonImage: '/images/Icons/System/calendar.png',
    buttonImageOnly: true,
    dateFormat: 'dd-mm-yy',
    altFormat: 'mm-dd-yy',
    changeMonth: true,
    changeYear: true,
    yearRange: '-200:+20',
    beforeShow: function(){
      var arr_dateText = $("#"+$(this).attr("end_date")).val().split("-");
      day = arr_dateText[0];
      month = arr_dateText[1];
      year = arr_dateText[2];
      if(year!=undefined){
        $(this).datepicker('option', 'maxDate', new Date(year, month-1, day));
      }
    }
  });
  

  $('.role_startdatepick').datepicker({
    showOn: 'button',
    buttonImage: '/images/Icons/System/calendar.png',
    buttonImageOnly: true,
    dateFormat: 'dd-mm-yy',
    altFormat: 'mm-dd-yy',
    changeMonth: true,
    changeYear: true,
    yearRange: '-200:+20',
    beforeShow: function(){
      var arr_dateText = $("#"+$(this).attr("end_date")).val().split("-");
      day = arr_dateText[0];
      month = arr_dateText[1];
      year = arr_dateText[2];
      if(year!=undefined){
        $(this).datepicker('option', 'maxDate', new Date(year, month-1, day));
      }
      var arr_dateText_start = $("#"+$(this).attr("start_date")).val().split("-");
      day_start = arr_dateText_start[0];
      month_start = arr_dateText_start[1];
      year_start = arr_dateText_start[2];
      if(year_start!=undefined){
        $(this).datepicker('option', 'minDate', new Date(year_start, month_start-1, day_start));
      }
    },
    onSelect: function(){
      $("#"+$(this).attr("end_date")).datepicker('enable');

    },
    onClose: function(){
      $(this).keyup();
    }

  });

  $('.role_enddatepick').datepicker({
    showOn: 'button',
    buttonImage: '/images/Icons/System/calendar.png',
    buttonImageOnly: true,
    dateFormat: 'dd-mm-yy',
    altFormat: 'mm-dd-yy',
    changeMonth: true,
    changeYear: true,
    yearRange: '-200:+20',
    beforeShow: function(){
      var arr_dateText = $("#"+$(this).attr("start_date")).val().split("-");
      day = arr_dateText[0];
      month = arr_dateText[1];
      year = arr_dateText[2];
      if(year!=undefined){
        $(this).datepicker('option', 'minDate', new Date(year, month-1, day));
      }
    }
  });


  $('.ui-datepicker-trigger').live('mouseover', function(){
    var endDate = $(this).parent().find('.enddatepick');
    if(endDate.attr('start_date')!=undefined){
      var arr_dateText = $('#'+endDate.attr('start_date')).val().split("-");
      year = arr_dateText[2];
      if(year==undefined){
        endDate.val('');
        endDate.datepicker('disable');
      }
    }else{
      var roleEndDate = $(this).parent().find('.role_enddatepick');
      if(roleEndDate.attr('start_date')!=undefined){
        var role_arr_dateText = $('#'+roleEndDate.attr('start_date')).val().split("-");
        year = role_arr_dateText[2];
        if(year==undefined){
          roleEndDate.val('');
          roleEndDate.datepicker('disable');
        }
      }
    }
  });
};


start_end_date_pick = function(){



  $('.startdatepick').datepicker({
    showOn: 'button',
    buttonImage: '/images/Icons/System/calendar.png',
    buttonImageOnly: true,
    dateFormat: 'dd-mm-yy',
    altFormat: 'mm-dd-yy',
    changeMonth: true,
    changeYear: true,
    yearRange: '-200:+20',
    beforeShow: function(){
      var arr_dateText = $("#"+$(this).attr("end_date")).val().split("-");
      day = arr_dateText[0];
      month = arr_dateText[1];
      year = arr_dateText[2];
      if(year!=undefined){
        $(this).datepicker('option', 'maxDate', new Date(year, month-1, day));
      }

    },
    onSelect: function(){
      $("#"+$(this).attr("end_date")).datepicker('enable');
    },
    onClose: function(){
      $(this).keyup();
    }
  });

  $('.enddatepick').datepicker({
    showOn: 'button',
    buttonImage: '/images/Icons/System/calendar.png',
    buttonImageOnly: true,
    dateFormat: 'dd-mm-yy',
    altFormat: 'mm-dd-yy',
    changeMonth: true,
    changeYear: true,
    yearRange: '-200:+20',
    beforeShow: function(){
      var arr_dateText = $("#"+$(this).attr("start_date")).val().split("-");
      day = arr_dateText[0];
      month = arr_dateText[1];
      year = arr_dateText[2];
      if(year!=undefined){
        $(this).datepicker('option', 'minDate', new Date(year, month-1, day));
      }
    }
  });



};


$(document).ready(function(){
  datapick_config();
  start_end_date_pick();
});





/* Photo */

$("#edit_photo_link").live("click",function() {
  $("#edit_photo").toggle('blind');
  return false;
});








$(function(){
  $(".calculate_field").live('change', function(){
    _valid = /^(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test($(this).val());
    if (_valid)
    {
      _salary = $("#hour_"+$(this).attr("employment_id")).val() * $("#rate_"+$(this).attr("employment_id")).val() * 52;
      $("#salary_"+$(this).attr("employment_id")).val(formatCurrency(_salary));
    }else{
      //alert("This field has be a number!");
      $('#error_message_text').html("Entered Value Must Be Positive Number Only ");
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

      $(this).val(0);
      $("#salary_"+$(this).attr("employment_id")).val(formatCurrency(0));
    }
  });
});




formatCurrency= function(num){
  num = num.toString().replace(/\$|\,/g,'');
  if(isNaN(num))
    num = "0";
  sign = (num == (num = Math.abs(num)));
  num = Math.floor(num*100+0.50000000001);
  cents = num%100;
  num = Math.floor(num/100).toString();
  if(cents<10)
    cents = "0" + cents;
  for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
    num = num.substring(0,num.length-(4*i+3))+','+
    num.substring(num.length-(4*i+3));
  return (((sign)?'':'-') + '$' + num + '.' + cents);
};




// Administration Menu
//
//$(function(){
//    $(".close_option").live('click', function(){
//        $("#system_data_add_entry_form").hide();
//        $("#custom_group_entry_form").hide();
//        $("#query_table_add_entry_form").hide();
//        $("#access_permission_add_entry_form").hide();
//    });
//});

// Configuration






/* Drop down box hack*/
$(function(){
  $(".clear_select").find('option:first').attr('selected', 'selected');
});



$(document).ready(function() {
  $(".inputWithImge").each(function(){
    $(this).add($(this).next()).wrapAll('<div class="imageInputWrapper"></div>');
  });
});

/*validation section*/
integer_check = function(link)
{
  _valid = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(link.val());
  if(link.val()!=""){
    if((!_valid) || link.val()<0){

      $('#error_message_text').html("Entered Value Must be Integer Only ");

      $('#error_message_image').css("display","");
      $('#error_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {
          "OK": function(){
            link.focus();
            link.val('');
            $(this).dialog('destroy');
            link.change();
            return true;
          }
        }
      });
      $('#error_message').dialog('option', 'title', 'Error');
      $('#error_message').parent().find("a").css("display","none");
      $("#error_message").parent().css('background-color','#D1DDE6');
      $("#error_message").css('background-color','#D1DDE6');
      $('#error_message').dialog('open');
    }
  }
  return false;
};

$(function(){
  $(".integer_field").live('keyup', function(){

    integer_check($(this));
  });

  $(".precent_field").live('keyup', function(){
    _valid = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test($(this).val());
    if($(this).val()!=""){
      if((!_valid) || $(this).val()<=0 || $(this).val()>= 100){
        var link = $(this);

        $('#error_message_text').html("Entered Value Must be in Range 00 - 100 Only ");

        $('#error_message_image').css("display","");
        $('#error_message').dialog({
          modal: true,
          resizable: false,
          draggable: true,
          height: 'auto',
          width: 'auto',
          buttons: {
            "OK": function(){
              link.focus();
              link.val('');
              $(this).dialog('destroy');
              return true;
            }
          }
        });
        $('#error_message').dialog('option', 'title', 'Error');
        $('#error_message').parent().find("a").css("display","none");
        $("#error_message").parent().css('background-color','#D1DDE6');
        $("#error_message").css('background-color','#D1DDE6');
        $('#error_message').dialog('open');

      }
    }
  });
});

check_empty_value = function(){

  if( $("#"+$(this).attr("check_field")).val()== "")
  {
    var error_message = "The " + $("#"+$(this).attr("check_field")).attr("name") +" Must be Filled" ;
    var link = $(this);

    $('#error_message_text').html(error_message);

    $('#error_message_image').css("display","");
    $('#error_message').dialog({
      modal: true,
      resizable: false,
      draggable: true,
      height: 'auto',
      width: 'auto',
      buttons: {
        "OK": function(){
          link.focus();

          $(this).dialog('destroy');
          return true;
        }
      }
    });
    $('#error_message').dialog('option', 'title', 'Error');
    $('#error_message').parent().find("a").css("display","none");
    $("#error_message").parent().css('background-color','#D1DDE6');
    $("#error_message").css('background-color','#D1DDE6');
    $('#error_message').dialog('open');
    return false;
  }
  return true;
};

check_email_field = function(){
  _valid = /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-zA-Z]{2,})$/.test($('#email_value').val());
  if($('#email_value').val()!=""){
    if((!_valid)){
      var link = $(this);

      $('#error_message_text').html("Invalid Email Address");

      $('#error_message_image').css("display","");
      $('#error_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {
          "OK": function(){
            link.focus();

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


    }
  }
};

check_email_field_edit = function(){
  _valid = /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-z]{2,})$/.test($('#email_value_edit').val());
  if($('#email_value_edit').val()!=""){
    if((!_valid)){
      var link = $(this);

      $('#error_message_text').html("Invalid Email Address");

      $('#error_message_image').css("display","");
      $('#error_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {
          "OK": function(){
            link.focus();

            $(this).dialog('destroy');
            return true;
          }
        }
      });
      $('#error_message').dialog('option', 'title', 'Error');
      $('#error_message').parent().find("a").css("display","none");
      $("#error_message").parent().css('background-color','#D1DDE6');
      $("#error_message").css('background-color','#D1DDE6');
      $('#error_message').dialog('open');
    }
  }
};

check_website_field = function(){
  _valid1 = /^((https|http|ftp|rtsp|mms)?:\/\/)?(([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\.[a-z]{2,6})(:[0-9]{1,4})?((\/?)|(\/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+\/?)$/.test($("#website_value").val());
  if($('#website_value').val()!=""){
    if((!_valid1)){
      var link = $(this);
      $('#error_message_text').html("Invalid Website Address");
      $('#error_message_image').css("display","");
      $('#error_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {
          "OK": function(){
            link.focus();
            $(this).dialog('destroy');
            return true;
          }
        }
      });
      $('#error_message').dialog('option', 'title', 'Error');
      $('#error_message').parent().find("a").css("display","none");
      $("#error_message").parent().css('background-color','#D1DDE6');
      $("#error_message").css('background-color','#D1DDE6');
      $('#error_message').dialog('open');
      enable_form_after_submit_finish();
      return false;
    }
  }

};

check_website_field_edit = function(){
  _valid1 = /^((https|http|ftp|rtsp|mms)?:\/\/)?(([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\.[a-z]{2,6})(:[0-9]{1,4})?((\/?)|(\/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+\/?)$/.test($("#website_value_edit").val());
  if($('#website_value_edit').val()!=""){
    if((!_valid1)){
      var link = $(this);
      $('#error_message_text').html("Invalid Website Address");
      $('#error_message_image').css("display","");
      $('#error_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {
          "OK": function(){
            link.focus();

            $(this).dialog('destroy');
            return true;
          }
        }
      });
      $('#error_message').dialog('option', 'title', 'Error');
      $('#error_message').parent().find("a").css("display","none");
      $("#error_message").parent().css('background-color','#D1DDE6');
      $("#error_message").css('background-color','#D1DDE6');
      $('#error_message').dialog('open');
      return false;
    }
  }

};


$(function(){
  $('.header_container').live('mouseover',function(){
    if ($("#" + $(this).attr('field')+'_hidden_tab').attr('mode') == "show"){

      $(this).find('.person_tag').css("display","");
    }
  });
});

$(function(){
  $('.header_container').live('mouseout',function(){
    if ($("#" + $(this).attr('field')+'_hidden_tab').attr('mode') == "show"){
      $(this).find('.person_tag').css("display","none");
    }
  });
});


/*Grid*/
$(function(){
  $("#feedback_search_grid").flexigrid({
    url: '/grids/feedback_search_grid',
    dataType: 'json',
    colModel : [
    {
      display: 'ID',
      name : 'grid_object_id',
      width : 40,
      sortable : true,
      align: 'left'
    },

    {
      display: 'Date',
      name : 'field_1',
      width : 180,
      sortable : true,
      align: 'left'
    },

    {
      display: 'Submitted By',
      name : 'field_2',
      width : 180,
      sortable : true,
      align: 'left'
    },

    {
      display: 'Subject',
      name : 'field_3',
      width : 180,
      sortable : true,
      align: 'left'
    },

    {
      display: 'IP Address',
      name : 'field_4',
      width : 180,
      sortable : true,
      align: 'left'
    },

    {
      display: 'Status',
      name : 'field_5',
      width : 180,
      sortable : true,
      align: 'left'
    },


    ],
    searchitems : [
    {
      display: 'Date',
      name : 'field_1'
    },

    {
      display: 'Submitted By',
      name : 'field_2'
    },

    {
      display: 'Subject',
      name : 'field_3'
    },

    {
      display: 'Status',
      name : 'field_5'
    },

    ],
    sortname: "grid_object_id",
    sortorder: "asc",
    usepager: true,
    useRp: true,
    rp: 20,
    showTableToggleBtn: false,
    width: 'auto',
    height: 'auto'
  });
});

$(function(){
  $('table#feedback_search_grid tbody tr').live('click',function(){
    $('table#feedback_search_grid tbody tr.trSelected').removeClass('trSelected');
    $(this).addClass('trSelected');
    $.ajax({
      type: 'GET',
      url: "/feedback/show/"+$(this).attr('id').substring(3),
      dataType: "script"
    });
  });
});

$(function(){
  $('table#feedback_search_grid tbody tr').live('mouserover', function(){
    $(this).css("cursor","pointer");
  });
});

$(function(){
  $('#system_log_archive_submit').live('click',function(){
    $('#system_log_archive_results').show();
    $('#system_log_archive_options').show();
    $('#system_log_archive_user_name').val($('#archive_user_name').val());
    $('#system_log_archive_start_date').val($('#archive_system_log_start_date').val());
    $('#system_log_archive_end_date').val($('#archive_system_log_end_date').val());
  });
});


$(function(){
  $('table#system_log_search_grid tbody tr').live('click',function(){
    $('table#system_log_search_grid tbody tr.trSelected').removeClass('trSelected');
    $(this).addClass('trSelected');
  });
});

$(function(){
  $('table#system_log_search_grid tbody tr').live('mouseover', function(){
    $(this).css('cursor',"pointer");
  });
});

$(function(){
  $('table#system_log_archive_grid tbody tr').live('click',function(){
    $('table#system_log_archive_grid tbody tr.trSelected').removeClass('trSelected');
    $(this).addClass('trSelected');
  });
});

$(function(){
  $('table#system_log_archive_grid tbody tr').live('mouseover', function(){
    $(this).css('cursor',"pointer");
  });
});

/*option hover*/
$(function(){
  $('.toggle_options').live('mouseover',function(){
    if ($("#" + $(this).attr('field')+'_mode').attr('mode') == "show"){
      $(this).find('.options').css('display','');
    }

  });
});

$(function(){
  $('.toggle_options').live('mouseout',function(){
    if ($("#" + $(this).attr('field')+'_mode').attr('mode') == "show"){
      $(this).find('.options').css('display','none');
    }
  });
});

$(function(){
  $('.edit_option').live('click',function(){
    $("#" + $(this).attr('field')+'_mode').attr('mode','edit');
    $('.new_option[field='+ $(this).attr('field') +']').css("display","none");
    $(".options").css("display", "none");
  });
});

$(function(){
  $('.close_option').live('click',function(){
    var link = $(this);
    if(link.attr("KeepEditStatus")!="true"){
      $('.flexigrid table.selectable_grid tr.IamEdited td').css("background-color","");
      $('.flexigrid table.selectable_grid tr.IamEdited').removeClass("IamEdited");
      $('.flexigrid table.selectable_grid tr.trSelected').removeClass("trSelected");
    }
        
    var temp = $('#check_input_change').val();
    var left_content = $("#content").find("#left_content");
    var  right_content = $("#content").find("#right_content");
    // if the web page got left and right side, do the judgement
    if (left_content.length > 0 &&  right_content.length > 0)
    {
      if ( $('#check_right_input_change').val() == "true"  )
      {
        temp = "true"
      }
      else
      {
        temp = "false"
      }
    }
        
    if ( temp=="true")
    {
      $('#warning_message_text').html("Data Not Saved.");
      $('#warning_message_image').css("display","");
      $('#warning_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {

          "Go Back" : function(){
            $(this).dialog('destroy');
            return false;

          },
          Exit: function(){
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $('#'+link.attr('toggle_id_name1')).toggle('blind');
            $("#" + link.attr('enable_id')).removeAttr('disabled');
            $('.select_ajax_call[field='+ link.attr('field') +']').attr('disabled', false);
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            clear_organisation_form(link);
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $('.close_option[field='+ link.attr('field') +']').css("display","none");
            if(link.attr('show_existing')=="true"){
              $('#'+link.attr('show_existing_id')).css('display', '');
            }


            if (left_content.length > 0 &&  right_content.length > 0)
            {
              $('#check_right_input_change').val("false");
            }
            else{
              $('#check_input_change').val("false");
            }
               


            $(this).dialog('destroy');
            $('table.selectable_grid[field='+ link.attr('field') +'] tbody tr.trEdited').removeClass('trEdited');
            return true;
          }
        }
      });
      $('#warning_message').dialog('option', 'title', 'Warning');

      $('#warning_message').parent().find("a").css("display","none");
      $("#warning_message").parent().css('background-color','#D1DDE6');
      $("#warning_message").css('background-color','#D1DDE6');

      $('#warning_message').dialog('open');
  
    }
    else
    {

      $('#'+link.attr('toggle_id_name')).toggle('blind');
      $('#'+link.attr('toggle_id_name1')).toggle('blind');
      $("#" + link.attr('enable_id')).removeAttr('disabled');
            
      $('.select_ajax_call[field='+ link.attr('field') +']').attr('disabled', false);
      $("#" + link.attr('field')+'_mode').attr('mode','show');
      clear_organisation_form(link);

      link.css("display","none");
      $('.new_option[field='+ link.attr('field') +']').css("display","");
      if($(this).attr('show_existing')=="true"){
        $('#'+$(this).attr('show_existing_id')).css('display', '');
      }
      $('.close_option[field='+ link.attr('field') +']').css("display","none");

    }

  });
});



$(function(){
  $('.new_option').live('click',function(){
    $("#" + $(this).attr('field')+'_mode').attr('mode','new');
    $(this).css("display","none");
    $('.close_option[field='+ $(this).attr('field') +']').css("display","");
  });
});




//system bar menu
$(function(){
  $("div#module_menu_top").click(function() {
    if($("div#module_menu_top").attr("class")==""){
      $("div#module_menu_top").addClass("hover");
      $("div#module_menu_items").fadeIn("fast");
    }else{
      $("div#module_menu_top").removeClass("hover");
      $("div#module_menu_items").fadeOut("fast");
    }
  });


  $("div#module_menu").hover(
    function(){},
    function(){
      $("div#module_menu_top").removeClass("hover");
      $("div#module_menu_items").fadeOut("fast");
    });


  $("div#module_menu_items li").hover(
    function(){
      $(this).removeClass("hover","fast");
    },
    function(){
      $(this).addClass("hover", "normal");
    });
});

//user preferences menu
$(function(){
  $("div#preferences_menu_top").click(function() {
    if($("div#preferences_menu_top").attr("class")==""){
      $("div#preferences_menu_top").addClass("hover");
      $("div#preferences_menu_items").fadeIn("fast");
    }else{
      $("div#preferences_menu_top").removeClass("hover");
      $("div#preferences_menu_items").fadeOut("fast");
    }
    return false;
  });


  $("div#preferences_menu").hover(
    function(){},
    function(){
      $("div#preferences_menu_top").removeClass("hover");
      $("div#preferences_menu_items").fadeOut("fast");
    });


  $("div#preferences_menu_items li").hover(
    function(){
      $(this).removeClass("hover","fast");
    },
    function(){
      $(this).addClass("hover", "normal");
    });
});






$(function(){
  $("#feedback").live("click", function(){

    $('#feedback_form').dialog( {
      modal: true,
      resizable: false,
      draggable : true,
      height: 580,
      width: 550
    }
    );
    $("#feedback_form").dialog("option","title","Feedback Form");
    $("#feedback_form").dialog("open");
    $("#feedback_item_subject").val("");
    $("#feedback_item_content").val("");
    $('#feedback_form_submit_button').attr('disabled', true);


  });


  $("#feedback").live("mouseover", function(){
    $(this).css("cursor","pointer");
  });
});


$(function() {
  $('#feedback_item_subject').keyup(function() {
    if($('#feedback_item_subject').val() == '' || $('#feedback_item_content').val() == '') {
      $('#feedback_form_submit_button').attr('disabled', true);
    } else {
      //            $('#feedback_form_submit_button').removeAttr('disabled');
      $('#feedback_form_submit_button').attr('disabled', false);
    }
  });
});

$(function() {
  $('#feedback_item_content').keyup(function() {
    if($('#feedback_item_subject').val() == '' || $('#feedback_item_content').val() == '') {
      $('#feedback_form_submit_button').attr('disabled', true);
    } else {
      //            $('#feedback_form_submit_button').removeAttr('disabled');
      $('#feedback_form_submit_button').attr('disabled', false);
    }
  });
});

/* disabled form */
$(function(){
  $(".disabled_form").find("input").attr("disabled", true);
  $(".disabled_form").find("select").attr("disabled", true);
});

disabled_form = function(){

  $(".disabled_form").find("input").not(".active_status").attr("disabled", true);

  $(".disabled_form").find("select").attr("disabled", true);
  $(".disabled_form").find(".person_lookup").css('display','none');
  $(".disabled_form").find(".organisation_lookup").css('display','none');
  $(".disabled_form").find(".launch_address_assistant").css('display','none');
  $(".disabled_form").find(".bank_lookup").css('display','none');
  $(".disabled_form").find(".ui-datepicker-trigger").css('display','none');


};


$(document).ready(function() {
  $(".admin_password_reset").validationEngine({
    validationEventTriggers:"blur",

    success :  false,

    failure : function() {
      callFailFunction()
    }

  });
});




/* sing out warning message*/

$('#signout').live('click', function(){
  //    $('#signout_warning_message_image').css("display","");
  //      $('#singoutmessage').css("display","");
  $('#signout_warning_message').dialog({

    modal: true,
    resizable: false,
    draggable: true,
    height: 'auto',
    width: 'auto',
    buttons: {

      "Go Back": function(){
        $(this).dialog('close');
        return true;

      },

      "Exit": function(){
        window.open("/signin/signout", "_self");
               
        signout_waiting();
        return true;
      }
    }
  });
  $('#signout_warning_message').dialog('option', 'title', 'Warning');
  $('#signout_warning_message').parent().find("a").css("display","none");
  $("#signout_warning_message").parent().css('background-color','#D1DDE6');
  $("#signout_warning_message").css('background-color','#D1DDE6');

  $('#signout_warning_message').dialog('open');
  return false;
});

signout_waiting = function(){

  $('#signout_warning_message').dialog('destroy');

  $('#signout_waiting_message').dialog({

    modal: true,
    resizable: false,
    draggable: true,
    height: 'auto',
    width: 'auto'
  });
  $('#signout_waiting_message').dialog('option', 'title', 'Warning');
  $('#signout_waiting_message').parent().find("a").css("display","none");
  $("#signout_waiting_message").parent().css('background-color','#D1DDE6');
  $("#signout_waiting_message").css('background-color','#D1DDE6');

  $('#signout_waiting_message').dialog('open');
  return false;

}


/* Dashboard */
$(function(){
  $(".read_more").live('click', function(){
    $(".system_news:not(#system_news_"+ $(this).attr("news_id") +")").toggleClass("hidden");
    $("#system_news_"+$(this).attr("news_id")).toggleClass("active");
    $("#system_news_"+ $(this).attr("news_id") +"> .news_content").toggleClass("hidden");
  });

  $("#message_more").live('click', function(){
    $("#message_less_container").css("display", "none");
    $("#message_more_container").css("display", "");
  });

  $("#message_less").live('click', function(){
    $("#message_less_container").css("display", "");
    $("#message_more_container").css("display", "none");
  });
});


//TO DO LIST
$(function(){
  $("#new_to_do").live('click', function(){
    $('#new_to_do_dialog').find("form").get(0).reset();
    $('#new_to_do_dialog').dialog( {
      modal: true,
      resizable: false,
      width: 600,
      height: 175,
      draggable: true
    });
    $('#new_to_do_dialog').dialog('option', 'title', 'New To Do Entry');
    $('#new_to_do_dialog').dialog('open');
  });

  $("#manage_to_do").live('click', function(){
    $.ajax({
      type: "GET",
      url: "/to_do_lists.js",
      dataType: "script"
    });
  });
});

// System News
$(function(){
  $("#new_news").live('click', function(){
    $('#new_system_news_dialog').find("form").get(0).reset();
    $('#new_system_news_dialog').dialog( {

      modal: true,
      resizable: false,
      width: 600,
      height: 400,
      draggable: true
    });
    $('#new_system_news_dialog').dialog('option', 'title', 'New System News Entry');
    $('#new_system_news_dialog').dialog('open');

  });

  $("#manage_system_news").live('click', function(){
    $.ajax({
      type: "GET",
      url: "/system_news.js",
      dataType: "script"
    });
  });

  $("#pre_three_news").live('click', function(){
    $.ajax({
      type: "GET",
      url: "/system_news/pre_three.js",
      data: "news_offset_number=" + $('#news_offset_number').val(),
      dataType: "script"
    });
  });

  $("#next_three_news").live('click', function(){
    $.ajax({
      type: "GET",
      url: "/system_news/next_three.js",
      data: "news_offset_number=" + $('#news_offset_number').val(),
      dataType: "script"
    });
  });
});



/*Check all input field change or not*/

$(function(){

  $("#content input[type='text']").live('change', function(){
    $(this).attr("spellcheck",true);
    left_content = $("#content").find("#left_content");
    right_content = $("#content").find("#right_content");
    if ((left_content.length > 0 &&  right_content.length > 0) || $(this).attr("class").indexOf('change_without_check_js')>0)
    {
    }
    else
    {
      $('#check_input_change').val("true");

    }

  });

  $("#content input[type='text']").live('keydown', function(){
    $(this).attr("spellcheck",true);
    left_content = $("#content").find("#left_content");
    right_content = $("#content").find("#right_content");
    if ((left_content.length > 0 &&  right_content.length > 0) || $(this).attr("class").indexOf('change_without_check_js')>0)
    {
    }
    else
    {
      $('#check_input_change').val("true");

    }

  });


  $("#content").find('textarea').live('change', function(){

    left_content = $("#content").find("#left_content");
    right_content = $("#content").find("#right_content");
    if (left_content.length > 0 &&  right_content.length > 0)
    {
    }
    else
    {

      $('#check_input_change').val("true");

    }
  });

  $("#content").find('textarea').live('keydown', function(){

    left_content = $("#content").find("#left_content");
    right_content = $("#content").find("#right_content");
    if (left_content.length > 0 &&  right_content.length > 0)
    {
    }
    else
    {

      $('#check_input_change').val("true");

    }
  });

          


});

$(function(){
  $("#content #left_content").find("input[type='text']").live('change', function(){
    $('#check_left_input_change').val("true");

  });


  $("#content #left_content").find("input[type='text']").live('keydown', function(){
    $('#check_left_input_change').val("true");
  });

});

$(function(){
  $("#content #right_content").find("input[type='text']").live('change', function(){
    right_tab = $("#right_content").find("#tabs");
    if(right_tab.length <= 0)
    {
      $('#check_right_input_change').val("true");
    }

  });

  $("#content #right_content").find("input[type='text']").live('keydown', function(){


    right_tab = $("#right_content").find("#tabs");
    if(right_tab.length <= 0)
    {
      $('#check_right_input_change').val("true");
    }

  });

// For the tinymce

    





});

check_input_change = function(){

  //    if($('#check_right_input_change').val() == "false")
  //    {

  if ($('#contact_input_change_or_not').val()=="true" || $('#address_input_change_or_not').val()=="true" ||  $('#master_doc_input_change_or_not').val()=="true" || $('#relationship_input_change_or_not').val() == "true" ||  $('#notes_input_change_or_not').val()=="true"||  $('#employment_input_change_or_not').val() == "true" || $('#role_input_change_or_not').val()=="true" ||$('#account_input_change_or_not').val()=="true"||$('#custom_field_input_change_or_not').val()=="true" )
  {

    $('#check_right_input_change').val("true");
  }
  else
  {

    $('#check_right_input_change').val("false");
  }
//     }



};

$(function(){
  $('#lc a').live('click', function(e){
    // if left-click
    if(e.button == 0){
      right_tab = $("#content #right_content").find("#tabs");
      //         alert(right_tab.length);
      if(right_tab.length > 0)
      {
        check_input_change();
      }


      left_content = $("#content").find("#left_content");
      right_content = $("#content").find("#right_content");
      //     alert( left_content.length);
      //     alert( right_content.length);
      if (left_content.length > 0 &&  right_content.length > 0)
      {
        //          $('#check_input_change').val("true");
        //          alert( $('#check_input_change').val());

        if ( $('#check_right_input_change').val() == "true" || $('#check_left_input_change').val() == "true" )
        {

          $('#check_input_change').val("true");
        }
        else
        {

          $('#check_input_change').val("false");
        }
      }
      var link = $(this);

      if($('#check_input_change').val() == "false"  )
      {
        window.open(link.attr('href'),"_self");

        return false;
      }
      else
      {
        $('#warning_message_text').html("Data Not Saved.");
        $('#warning_message_image').css("display","");
        $('#warning_message').dialog({
          modal: true,
          resizable: false,
          draggable: true,
          height: 'auto',
          width: 'auto',
          buttons: {

            "Go Back" : function(){
              $(this).dialog('destroy');
              return false;

            },
            "Exit" : function(){
              window.open(link.attr('href'),"_self");
              $('#check_left_input_change').val("false");
              $('#check_right_input_change').val("false");
              $('#check_input_change').val("false");
              $(this).dialog('destroy');
              return true;
            }
          }
        });
        $('#warning_message').dialog('option', 'title', 'Warning');

        $('#warning_message').parent().find("a").css("display","none");
        $("#warning_message").parent().css('background-color','#D1DDE6');
        $("#warning_message").css('background-color','#D1DDE6');

        $('#warning_message').dialog('open');
        return false;
      }
    }else{
      return false;
    }
  }).attr("rel", "nofollow");
});

$(function(){
  $('#sysbar a').live('click', function(e){
    // if left-click
    if(e.button == 0){
      right_tab = $("#content #right_content").find("#tabs");
      //         alert(right_tab.length);
      if(right_tab.length > 0)
      {
        check_input_change();
      }


      left_content = $("#content").find("#left_content");
      right_content = $("#content").find("#right_content");
      //     alert( left_content.length);
      //     alert( right_content.length);
      if (left_content.length > 0 &&  right_content.length > 0)
      {
        //          $('#check_input_change').val("true");
        //          alert( $('#check_input_change').val());

        if ( $('#check_right_input_change').val() == "true" || $('#check_left_input_change').val() == "true" )
        {

          $('#check_input_change').val("true");
        }
        else
        {

          $('#check_input_change').val("false");
        }
      }
      var link = $(this);
      if($('#check_input_change').val() == "false")
      {
        window.open(link.attr('href'),"_self");

        return false;
      }
      else
      {
        $('#warning_message_text').html("Data Not Saved.");
        $('#warning_message_image').css("display","");
        $('#warning_message').dialog({
          modal: true,
          resizable: false,
          draggable: true,
          height: 'auto',
          width: 'auto',
          buttons: {

            "Go Back" : function(){
              $(this).dialog('destroy');
              return false;

            },
            "Exit" : function(){
              window.open(link.attr('href'),"_self");
              $('#check_left_input_change').val("false");
              $('#check_right_input_change').val("false");
              $('#check_input_change').val("false");
              $(this).dialog('destroy');
              return true;
            }
          }
        });
        $('#warning_message').dialog('option', 'title', 'Warning');

        $('#warning_message').parent().find("a").css("display","none");
        $("#warning_message").parent().css('background-color','#D1DDE6');
        $("#warning_message").css('background-color','#D1DDE6');

        $('#warning_message').dialog('open');
        return false;
      }
    }else{
      return false;
    }
        
  }).attr("rel", "nofollow");
});

lolanavigation = function(link){
  right_tab = $("#content #right_content").find("#tabs");
  //         alert(right_tab.length);
  if(right_tab.length > 0)
  {
    check_input_change();
  }


  left_content = $("#content").find("#left_content");
  right_content = $("#content").find("#right_content");
  //     alert( left_content.length);
  //     alert( right_content.length);
  if (left_content.length > 0 &&  right_content.length > 0)
  {
    //          $('#check_input_change').val("true");
    //          alert( $('#check_input_change').val());

    if ( $('#check_right_input_change').val() == "true" || $('#check_left_input_change').val() == "true" )
    {

      $('#check_input_change').val("true");
    }
    else
    {

      $('#check_input_change').val("false");
    }
  }

  if($('#check_input_change').val() == "false")
  {
    if (link.attr('url').indexOf("people") > 0)
    {
      $.ajax({
        type: "GET",
        url: link.attr('url')+".js",
        data: 'active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.person_edit_tab.active').attr('field'),
        dataType: "script"
      });
    }
    if (link.attr('url').indexOf("organisations") > 0)
    {
      $.ajax({
        type: "GET",
        url: link.attr('url')+".js",
        data: 'active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.organisation_edit_tab.active').attr('field'),
        dataType: "script"
      });

    }


    return false;
  }
  else
  {
    $('#warning_message_text').html("Data Not Saved.");
    $('#warning_message_image').css("display","");
    $('#warning_message').dialog({
      modal: true,
      resizable: false,
      draggable: true,
      height: 'auto',
      width: 'auto',
      buttons: {

        "Go Back" : function(){
          $(this).dialog('destroy');
          return false;

        },
        "Exit" : function(){
          if (link.attr('url').indexOf("people") > 0)
          {
            $.ajax({
              type: "GET",
              url: link.attr('url')+".js",
              data: 'active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.person_edit_tab.active').attr('field'),
              dataType: "script"
            });
          }
          if (link.attr('url').indexOf("organisations") > 0)
          {
            $.ajax({
              type: "GET",
              url: link.attr('url')+".js",
              data: 'active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.organisation_edit_tab.active').attr('field'),
              dataType: "script"
            });

          }
          $('#check_left_input_change').val("false");
          $('#check_right_input_change').val("false");
          $('#check_input_change').val("false");
          $(this).dialog('destroy');
          return true;
        }
      }
    });
    $('#warning_message').dialog('option', 'title', 'Warning');

    $('#warning_message').parent().find("a").css("display","none");
    $("#warning_message").parent().css('background-color','#D1DDE6');
    $("#warning_message").css('background-color','#D1DDE6');

    $('#warning_message').dialog('open');
    return false;
  }
};

$(function(){
  $('#lol a').live('click', function(){
        
    lolanavigation($(this));
  }).attr("rel", "nofollow");
});



$(function(){
  $('#content input[type="submit"]').live('click', function(){

    left_content = $("#content").find("#left_content");
    right_content = $("#content").find("#right_content");
    if (!(left_content.length > 0 &&  right_content.length > 0))
    {
      $('#check_input_change').val("false");
    }


  });
});


$(function(){ /*This is for button to function*/
  $('#content input[type="button"]').live('click', function(){

    $('#check_input_change').val("false");

  });
});

$(function(){
  $('#left_content input[type="submit"]').live('click', function(){
    $('#check_left_input_change').val("false");

  });
});

$(function(){
  $('#right_content input[type="submit"]').live('click', function(){
    if ( $('#contact_input_change_or_not').val()=="true" || $('#address_input_change_or_not').val()=="true" ||  $('#master_doc_input_change_or_not').val()=="true" || $('#relationship_input_change_or_not').val() == "true" ||  $('#notes_input_change_or_not').val()=="true"||  $('#employment_input_change_or_not').val() == "true" || $('#role_input_change_or_not').val()=="true"||$('#account_input_change_or_not').val() == "true"||$('#custom_field_input_change_or_not').val() == "true")
    {
      $('#check_right_input_change').val("true");

    }
    else
    {
      $('#check_right_input_change').val("false");

    }
  });
});

/*Save My Dashboard*/

$(function(){
  $("#save_my_dashboard").click(function(){
    var my_box = [];
    for(i=1; i<=3; i++){
      var len = $("#column"+i).find(".portlet").length;
      var my_column = [];
      for(j=0; j<len; j++){
        my_column[j] = $('#'+($("#column"+i).find(".portlet"))[j].id).attr('box_id');
      }
      my_box[i] = my_column.join(",");
    }
    $.ajax({
      type: "GET",
      url: "/dashboards/save_dashboard.js",
      data: 'column1='+my_box[1]+'&column2='+my_box[2]+'&column3='+my_box[3],
      dataType: "script"
    });
  });

});
$(function(){
  $("#whoami").css({
    'opacity':'0.3'
  });
  $("#whoami").mouseover(
    function(){
      $(this).stop().fadeTo('fast',1 );
    });

  $("#whoami").mouseout(
    function (){
      $(this).stop().fadeTo('fast',0.3 );
    });
  return false;


});


/* Ajax call system */
$(function(){
  $(".ajax_call").live("click", function(){
    if ($(this).attr("light_box") == "true"){

      var link = $(this);
      if (link.attr("message")!="")
      {
        $('#warning_message_text').html("Are You Sure You Want to "+link.attr("message")+"?");
      }
      else
      {
        $('#warning_message_text').html("Are You Sure You Want to Change?  ");
      }


      $('#warning_message_image').css("display","");
      $('#warning_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {

          No: function(){
            $(this).dialog('destroy');
            return false;

          },
          Yes: function(){
                    
            $.ajax({
              type: link.attr("method"),
              url: link.attr("url"),
              data: 'param1='+link.attr("param1")+'&param2='+link.attr("param2")+'&param3='+link.attr("param3")+'&param4='+$(this).attr("param4")+'&render_page='+$(this).attr("render_page")+'&field='+$(this).attr("field"),
              dataType: "script"

            });
                       
            $(this).dialog('destroy');
            return true;
          }
        }
      });
      $('#warning_message').dialog('option', 'title', 'Warning');

      $('#warning_message').parent().find("a").css("display","none");
      $("#warning_message").parent().css('background-color','#D1DDE6');
      $("#warning_message").css('background-color','#D1DDE6');

      $('#warning_message').dialog('open');
      return false;

    }else{
      $.ajax({
        type: $(this).attr("method"),
        url: $(this).attr("url"),
        data: 'param1='+$(this).attr("param1")+'&param2='+$(this).attr("param2")+'&param3='+$(this).attr("param3")+'&param4='+$(this).attr("param4")+'&render_page='+$(this).attr("render_page")+'&field='+$(this).attr("field"),
        dataType: "script"
      });
    }
    return false;
  });
});

/*CSS tab switch system*/
$(".tab_switch_button").live('click', function(){
  // for organisation structure
  var active_org_structure = $('.nav_item.active');
  $('#content .active').removeClass("active");
  active_org_structure.addClass("active");
  $('#org_rel .active').removeClass("active");
  $(this).addClass("active");
  $(this).parent().addClass("active");
  $('.tab_switch_right[field='+ $(this).attr('field') +']').addClass("active");
  $('.tab_switch_left[field='+ $(this).attr('field') +']').addClass("active");
  $('#'+$(this).attr('field')).addClass("active");
  
});

$(".tab_switch_button_show_list").live('click', function(){
  $('#show_list_grid  .active').removeClass("active");
  $(this).addClass("active");
  $(this).parent().addClass("active");
  $('.tab_switch_right[field='+ $(this).attr('field') +']').addClass("active");
  $('.tab_switch_left[field='+ $(this).attr('field') +']').addClass("active");
  $('#'+$(this).attr('field')).addClass("active");
});


/*CSS tab menu_switch system*/
$(".tab menu_switch_button").live('click', function(){
  $('.active mene').removeClass("active menu");
  $(this).addClass("active menu");
  $(this).parent().addClass("active menu");
  $('.tab menu_switch_right[field='+ $(this).attr('field') +']').addClass("active menu");
  $('.tab menu_switch_left[field='+ $(this).attr('field') +']').addClass("active menu");
  $('#'+$(this).attr('field')).addClass("active menu");
});

// Address assistant //

$(document).ready(function() {

  $('.launch_address_assistant').live('click', function() {

    $(this).removeClass('launch_address_assistant');
    $(this).addClass('launch_address_assistant_disabled');
    var suburb = $("#"+$(this).attr("update_field1")).val();
    var state = $("#"+$(this).attr("update_field2")).val();
    var postcode = $("#"+$(this).attr("update_field3")).val();
    $('#address_postcode_input').attr("update_field1", $(this).attr("update_field1"));
    $('#address_postcode_input').attr("update_field2", $(this).attr("update_field2"));
    $('#address_postcode_input').attr("update_field3", $(this).attr("update_field3"));
    $('#address_postcode_input').attr("update_field4", $(this).attr("update_field4"));
    $.ajax({
      type: "GET",
      url: "/people/show_postcode.js",
      data: 'suburb='+suburb+'&postcode='+postcode+'&state='+state,
      dataType: "script"
    });
  });
});

$(function(){
  $('table#address_postcode tbody tr').live('dblclick',function(){
    $('table#address_postcode tbody tr.trSelected').removeClass('trSelected');
    $(this).addClass('trSelected');

    $.ajax({
      type: 'GET',
      url: "/people/"+$(this).attr('id').substring(3)+"/postcode_look_up.js",
      data:'update_field1='+$("#address_postcode_input").attr("update_field1")+'&update_field2='+$("#address_postcode_input").attr("update_field2")+'&update_field3='+$("#address_postcode_input").attr("update_field3")+'&update_field4='+$("#address_postcode_input").attr("update_field4"),
      dataType: "script"
    });
    $('#address_form_assistant').dialog('close');
  });
});


$(function(){
  $('table#address_postcode tbody tr').live('click',function(){
    $('table#address_postcode tbody tr.trSelected').removeClass('trSelected');
    $(this).addClass('trSelected');
  });
});

$(function(){
  $('table#address_postcode tbody tr').live('mouseover', function(){
    $(this).css('cursor', "pointer");
  });
});


$(function(){
  $('.address_assistant_search').keyup(function() {
    $.ajax({
      type: "GET",
      url: "/addresses/0/search_postcodes.js",
      data: 'suburb='+$('#address_assistant_suburb').val()+'&state='+$('#address_assistant_state').val()+'&postcode='+$('#address_assistant_postcode').val(),
      dataType: "script"
    });
  });
});

$(function(){
  $('.list_assistant_search').live('keyup', function() {
    $.ajax({
      type: "GET",
      url: "/people/search_lists.js",
      data: 'name='+$('#list_assistant_name').val()+'&phone='+$('#list_assistant_phone').val()+'&email='+$('#list_assistant_email').val(),
      dataType: "script"
    });
  });
});

/* Person Bank Account Grid*/
$(function(){
  $('table#show_person_bank_accounts_grid tbody tr').live('click',function(){
    if($('#person_bank_account_mode').attr('mode')=="show"){
      $('table#show_person_bank_accounts_grid tbody tr.trSelected').removeClass('trSelected');
      $(this).addClass('trSelected');
    }else{
      $(this).removeClass('trSelected');
    }
  });

  $('table#show_person_bank_accounts_grid tbody tr').live('dblclick',function(){
    if($('#person_bank_account_mode').attr('mode')=="show"){
      $.ajax({
        type: 'GET',
        url: "/client_setups/edit_person_bank_account/"+$(this).attr('id').substring(3),
        dataType: "script"
      });
    }
  });

});

// When we have a form to edit we need to disable all the fields except the status field

$(function(){
  $(".disable_on_inactive").live('change',function(){
    $.ajax({
      type: "GET",
      url: "/tags/show_role_condition_description.js",
      data: 'doctype_id='+$(this).val(),
      dataType: "script"

    });
  });
});

/* Show Add Role Condition Description */

$(function(){
  $("#doctype_id").live('change',function(){
    $.ajax({
      type: "GET",
      url: "/tags/show_role_condition_description.js",
      data: 'doctype_id='+$(this).val(),
      dataType: "script"

    });
  });
});

/*show submit button*/


mandantory_check = function(link)
{

 

  if($('#'+link.attr('mandantory_field1')).val()==''||$('#'+link.attr('mandantory_field2')).val()=='' ||$('#'+link.attr('mandantory_field3')).val()==''||$('#'+link.attr('mandantory_field4')).val()==''||$('#'+link.attr('mandantory_field5')).val()==''||$('#'+link.attr('mandantory_field6')).val()==''||$('#'+link.attr('mandantory_field7')).val()==''||$('#'+link.attr('mandantory_field8')).val()==''||$('#'+link.attr('mandantory_field9')).val()==''||$('#'+link.attr('mandantory_field10')).val()=='')
  {
    $('#'+link.attr('submit_button_id')).attr('disabled', true);

  }
  else
  {
    $('#'+link.attr('submit_button_id')).attr('disabled', false);
  }
};

$(function(){
  $(".mandantory_dropdown_list").live('change',function(){

    mandantory_check($(this));

  });
});

$(function(){
  $(".mandantory_field").live('keyup',function(e){
    if(e.which != 13){
      if ($.trim($(this).val())!="")
      {
        mandantory_check($(this));
      }
      else
      {
        $('#'+$(this).attr('submit_button_id')).attr('disabled', true);
      }
    }
  });
});

//This is for select the data from dropdownlist in input field
$(function(){
  $(".mandantory_field").live('change',function(){

    if ($.trim($(this).val())!="")
    {
      mandantory_check($(this));
    }
    else
    {
      $('#'+$(this).attr('submit_button_id')).attr('disabled', true);
    }

  });
});







$(function(){
  $("#copy_allocation_type_button").live('click', function(){

    $('#allocation_type_save_form').dialog('close');
    $('#allocation_type_save_form').dialog( {
      modal: true,
      resizable: true,
      draggable: true
    });
    $('#allocation_type_save_form').dialog('option', 'title', 'New Query');
    $('#allocation_type_save_form').dialog('open');
    $('#allocation_type_save_form').parent().css('background-color','#D1DDE6');
    $('#allocation_type_save_form').css('background-color','#D1DDE6');

  });
});


//Transaction
/* Show unbanked transaction Grid*/





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
//      alert("a");
//      alert(current_form.attr("id"));
//          alert(current_form.attr("'submit_button_id"));
      $('#'+current_form.attr('submit_button_id')).attr('disabled', true);
    }else{
//      alert("b");
//        alert(current_form.attr("id"));
//        alert(current_form.attr("'submit_button_id"));
      $('#'+current_form.attr('submit_button_id')).removeAttr('disabled');
    }
    return false;
  };

  $(".compulsory_field").live('keyup', function(e){

  
    var current_form = $('#'+$(this).closest('form').attr('id'));
    if(e.which!=13){
      if ($.trim($(this).val())!="")
      {

        compulsory_check($(this));
      }
      else
      {


        $('#'+current_form.attr('submit_button_id')).attr('disabled', true);
      }
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
});


/* optional field setting for controlling submit button*/
$(function(){
  optional_check = function(link){
    var current_form = $('#'+link.closest('form').attr('id'));
    var optional_fields = current_form.find('.optional_field');
    var length = optional_fields.length;
    var disable = true;
    for(i=0; i<length; i++){
      if ($('#'+optional_fields[i].id).val()!=''){
        disable = false;
        break;
      }
    }
    if (disable){
      $('#'+current_form.attr('submit_button_id')).attr('disabled', true);
    }else{
      a = current_form.attr('submit_button_id')
      $('#'+current_form.attr('submit_button_id')).removeAttr('disabled');
    }
    return false;
  };

  $(".optional_field").live('keyup', function(){
    optional_check($(this));
  });

  $(".optional_field").live('change', function(){
    optional_check($(this));
  });
});


//from person.js

$(function() {

  $(".toggle_button").live('click', function(){
    $('#'+$(this).attr('toggle_id_name')).toggle('blind');
  });

  $(".toggle_button_clear").live('click', function(){
    $('#'+$(this).attr('toggle_id_name')).html("");
  });


  $(".toggle_div").live('click', function(){
    $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    var current_image;
    if ($(this).attr('expand_with_arrow') == "true"){
      current_image = $(this).find('img[alt=Expand]');
    }else{
      current_image = $(this).find('img');
    }

    if (current_image.attr('src').indexOf('expand') > 0){
      current_image.attr('src','/images/Icons/System/collapse.png');
    }else{
      current_image.attr('src','/images/Icons/System/expand.png');
    }
  });






  $(".toggle_button1").click(function(){
    $('#'+$(this).attr('toggle_id_name1')).toggle('blind');
    $('#'+$(this).attr('toggle_id_name2')).toggle('blind');

  });

  $(".toggle_button2").click(function(){
    $('#'+$(this).attr('toggle_id_name')).css("display","");
    $('#'+$(this).attr('toggle_id_name1')).css("display","none");
    $('#'+$(this).attr('toggle_id_name2')).css("display","none");
    $('.toggle_button2').find('img').attr('src','/images/Icons/System/expand.png');
    $(this).find('img').attr('src','/images/Icons/System/collapse.png');
  });

  $(".close_image").live('click', function(){
    $(this).children('img').attr('src', '/images/Icons/System/collapse.png');
    $(this).removeClass('close_image');
    $(this).addClass('open_image');
  });

  $(".open_image").live('click', function(){
    $(this).children('img').attr('src', '/images/Icons/System/expand.png');
    $(this).removeClass('open_image');
    $(this).addClass('close_image');
  });

  $(".show_hide_button").live('click', function(){
    $('#'+$(this).attr('show_id_name')).css("display","");
    $('.profile_tab_right[field='+ $(this).attr('show_id_name') +']').css("background-image","url(/images/round_right.png)");
    $('.profile_tab_left[field='+ $(this).attr('show_id_name') +']').css("background-image","url(/images/round_left.png)");
    //    $('.pppp[field='+ $(this).attr('show_id_name') +']').css("display","");
    $('#'+$(this).attr('hide_id_name')).css("display","none");
    $('.profile_tab_right[field='+ $(this).attr('hide_id_name') +']').css("background-image","none");
    $('.profile_tab_left[field='+ $(this).attr('hide_id_name') +']').css("background-image","none");
    // $('.pppp[field='+ $(this).attr('hide_id_name') +']').css("display","none");
    $(".container_icon").removeClass("container_icon_color");
    $(this).parent().addClass("container_icon_color");

    $('.pppp[field='+ $(this).attr('show_id_name') +']').removeClass('hidden');
  });
  /*
	  Replaces text of the toggle link, with the alt_text,
	  and toggles an object with the class assigned to
	  toggle_more_id
 */

  $(".toggle_more").click(function(){
    var $alt_text = $(this).attr('alt_text');
    $(this).attr({
      alt_text: $(this).html()
    });
    $(this).html($alt_text);
    $('#'+$(this).attr('toggle_more_id')).toggle();
  });


  $(".clear_form").live('click',function(){

    var link = $(this);
    var  left_content = $("#content").find("#left_content");
    var  right_content = $("#content").find("#right_content");
    if (left_content.length > 0 &&  right_content.length > 0)
    {
      if ( $('#check_right_input_change').val() == "true" || $('#check_left_input_change').val() == "true" )
      {

        $('#check_input_change').val("true");
      }
      else
      {

        $('#check_input_change').val("false");
      }
    }


    if($('#check_input_change').val()=="true")
    {

      $('#warning_message_text').html("Are You Sure You Wish to Clear The Entered Data? ");
      $('#warning_message_image').css("display","");
      $('#warning_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {

          No: function(){
            $(this).dialog('destroy');
            return true;

          },
          Yes: function(){
            $('#'+link.parents("form").get(0).id)[0].reset();
            $('.mandantory_field').keyup();
            $('#check_input_change').val("false");
            $('#check_left_input_change').val("false");
            $('#check_right_input_change').val("false");
            $(this).dialog('destroy');
            return true;
          }
        }
      });
      $('#warning_message').dialog('option', 'title', 'Warning');

      $('#warning_message').parent().find("a").css("display","none");
      $("#warning_message").parent().css('background-color','#D1DDE6');
      $("#warning_message").css('background-color','#D1DDE6');

      $('#warning_message').dialog('open');



    }
    else
    {

      $('#'+link.parents("form").get(0).id)[0].reset();

    }
  });

  $(".user_clear_form").click(function(){
    $('#'+$(this).parents("form").get(0).id)[0].reset();
    $('#login_name_container_0').html('');
    $('#user_name_container_0').html('');

    $('#no_password').hide();
    $('#yes_password').hide();
    $('#no_username').hide();
    $('#yes_username').hide();

  })
});

$(function(){
  $("#accordion").accordion();
  $("#accordion01").accordion();
  $("#accordion02").accordion();

});


clear_organisation_form = function(link){

  if(link.attr('toggle_id_name')=="new_contact")
  {
    $("#new_phone")[0].reset();
    $("#new_email")[0].reset();
    $("#new_website")[0].reset();
  }

  if(link.attr('toggle_id_name')=="new_address")
  {
    $("#new_address")[0].reset();

  }

  if(link.attr('toggle_id_name')=="new_note")
  {
    $("#new_note")[0].reset();

  }
  if(link.attr('toggle_id_name')=="new_master_doc")
  {
    $("#new_master_doc")[0].reset();

  }
  if(link.attr('toggle_id_name')=="new_organisation_relationship")
  {
    $("#organisation_relationship_related_organisation_id").val("").keyup();
    $("#related_organisation_level").html("");
    $("#related_organisation_level_label").html("");
    $("#related_organisation_name_container").html("");

  }

};

// Tag hover system
$(function(){
  $(".multilevel_new_option").live("click", function(){
    $("li.open").removeClass("open");
    $("li.active").removeClass("active");
    $(".toggle_multilevel_options").removeClass("container_selected");
  });


  $(".toggle_multilevel_options").live("click", function(){
    if ($(this).parent().attr("class").indexOf("open")>=0){
      $(this).parent().removeClass("open");
    }else{
      $("li.open[level="+ $(this).parent().attr("level")+"]").removeClass("open");
      $(this).parent().addClass("open");
    }
    $("li").removeClass("active");
    $(this).parent().addClass("active");
    $(".toggle_multilevel_options").removeClass("container_selected");
    $(this).addClass("container_selected");
  });

  $(".toggle_multilevel_options").live("mouseover", function(){
    $(this).css("cursor","pointer");
    $(this).find(".options").addClass("active");
  });

  $(".toggle_multilevel_options").live("mouseout", function(){
    $(this).find(".options").removeClass("active");
  });
});

//tag system
$(function(){
  $(".new_tag_meta_type").live("click", function(){
    $.ajax({
      type: "GET",
      url: "/tag_meta_types/new.js",
      data: 'tag=' + $(this).attr('tag'),
      dataType: "script"
    });
  });

  $(".new_tag_type").live("click", function(){
    container = $(this).parent().parent();
    container.parent().removeClass("open");
    $.ajax({
      type: "GET",
      url: "/tag_types/new.js",
      data: 'tag=' + $(this).attr('tag') + '&tag_meta_type_id=' + $(this).attr('tag_meta_type_id'),
      dataType: "script"
    });
  });

  $(".new_tag").live("click", function(){
    container = $(this).parent().parent();
    container.parent().removeClass("open");
    $.ajax({
      type: "GET",
      url: "/tags/new.js",
      data: 'tag=' + $(this).attr('tag') + '&tag_type_id=' + $(this).attr('tag_type_id'),
      dataType: "script"
    });
  });

  $('a.get_tag').live('click', function() {
    container = $(this).parent().parent();
    container.parent().removeClass("open");
    $("li").removeClass("active");
    container.parent().addClass("active");
    $(".toggle_multilevel_options").removeClass("container_selected");
    container.addClass("container_selected");
    var link = $(this);
    $.get(link.attr('href'), null ,null, 'script');
    return false;
  }).attr("rel", "nofollow");

  jQuery('a.get_tag').removeAttr('onclick');
});


/* transaction */
$(function(){
  $('.fake_submit_button').live('click',function(){
    $('#'+$(this).attr('form_id')).doAjaxSubmit();
    disable_form_after_submit($('#'+$(this).attr('form_id')));
  });
});


$(function(){
  $('a.tab_switch_with_page_initial').live('click', function(){

    var link = $(this);
    var temp = $('#check_input_change').val();
    var left_content = $("#content").find("#left_content");
    var  right_content = $("#content").find("#right_content");
    // if the web page got left and right side, do the judgement
    if (left_content.length > 0 &&  right_content.length > 0)
    {
      if ( $('#check_right_input_change').val() == "true"  )
      {
        temp = "true"
      }
      else
      {
        temp = "false"
      }
    }
      

    if(temp == "false")
    {
      $('.page_initial[field='+ link.attr('field')+']').mousedown();
      $('.tab_switch_button[field='+ link.attr('field')+']').click();
      $('.tab_switch_button_show_list[field='+ link.attr('field')+']').click();
      $('#current_tab_id').val(link.attr('field'));

    }
    else
    {
      $('#warning_message_text').html("Data Not Saved.");
      $('#warning_message_image').css("display","");
      $('#warning_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {

          "Go Back" : function(){
            $(this).dialog('destroy');
            return false;

          },
          "Exit" : function(){
            $('.page_initial[field='+ link.attr('field')+']').mousedown();
            $('.tab_switch_button[field='+ link.attr('field')+']').click();
            $('.tab_switch_button_show_list[field='+ link.attr('field')+']').click();
            $('#current_tab_id').val(link.attr('field'));
            if (left_content.length > 0 &&  right_content.length > 0)
            {

              $('#check_right_input_change').val("false");
            }
            else
            {
              $('#check_input_change').val("false");
            }
    
            $(this).dialog('destroy');
            return true;
          }
        }
      });
      $('#warning_message').dialog('option', 'title', 'Warning');

      $('#warning_message').parent().find("a").css("display","none");
      $("#warning_message").parent().css('background-color','#D1DDE6');
      $("#warning_message").css('background-color','#D1DDE6');

      $('#warning_message').dialog('open');
      return false;
    }
    return false;
  });
});


$(function(){
  $(".page_initial").live('mousedown', function(){
    $("#"+$(this).attr("field")).html("<div class='spinner'></div>");

    if ($(this).attr("type") == "Person"){
      $(".person_edit_tab").removeClass("active");
      $(".person_edit_tab:not(.active)").mouseout();
      $(".tab_switch_with_page_initial[field ="+ $(this).attr('field')+"]").find("img").attr("src","/images/Icons/Core/Person/tabs/"+$(this).parent().attr("field")+"_title.png");
    }
        
    if ($(this).attr("type") == "Organisation"){
      $(".organisation_edit_tab").removeClass("active");
      $(".organisation_edit_tab:not(.active)").mouseout();
      $(".tab_switch_with_page_initial[field ="+ $(this).attr('field')+"]").find("img").attr("src","/images/Icons/Core/Org/tabs/"+$(this).parent().attr("field")+"_title.png");
    }
    $(this).parent().addClass("active");

    $.ajax({
      type: $(this).attr("method"),
      url: $(this).attr("url"),
      // params1 for let it as undefined for grid controller show list grid
      //parmas2 for judement this page is edit or show
      data: 'render_page='+$(this).attr("render_page")+'&field='+$(this).attr("field")+'&params1='+$(this).attr("params1")+'&type='+$(this).attr("type")+'&active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.person_edit_tab.active').attr('field')+'&param1='+$(this).attr('param1')+'&params2='+$(this).attr("params2"),

      dataType: "script"
    });
  });
});




/* Show transaction allocation Grid*/
$(function(){
  $('table#show_existing_transaction_allocations_grid tbody tr').live('click',function(){
    if($('#edit_transaction_allocation_mode').attr('mode')=="show"){
      $('table#show_existing_transaction_allocations_grid tbody tr.trSelected').removeClass('trSelected');
      $(this).addClass('trSelected');
    }else{
      $(this).removeClass('trSelected');
    }
  });

  $('table#show_existing_transaction_allocations_grid tbody tr').live('dblclick',function(){
    if($('#edit_transaction_allocation_mode').attr('mode')=="show"){
      $.ajax({
        type: 'GET',
        url: "/transaction_allocations/"+$(this).attr('id').substring(3)+"/edit.js",
        dataType: "script"
      });
    }
  });

  $('table#show_existing_transaction_allocations_grid tbody tr').live('mouseover',function(){
    if($('#edit_transaction_allocation_mode').attr('mode')=="show"){
      $(this).css('cursor',"pointer");
    }else{
      $(this).css('cursor',"");
    }
  });
});


//for general use get the person name or organasation name
$(function(){
  $(".general_name_show").live('change', function(){
    if($(this).val() != ""){
      $.ajax({
        type: "GET",
        url:"/people/general_name_show.js",
        data:'person_id='+$(this).val()+'&update_field='+$(this).attr('update_field')+'&input_field='+$(this).attr('input_field'),
        dataType: "script"
      });
    }else{

      $("#"+$(this).attr('update_field')).html("");
    }
  });
});

$(function(){
  $(".org_general_name_show").live('change', function(){
    if($(this).val() != ""){
      $.ajax({
        type: "GET",
        url:"/organisations/org_general_name_show.js",
        data:'organisation_id='+$(this).val()+'&update_field='+$(this).attr('update_field')+'&input_field='+$(this).attr('input_field'),
        dataType: "script"
      });
    }
    else{
      $("#"+$(this).attr('update_field')).val("");
    }
  });
});


find_org_name_for_relationship = function(target){
  $('#org_spinner').show();
  $.ajax({
    type: "GET",
    url:"/organisations/org_relationship_name_show.js",
    data:'organisation_id='+target+'&update_field=related_organisation_name&input_field=related_organisation_id',
    dataType: "script"
  });
};


/*transaction--money--number field check*/
number_check = function(link)
{
  _valid = /^(\d|,)*\.?\d*$/.test(link.val());
  if(link.val()!=""){
    if((!_valid) || link.val()<0){

      $('#error_message_text').html("Entered Value Must Be Number Only");

      $('#error_message_image').css("display","");
      $('#error_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {
          "OK": function(){
            link.focus();
            link.val('');
            $(this).dialog('destroy');
            link.change();
            return true;
          }
        }
      });
      $('#error_message').dialog('option', 'title', 'Error');
      $('#error_message').parent().find("a").css("display","none");
      $("#error_message").parent().css('background-color','#D1DDE6');
      $("#error_message").css('background-color','#D1DDE6');
      $('#error_message').dialog('open');
    }
  }
  return false;
};

$(function(){
  $(".number_field").live('keyup', function(){

    number_check($(this));
  });
});

/*matain---geo_area*/
$(function(){
  $(".select_ajax_call").live('change', function(){
    if($(this).val() != ""){
      if($(this).attr("update_field")!=undefined){
        $('#'+$(this).attr("update_field")).attr("disabled", "true");
      }
      $.ajax({
        type: $(this).attr("method"),
        url: $(this).attr("url"),
        data: 'param1='+$(this).val()+'&type='+$(this).attr('type_class')+'&update_field='+$(this).attr('update_field'),
        dataType: "script"
      });
    }else{


      $('#add_new_'+ $(this).attr('field')).html('');

      if($(this).attr('field')=="postcode"){
        $('#existing_postcodes').html('');
      }else{
        $('#existing_'+ $(this).attr('field')).html('');

      }
      $('#edit_'+ $(this).attr('field')+'_form').html('');

    }
  });
});

// Feedback - which is used throughout the system

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


// people-organisation show list reuse part and grid dbclick - click--reuse part




/* Show list*/
$(function(){
  $(".general_show_all_list_member").live('click',function(){
    var link = $(this);
    if($('#check_input_change').val() == "false")
    {
      $.ajax({
        type: "GET",
        url: "/people/general_show_list.js",
        data: 'person_id='+link.attr('person_id'),
        dataType: "script"

      });

      return false;
    }
    else
    {
      $('#warning_message_text').html("Data Not Saved.");
      $('#warning_message_image').css("display","");
      $('#warning_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {

          "Go Back" : function(){
            $(this).dialog('destroy');
            return false;

          },
          "Exit" : function(){
            $.ajax({
              type: "GET",
              url: "/people/general_show_list.js",
              data: 'person_id='+link.attr('person_id'),
              dataType: "script"

            });
            $('#check_left_input_change').val("false");
            $('#check_right_input_change').val("false");
            $('#check_input_change').val("false");
            $(this).dialog('destroy');
            return true;
          }
        }
      });
      $('#warning_message').dialog('option', 'title', 'Warning');

      $('#warning_message').parent().find("a").css("display","none");
      $("#warning_message").parent().css('background-color','#D1DDE6');
      $("#warning_message").css('background-color','#D1DDE6');

      $('#warning_message').dialog('open');
      return false;
    }

  });
});

$(function(){
  $(".general_show_all_list_member").live('mouseover',function(){
    $(this).css("cursor","pointer");
  });
});


/* Show Summary list*/
$(function(){
    
  $('table.selectable_grid tbody tr').live('click',function(){

    var form_id = $(this).closest('table').get(0).id
    var form = $('#'+form_id);
    if (form.attr('click_function') == "true"){
      $.ajax({
        type: 'GET',
        url: $('#'+ form_id).attr('click_url'),
        data: 'grid_object_id='+$(this).attr('id').substring(3)+'&params1='+form.attr('params1')+'&current_tab_id='+$('#current_tab_id').val(),
        dataType: "script"
      });
    }
    if($('#'+form.attr('field')+"_mode").attr('mode')=='show' || $('#'+form.attr('field')+"_mode").attr('mode')==undefined){
      $('table.selectable_grid tbody tr.trSelected').removeClass('trSelected');
      $(this).addClass("trSelected");
    }else{
      $(this).removeClass("trSelected");
    }
  });

  $('table.selectable_grid tbody tr').live('dblclick',function(){
        
    var form_id = $(this).closest('table').get(0).id;

    var form = $('#'+form_id);
    if (form.attr('db_click_function') == "true" && ($('#'+form.attr('field')+"_mode").attr('mode')=='show' || $('#'+form.attr('field')+"_mode").attr('mode')==undefined))
    {
      $("#" + form_id + " tbody tr.trEdited").removeClass('trEdited');
      $(this).addClass("trEdited");
      var url = form.attr('db_click_url');
      var type = "GET";
      if (form.attr('edit')=="true")
      {
        url=url+$(this).attr('id').substring(3)+"/edit.js";
      }
      if (form.attr('create')=="true"){
        type = "POST";
      }
      if (form.attr('db_show')=="true")
      {
        url=url+$(this).attr('id').substring(3)+".js";
      }

      $.ajax({
        type: type,
        url: url,
        data: 'grid_object_id='+$(this).attr('id').substring(3)+'&params2='+form.attr('params2')+'&target='+form.attr('target')+'&current_tab_id='+$('#current_tab_id').val(),
        dataType: "script"
      });
    }
    if (form.attr('db_close') == "true")
    {
      $('.ui-icon-closethick').click();
    }
  });

  $('table.selectable_grid tbody tr').live('mouseover',function(){
    $(this).css("cursor","pointer");
  });

  $('.close_edit').live('click', function(){


    $('table.selectable_grid[field='+ $(this).attr('field') +'] tbody tr.trEdited').removeClass('trEdited');

  });
});




/*show_list orgnasation---*/
$(function(){
  $(".general_show_all_list_organisations").live('click',function(){

    var link = $(this);
    if($('#check_input_change').val() == "false")
    {

      $.ajax({
        type: "GET",
        url: "/organisations/general_show_list.js",
        data: 'organisation_id='+link.attr('organisation_id'),
        dataType: "script"
      });

      return false;
    }
    else
    {
      $('#warning_message_text').html("Data Not Saved.");
      $('#warning_message_image').css("display","");
      $('#warning_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {

          "Go Back" : function(){
            $(this).dialog('destroy');
            return false;

          },
          "Exit" : function(){

            $.ajax({
              type: "GET",
              url: "/organisations/general_show_list.js",
              data: 'organisation_id='+link.attr('organisation_id'),
              dataType: "script"
            });
            $('#check_left_input_change').val("false");
            $('#check_right_input_change').val("false");
            $('#check_input_change').val("false");
            $(this).dialog('destroy');
            return true;
          }
        }
      });
      $('#warning_message').dialog('option', 'title', 'Warning');

      $('#warning_message').parent().find("a").css("display","none");
      $("#warning_message").parent().css('background-color','#D1DDE6');
      $("#warning_message").css('background-color','#D1DDE6');

      $('#warning_message').dialog('open');
      return false;
    }





  });
});

$(function(){
  $(".general_show_all_list_organisations").live('mouseover',function(){

    $(this).css("cursor","pointer");
  });
});


/* Organisation Lookup*/
$(function(){
  $(".organisation_lookup").live('click', function(){
    $(this).removeClass('organisation_lookup');
    $(this).addClass('organisation_lookup_disabled');
    $.ajax({
      type: "GET",
      url:"/organisations/lookup.js",
      data:'update_field='+$(this).attr('update_field'),
      dataType: "script"
    });
  });

  $("table#organisation_lookup_grid tbody tr").live("dblclick", function(){
    $.ajax({
      type: "GET",
      url:"/organisations/lookup_fill.js",
      data:'id='+$(this).attr('id').substring(3) + "&update_field=" + $("table#organisation_lookup_grid").attr('update_field'),
      dataType: "script"
    });

  });

  $("table#organisation_lookup_grid tbody tr").live("click", function(){
    $('table#organisation_lookup_grid tbody tr.selected').removeClass('selected');
    $(this).addClass("selected");
  });
  $('table#organisation_lookup_grid tbody tr').live('mouseover',function(){
    $(this).css("cursor", "pointer");
  });
});

/* Person Lookup*/
$(function(){
  $(".person_lookup").live('click', function(){
    $(this).removeClass('person_lookup');
    $(this).addClass('person_lookup_disabled');
    $.ajax({
      type: "GET",
      url:"/people/lookup.js",
      data:'update_field='+$(this).attr('update_field'),
      dataType: "script"
    });
  });

  $("table#person_lookup_grid tbody tr").live("dblclick", function(){
    $.ajax({
      type: "GET",
      url:"/people/lookup_fill.js",
      data:'id='+$(this).attr('id').substring(3) + "&update_field=" + $("table#person_lookup_grid").attr('update_field'),
      dataType: "script"
    });

  });

  $("table#person_lookup_grid tbody tr").live("click", function(){
    $('table#person_lookup_grid tbody tr.trSelected').removeClass('trSelected');
    $(this).addClass('trSelected');

  });

  $('table#person_lookup_grid tbody tr').live('mouseover',function(){
    $(this).css('cursor',"pointer");
  });
});

//general show more detail for select field
$(function(){
  $('.select_to_show_more_detail').live('change', function(){
    $('.'+$(this).attr('target_class')).css('display', 'none');
    $('#'+$(this).attr('target_class')+'_'+$(this).val()).css('display','');
  });

});

//Drag and Drop
config_drag_drop= function(){
  $('.draggable').draggable({
    helper: "clone"
  });

  $('.droppable').droppable({
    
    drop: function(event, ui) {
      var target = $('.ui-draggable-dragging');
      if (target.attr('controller') != undefined){
        target.remove();
        $.ajax({
          type: "POST",
          url: "/quick_launch_icons",
          data:'icon_controller='+ target.attr('controller')+ "&icon_action=" + target.attr('action')+ "&image_url=" + target.attr('image_url')+ "&title=" + target.attr('title')+"&icon_module=" + target.attr('icon_module'),
          dataType:"script"
        });
      }
            
    },
        
    out: function(event, ui) {
      var target = $('.ui-draggable-dragging');
      if (target.attr('data_id') != undefined){
        target.remove();
        $.ajax({
          type: "DELETE",
          url: "/quick_launch_icons/"+ target.attr('data_id'),
          dataType:"script"
        });
      }
    }
  });

};


$(function(){
  config_drag_drop();

});

config_drag= function(){
  $('.draggable').draggable({
    helper: "clone"

  });
};



//disable form after submit and enable form after submit finish
//$('input[type="submit"]').live('click', function(){
//  disable_form_after_submit($(this));
//});
//$('.fake_submit_button').live('click', function(){
//  disable_form_after_submit($(this));
//});


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
  submit_button.after('<div id="spinner" style="height: 24px; float: right; background-image: url(/images/load.gif); background-repeat: no-repeat; background-position: center center; width: 50px; margin-right: 10px;"></div>');
  
};

enable_form_after_submit_finish = function(){
  $("form :input").removeAttr("readonly");
  $("form :select").removeAttr("readonly");
  $("form :textarea").removeAttr("readonly");
  $('form :input[type="submit"]').removeAttr("disabled");
  $('.fake_submit_button').removeAttr("disabled");
  $('#spinner').remove();
};

enable_form_after_submit_finish_extension = function(target_form, flag){
  $("#" + target_form + " :input").removeAttr("readonly");
  $("#" + target_form + " :select").removeAttr("readonly");
  $("#" + target_form + " :textarea").removeAttr("readonly");
  if (flag == false){
    $("#" + target_form + ' :input[type="submit"]').removeAttr("disabled");
  }
  $('#spinner').remove();
};

////// Modify my account
$(function(){
  $("#modify_my_accounts").click(function(){
    $.ajax({
      type: "POST",
      url: "/user_preferences/show_modify_my_account",
      dataType:"script"
    });
    return false;
  });
});

////// Display Who AM I
$(function(){
  $("#show_whoami").click(function(){
    $.ajax({
      type: "POST",
      url: "/user_preferences/show_whoami",
      dataType:"script"
    });
    return false;
  });
});




/*show_object_general_function_for all use*/
$(function(){
  $(".show_all_objects_look_up").live('click',function(){

    var link = $(this);
    if($('#check_input_change').val() == "false")
    {

      $.ajax({
        type: "GET",
        //url: "/organisations/general_show_list.js",
        url: link.attr('look_up_url'),
        data: 'object_id='+link.attr('object_id'),
        dataType: "script"
      });

      return false;
    }
    else
    {
      $('#warning_message_text').html("Data Not Saved.");
      $('#warning_message_image').css("display","");
      $('#warning_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {

          "Go Back" : function(){
            $(this).dialog('destroy');
            return false;

          },
          "Exit" : function(){

            $.ajax({
              type: "GET",
              url: link.attr('look_up_url'),
              data: 'object_id='+link.attr('object_id'),
              dataType: "script"
            });
            $('#check_left_input_change').val("false");
            $('#check_right_input_change').val("false");
            $('#check_input_change').val("false");
            $(this).dialog('destroy');
            return true;
          }
        }
      });
      $('#warning_message').dialog('option', 'title', 'Warning');

      $('#warning_message').parent().find("a").css("display","none");
      $("#warning_message").parent().css('background-color','#D1DDE6');
      $("#warning_message").css('background-color','#D1DDE6');

      $('#warning_message').dialog('open');
      return false;
    }





  });
});

$(function(){
  $(".show_all_objects_look_up").live('mouseover',function(){

    $(this).css("cursor","pointer");
  });
});



/*for iphone switch use*/

iphone_checkbox = function(){

  $(':checkbox').iphoneStyle();

};


/* for help button */
$(function(){
  //ajax invoke the help lightbox
  $("#help_icon_tab").click(function(){
    $.ajax({
      type: "POST",
      url: "/helps/show",
      data: "current_controller="+$("#controller").val()+"&current_action="+$("#action").val(),
      dataType: "script"
    });
    return false;
  });

  //when click the title of a search result, use the title and content of search result to update left help_content
  $("#search_result .title").live('click',function(){
    $("#help_content .title").html($(this).html());
    $("#help_content .content").html($(this).next().html());
  });
});



delete_from_grid = function(grid,mode,type,url){
  var trSelected = grid
  var id = "";

  if($(mode).attr('mode')=="show"){
    if (trSelected != undefined){
      id = trSelected.substring(3);
      $('#warning_message_text').html("Are you sure you wish to delete this record?");
      $("#warning_message").dialog({
        modal:false,
        resizable:false,
        draggable:false,
        height: 'auto',
        width: 'auto',
        buttons:{

          NO: function(){
            $(this).dialog("destroy");

          },

          Yes: function(){
            $.ajax({
              type: type,
              url: url+id,
              data: "id="+id,
              dataType: "script"
            });
            $(this).dialog('destroy');
            return true;
          }
        }

      });
    }else{
      $('#warning_message_text').html("Please select the record you want to delete");
      $('#warning_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {
          Ok: function(){
            $(this).dialog('destroy');
            return false;
          }
        }

      });
    }
    $('#warning_message_image').css("display","");
    $('#warning_message').dialog('option', 'title', 'Warning');
    $('#warning_message').parent().find("a").css("display","none");
    $("#warning_message").parent().css('background-color','#D1DDE6');
    $("#warning_message").css('background-color','#D1DDE6');
    $('#warning_message').dialog('open');
    return false;
  }
  return false;
};

delete_from_grid_with_target = function(target, grid, mode, type, url){
  var trSelected = grid
  var id = "";

  if($(mode).attr('mode')=="show"){
    if (trSelected != undefined){
      id = trSelected.substring(3);
      $('#warning_message_text').html("Are you sure you wish to delete this record?");
      $("#warning_message").dialog({
        modal:false,
        resizable:false,
        draggable:false,
        height: 'auto',
        width: 'auto',
        buttons:{

          NO: function(){
            $(this).dialog("destroy");
            return false;
          },

          Yes: function(){
            $.ajax({
              type: type,
              url: url+id,
              data: "id="+id+"&target="+target,
              dataType: "script"
            });
            $(this).dialog('destroy');
            return true;
          }
        }

      });
    }else{
      $('#warning_message_text').html("Please select the record you want to delete");
      $('#warning_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {
          Ok: function(){
            $(this).dialog('destroy');
            return false;
          }
        }

      });
    }
    $('#warning_message_image').css("display","");
    $('#warning_message').dialog('option', 'title', 'Warning');
    $('#warning_message').parent().find("a").css("display","none");
    $("#warning_message").parent().css('background-color','#D1DDE6');
    $("#warning_message").css('background-color','#D1DDE6');
    $('#warning_message').dialog('open');
    return false;
  }
  return false;
};


retrieve_from_grid = function(grid,mode,type,url){
  var trSelected = grid
  var id = "";
  if($(mode).attr('mode')=="show"){
    if (trSelected != undefined){
      id = trSelected.substring(3);
      $.ajax({
        type: type,
        url: url,
        data: "id="+id,
        dataType: "script"
      });
    }
  }

};


tinymce_init = function(){

  tinyMCE.init({
    // General options
    mode: "textareas",
    theme : "advanced",
    skin: "o2k7",
    editor_selector : "mceEditor",
    editor_deselector : "mceNoEditor",
    plugins : "table,insertdatetime,preview",
    theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect,cut,copy,paste,pastetext,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
    theme_advanced_buttons2 : "tablecontrols,|,",
    theme_advanced_buttons3 : "",
    width : 1050,
    height : 500,
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left"
  });
};

/*for general 2 level drop down list hook*/

$(function(){
  $(".general_drop_down_level").live('change', function(){
    if($(this).val()){
      $.ajax({
        type: $(this).attr("method"),
        url: $(this).attr("url"),
        data: 'level1_value='+$(this).val()+'&level2='+$(this).attr("level2")+'&drop_down_field='+$(this).attr("drop_down_field"),
        dataType: "script"
      });
    }else{
      $('.drop_down_level2[drop_down_field='+ $(this).attr('drop_down_field') +']').html("");
      $('.drop_down_level2_description[drop_down_field='+ $(this).attr('drop_down_field') +']').html("<label class='descriptions'>&nbsp;</label>");
          
    }
  });
});

$(function(){
  $(".general_drop_down_level_2_3").live('change', function(){
    if($(this).val()){
      $.ajax({
        type: $(this).attr("method"),
        url: $(this).attr("url"),
        data: 'level2_value='+$(this).val()+'&level3='+$(this).attr("level3")+'&drop_down_field='+$(this).attr("drop_down_field"),
        dataType: "script"
      });
    }else{
      $('.drop_down_level3[drop_down_field='+ $(this).attr('drop_down_field') +']').html("");
      $('.drop_down_level3_description[drop_down_field='+ $(this).attr('drop_down_field') +']').html("<label class='descriptions'>&nbsp;</label>");

    }
  });
});


/*for select ban the submit*/
select_ban_submit_check = function(link){
  var current_form = $('#'+ link.closest('form').get(0).id);
  var select_ban_submits = current_form.find('.select_ban_submit');
  var length = select_ban_submits.length;
  var disable = true;

  for(i=0; i<length; i++){
    if ($('#'+select_ban_submits[i].id).val()=='0'||$('#'+select_ban_submits[i].id).val()== null||$.trim($('#'+select_ban_submits[i].id).val())== ""){
      disable = true;
      break;
    }
    else{
         
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



$(".select_ban_submit").live('change', function(){
  select_ban_submit_check($(this));
});

$(".select_ban_submit").live('keyup', function(){
  select_ban_submit_check($(this));
});





//post_code_auto = function(link){
//  // link = this---this input field
//
//  var current_form = $('#'+ link.closest('form').attr('id'));
//  var suburb = current_form.find('.suburb_value').val();
//  var state = current_form.find('.state_value').val();
//  var postcode =current_form.find('.postcode_auto').val();
//  if (suburb != ""&& state != ""){
//
//    $.ajax({
//      type: "GET",
//      url: "/postcodes/lookup_postcode.js",
//      data: 'state='+state+'&suburb='+suburb,
//      dataType: "script"
//    });
//
//  }else{
//
//}
//
//};



//$(function(){
//
//  //    $('.state_value').blur(function(){
//  $('.state_value').live('change',function(){
//    post_code_auto($(this));
//
//  });
//
//});
//
//$(function(){
//
//  //    $('.suburb_value').blur(function(){
//  $('.suburb_value').live('change',function(){
//    post_code_auto($(this));
//
//  });
//
//});




// check date input
check_date = function(value){


  _valid = /^(((0[1-9]|[12]\d|3[01])\-(0[13578]|1[02])\-((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\-(0[13456789]|1[012])\-((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\-02\-((19|[2-9]\d)\d{2}))|(29\-02\-((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$/.test(value.val());
  if(value.val()!=""){
    if((!_valid)){
      var link = value;

      $('#error_message_text').html("Invalid Date Format");

      $('#error_message_image').css("display","");
      $('#error_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {
          "OK": function(){

            link.val("").change();
            link.focus();

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


    }
  }


}


$(".hasDatepicker").live('change',function(){
  check_date($(this));
});

hasDatepicker= function()
{
  $(".hasDatepicker").live('change',function(){
    check_date($(this));
  });

}


/*for all validating input field use*/

$(function(){

  $('input[numeric]').live('keyup',function(){
    var d= $(this).attr('numeric');
    var value = $(this).val();
    var orignalValue = value
    val = value.replace(/[0-9]*/g, "")
    var msg="Only Integer Values allowed.";
    if (d=='decimal'){
      value=value.replace(/\./, "");
      msg="Only Numeric Values allowed.";
    }

    if (val!=''){
      orignalValue=orignalValue.replace(/([^0-9].*)/g, "")
      $(this).val(orignalValue);
    }
  }
  )
});


//user preferences  --default value

$(function(){

  $('#user_defaule_value').click(function(){

    $.ajax({
      type: "GET",
      url: "/user_preferences/default_value",
      dataType: "script"
    });
    return false;

  })
});



//function for alert message when a link is clicked
alert_with_link = function(link, e){
  // if left-click
  if(e.button == 0){
    right_tab = $("#content #right_content").find("#tabs");
    if(right_tab.length > 0)
    {
      check_input_change();
    }
    left_content = $("#content").find("#left_content");
    right_content = $("#content").find("#right_content");
    if (left_content.length > 0 &&  right_content.length > 0)
    {
      if ( $('#check_right_input_change').val() == "true" || $('#check_left_input_change').val() == "true" )
      {
        $('#check_input_change').val("true");
      }
      else
      {
        $('#check_input_change').val("false");
      }
    }

    if($('#check_input_change').val() == "false"  )
    {
      window.open(link.attr('href'),"_self");
      return false;
    }
    else
    {
      $('#warning_message_text').html("Data Not Saved.");
      $('#warning_message_image').css("display","");
      $('#warning_message').dialog({
        modal: true,
        resizable: false,
        draggable: true,
        height: 'auto',
        width: 'auto',
        buttons: {
          "Go Back" : function(){
            $(this).dialog('destroy');
            return false;
          },
          "Exit" : function(){
            window.open(link.attr('href'),"_self");
            $('#check_left_input_change').val("false");
            $('#check_right_input_change').val("false");
            $('#check_input_change').val("false");
            $(this).dialog('destroy');
            return true;
          }
        }
      });
      $('#warning_message').dialog('option', 'title', 'Warning');
      $('#warning_message').parent().find("a").css("display","none");
      $("#warning_message").parent().css('background-color','#D1DDE6');
      $("#warning_message").css('background-color','#D1DDE6');
      $('#warning_message').dialog('open');
      return false;
    }
  }else{
    return false;
  }
};

$(function(){
  $('.alert_with_link_container a').live('click', function(e){
    alert_with_link($(this), e);
    return false;
  });
});


$(function(){
  $('.spin_start').live('click', function(){
    $("#"+$(this).attr("field")).html("<div class='spinner'></div>");
    return false;
  });
});

/*For Organisation relationship*/
$(function(){
  $(".organisation_relationship_reset").live('click',function(){
    if ($(this).attr('use') == "profile_show"){
      $.ajax({
        type: "GET",
        url: "/organisation_relationships/profile_show_branches.js",
        data: "grid_object_id="+$(this).attr("grid_object_id")+"&target="+$(this).attr("target"),
        dataType: "script"
      });
    

    }else{
      $.ajax({
        type: "GET",
        url: "/organisation_relationships/show_branches.js",
        data: "grid_object_id="+$(this).attr("grid_object_id")+"&target="+$(this).attr("target"),
        dataType: "script"
      });

    }
  });
});


$(function(){
  $('.password').pstrength();
});




address_helper_zipcode = function(){
  link = $(this.el)
  var current_form = $('#'+ link.closest('form').attr('id'));
  var suburb = current_form.find('.suburb_value').val();
  var state = current_form.find('.state_value').val();
  var country = current_form.find('.country_value').val();
  var postcode =current_form.find('.postcode_auto').val();
  if (suburb != ""&& state != ""){
    $('.post_spinner[field='+ link.attr('field')+']').show();
    $.ajax({
      type: "GET",
      url: "/postcodes/lookup_postcode.js",
      data: 'state='+state+'&suburb='+suburb+'&country='+country,
      dataType: "script"
    });

  }else{

}

};

$(function(){
  $(".state_value").typeWatch( {
    callback: address_helper_zipcode
  } );
  $(".suburb_value").typeWatch( {
    callback: address_helper_zipcode
  } );
});


//type check for photo files uploading
$(function(){
  testFileType = function(fileName, fileTypes){
    if(fileName){
      dots = fileName.split('.');
      fileType = '.'+dots[dots.length-1];
      if(fileTypes.join('.').indexOf(fileType) == -1){
        $('#error_message_text').html("Invalid File. Please Only Upload Files In Types: \n\n" + (fileTypes.join('.')));
        $('#error_message_image').css("display","");
        $('#error_message').dialog({
          modal: true,
          resizable: false,
          draggable: true,
          height: 'auto',
          width: 'auto',
          buttons: {
            "OK": function(){
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
      }
    }
  }

  $('#image_image_file').live('change', function(){
    testFileType($(this).val(), ['gif','jpg','png','jpeg']);
  });
});

//post_code_auto = function(link){
//  // link = this---this input field
//
//  var current_form = $('#'+ link.closest('form').attr('id'));
//  var suburb = current_form.find('.suburb_value').val();
//  var state = current_form.find('.state_value').val();
//  var postcode =current_form.find('.postcode_auto').val();
//  if (suburb != ""&& state != ""){
//
//    $.ajax({
//      type: "GET",
//      url: "/postcodes/lookup_postcode.js",
//      data: 'state='+state+'&suburb='+suburb,
//      dataType: "script"
//    });
//
//  }else{
//
//}
//
//};