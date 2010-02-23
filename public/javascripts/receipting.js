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





/* Campaign Grid*/


$(function() {
  $('#copy_campaign').live('click', function() {

    $.ajax({
      type: "GET",
      url: "/receipting/copy_campaign.js",
      data: 'id=' + $(this).attr('campaign'),
      dataType: "script"
    });
  });
});

/* Campaign Source Grid*/


/* Receipt Account Grid*/


$(function() {
  $('#copy_receipt_account').live('click', function() {

    $.ajax({
      type: "GET",
      url: "/receipt_accounts/copy.js",
      data: 'id=' + $(this).attr('receipt_account'),
      dataType: "script"
    });
  });
});

/* Receipt Method Grid*/
$(function(){
  $('table#show_receipt_methods_grid tbody tr').live('click',function(){
    if($('#receipt_method_mode').attr('mode')=="show"){
      $('table#show_receipt_methods_grid tbody tr.trSelected').removeClass('trSelected');
      $(this).addClass('trSelected');
    }else{
      $(this).removeClass('trSelected');
    }
  });

  $('table#show_receipt_methods_grid tbody tr').live('dblclick',function(){
    if($('#receipt_method_mode').attr('mode')=="show"){
      $.ajax({
        type: 'GET',
        url: "/receipt_methods/edit_receipt_method/"+$(this).attr('id').substring(3),
        dataType: "script"
      });
    }
  });


  $('table#show_receipt_methods_grid tbody tr').live('mouseover',function(){
    if($('#receipt_method_mode').attr('mode')=="show"){
      $(this).css('cursor',"pointer");
    }else{
      $(this).css('cursor',"");
    }
  });
});

$(function() {
  $('#copy_receipt_method').live('click', function() {
    $.ajax({
      type: "GET",
      url: "/receipt_methods/copy_receipt_method.js",
      data: 'id=' + $(this).attr('receipt_method'),
      dataType: "script"
    });
  });

});

/*System ID Submit*/
system_id_check_input_change_or_not_transaction = function()
{

  var link = $('#system_id_tag');

  if($('#check_input_change').val() == "false")
  {
    $('#'+link.attr('form_name')).doAjaxSubmit();
    return false;
  }
  else
  {
    $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT? ");
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
          $('#transaction_list_header').val($('#transaction_list_header').attr('old_value'));
          return false;
        },
        Yes: function(){
          $('#'+link.attr('form_name')).doAjaxSubmit();
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
  $('#transaction_list_header').live('change', function(){
    system_id_check_input_change_or_not_transaction();
  });
});

transactionnavigation = function(link){
  if($('#check_input_change').val() == "false")
  {
    $.ajax({
      type: "GET",
      url: link.attr('url')+".js",
      data: 'current_tab_id='+$('#current_tab_id').val()+'&target='+link.attr('title'),
      dataType: "script"
    });
    return false;
  }
  else
  {
    $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT? ");
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
            type: "GET",
            url: link.attr('url')+".js",
            data: 'current_tab_id='+$('#current_tab_id').val()+'&target='+link.attr('title'),
            dataType: "script"
          });
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
}

$(function(){
  $('.transaction_navigator').live('click', function(){
    transactionnavigation($(this));
  }).attr("rel", "nofollow");

});



//person organisation name change


$(function(){
  $('.entity_type_change').live('change', function(){
    var input_field = $('#'+$(this).attr('input_field'));
    var update_field = $('#'+$(this).attr('update_field'));
    var lookup_field = $('#'+$(this).attr('lookup_field'));
    input_field.val("");
    update_field.html("");
    if($(this).val() == "Person"){

      input_field.removeClass('org_general_name_show').removeClass('general_name_show').addClass('general_name_show');
      lookup_field.removeClass('organisation_lookup').removeClass('person_lookup').addClass('person_lookup');

    }else{

      input_field.removeClass('org_general_name_show').removeClass('general_name_show').addClass('org_general_name_show');
      lookup_field.removeClass('person_lookup').removeClass('organisation_lookup').addClass('organisation_lookup');
    }
    return false;

  });
});

//transaction histroy export
$(function(){
  $('#export_to_pdf_button').live('click',function(){
    var start_date = $("#filter_start_date").val();
    var end_date = $("#filter_end_date").val();
    window.open("/transaction_headers/export_histroy_to_report.pdf?start_date="+start_date+"&end_date="+end_date);
  });
});

//Transaction Bank Run If the User ID is Empty, Set the value is All
$(function(){
  $('#filter_user_id').blur(function(){
    if($(this).val() == "")
    {
      $(this).val("All");
    }
    return false;
  });

  $('#transaction_run').click(function(){
    $('#rollback').show();
    return true;
  })
});

//For the Enquiry

$(function(){
  $('#select_filter').live("change",function(){


    if ($(this).val()=="ID Range")
    {

      $('#visible_select_fileter').append($('#id_range_filter'));
      $('#filter_start_id').attr('disabled',false);
      $('#filter_end_id').attr('disabled',false);

      $('#id_range_filter').show();
    }
    else if ($(this).val()=="Receipt Range")
    {
      $('#visible_select_fileter').append($('#receipt_range_filter'));
      $('#filter_start_receipt_id').attr('disabled',false);
      $('#filter_end_receipt_id').attr('disabled',false);

      $('#receipt_range_filter').show();
    }
    else if ($(this).val()=="System Date")
    {
      $('#visible_select_fileter').append($('#system_date_range_filter'));
      $('#filter_start_system_date').attr('disabled',false);
      $('#filter_end_system_date').attr('disabled',false);
      $('#system_date_range_filter').show();
    }
    else if ($(this).val()=="Transaction Date")
    {

      $('#visible_select_fileter').append($('#transaction_date_range_filter'));
      $('#filter_start_transaction_date').attr('disabled',false);
      $('#filter_end_transaction_date').attr('disabled',false);
      $('#transaction_date_range_filter').show();
    }
    else if ($(this).val()=="Bank Account Number")
    {
      $('#visible_select_fileter').append($('#bank_account_number_filter'));

      $('#bank_account_number_filter').show();
    }
    else if ($(this).val()=="Banking Status")
    {
      $('#visible_select_fileter').append($('#banking_status_filter'));

      $('#banking_status_filter').show();
    }
    else if ($(this).val()=="Receipt Type")
    {
      $('#visible_select_fileter').append($('#receipt_type_filter'));

      $('#receipt_type_filter').show();
    }
    else if ($(this).val()=="Receipt Account")
    {
      $('#visible_select_fileter').append($('#receipt_account_filter'));
      $('#receipt_account_filter').show();
    }
    else if ($(this).val()=="Letter")
    {
      $('#visible_select_fileter').append($('#leter_filter'));
      $('#leter_filter').show();
    }

    $(this).children('option[value="'+$(this).val()+'"]').attr('disabled',true);
    $(this).val("");
    return false;
  });


  $(".enquiry_filter_close").live("click",function(){

    var date = new Date();
    var month = (date.getMonth()+1).toString();
    var dom = date.getDate().toString();
    if (month.length == 1) month = "0" + month;
    if (dom.length == 1) dom = "0" + dom;
    if ($(this).attr("field")=="ID Range")
    {
      $('#filter_start_id').attr('disabled',true);
      $('#filter_end_id').attr('disabled',true);
       $('#filter_start_id').val("1");
      $('#filter_end_id').val("10000");
      $('#hidden_select_fileter').append($('#id_range_filter'));
      $('#id_range_filter').hide();
    }
    else if ($(this).attr("field")=="Receipt Range")
    {
      $('#filter_start_receipt_id').attr('disabled',true);
      $('#filter_end_receipt_id').attr('disabled',true);
      $('#filter_start_receipt_id').val("1");
      $('#filter_end_receipt_id').val("10000");
      $('#hidden_select_fileter').append($('#receipt_range_filter'));
      $('#receipt_range_filter').hide();
    }
    else if ($(this).attr("field")=="System Date")
    {
      $('#filter_start_system_date').attr('disabled',true);
      $('#filter_end_system_date').attr('disabled',true);
      $('#filter_start_system_date').val(dom+"-"+month+"-"+(date.getFullYear()-1).toString());
      $('#filter_end_system_date').val(dom+"-"+month+"-"+date.getFullYear().toString());
      $('#hidden_select_fileter').append($('#system_date_range_filterr'));
      $('#system_date_range_filter').hide();
    }
    else if ($(this).attr("field")=="Transaction Date")
    {

      $('#filter_start_transaction_date').attr('disabled',true);
      $('#filter_end_transaction_date').attr('disabled',true);
      $('#filter_start_transaction_date').val(dom+"-"+month+"-"+(date.getFullYear()-1).toString());
      $('#filter_end_transaction_date').val(dom+"-"+month+"-"+date.getFullYear().toString());
      $('#hidden_select_fileter').append($('#transaction_date_range_filter'));
      $('#transaction_date_range_filter').hide();
    }
    else if ($(this).attr("field")=="Bank Account Number")
    {
      $('#hidden_select_fileter').append($('#bank_account_number_filter'));
      $('#bank_account_number').val("0");
      $('#bank_account_number_filter').hide();
    }
    else if ($(this).attr("field")=="Banking Status")
    {
      $('#hidden_select_fileter').append($('#banking_status_filter'));
            $('#banked').val("0");
      $('#banking_status_filter').hide();
    }
    else if ($(this).attr("field")=="Receipt Type")
    {
      $('#hidden_select_fileter').append($('#receipt_type_filter'));
            $('#receipt_meta_type_id').val("0");
      $('#enquiry_receipt_type').val("0");
      $('#received_via_id').val("0");
      $('#receipt_type_filter').hide();
    }
    else if ($(this).attr("field")=="Receipt Account")
    {
      $('#hidden_select_fileter').append($('#receipt_account_filter'));
      $('#receipt_account_id').val("0");
      $('#receipt_account_filter').hide();
    }
    else if ($(this).attr("field")=="Letter")
    {
      $('#hidden_select_fileter').append($('#leter_filter'));
      $('#letter_id').val("0");
      $('#leter_filter').hide();
    }

    $('#select_filter').children('option[value="'+$(this).attr("field")+'"]').attr('disabled',false);
    $('#select_filter').val("");

    return false;
  });

});


//For Bank Run More options

$(function(){
  $('#bank_run_select_filter').change(function(){

    if ($(this).val()=="Account Number")
    {

      $('#visible_select_fileter').append($('#bank_id_filter'));

      $('#bank_id_filter').show();
    }
    else if ($(this).val()=="User ID")
    {
      $('#visible_select_fileter').append($('#user_id_filter'));

      $('#user_id_filter').show();
    }
    else if ($(this).val()=="Transaction ID")
    {
      $('#filter_start_id').attr('disabled',false);
      $('#filter_end_id').attr('disabled',false);
      $('#visible_select_fileter').append($('#transaction_id_range_filter'));

      $('#transaction_id_range_filter').show();
    }
    else if ($(this).val()=="Transaction Date")
    {
      $('#filter_start_transaction_date').attr('disabled',false);
      $('#filter_end_transaction_date').attr('disabled',false);
      $('#visible_select_fileter').append($('#transaction_date_range_filter'));

      $('#transaction_date_range_filter').show();
    }

    $(this).children('option[value="'+$(this).val()+'"]').attr('disabled',true);
    $(this).val("");
    return false;
  });

  $(".bank_run_close").click(function(){


    if ($(this).attr("field")=="Account Number")
    {

      $('#hidden_select_fileter').append($('#bank_id_filter'));
      $('#bank_id_filter').hide();
      $('#bank_account_number').val("0");
    }
    else if ($(this).attr("field")=="User ID")
    {

      $('#hidden_select_fileter').append($('#user_id_filter'));
      $('#user_id_filter').hide();
      $('#filter_user_id').val("All");
    }
    else if ($(this).attr("field")=="Transaction ID")
    {

      $('#filter_start_id').attr('disabled',true);
      $('#filter_end_id').attr('disabled',true);
      $('#filter_start_id').val("1");
      $('#filter_end_id').val("10000");
      $('#hidden_select_fileter').append($('#transaction_id_range_filter'));
      $('#transaction_id_range_filter').hide();
    }
    else if ($(this).attr("field")=="Transaction Date")
    {
      var date = new Date();
      var month = (date.getMonth()+1).toString();
      var dom = date.getDate().toString();
      if (month.length == 1) month = "0" + month;
      if (dom.length == 1) dom = "0" + dom;

      $('#filter_start_transaction_date').attr('disabled',true);
      $('#filter_end_transaction_date').attr('disabled',true);
      $('#hidden_select_fileter').append($('#transaction_date_range_filter'));
      $('#transaction_date_range_filter').hide();
      $('#filter_start_transaction_date').val(dom+"-"+month+"-"+(date.getFullYear()-1).toString());
      $('#filter_end_transaction_date').val(dom+"-"+month+"-"+date.getFullYear().toString());
    }
    $('#bank_run_select_filter').children('option[value="'+$(this).attr("field")+'"]').attr('disabled',false);
    $('#bank_run_select_filter').val("");




    return false;
  });





  $("#bank_run_more_option").live("click",function(){

    $(this).css("display","none");
    
  });




  $("#bank_run_filter_close").live("click",function(){

  
    $("#enquiry_filter").css("display","none");
    $("#bank_run_more_option").css("display","");
    $("#transaction_bank_run").get(0).reset();

    $('#bank_id_filter').hide();
    $('#user_id_filter').hide();
    $('#transaction_id_range_filter').hide();
    $('#transaction_date_range_filter').hide();
    $('#bank_run_select_filter').children('option').attr('disabled',false);

  });

  
});
