// All ajax requests will trigger the wants.js block
// of +respond_to do |wants|+ declarations

$(function(){
    $("#tabs").tabs();
});

$(function(){
    $("#tabs2").tabs();
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
    // All A tags with class 'get', 'post', 'put' or 'delete' will perform an ajax call
    $('a.get').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");


    $('a.move_down_address_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_up_address_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_down_phone_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_up_phone_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");


    $('a.move_down_email_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_up_email_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_down_website_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_up_website_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_down_master_doc_priority').live('click', function() {
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.move_up_master_doc_priority').live('click', function() {


        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");



    //To use for the person contact edit close button to show the warning message

    $('a.get_close').live('click', function() {
        var change_type = "false";
        if($(this).attr('field')== "contact")
        {
            change_type =$('#contact_input_change_or_not').val();
 
        }
        if($(this).attr('field')== "address")
        {
            change_type =$('#address_input_change_or_not').val();

        }

        if($(this).attr('field')== "master_doc")
        {
            change_type =$('#master_doc_input_change_or_not').val();

        }

        if($(this).attr('field')== "relationship")
        {
            change_type =$('#relationship_input_change_or_not').val();

        }

        if($(this).attr('field')== "note")
        {
            change_type =$('#notes_input_change_or_not').val();

        }

        if($(this).attr('field')== "person_role")
        {
            change_type =$('#role_input_change_or_not').val();

        }

        if($(this).attr('field')== "employment")
        {
            change_type =$('#employment_input_change_or_not').val();
 
        }
        if($(this).attr('field')== "group")
        {
            change_type =$('#group_input_change_or_not').val();

        }
        //                if($(this).attr('field')== "organisation_contact")
        //          {
        //            change_type =$('#organisation_contact_input_change_or_not').val();
        //          }
        var link = $(this);
        if(change_type=="true" )
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
                        
                        if(link.attr('field')== "contact")
                        {

                            $('#contact_input_change_or_not').val("false");
                        }
                        if(link.attr('field')== "address")
                        {
          
                            $('#address_input_change_or_not').val("false");
                        }

                        if(link.attr('field')== "master_doc")
                        {
           
                            $('#master_doc_input_change_or_not').val("false");
                        }

                        if(link.attr('field')== "relationship")
                        {
          
                            $('#relationship_input_change_or_not').val("false");
                        }

                        if(link.attr('field')== "note")
                        {
                            $('#notes_input_change_or_not').val("false");
                        }

                        if(link.attr('field')== "person_role")
                        {

                            $('#role_input_change_or_not').val("false");
                        }

                        if(link.attr('field')== "employment")
                        {

                            $('#employment_input_change_or_not').val("false");
                        }
                        if(link.attr('field')== "group")
                        {

                            $('#group_input_change_or_not').val("false");
                        }

                        $.get(link.attr('href'), null ,null, 'script');

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
            $.get(link.attr('href'), null ,null, 'script');
            return false;
        }
        return false;
    });

    //To use this function, please add data_id attributes to the link and the element id point to should be the form
    $('a.post').live('click', function(){
        $.post($(this).attr('href'), $("#" + $(this).attr("data_id")).serialize(),null,'script');
        return false;
    }).attr("rel", "nofollow");

    $('a.put').live('click', function() {
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

jQuery.fn.submitWithAjax = function($callback) {
    this.live('submit', function() {
        $.post($(this).attr("action"), $(this).serialize(), $callback, "script");
        return false;
    });
    return this;
};

jQuery.fn.doAjaxSubmit = function($callback) {
    $.post($(this).attr("action"), $(this).serialize(), $callback, "script");
    return false;
};

$(document).ready(function() {
    $(".ajax_form").submitWithAjax();
});





/*Date picker */
$('.birthdatepick').live("mouseover", function(){
    $(this).datepicker({
        dateFormat: 'dd-mm-yy',
        altFormat: 'mm-dd-yy',
        changeMonth: true,
        changeYear: true,
        maxDate: '+0d',
        yearRange: '-150:+0'
    });
});


$('.startdatepick').live("mouseover", function(){
    $("#"+$(this).attr("end_date")).datepicker('enable');
    var arr_dateText = $("#"+$(this).attr("end_date")).val().split("-");
    day = arr_dateText[0];
    month = arr_dateText[1];
    year = arr_dateText[2];

    if(year!=undefined){
        $(this).datepicker('option', 'maxDate', new Date(year, month-1, day-1));
    }else{
        $(this).datepicker({
            dateFormat: 'dd-mm-yy',
            altFormat: 'mm-dd-yy',
            changeMonth: true,
            changeYear: true
        });
    }

});



$('.enddatepick').live("mouseover", function(){
    var arr_dateText = $("#"+$(this).attr("start_date")).val().split("-");
    day = arr_dateText[0];
    month = arr_dateText[1];
    year = arr_dateText[2];
    //init
    $(this).datepicker({
        dateFormat: 'dd-mm-yy',
        altFormat: 'mm-dd-yy',
        changeMonth: true,
        changeYear: true,
        minDate: new Date(year, month-1, day)
    });

    //reset
    if(year!=undefined){
        $(this).datepicker('option', 'minDate', new Date(year, month-1, day));
    }else{
        $(this).datepicker('disable');
    }
});

$('.datepick').live("mouseover", function(){
    $(this).datepicker({
        dateFormat: 'dd-mm-yy',
        altFormat: 'mm-dd-yy',
        changeMonth: true,
        changeYear: true
    });
});


/* Photo */

$("#edit_photo_link").live("click",function() {
    $("#edit_photo").toggle('blind');
    return false;
});

/*Keywords*/
showKeyword = function(){
    $("#add_person_keywords option:selected").removeAttr("selected");
    $("#add_person_keywords").find("option").hide();
    //    alert($("#keyword_keyword_type_id").find("option:selected").text());
    $("#keyword_person_types").find("option:selected").each(function(){
        if($(this).val() == ""){
            $("#add_person_keywords").find("option").show();
        }else{      
            $("#add_person_keywords option[class=" + $(this).text() + "]").show();
        //             $("#add_person_keywords option[class=" + $(this).text() + "]").css('display','');
             
        }
    });
}

showTooltip = function(){
    $("#add_person_keywords option ,#remove_person_keywords option").each(function(){
        $(this).qtip({
            content: $(this).attr('remark'),
            position: {
                corner: {
                    target: 'leftMiddle',
                    tooltip: 'rightMiddle'
                }
            },
            style : {
                tip: true
            }
        });
    });
}

//$(document).ready(function(){
//    showKeyword();
//    showTooltip();
//});



$("#keyword_person_types").live("change", showKeyword);

/*organisation keyword*/
showOrganisationKeyword = function(){
    $("#add_organisation_keywords option:selected").removeAttr("selected");
    $("#add_organisation_keywords").find("option").hide();
    $("#keyword_organisation_types").find("option:selected").each(function(){
        if($(this).val() == ""){
            $("#add_organisation_keywords").find("option").show();
        }else{
            $("#add_organisation_keywords option[class=" + $(this).text() + "]").show();
        }
    });
}

showOrganisationTooltip = function(){
    $("#add_organisation_keywords option ,#remove_organisation_keywords option").each(function(){
        $(this).qtip({
            content: $(this).attr('remark'),
            position: {
                corner: {
                    target: 'leftMiddle',
                    tooltip: 'rightMiddle'
                }
            },
            style : {
                tip: true
            }
        });
    });
}

$("#keyword_organisation_types").live("change", showOrganisationKeyword);

/* Relationships */
$(function(){
    $("input[type='text']#relationship_related_person_id").change(function(){
        $.ajax({
            type: "GET",
            url: "/people/name_finder.js",
            data: 'person_id='+$(this).val(),

            dataType: "script"
        });
    });
});

$(function(){
    $('table#search_results tbody tr').live('click',function(){
        $.ajax({
            type: 'GET',
            url: "/people/"+$(this).attr('person_id')+"/name_card.js",
            dataType: "script"
        });
        $('table#search_results tbody tr.selected').removeClass('selected');
        $(this).addClass("selected");

    });
});


/* Show Summary list*/

$(function(){
    $('table#search_list_results tbody tr').live('dblclick',function(){
        // alert($('table#search_list_results').attr('current_operation'));
        if ($('table#search_list_results').attr('current_operation') == "edit_list")
        {
            window.open("/people/"+$(this).attr("id").substring(3)+"/edit","_self");
        }
        if ($('table#search_list_results').attr('current_operation') == "show_list")
        {
            window.open("/people/"+$(this).attr("id").substring(3)+"/","_self");
          
        }
    });
});

$(function(){
    $('table#search_list_results tbody tr').live('click',function(){
        $.ajax({
            type: 'GET',
            url: "/people/show_left.js",
            data: 'person_id='+$(this).attr('id').substring(3)+'&current_operation='+ $('#search_list_results').attr('current_operation')+'&active_tab='+$('#search_list_results').attr('active_tab')+'&active_sub_tab='+$('#search_list_results').attr('active_sub_tab'),
            dataType: "script"
        });
        $('table#search_list_results tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass("trSelected");
    });
});


$(function(){
    $('table#search_list_results tbody tr').live('mouseover',function(){
        $(this).css("cursor","pointer");
    });
});



/*role*/


$(function(){
    $(".find_role_field").live('change',function(){
        $.ajax({
            type: "GET",
            url: "/people/"+$(this).attr('person_id')+"/roles/get_roles.js",
            data: 'role_type_id='+$(this).val()+'&person_role_id='+$(this).attr('person_role_id'),
            dataType: "script"
        });
    });
});



$(function(){
    $(".check_person_field").live('change', function(){
        $.ajax({
            type: "GET",
            url: "/people/role_finder.js",
            data: 'person_id='+$(this).val()+'&update='+$(this).attr('update')+'&person_role_id='+$(this).attr('person_role_id'),
            dataType: "script"
        });
    });
});


/* Employment Tab*/

$(function(){
    $(".find_organisation_field").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url:
                "/organisations/name_finder.js",
                data:
                'organisation_id='+$(this).val()+'&employment_id='+$(this).attr('employment_id'),
                dataType: "script"
            });
        }else{
            $("#organisation_name_container_"+$(this).attr('employment_id')).html(" ");
        }
    });
});

$(function(){
    $(".find_person_field").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url:
                "/people/name_finder.js",
                data:
                'person_id='+$(this).val()+'&update='+$(this).attr('update')+'&employment_id='+$(this).attr('employment_id'),
                dataType: "script"
            });
        }else{
            $("#"+$(this).attr('update')+"_"+$(this).attr('employment_id')).val("");
        }
    });
});

$(function(){
    $(".calculate_field").live('change', function(){
        _valid = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test($(this).val());
        if (_valid)
        {
            _salary = $("#hour_"+$(this).attr("employment_id")).val() * $("#rate_"+$(this).attr("employment_id")).val() * 52;
            $("#salary_"+$(this).attr("employment_id")).val(formatCurrency(_salary));
        }else{
            //alert("This field has be a number!");
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

/* Person_Group */

$(function()
{
    $(".show_group_type").live('change', function(){
        /*   if($(this).val()!= ""){  */
        $.ajax({
            type: "GET",
            url: "/tag_meta_types/show_group_types.js",
            data: 'group_meta_meta_type_id='+$(this).val()+'&person_group_id='+$(this).attr('person_group_id'),
            dataType: "script"
        });

    /* }
        else{
            if($(this).attr('person_group_id').val()!="")
                {
                    $(".find_group_meta_type[person_group_id='"+ $(this).attr("person_group_id") +"']").html(" ")
             $("#person_group_id[person_group_id='"+ $(this).attr("person_group_id") +"']").html(" ")
                    
                }
                else {
            $(".find_group_meta_type").html(" ")
            $("#person_group_id").html(" ")}
        } */
    });


})


/* show other group member */
$(function(){
    $("#show_other_group_members").live('click',function(){
        $.ajax({
            type: "GET",
            url: "/people/"+$(this).attr('person_id')+"/person_groups/show_group_members.js",
            data: 'person_group_id='+$(this).attr('person_group_id'),
            dataType: "script"

        });
    });
});

$(function(){
    $("#show_other_group_members_organisations").live('click',function(){
        $.ajax({
            type: "GET",
            url: "/organisations/"+$(this).attr('organisation_id')+"/organisation_groups/show_group_members.js",
            data: 'organisation_group_id='+$(this).attr('organisation_group_id'),
            dataType: "script"

        });
    });
});





/* Show_group */
$(function(){
    $(".find_group_meta_type").live('change',function(){
        $.ajax({
            type: "GET",
            url: "/tag_types/show_types.js",
            data: 'group_meta_type_id='+$(this).val(),
            dataType: "script"

        });
    });
});

/* Show Group Description */

$(function(){
    $("#group_id").live('change',function(){
        $.ajax({
            type: "GET",
            url: "/tags/show_group_description.js",
            data: 'group_id='+$(this).val(),
            dataType: "script"

        });
    });
});


/* MasterDoc */
$(function(){
    $(".find_master_doc_meta_type_field").live('change', function(){
        $.ajax({
            type: "GET",
            url:
            "/people/master_doc_meta_type_finder.js",
            data:
            'id='+$(this).val()+'&master_doc_id='+$(this).attr('master_doc_id'),
            dataType: "script"
        });
    });
});


$(function(){
    $(".find_master_doc_type_field").live('change', function(){
        $.ajax({
            type: "GET",
            url:
            "/people/master_doc_type_finder.js",
            data:
            'id='+$(this).val()+'&master_doc_id='+$(this).attr('master_doc_id'),
            dataType: "script"
        });
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
}




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

//Admin - System Data Tab

$(function(){
    $("#system_data_type").live('change', function(){
        if($(this).val()==""){
            $("#system_data_main_contents").hide();
            $("#system_data_entries").html("");
            $("#edit_system_data_entry").html("");
        } else {
            $("#system_data_add_entry").css("display","");
            $("#edit_system_data_entry").html("");
            $("#amazon_setting_type").val($(this).val());
            $.ajax({
                type: "GET",
                url: "/amazon_settings/system_settings_finder.js",
                data: 'type=' + $(this).val(),
                dataType: "script"
            });
            $("#system_data_main_contents").show();
        }
        $("#system_data_mode").attr('mode', 'show');
    });
});


$(function(){
    $("#edit_current_system_data_entry").live('click', function(){
        $(".container_selected").removeClass("container_selected");
        $(this).closest('.toggle_options').addClass("container_selected");
        $("#edit_system_data_entry").html("");
        $("#system_data_type").attr("disabled",true);
        $("#system_data_add_entry_form").hide();
        $.ajax({
            type: "GET",
            url: "/amazon_settings/system_data_entry_finder.js",
            data: 'id=' + $(this).attr('system_data_id'),
            dataType: "script"
        });

    });
});

$(function(){
    $("#delete_system_data_entry").live('click', function(){


        var link = $(this);
        if($(this).attr("error_message_field" != null))
        {
            $('#warning_message_text').html("Are you sure you wish to delete this "  + $(this).attr("error_message_field") + " ? ");
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
                    $(".container_selected").removeClass("container_selected");
                    $("#edit_system_data_entry").hide();
                    $("#system_data_add_entry_form").hide();
                    $.ajax({
                        type: "GET",
                        url: "/amazon_settings/delete_system_data_entry.js",
                        data: 'id=' + link.attr('system_data_id'),
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
        //      $("#warning_message").closest("ui-dialog-titlebar").css('background','#97B6CE');

        $('#warning_message').dialog('open');





      

    });
}); 

$(function(){
    $("#system_data_add_entry").live('click', function(){
        $("#system_data_add_entry_form").show();
        $("#edit_system_data_entry").html("");
        $(".system_data_entry_selected").removeClass("system_data_entry_selected");
        $("#system_data_type").attr("disabled",true);
    });
});


$(function(){
    $("#close_edit_system_data_entry").live('click', function(){


        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $(".container_selected").removeClass("container_selected");
                        $("#edit_system_data_entry").hide();
                        $("#system_data_type").attr("disabled",false);
                        $.ajax({
                            type: "GET",
                            url: "/amazon_settings/system_settings_finder.js",
                            data: 'type=' + $("#system_data_type").val(),
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
            //      $("#warning_message").closest("ui-dialog-titlebar").css('background','#97B6CE');

            $('#warning_message').dialog('open');











        }
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $('#check_input_change').val("false");
            $(".container_selected").removeClass("container_selected");
            $("#edit_system_data_entry").hide();
            $("#system_data_type").attr("disabled",false);
            $.ajax({
                type: "GET",
                url: "/amazon_settings/system_settings_finder.js",
                data: 'type=' + $("#system_data_type").val(),
                dataType: "script"
            });

        }
       
    });
});

$(function(){
    $("#system_data_close_entry").live('click', function(){

        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $("#system_data_add_entry_form").css("display","none");
                        $("#system_data_type").attr("disabled",false);
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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $("#system_data_add_entry_form").css("display","none");
            $("#system_data_type").attr("disabled",false);

        }


        
    });
});


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


/* Custom Group Types */
$(function(){
    $("#show_group_meta_type_form").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_types/new.js",
            data: 'id=' + $(this).attr('custom_group_type_id'),
            dataType: "script"
        });
    })
});

$(function(){
    $("#delete_custom_group_type").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_types/delete_custom_group_type.js",
            data: 'id=' + $(this).attr('custom_group_type_id'),
            dataType: "script"
        });

    });
});

$(function(){
    $("#delete_custom_group").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tags/delete_custom_group.js",
            data: 'id=' + $(this).attr('custom_group_id') + '&custom_group_type_id=' + $(this).attr('custom_group_type_id'),
            dataType: "script"
        });

    });
});


$(function(){
    $(".edit_custom_group").live('click', function(){
        $('#edit_sub_group_'+$(this).attr('sub_group_id')).show();
        $('#sub_group_'+$(this).attr('sub_group_id')).hide();
        $("#multilevel_mode_1").attr("mode", "inactive");
        $("#multilevel_mode_2").attr("mode", "inactive");
        $("#multilevel_mode_3").attr("mode", "inactive");
    });
});

$(function(){
    $(".close_edit_custom_group").live('click', function(){
        $('#edit_sub_group_'+$(this).attr('sub_group_id')).hide();
        $('#sub_group_'+$(this).attr('sub_group_id')).show();
        $("#multilevel_mode_1").attr("mode", "inactive");
        $("#multilevel_mode_2").attr("mode", "show");
        $("#multilevel_mode_3").attr("mode", "inactive");
    });
});





$(function(){
    $("#find_data_list_field").live('change', function(){
        $.ajax({
            type: "GET",
            url: "/amazon_settings/data_list_finder.js",
            data: 'type=' + $(this).val() + '&id=' + $("#hiden_id").val(),
            dataType: "script"
        });
    });
});

$(function(){
    $("#data_list_field").live('change', function(){
        if($(this).val()==0){
            $.ajax({
                type: "GET",
                url:
                "/amazon_settings/new.js",
                data:
                'type=' + $("#find_data_list_field").val(),
                dataType: "script"
            });
        }else{
            $.ajax({
                type: "GET",
                url:
                "/amazon_settings/" + $(this).val() + "/edit.js",
                data:
                'id=' + $(this).val(),
                dataType: "script"
            });
        }
    });
});



$(function(){
    $(".delete_system_data").live('click', function(){
        $.ajax({
            type: "DELETE",
            url: "/amazon_settings/" + $(this).attr("data_id"),
            data:'&id=' + $(this).attr("data_id"),
            dataType: "script"
        });
    });
});


/* Drop down box hack*/
$(function(){
    $(".clear_select").find('option:first').attr('selected', 'selected');
});

/* Admin  -  Role_Condition Tab*/


$(function(){
    $(".show_role").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url: "/roles/show_roles.js",
                data: 'role_type_id='+$(this).val(),
                dataType: "script"

            });

            $('#role_main_contents').show();
        }else{

            $("#downside").html("");
            $("#role_type_description_label").html('');
            $('#role_main_contents').hide();
        }
    });
});


$(function(){
    $(".choose_role").live('change', function(){
        if($(this).val()=="0"){
            $.ajax({
                type: "GET",
                url: "/roles/new.js",
                data: 'id='+$(this).val()+'&role_type_id='+$('#role_role_type_id').val(),
                dataType: "script"
            });
        }else{
            $.ajax({
                type: "GET",
                url: "/roles/"+$(this).val()+"/edit.js",
                data: 'id='+$(this).val()+'&role_type_id='+$('#role_role_type_id').val(),
                dataType: "script"
            });           
        }
    });
});






$(function(){
    $("#cheatbutton").live('click', function(){
        $("#edit_role").doAjaxSubmit();
    })
});




$(function(){
    $("#rm").live('mousedown', function(){
        $.ajax({
            type: "GET",
            url:"/roles/role_type_finder.js",
            dataType: "script"
        });
    });
});

/*for rule use*/

$(function(){
    $(".show_role_table").live('change',function(){
        
        $.ajax({
            type: "GET",
            url: "/people/"+$(this).attr('person_id')+"/roles/person_role_des.js",
            data: 'id='+$(this).val()+'&person_id='+$(this).attr('person_id')+'&person_role_id='+$(this).attr('person_role_id'),
            dataType: "script"
        });
    });
});

$('.beforestartdatepick').live("mouseover", function(){
    $("#"+$(this).attr("end_date")).datepicker('enable');
    $(this).datepicker({
        dateFormat: 'dd-mm-yy',
        altFormat: 'mm-dd-yy',
        changeMonth: true,
        changeYear: true
    });
});

$('.role_enddatepick').live("mouseover", function(){
    var arr_dateText = $("#"+$(this).attr("start_date")).val().split("-");
    day = arr_dateText[0];
    month = arr_dateText[1];
    year = arr_dateText[2];
    //init
    $(this).datepicker({
        dateFormat: 'dd-mm-yy',
        altFormat: 'mm-dd-yy',
        changeMonth: true,
        changeYear: true,
        minDate: new Date(year, month-1, day)
    });

    //reset
    if(year!=undefined){
        $(this).datepicker('option', 'minDate', new Date(year, month-1, day));
    }
});

$('.role_startdatepick').live("mouseover", function(){
    $("#"+$(this).attr("end_date")).datepicker('enable');
    var arr_dateText = $("#"+$(this).attr("start_date")).val().split("-");
    day = arr_dateText[0];
    month = arr_dateText[1];
    year = arr_dateText[2];
    //init
    $(this).datepicker({
        dateFormat: 'dd-mm-yy',
        altFormat: 'mm-dd-yy',
        changeMonth: true,
        changeYear: true,
        minDate: new Date(year, month-1, day)
    });

    //reset
    if(year!=undefined){
        $(this).datepicker('option', 'minDate', new Date(year, month-1, day));
    }
});


/*Admin Tag Setting*/

$(function(){
    $("#tag_selection").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url: "/tag_settings/show_all_for_selected_classifier.js",
                data: 'tag='+$(this).val(),
                dataType: "script"
            });
            if($(this).val() != "5"){
                $("#add_tag_meta_type").css("display", "");
            }else{
                $("#add_tag_meta_type").css("display", "none");
            }
        }else{
            $("#add_tag_meta_type").css("display", "none");
            $("#show_tag").html("");
        }

    });
});


$(function(){
    $(".show_tag_types").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_types/show_tag_types.js",
            data:'tag='+$('#tag_selection').val() + '&id='+$(this).attr('tag_meta_types_id'),
            dataType: "script"
        });
    });
});

$(function(){
    $(".show_tags").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tags/show_tags.js",
            data:'tag='+$('#tag_selection').val() + '&id='+$(this).attr('tag_types_id'),
            dataType: "script"
        });
    });
});

$(function(){
    $("#add_tag_meta_type").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_meta_types/new.js",
            data:'tag='+$('#tag_selection').val(),
            dataType: "script"
        });
    });
});

$(function(){
    $(".edit_tag_meta_type").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_meta_types/" + $(this).attr("tag_meta_type_id") + "/edit.js",
            data:'tag='+$('#tag_selection').val()+'&id=' + $(this).attr("tag_meta_type_id"),
            dataType: "script"
        });
    });
});

$(function(){
    $(".delete_tag_meta_type").live('click', function(){
        $.ajax({
            type: "DELETE",
            url: "/tag_meta_types/" + $(this).attr("tag_meta_type_id"),
            data:'tag='+$('#tag_selection').val()+'&id=' + $(this).attr("tag_meta_type_id"),
            dataType: "script"
        });
    });
});



$(function(){
    $(".add_tag_type").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_types/new.js",
            data:'tag='+$('#tag_selection').val()+'&tag_meta_type_id=' + $(this).attr("tag_meta_type_id"),
            dataType: "script"
        });
    });
});

$(function(){
    $(".edit_tag_type").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tag_types/" + $(this).attr("tag_type_id") + "/edit.js",
            data:'tag='+$('#tag_selection').val()+'&id=' + $(this).attr("tag_type_id"),
            dataType: "script"
        });
    });
});

$(function(){
    $(".delete_tag_type").live('click', function(){
        $.ajax({
            type: "DELETE",
            url: "/tag_types/" + $(this).attr("tag_type_id"),
            data:'tag='+$('#tag_selection').val()+'&id=' + $(this).attr("tag_type_id"),
            dataType: "script"
            
        });
    });
});


$(function(){
    $(".add_tag").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tags/new.js",
            data:'tag='+$('#tag_selection').val()+'&tag_type_id=' + $(this).attr("tag_type_id"),
            dataType: "script"
        });
    });
});

$(function(){
    $(".edit_tag").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/tags/" + $(this).attr("tag_id") + "/edit.js",
            data:'tag='+$('#tag_selection').val()+'&id=' + $(this).attr("tag_id"),
            dataType: "script"
        });
    });
});

$(function(){
    $(".delete_tag").live('click', function(){
        $.ajax({
            type: "DELETE",
            url: "/tags/" + $(this).attr("tag_id"),
            data:'tag='+$('#tag_selection').val()+'&id=' + $(this).attr("tag_id"),
            dataType: "script"
        });
    });
});

$(function(){
    $(".show_tag_types").live('mouseover', function(){
        $(this).animate({
            color: "#FFFF00"
        }, 300)
    });
});

$(function(){
    $(".show_tag_types").live('mouseout', function(){
        $(this).animate({
            color: "#F7F8E0"
        }, 300)
    });
});

/*Admin User management*/
$(function(){
    $("#add_user").live('click', function(){
        $(this).hide();
        $(".user_clear_form").click();
        //$(".show_user_container").hide();
        $("#close_new_account").show();
    });
});

$(function(){
    $(".check_login_id").blur(function(){
        if($(this).val()!= ""){
            $.ajax({
                type: "GET",
                url: "/people/login_id_finder.js",
                data: 'person_id='+$(this).val()+'&login_account_id='+$(this).attr('login_account_id'),
                dataType:"script"
            });
        }else{
            $("#login_name_container_"+$(this).attr('login_account_id')).html("");
            $('#error_message_text').html("Please type Person ID");
            $('#error_message_image').css("display","");
            $('#error_message').dialog({
                modal: true,
                resizable: false,
                draggable: true,
                height: 'auto',
                width: 'auto',
                buttons: {
                    "OK":function(){
                  
                        $(this).dialog('destroy');
                        return false;

                    }
                }
            });
            $('#error_message').dialog('option', 'title', 'ERROR');

            $('#error_message').parent().find("a").css("display","none");
            $("#error_message").parent().css('background-color','#D1DDE6');
            $("#error_message").css('background-color','#D1DDE6');

            $('#error_message').dialog('open');

            
        //            $('#login_name_invalid').dialog( {
        //                modal: true,
        //                resizable: true,
        //                draggable: true,
        //                buttons: {
        //
        //                    OK: function(){
        //
        //                        $(this).dialog('close');
        //                    }
        //                }
        //            });
        //            $('#login_name_invalid').dialog('open');
        }
    });
});




$(function(){

    $(".check_username_unique").blur(function(){

        //        if ($('#login_account_user_name').val().length < 6 ||$('#login_account_user_name').val().length > 30 )
        //     {
        //         return false;
        //     }

        //     else
        //         {
        $.ajax({
            type: "GET",
            url: "/login_accounts/user_name_unique.js",
            data: 'user_name='+$(this).val()+'&login_account_id='+$(this).attr('login_account_id')+'&length='+$(this).val().length,
            dataType:"script"
        });

    //         }


      
    
    });

    $('#login_account_user_name').live("focus", function(){
        $(this).qtip(
        {
            content: 'username must between 6~20<br>username can\'t the same as password',
            style: 'dark'
        }
        );
    });
});

$(function(){
    $(".user_email_new").blur(function(){
        _valid = /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-zA-Z]{2,})$/.test($(this).val());
        if($(this).val()!=""){
            if((!_valid)){
                
                $('#error_message_text').html("Invalid Email Address ");
                $('#error_message_image').css("display","");
                $('#error_message').dialog({
                    modal: true,
                    resizable: false,
                    draggable: true,
                    height: 'auto',
                    width: 'auto',
                    buttons: {
                        "OK": function(){
                            $('#login_account_security_email').val("");
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



                //
                //                $('#invalid_email').dialog( {
                //                    modal: true,
                //                    resizable: true,
                //                    draggable: true,
                //                    buttons: {
                //
                //                        OK: function(){
                //
                //                            $(this).dialog('close');
                //                        }
                //                    }
                //                });
                //                $('#invalid_email').dialog('open');
                $('.user_email_new').focus();
                return false;
            }
        }else{

            $('#error_message_text').html("Invalid Email Address ");
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
            $('#error_message').dialog('option', 'title', 'Error');
            $('#error_message').parent().find("a").css("display","none");
            $("#error_message").parent().css('background-color','#D1DDE6');
            $("#error_message").css('background-color','#D1DDE6');
            $('#error_message').dialog('open');
       
        }
    });
});


//check_email_field = function(){
//    _valid = /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-zA-Z]{2,})$/.test($('#email_value').val());
//    if($('#email_value').val()!=""){
//        if((!_valid)){
//            alert("Invalid email address !");
//            $('#email_value').focus();
//            return false;
//        }
//    }
//}
//$(function(){
//    $('#login_account_user_name').live("focus", function(){
//        $(this).qtip(
//        {
//            content: 'username must between 6~20<br>username can\'t the same as password',
//            style: 'dark'
//        }
//    );
//    });
//});
//
//$(function(){
//    $('#login_account_user_name').live("mouseover", function(){
//        $(this).qtip(
//        {
//            content: 'username must between 6~20<br>username can\'t the same as password',
//            style: 'dark'
//        }
//    );
//    });
//});


$(function() {
    $(".password").jpassword({
        lang: {
            please: "please type password over 6 characters",
            low: "Low security.",
            correct: "Correct security.",
            high: "High security.",
            length: "-X- characters would be a plus.",
            number: "Why not numbers?",
            uppercase: "And caps?",
            lowercase: "Some tiny?",
            punctuation: "Punctuations?",
            special: "Best, special characters?"
        },
        length: 6
    });
});


$(function(){
    $("#login_account_password_confirmation").live('change', function(){

        if ($(this).val()!= $('#login_account_password').val()){

            $('#error_message_text').html("Passwords DO NOT Match ");

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
            $('#error_message').dialog('option', 'title', 'Error');
            $('#error_message').parent().find("a").css("display","none");
            $("#error_message").parent().css('background-color','#D1DDE6');
            $("#error_message").css('background-color','#D1DDE6');
            $('#error_message').dialog('open');






        //            $('#password_confirm').dialog( {
        //                modal: true,
        //                resizable: true,
        //                draggable: true
        //            });
        //            $('#password_confirm').dialog('open');
        }
    });
});




$(function(){
    $("#login_account_password").live('change', function(){

        if ($(this).val().length < 6 ||$(this).val().length > 30 ){
            $('#no_password').show();
            $('#yes_password').hide();

        }else{
            $('#no_password').hide();
            $('#yes_password').show();

        }

    });
});



$(function(){
    $(".user_clear_edit_form").live('click', function(){
        $('#'+($(this).closest('form').get(0).id))[0].reset();
      
        $('#user_name_container_' + $(this).attr('login_account_id')).html('');     
    })

});


$(function(){
    $("#group_secu_submit").live('click', function(){
        $(".edit_login").doAjaxSubmit();
    })
});



$(function(){
    $(".delete_login_account").live('click', function(){
        $.ajax({
            type: "DELETE",
            url: "/login_accounts/" + $(this).attr("data_id"),
            data:'&id=' + $(this).attr("data_id"),
            dataType: "script"
        });
    });
});


$(function(){
    $("#close_new_account").live('click', function(){

        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are you Sure You Wish to EXIT ?");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $(".user_clear_form").click();
                        $("#new_user").toggle('blind');
                        $(".show_user_container").show();
                        $("#close_new_account").hide();
                        $("#add_user").show();
                        $('#no_password').hide();
                        $('#yes_password').hide();
                        $('#no_username').hide();
                        $('#yes_username').hide();
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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $(".user_clear_form").click();
            $("#new_user").toggle('blind');
            $(".show_user_container").show();
            $("#close_new_account").hide();
            $("#add_user").show();
            $('#no_password').hide();
            $('#yes_password').hide();
            $('#no_username').hide();
            $('#yes_username').hide();

        }









       
      
    });
});

$(function(){
    $("#close_edit_account").live('click', function(){

        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $(".add_user").show();
                        $(".container_selected").removeClass("container_selected");
                        $("#edit_user").html('');

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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $(".add_user").show();
            $(".container_selected").removeClass("container_selected");
            $("#edit_user").html('');


        }

    });
});



$(document).ready(function() {
    $(".inputWithImge").each(function(){
        $(this).add($(this).next()).wrapAll('<div class="imageInputWrapper"></div>');
    });
});


/* Admin List Management - Query*/

$(function(){
    $(".show_fields").live('change', function(){
        if($(this).val()){
            $.ajax({
                type: "GET",
                url: "/tag_types/show_fields.js",
                data:'table_name=' + $(this).val() + '&update_field=' + $(this).attr("update_field") + '&update_value=' + $(this).attr("update_value"),
                dataType: "script"
            });
        }else{
            $("#fields_"+$(this).attr("update_field")).html("");
            $("#attribute_description_"+$(this).attr("update_field")).html("<label class='descriptions'>&nbsp;</label>")
        }
    });
});

$(function(){
    $("#fields_criteria").live('change', function(){
        $(".descriptions_criteria").css("display", "none");
        $("#description_criteria_"+$(this).val()).css("display", "");
        if ($(this).val()!=null && $(this).val().indexOf("date") > 0){
            if ($(this).val() == "birth_date"){
                $("#query_criteria_value").datepicker({
                    dateFormat: 'dd-mm-yy',
                    altFormat: 'mm-dd-yy',
                    changeMonth: true,
                    changeYear: true,
                    maxDate: '+0d',
                    yearRange: '-150:+0'
                });
            }else{
                $("#query_criteria_value").datepicker({
                    dateFormat: 'dd-mm-yy',
                    altFormat: 'mm-dd-yy',
                    changeMonth: true,
                    changeYear: true
                });
            }
        }else{
            $("#query_criteria_value").datepicker('destroy');
        }
    });
});

$(function(){
    $("#fields_selection").live('change', function(){
        $(".descriptions_selection").css("display", "none");
        $("#description_selection_"+$(this).val()).css("display", "");
    });
});

$(function(){
    $("#fields_sorter").live('change', function(){
        $(".descriptions_sorter").css("display", "none");
        $("#description_sorter_"+$(this).val()).css("display", "");
    });
});

$(function(){
    $("#show_new_query").live('click', function(){
        $(this).css("display", "none");
        $.ajax({
            type: "GET",
            url: "/query_headers/new.js",
            dataType: "script"
        });
    });
});

$(function(){
    $("#close_new_query").live('click', function(){
        $(this).css("display", "none");
        $("#current_action").val("");
        $('#new_query_form').html('');
        $('#new_query_list').html('');
        $('#new_selection_form').html('');
        $('#new_selection_list').html('');
        $('#new_sorter_form').html('');
        $('#new_sorter_list').html('');
        $('#save_form').html('');
        $('#new_form').css("display", "none");
        $("#show_new_query").css("display", "");
        $("#existing_query").css("display", "");
    });
});

$(function(){
    $("#save_button").live('click', function(){
        if($(this).attr("action")=="new"){
            $('#save_form').toggle('blind');
            $('#save_form').dialog( {
                modal: true,
                resizable: true,
                draggable: true
            });
            $('#save_form').dialog('option', 'title', 'New Query');
            $('#save_form').dialog('open');
        }else{
            $('#edit_query_header').doAjaxSubmit();
        }
    });
});


$(function(){
    $("#run_button").live('click', function(){
        var temp = "";
        temp += 'id=' + $("#query_header_id").val();
        if($("#query_top_number").attr("checked")==true){
            temp += "&top=number&top_number=" + $("#query_top_value").val();
        }else{
            temp += "&top=percent&top_percent=" + $("#query_top_value").val();
        }
        $.ajax({
            type: "GET",
            url: "/query_headers/check_runtime.js",
            data: temp,
            dataType: "script"
        });
    });
});

$(function(){
    $("#run_button_edit").live('click', function(){
        var temp = "";
        temp += 'id=' + $("#query_header_id").val();
        if($("#query_top_number").attr("checked")==true){
            temp += "&top=number&top_number=" + $("#query_top_value").val();
        }else{
            temp += "&top=percent&top_percent=" + $("#query_top_value").val();
        }
        $.ajax({
            type: "GET",
            url: "/query_headers/check_runtime.js",
            data: temp,
            dataType: "script"
        });
    });
});

$(function(){
    $("#clear_button").live('click', function(){

        $('#query_top_value').val("").change();
        $('#check_input_change').val("false");
        $('#check_left_input_change').val("false");
        $('#check_right_input_change').val("false");
        $.ajax({
            type: "GET",
            url: "/query_headers/clear.js",
            data:'id=' + $("#query_header_id").val(),
            dataType: "script"
        });
    });
});

$(function(){
    $("#new_runtime").live('click', function(){
        if ($("#query_criteria_value").attr("readonly")==false){
            $("#query_criteria_value").val("?");
            $("#query_criteria_value").attr("readonly", true);
        }else{
            $("#query_criteria_value").val("");
            $("#query_criteria_value").attr("readonly", false);
        }
    });
});

$(function(){
    $("#show_sql_statements").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/query_headers/show_sql_statement.js",
            data:'id=' + $("#query_header_id").val(),
            dataType: "script"
        });
    });
});

$(function(){
    $('a.get_query').live('click', function() {
        container = $(this).parent().parent().parent();
        $("#current_action").val("edit");
        $(".highlight").removeClass("highlight");
        
        container.addClass("highlight");
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");

    jQuery('a.get_query').removeAttr('onclick');
});

$(function(){
    $("#close_edit_query").live('click', function(){
        var link = $(this);
        if($('#check_input_change').val()=="true")
        {
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
                        $("#new_query").css('display','');
                        $(".highlight").removeClass("highlight");
                        link.css("display", "none");
                        $("#edit_query").css("display", "none");
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        $('#edit_query_form').html('');
                        $('#edit_query_list').html('');
                        $('#edit_selection_form').html('');
                        $('#edit_selection_list').html('');
                        $('#edit_sorter_form').html('');
                        $('#edit_sorter_list').html('');
                        $('#check_input_change').val('false');

                        $(this).dialog('destroy');
                        return true;
                    }
                }

            });
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
            $('#warning_message').dialog('option', 'title', 'Warning');

            $('#warning_message').parent().find("a").css("display","none");
            $("#warning_message").parent().css('background-color','#D1DDE6');
            $("#warning_message").css('background-color','#D1DDE6');
            //      $("#warning_message").closest("ui-dialog-titlebar").css('background','#97B6CE');

            $('#warning_message').dialog('open');
            return false;





        }
        else
        {

            $("#new_query").css('display','');
            $(".highlight").removeClass("highlight");
            $(this).css("display", "none");
            $("#edit_query").css("display", "none");
            $('#edit_query_form').html('');
            $('#edit_query_list').html('');
            $('#edit_selection_form').html('');
            $('#edit_selection_list').html('');
            $('#edit_sorter_form').html('');
            $('#edit_sorter_list').html('');

        }
    });
});

$(function(){
    $(".select_all").live('click', function(){
        if($(this).attr("checked") == true){
            $(".checkboxes").attr("checked", true);
        }else{
            $(".checkboxes").attr("checked", false);
        }
    });
});

$(function(){
    $("#query_top_number").live('click', function(){
        $("#query_top_value").val('');
        $("#query_top_value.precent_field").removeClass("precent_field").addClass("integer_field");
    });
    $("#query_top_percent").live('click', function(){
        $("#query_top_value").val('');
        $("#query_top_value.integer_field").removeClass("integer_field").addClass("precent_field");
    });
});

$(function(){
    $("#query_edit_top_number").click(function(){
        $("#query_edit_top_percent_value").val('');
        $("#query_edit_top_percent_value").attr("disabled",true);
        $("#query_edit_top_number_value").attr("disabled",false);
    });
    $("#query_edit_top_percent").click(function(){
        $("#query_edit_top_number_value").val('');
        $("#query_edit_top_number_value").attr("disabled",true);
        $("#query_edit_top_percent_value").attr("disabled",false);
    });
});


/*List Header of Person*/

$(function(){
    $("#list_header_name").change(function(){
        $("#person_list_edit").submit();
    });
});

$(function(){
    $("#list_header_name2").change(function(){
        $("#person_list").submit();
    });
});


/*Admin List Management - List Manager*/
$(function(){
    $('a.get_list').live('click', function() {
        container = $(this).parent().parent().parent();
        $(".highlight").removeClass("highlight");
        container.addClass("highlight");
        var link = $(this);
        $.get(link.attr('href'), null ,null, 'script');
        return false;
    }).attr("rel", "nofollow");
    jQuery('a.get_list').removeAttr('onclick');
});


$(function(){
    $('#show_list_compiler').live('click', function(){
        $(this).css("display","none");
        $("#close_list_compiler").css("display", "");
        $("#list_compiler_form").css("display","");
        $("#existing_list").css("display","none");
        $("#clear_compile_list").click();
        $.ajax({
            type: "GET",
            url: "/list_headers",
            dataType: "script"
        });
    });
});

$(function(){
    $('#close_list_compiler').live('click', function(){
        $(this).css("display","none");
        $("#show_list_compiler").css("display", "");
        $("#existing_list").css("display","");
        $("#list_compiler_form").css("display","none");
        $("#clear_compile_list").click();
    });
});

$(function(){
    $("#add_to_include").live('click', function(){
        if($("#compiler_options").val() != null){
            $.ajax({
                type: "POST",
                url: "/include_lists",
                data:'list_header_id=' + $("#compiler_options").val() + '&login_account_id=' + $("#login_account_id").val(),
                dataType: "script"
            });

        }
    });
});



$(function(){
    $("#add_to_exclude").live('click', function(){
        if($("#compiler_options").val() != null){
            $.ajax({
                type: "POST",
                url: "/exclude_lists",
                data:'list_header_id=' + $("#compiler_options").val() + '&login_account_id=' + $("#login_account_id").val(),
                dataType: "script"
            });
        }
    });
});


$(function(){
    $("#clear_compile_list").live('click', function(){

        $('#top_value').val("").change();
        $('#check_input_change').val("false");
        $('#check_left_input_change').val("false");
        $('#check_right_input_change').val("false");

        $.ajax({
            type: "POST",
            url: "/compile_lists/clear.js",
            data: "login_account_id=" + $("#login_account_id").val(),
            dataType: "script"
        });
    });
});

$(function(){
    $("#compile_button").live('click', function(){
        var temp = "";
        temp += "login_account_id=" + $("#login_account_id").val();
        temp += "&allow_duplication=" + $("#allow_duplication").attr("checked");
        if($("#top_number").attr("checked")==true){
            temp += "&top=number&top_number=" + $("#top_value").val();
        }else{
            temp += "&top=percent&top_percent=" + $("#top_value").val();
        }

        $.ajax({
            type: "POST",
            url: "/compile_lists/compile.js",
            data: temp,
            dataType: "script"
        });
    });
});


$(function(){
    $("#top_number").click(function(){
        $("#top_value").val('');
        $("#top_value.precent_field").removeClass("precent_field").addClass("integer_field");
    });
    $("#top_percent").click(function(){
        $("#top_value").val('');
        $("#top_value.integer_field").removeClass("integer_field").addClass("precent_field");
    });
});

/*validation section*/



$(function(){
    $(".integer_field").live('keyup', function(){

        _valid = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test($(this).val());
        if($(this).val()!=""){
            if((!_valid) || $(this).val()<0){
                var link = $(this);
   
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
                            //                            link.val('');
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
        return false;
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
        var error_message = "The " + $("#"+$(this).attr("check_field")).attr("name") +" Must be Filled"
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
}

$(function(){
    $("#contact_phone_submit").live('click', check_empty_value);
});

$(function(){
    $("#contact_phone_submit_edit").live('click', check_empty_value);
});


$(function(){
    $("#submit_email_field").live('click', check_empty_value);
});

$(function(){
    $("#submit_email_field_edit").live('click', check_empty_value);
});



$(function(){
    $("#submit_website_field").live('click', check_empty_value);
});

$(function(){
    $("#submit_website_field_edit").live('click', check_empty_value);
});

$(function(){
    $("#address_submit_button").live('click', check_empty_value);
});

$(function(){
    $("#address_submit_button_edit").live('click', check_empty_value);
});





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
}

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
}

$(function(){
    $("#submit_email_field").live('click', check_email_field);
});

$(function(){
    $("#new_person_submit").live('click', function(){

        if($('#person_emails_attributes_2_value').val()!="" ||  $('#person_websites_attributes_3_value').val()!="")
        { 
            _valid = /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-z]{2,})$/.test($('#person_emails_attributes_2_value').val());
            if($('#person_emails_attributes_2_value').val()!=""){
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
                                return false;
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
            var valid_temp;
            _valid1 = /^((https|http|ftp|rtsp|mms)?:\/\/)(([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\.[a-z]{2,6})(:[0-9]{1,4})?((\/?)|(\/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+\/?)$/.test($("#person_websites_attributes_3_value").val());
            _valid2 = /^(([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\.[a-z]{2,6})(:[0-9]{1,4})?((\/?)|(\/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+\/?)$/.test($("#person_websites_attributes_3_value").val());
            // _valid1 = /^(http|https|ftp):\/\/[\w-]+[\.\w-]*\.[\w-]+(\/[^\s]*)?$/.test($("#person_websites_attributes_3_value").val());
            if (_valid1==true || _valid2 ==true)
            {
                valid_temp = true;
            }
            if($('#person_websites_attributes_3_value').val()!="" && $('#person_websites_attributes_3_value').val()!="http://"  ){
                if((!valid_temp)){
                    var link1 = $(this);

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
                                link1.focus();

                                $(this).dialog('destroy');
                                return false;
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

          
        }
        return true;
    });
});



$(function(){
    $("#new_organisation_submit").live('click', function(){


        if($('#organisation_emails_attributes_2_value').val()!="" ||  $('#organisation_websites_attributes_3_value').val()!="")
        {
            _valid = /^([^@\s]+)@((?:[-a-z0-9A-Z]+\.)+[a-z]{2,})$/.test($('#organisation_emails_attributes_2_value').val());
            if($('#organisation_emails_attributes_2_value').val()!=""){
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
                                return false;
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

            var valid_temp_organisation;
                     
            _valid1 = /(https|http|ftp|rtsp|mms)?:\/\/?(([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\.[a-z]{2,6})(:[0-9]{1,4})?((\/?)|(\/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+\/?)$/.test($("#organisation_websites_attributes_3_value").val());
            _valid2 = /(([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\.[a-z]{2,6})(:[0-9]{1,4})?((\/?)|(\/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+\/?)$/.test($("#organisation_websites_attributes_3_value").val());
            if (_valid1==true || _valid2 ==true)
            {
                valid_temp_organisation = true;
            }
            if($('#organisation_websites_attributes_3_value').val()!=""&& $('#organisation_websites_attributes_3_value').val()!="http://" ){
                if((!valid_temp_organisation)){
                    var link1 = $(this);

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
                                link1.focus();

                                $(this).dialog('destroy');
                                return false;
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
          
        }
        return true;
    });
});

$(function(){
    $("#submit_email_field_edit").live('click', check_email_field_edit);
});

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
            return false;
        }
    }
}

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
}

$(function(){
    $("#submit_website_field").live('click', check_website_field);
});

$(function(){
    $("#submit_website_field_edit").live('click', check_website_field_edit);
});



/*Group ---List*/
$(function(){
    $(".show_list").live('change',function(){
        if ($(this).val()!= ""){

            $.ajax({
                type: "GET",
                url: "/group_lists/show_lists.js",
                data: 'group_id='+$(this).val(),
                dataType: "script"
            });
            $(".show_list_container").css("display", "");
            $("#new_group_list_container").css("display", "");
        } else{
            $(".show_list_container").css("display", "none");
            $("#new_group_list_container").css("display", "none")
           
        }
    });
});

$(function(){
    $("#add_new_list").live('click', function(){
        $(this).css("display", "none");
        $(".group_list_delete").css("display", "none");
        $("#close_new_group_list").css("display", "");
    });
});


$(function(){
    $("#close_new_group_list").live('click', function(){
        $(this).css("display", "none");

        $('#new_group_list').toggle('blind');
        $('#add_new_list').css("display", "");
        $(".group_list_delete").css("display", "");

    });
});


/* Admin - Duplication Formular */
$(function(){
    $("#fields_personal_duplication").live('change', function(){
        $(".descriptions_personal_duplication").css("display", "none");
        $("#description_personal_duplication_"+$(this).val()).css("display", "");
        if($("#description_personal_duplication_"+$(this).val()).html().match("(Integer FK)")){
            $("#is_foreign_key").val(true);
        }else{
            $("#is_foreign_key").val(false);
        }
    });
});

$(function(){
    $('#apply_personal_duplication').live('click', function(){
   
        $('#warning_message_text').html("You Have Applied a New Duplication Formula Successfully, Do You Wish to Re-Generate the People Duplication Index Now? ");
        $('#warning_message_image').css("display","");
        $('#warning_message').dialog({
            modal: true,
            resizable: false,
            draggable: true,
            height: 'auto',
            width: 'auto',
            buttons: {

                No: function(){
                    $("#personal_duplication_form").doAjaxSubmit();
                    $(this).dialog('destroy');
                    return false;

                },
                Yes: function(){
                    $.ajax({
                        type: "GET",
                        url: "/personal_duplication_formulas/generate.js",
                        dataType: "script"
                    })
                    $("#personal_duplication_form").doAjaxSubmit();
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

        
    });
});

$(function(){
    $("#fields_organisational_duplication").live('change', function(){
        $(".descriptions_organisational_duplication").css("display", "none");
        $("#description_organisational_duplication_"+$(this).val()).css("display", "");
        if($("#description_organisational_duplication_"+$(this).val()).html().match("(Integer FK)")){
            $("#is_foreign_key_organisational").val(true);
        }else{
            $("#is_foreign_key_organisational").val(false);
        }
    });
});

$(function(){
    $('#apply_organisational_duplication').live('click', function(){
        $("#organisational_duplication_form").doAjaxSubmit();
        
        





    });
});

$(function(){
    $("#generate_personal_duplication").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/personal_duplication_formulas/generate.js",
            dataType: "script"
        });
    });
});

$(function(){
    $("#generate_organisational_duplication").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/organisational_duplication_formulas/generate.js",
            dataType: "script"
        });
    });
});

$(function(){
    $('#load_personal_duplication').live('click', function(){

        $('#load_personal_message_text').html("Are You Sure You Wish to Load the System Default Setting? ");
       
        $('#load_personal_default').dialog({
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
                    window.open("/personal_duplication_formulas/set_default.html", "_self");
                    $(this).dialog('destroy');
                    return true;
                }
            }
        });
        $('#load_personal_default').dialog('option', 'title', 'Warning - Default Setting');

        $('#load_personal_default').parent().find("a").css("display","none");
        $("#load_personal_default").parent().css('background-color','#D1DDE6');
        $("#load_personal_default").css('background-color','#D1DDE6');

        $('#load_personal_default').dialog('open');

    //        $('#load_personal_default').dialog( {
    //            modal: true,
    //            resizable: true,
    //            draggable :true,
    //            height: 250,
    //            width: 700,
    //            buttons: {
    //                NO: function() {
    //                    $(this).dialog('close');
    //                },
    //                YES: function() {
    //                    window.open("/personal_duplication_formulas/set_default.html", "_self");
    //                    return false;
    //                }
    //            }
    //        });
    //        $('#load_personal_default').dialog('open');
    });
});

$(function(){
    $('#load_organisational_duplication').live('click', function(){


        $('#load_organisational_message_text').html("Are You Sure You Wish to Load the System Default Setting? ");

        $('#load_organisational_default').dialog({
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
                    window.open("/organisational_duplication_formulas/set_default.html", "_self");
                    $(this).dialog('destroy');
                    return true;
                }
            }
        });
        $('#load_organisational_default').dialog('option', 'title', 'Warning - Default Setting');

        $('#load_organisational_default').parent().find("a").css("display","none");
        $("#load_organisational_default").parent().css('background-color','#D1DDE6');
        $("#load_organisational_default").css('background-color','#D1DDE6');

        $('#load_organisational_default').dialog('open');



    //        $('#load_organisational_default').dialog( {
    //            modal: true,
    //            resizable: true,
    //            draggable :true,
    //            height: 250,
    //            width: 700,
    //            buttons: {
    //                NO: function() {
    //                    $(this).dialog('close');
    //                },
    //                YES: function() {
    //                    window.open("/organisational_duplication_formulas/set_default.html", "_self");
    //                    return false;
    //                }
    //            }
    //        });
    //        $('#load_organisational_default').dialog('open');
    });
});


/*Group---Permission*/

$(function(){
    $(".show_permission_container").live('change',function(){
        if ($(this).val()!= ""){

            $.ajax({
                type:"GET",
                url: "/group_permissions/show_add_container.js",
                data: "group_id="+$(this).val(),
                dataType: "script"
            });
            $(".permission_container").css("display", "");
            $("#old_permissions").show();
        }
        else{

            $(".permission_container").css("display", "none");
            $("#old_permissions").hide();

        }
    });
});


//$(function(){
//
//    $("#system_permission_meta_meta_type_id").live('change',function(){
//
//        if ($(this).val()!= ""){
//            $.ajax({
//                type:"GET",
//                url: "/group_permissions/show_module.js",
//                data:"system_permission_module_id="+$(this).val() + '&group_id=' + $("#group_permission_user_group_id").val(),
//                dataType:"script"
//
//            });
//            $('#permission_form').show();
//        }else{
//
//            $('#permission_form').hide();
//        }
//
//    });
//});




/*Organisation-part*/


$(function(){

    $("#organisation_industry_sector_id").live('change', function(){

        if ($(this).val()!= ""){
            $.ajax({
                type:"GET",
                url: "/organisations/show_industrial_code.js",
                data:"industrial_id="+$(this).val(),
                dataType:"script"

            });
      
        }else{

            $('#organisation_industrial_code').val('');
        }

    });
});

$(function(){

    $("#organisation_business_category_id").live('change', function(){

        if ($(this).val()!= ""){
            $.ajax({
                type:"GET",
                url: "/organisations/show_sub_category.js",
                data:"sub_category_id="+$(this).val(),
                dataType:"script"

            });

        }else{

            $('#organisation_business_sub_category').val('');
        }
    });
});


/* Show list*/
$(function(){
    $("#show_all_list_member").live('click',function(){
        $.ajax({
            type: "GET",
            url: "/people/show_list.js",
            data: 'person_id='+$(this).attr('person_id')+'&current_operation='+$(this).attr('current_operation')+'&active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.person_edit_tab.active').attr('field'),
            dataType: "script"

        });
    });
});

$(function(){
    $("#show_all_list_member").live('mouseover',function(){
        $(this).css("cursor","pointer");
    });
});





//$(function(){
//    $("#edit_all_list_member").live('click',function(){
//        $.ajax({
//            type: "GET",
//            url: "/people/edit_show_list.js",
//            data: 'person_id='+$(this).attr('person_id'),
//            dataType: "script"
//
//        });
//    });
//});



//$(function(){
//    $("#show_list_select").live('click',function(){
//        window.open("/people/"+ $('#system_id_tag').val(), "_self");
//    });
//});
//
//
//$(function(){
//    $("#edit_list_select").live('click',function(){
//        window.open("/people/"+ $('#system_id_tag').val()+"/edit", "_self");
//    });
//});

$(function(){
    $("#show_all_organisations").live('click',function(){
        $.ajax({
            type: "GET",
            url: "/organisations/show_list.js",
            data: 'organisation_id='+$(this).attr('organisation_id')+'&current_operation='+$(this).attr('current_operation')+'&active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.organisation_edit_tab.active').attr('field'),
            dataType: "script"
        });
    });
});

$(function(){
    $("#show_all_organisations").live('mouseover',function(){

        $(this).css("cursor","pointer");
    });
});



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
            name : 'field_4'
        },

        ],
        sortname: "grid_object_id",
        sortorder: "asc",
        usepager: true,
        title: 'Feedback Items',
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
    $('table#feedback_search_grid tbody tr').live('click',function(){
        $('table#feedback_search_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
    });
});

$(function(){
    $('table#feedback_search_grid tbody tr').live('mouserover', function(){
        $(this).css('cursor',"pointer");
    });
});

$(function(){
    $('#system_log_search_submit').live('click',function(){
        $('#system_log_search_results').show();
        $('#system_log_export_options').show();
        $('#system_log_export_user_name').val($('#user_name').val());
        $('#system_log_export_start_date').val($('#system_log_start_date').val());
        $('#system_log_export_end_date').val($('#system_log_end_date').val());

    });
});

//$(function(){
//    $('#system_log_start_date').datepicker();
//});
//
//$(function(){
//    $('#system_log_end_date').datepicker();
//});

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

//$(function(){
//    $("#system_log_search_grid").flexigrid({
//        url: '/grids/system_log_search_grid',
//        dataType: 'json',
//        colModel : [
//        {
//            display: 'ID',
//            name : 'grid_object_id',
//            width : 40,
//            sortable : true,
//            align: 'left'
//        },
//
//        {
//            display: 'Date',
//            name : 'field_1',
//            width : 160,
//            sortable : true,
//            align: 'left'
//        },
//
//        {
//            display: 'User',
//            name : 'field_2',
//            width : 180,
//            sortable : true,
//            align: 'left'
//        },
//
//        {
//            display: 'IP Address',
//            name : 'field_3',
//            width : 120,
//            sortable : true,
//            align: 'left'
//        },
//        {
//            display: 'Controller',
//            name : 'field_4',
//            width : 100,
//            sortable : true,
//            align: 'left'
//        },
//
//        {
//            display: 'Action',
//            name : 'field_5',
//            width : 100,
//            sortable : true,
//            align: 'left'
//        },
//
//        {
//            display: 'Message',
//            name : 'field_6',
//            width : 270,
//            sortable : true,
//            align: 'left'
//        },
//
//        ],
//        searchitems : [
//        {
//            display: 'Date',
//            name : 'field_1'
//        },
//
//        {
//            display: 'User',
//            name : 'field_2'
//        },
//
//        {
//            display: 'IP Address',
//            name : 'field_3'
//        },
//
//        {
//            display: 'Controller',
//            name : 'field_4'
//        },
//
//        {
//            display: 'Action',
//            name : 'field_5'
//        },
//        {
//            display: 'Message',
//            name : 'field_6'
//        },
//
//        ],
//        sortname: "grid_object_id",
//        sortorder: "asc",
//        usepager: true,
//        title: 'System Log Entries',
//        useRp: true,
//        rp: 20,
//        showTableToggleBtn: false,
//        width: 'auto',
//        height: 'auto'
//    });
//});
//


$(function(){
    $("#people_search_grid").flexigrid({
        url: '/grids/people_search_grid',
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
            display: 'First Name',
            name : 'field_1',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Family Name',
            name : 'field_2',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Address',
            name : 'field_3',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Phone',
            name : 'field_4',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Email',
            name : 'field_5',
            width : 180,
            sortable : true,
            align: 'left'
        }
        ],
        searchitems : [
        {
            display: 'First Name',
            name : 'field_1'
        },

        {
            display: 'Family Name',
            name : 'field_2'
        },

        {
            display: 'Address',
            name : 'field_3'
        },

        {
            display: 'Phone',
            name : 'field_4'
        },

        {
            display: 'Email',
            name : 'field_5'
        }
        ],
        sortname: "grid_object_id",
        sortorder: "asc",
        usepager: true,
        title: 'People Search Result',
        useRp: true,
        rp: 20,
        showTableToggleBtn: false,
        width: 'auto',
        height: 'auto'
    });
});

$(function(){
    $('table#people_search_grid tbody tr').live('click',function(){
        $('table#people_search_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
        $.ajax({
            type: 'GET',
            url: "/people/"+$(this).attr('id').substring(3)+"/name_card.js",
            dataType: "script"
        });
    });
});

$(function(){
    $('table#people_search_grid tbody tr').live('dblclick',function(){
    {
        window.open("/people/"+$(this).attr("id").substring(3)+"/edit","_self");
    }
    });
});

$(function(){
    $('table#people_search_grid tbody tr').live('mouseover', function(){
        $(this).css('cursor',"pointer");
    });
});

$(function(){
    $('table#query_result_grid tbody tr').live('click',function(){
        $('table#query_result_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
    });
});

$(function(){
    $('table#query_result_grid tbody tr').live('mouseover', function(){
        $(this).css('cursor',"pointer");
    });
});

/*option hover*/
$(function(){
    $('.toggle_options').live('mouseover',function(){
        if ($("#" + $(this).attr('field')+'_mode').attr('mode') == "show"){
            $(this).find('.options').css("display","");
        }
         
    });
});

$(function(){
    $('.toggle_options').live('mouseout',function(){
        if ($("#" + $(this).attr('field')+'_mode').attr('mode') == "show"){
            $(this).find('.options').css("display","none");
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
        if  ($(this).parent().parent().parent().parent().find('.ogranisation_input_change_class').attr('value') == "true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");                        
                        link.parent().parent().parent().parent().find('.ogranisation_input_change_class').attr('value','false');
                        clear_organisation_form(link);
                  
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
        else if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $('#'+link.attr('toggle_id_name1')).toggle('blind');
                        $('.select_ajax_call[field='+ link.attr('field') +']').attr('disabled', false)
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('.close_option[field='+ link.attr('field') +']').css("display","none");
                        $('#check_input_change').val("false");

                        clear_organisation_form(link);

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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $('#'+link.attr('toggle_id_name1')).toggle('blind');
            $('.select_ajax_call[field='+ link.attr('field') +']').attr('disabled', false)
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            clear_organisation_form(link);

            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $('.close_option[field='+ link.attr('field') +']').css("display","none");

        }


    });
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

    //    if(link.attr('toggle_id_name')=="new_master_doc")
    //    {
    //        $("#new_master_doc")[0].reset();
    //
    //    }
    if(link.attr('toggle_id_name')=="new_note")
    {
        $("#new_note")[0].reset();

    }


}

$(function(){
    $('.new_option').live('click',function(){

        $("#" + $(this).attr('field')+'_mode').attr('mode','new');
        $(this).css("display","none");
        $('.close_option[field='+ $(this).attr('field') +']').css("display","");
    });
});

/*Organisation Grid*/

$(function(){
    $('table#search_organisations_list_results tbody tr').live('dblclick',function(){
        if ($('table#search_organisations_list_results').attr('current_operation') == "edit_organisation_list")
        {
            window.open("/organisations/"+$(this).attr("id").substring(3)+"/edit","_self");
        }
        if ($('table#search_organisations_list_results').attr('current_operation') == "show_organisation_list")
        {
            window.open("/organisations/"+$(this).attr("id").substring(3)+"/","_self");
        }

    });
});


$(function(){
    $('table#search_organisations_list_results tbody tr').live('click',function(){
        $.ajax({
            type: 'GET',
            url: "/organisations/show_left.js",
            data: 'organisation_id='+$(this).attr('id').substring(3)+'&current_operation='+ $('#search_organisations_list_results').attr('current_operation')+'&active_tab='+$('#search_organisations_list_results').attr('active_tab')+'&active_sub_tab='+$('#search_organisations_list_results').attr('active_sub_tab'),
            dataType: "script"
        });
        $('table#search_organisations_list_results tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass("trSelected");
    });
});

$(function(){
    $('table#search_organisations_list_results tbody tr').live('mouseover', function(){
        $(this).css('cursor',"pointer");
    });
});

//$(function(){
//    $("#show_organisation_list_select").live('click',function(){
//        window.open("/organisations/"+ $('#system_id_tag').val(), "_self");
//    });
//});
//
//
//$(function(){
//    $("#edit_organisation_list_select").live('click',function(){
//        window.open("/organisations/"+ $('#system_id_tag').val()+"/edit", "_self");
//    });
//});

$(function(){
    $("#organisation_search_grid").flexigrid({
        url: '/grids/organisation_search_grid',
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
            display: 'Trading As',
            name : 'field_1',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Registered Name',
            name : 'field_2',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Address',
            name : 'field_3',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Phone',
            name : 'field_4',
            width : 180,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Website',
            name : 'field_5',
            width : 180,
            sortable : true,
            align: 'left'
        }
        ],
        searchitems : [
        {
            display: 'Trading As',
            name : 'field_1'
        },

        {
            display: 'Registered Name',
            name : 'field_2'
        },

        {
            display: 'Address',
            name : 'field_3'
        },

        {
            display: 'Phone',
            name : 'field_4'
        },

        {
            display: 'Website',
            name : 'field_5'
        }
        ],
        sortname: "grid_object_id",
        sortorder: "asc",
        usepager: true,
        title: 'Organisation Search Result',
        useRp: true,
        rp: 20,
        showTableToggleBtn: false,
        width: 'auto',
        height: 'auto'
    });
});

$(function(){
    $('table#organisation_search_grid tbody tr').live('click',function(){
        $('table#organisation_search_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
        $.ajax({
            type: 'GET',
            url: "/organisations/"+$(this).attr('id').substring(3)+"/name_card.js",
            dataType: "script"
        });
    });
});

$(function(){
    $('table#organisation_search_grid tbody tr').live('dblclick',function(){
    {
        window.open("/organisations/"+$(this).attr("id").substring(3)+"/edit","_self");
    }
    });
});

$(function(){
    $('table#organisation_search_grid tbody tr').live('mouseover',function(){
        $(this).css('cursor',"pointer");
    });
});
$(function(){   /*organisation employee list result*/
    $("#organisations_employees_grid").flexigrid({
        url: '/grids/organisation_employee_grid',
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
            display: 'First Name',
            name : 'field_1',
            width : 50,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Family Name',
            name : 'field_2',
            width : 50,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Address',
            name : 'field_3',
            width : 120,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Phone',
            name : 'field_4',
            width : 80,
            sortable : true,
            align: 'left'
        },

        {
            display: 'email',
            name : 'field_5',
            width : 40,
            sortable : true,
            align: 'left'
        }
        ],
        searchitems : [
        {
            display: 'First Name',
            name : 'field_1'
        },

        {
            display: 'Family Name',
            name : 'field_2'
        },

        {
            display: 'Address',
            name : 'field_3'
        },

        {
            display: 'Phone',
            name : 'field_4'
        },

        {
            display: 'Email',
            name : 'field_5'
        }
        ],
        sortname: "grid_object_id",
        sortorder: "asc",
        usepager: true,
        title: 'Organisation Employee Result',
        useRp: true,
        rp: 20,
        showTableToggleBtn: false,
        width: 'auto',
        height: 'auto'
    });
});


/* person check dup feild*/

$(function(){
    $('.personal_check_field').blur(function(){

        var personal_check_fields=[];
        var personal_data_string ="";

        for(var k=0; k < $('.personal_check_field').get().length;k++)
        {
            if($('.personal_check_field').eq(k).attr("id").indexOf("_id")>0)
            {
             
                personal_check_fields.push($('.personal_check_field').eq(k).attr("id").substring(7,$('.personal_check_field').eq(k).attr("id").indexOf("_id")));
                personal_check_fields.push($('.personal_check_field').eq(k).val());
            }
            else
            {
                personal_check_fields.push($('.personal_check_field').eq(k).attr("id").substring(7));
                personal_check_fields.push($('.personal_check_field').eq(k).val());
            }
        }

        for (var z=0; z< personal_check_fields.length;z++)
        {

            if(z > 0)
            {
                personal_data_string += "&"

            }
            personal_data_string += personal_check_fields[z++] + "=" + personal_check_fields[z];
        }
    
        $.ajax({
            type: 'GET',
            url: "/people/check_duplication.js",
            data: personal_data_string + "&id="+$("#person_id").val(),
            dataType: "script"

        });
    });
});

$(function(){
    $('table#person_check_field tbody tr').live('click',function(){
        $('table#person_check_field tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
    });
});
$(function(){
    $('table#person_check_field tbody tr').live('mouseover',function(){
        $(this).css('cursor',"pointer");
    });
});


/*Organisational Duplication Check*/
$(function(){
    $('.organisational_check_field').blur(function(){
        var check_fields = [];
        var data_string = "";
        for (var i = 0; i < $('.organisational_check_field').get().length; i++){
            if($('.organisational_check_field').eq(i).attr("id").indexOf("_id")>0){
                check_fields.push($('.organisational_check_field').eq(i).attr("id").substring(13, $('.organisational_check_field').eq(i).attr("id").indexOf("_id")));
                check_fields.push($('.organisational_check_field').eq(i).val());
            }else{
                check_fields.push($('.organisational_check_field').eq(i).attr("id").substring(13));
                check_fields.push($('.organisational_check_field').eq(i).val());
            }            
        }
        for (var j = 0; j < check_fields.length; j++){
            if (j >0){
                data_string += "&";
            }
            data_string += check_fields[j++] + "=" + check_fields[j];
        }
        $.ajax({
            type: 'GET',
            url: "/organisations/check_duplication.js",
            data: data_string + "&id=" + $("#organisation_id").val(),
            dataType: "script"
        });
    });
});

$(function(){
    $('table#duplication_organisations_grid tbody tr').live('click',function(){
        $('table#duplication_organisations_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
    });
});


/*personal check field restart button*/
personal_check_duplication_restart_button = function(){


    //alert($('#system_id_tag').val());
    if($('#system_id_tag').val() != null)
    {
        window.open("/people/"+ $('#system_id_tag').val()+"/edit", "_self");
    }
    else
    {
        window.open("/people/new", "_self");
    }
    return false;
}

$(function(){
    $('table#person_check_field tbody tr.trSelected').live('dblclick',function(){

        window.open("/people/"+$(this).attr("id").substring(3)+"/edit","_self");
    });
});

$(function(){
    $('table#duplication_organisations_grid tbody tr').live('dblclick',function(){
        window.open("/organisations/"+ $(this).attr('id').substring(3) +"/edit", "_self");
    });
});
$(function(){
    $('table#duplication_organisations_grid tbody tr').live('mouseover',function(){
        $(this).css('cursor',"pointer");
    });
});


/*user_group  new design*/




$(function(){

    $('.add_flag').live('click', function(){
        $(this).css('display', 'none');
        $('#close_'+ $(this).attr('flag_name')).css('display', '');
    });
});


$(function(){
    $('.close_flag').live('click', function(){

        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {

            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" +link.attr('field')+'_mode').attr('mode','show');
                        link.css('display', 'none');
                        $('#add_'+link.attr('flag_name')).css('display', '');
                        $('#new_'+link.attr('flag_name')).toggle('blind');
                        $('#add_new_role').css("display","");
                        $('#role_role_type_id').attr("disabled", false);
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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" +link.attr('field')+'_mode').attr('mode','show');
            link.css('display', 'none');
            $('#add_'+link.attr('flag_name')).css('display', '');
            $('#new_'+link.attr('flag_name')).toggle('blind');
            $('#check_input_change').val("false");
            $('#add_new_role').css("display","");
            return true;

        }


   

    });
   
});



$(function(){
    $('.edit_close_flag').live('click', function(){
        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {

            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" +link.attr('field')+'_mode').attr('mode','show');
                        link.css('display', 'none');
                        $('#edit_'+link.attr('flag_name')+"_container").html('');
                        $('#add_new_role').css("display","");
                        $('#check_input_change').val("false");
                        $('#role_role_type_id').attr("disabled", false);
                        $(".container_selected").removeClass("container_selected");
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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" +link.attr('field')+'_mode').attr('mode','show');
            link.css('display', 'none');
            $('#edit_'+link.attr('flag_name')+"_container").html('');
            $('#add_new_role').css("display","");
            $('#check_input_change').val("false");
            $('#role_role_type_id').attr("disabled", false);
            $(".container_selected").removeClass("container_selected");
            return true;

        }
    });

});

//$(function(){
//    $('.user_name_to_person').live('change', function(){
//        if($(this).val()!= ""){
//            $.ajax({
//                type: "GET",
//                url: "/user_groups/user_name_to_person.js",
//                data: 'user_name='+$(this).val(),
//                dataType:"script"
//            });
//        }else{
//            $("#login_name_container_"+$(this).attr('login_account_id')).html("");
//        }
//
//    });
//});

//
//
//$(function(){
//    $(".check_username_unique").live('change', function(){
//        if($(this).val()!= ""){
//            $.ajax({
//                type: "GET",
//                url: "/login_accounts/user_name_unique.js",
//                data: 'user_name='+$(this).val()+'&login_account_id='+$(this).attr('login_account_id')+'&length='+$(this).val().length,
//                dataType:"script"
//            });
//        }else{
//            $("#login_name_container_"+$(this).attr('login_account_id')).html("");
//        }
//    });
//});



/*organisation info tab*/
$(function(){
    $('.active_organisation_info_tab').live('click',function(){
        $('.organisation_info_tab').removeClass('hidden_tab');
        $("#"+$(this).attr("hidden_id_name")).addClass('hidden_tab');
        $(".container_icon").removeClass("container_icon_color");
        $(this).parent().addClass("container_icon_color");
    });
});


/* Import and Export */
$(function(){
    $('.export_button').live('click',function(){
        var format = $(this).attr("value").toLowerCase();
        var source = $(this).attr("source");
        var source_id = $("#source_id").val();
        window.open("/data_managers/export."+format+"?source="+source+"&source_id="+source_id);
    });
});


/* Reporting*/
$(function(){
    $('#report_person_pdf_submit_button').live('click', function(){

        window.open("/reports/generate_person_report_pdf?request_format="+$('#report_requested_format').val()+"&list_header_id="+$('#report_list').val());
    });

});

$(function(){
    $('#report_organisation_pdf_submit_button').live('click', function(){

        window.open("/reports/generate_organisation_report_pdf?request_format="+$('#report_requested_format').val()+"&list_header_id="+$('#report_list').val());
    });

});


/*role--new--design*/

//$(function(){
//    $('#edit_role_form').live('click', function(){
//        $('#role_role_type_id').attr("disabled", false);
//        $(".container_selected").removeClass("container_selected");
//    });
//
//});


/*role_condition part*/


$(function(){
    $('.edit_role').live('click', function(){

        $(".container_selected").removeClass("container_selected");
        $(this).closest('.toggle_options').addClass("container_selected");
        $.ajax({
            type: "GET",
            url: "/roles/" + $(this).attr('role_id') + "/edit.js",
            data: "role_id="+$(this).attr('role_id'),
            dataType:"script"

        });
    });
});

$(function(){
    $(".role_condition_show_role").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url: "/role_conditions/role_condition_show_roles.js",
                data: 'role_type_id='+$(this).val(),
                dataType: "script"

            });

            $('#role_condition_role_main_contents').show();
        }else{

            $('#role_condition_role_main_contents').hide();
            
        }
    });
});


$(function(){
    $('#role_condition_role_click').live('click', function(){
        $(".container_selected").removeClass("container_selected");
        $(this).closest('.toggle_options').addClass("container_selected");

        $.ajax({
            type:'GET',
            url: "/role_conditions/" + $(this).attr('role_id') + "/edit.js",
            data: "role_id="+$(this).attr('role_id'),
            dataType:"script"

        });
    });
});


$(function(){
    $(".find_master_doc_meta_type_field_for_role_condition").live('change', function(){
        $.ajax({
            type: "GET",
            url: "/role_conditions/condition_meta_type_finder.js",
            data: 'master_doc_meta_meta_type_id='+$(this).val()+'&id='+$(this).val(),
            dataType: "script"
        });

    });
});


//$(function(){
//    $(".find_master_doc_meta_type_field_for_role_condition").live('change', function(){
//        $.ajax({
//            type: "GET",
//            url:
//            "/roles/meta_name_finder.js",
//            data:
//            'id='+$(this).val(),
//            dataType: "script"
//        });
//    });
//});

//$(function(){
//    $("#master_doc_meta_type_id_for_role_condition").live('change', function(){
//        $.ajax({
//            type: "GET",
//            url: "/roles/meta_type_name_finder.js",
//            data:'id='+$(this).val(),
//            dataType: "script"
//        });
//    });
//});

$(function(){

    $("#master_doc_meta_type_id_for_role_condition").live('change', function(){
        $.ajax({
            type: "GET",
            url:"/role_conditions/doc_type_finder.js",
            data:'master_doc_meta_type_id='+$(this).val(),
            dataType: "script"
        });
    });
});


$(function(){

    $("#edit_role_condition_form").live('click', function(){
        $(".container_selected").removeClass("container_selected");
        $("#role_condition_edit_role_container").hide();
        $('#role_condition_role_type_id').attr("disabled", false);
    });
});

$(function(){
    $("#click_condition").live('mousedown', function(){
        $.ajax({
            type: "GET",
            url:"/roles/role_type_finder.js",
            dataType: "script"
        });
    });
});


/*  Address Post Code */
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

/* Organisation Lookup*/
$(function(){
    $(".organisation_lookup").live('click', function(){
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

/*group----list*/
$(function(){
    $(".edit_logo").live('click', function(){

        $(".container_selected").removeClass("container_selected");
        $(this).closest('.toggle_options').addClass("container_selected");
        
        $(this).closest('.options').css("display","none");
        $.ajax({
            type:'GET',
            url: "/"+$(this).attr('controller')+"/" + $(this).attr('data_id') + "/edit.js",
            data: "data_id="+$(this).attr('data_id'),
            dataType:"script"

        });
    });
});


$(function(){
    $('.new_logo').live('click', function(){        
        $("#new_" + $(this).attr('field')+ "_form").toggle('blind');
        $('.close_logo').css('display','');
        
    });
});


$(function(){
    $('.close_logo').live('click', function(){


        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $("#new_" + link.attr('field')+ "_form").toggle('blind');
                        //                       $('#new_user_group_form').css('display','none');
                        $("#" + link.attr('field')+ "_edit_container").html('');
                        if (link.attr('change_color') == "false"){

                        }else{
                            $(".container_selected").removeClass("container_selected");
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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            //            $('#new_user_group_form').css('display','none');

            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $("#new_" + link.attr('field')+ "_form").toggle('blind');
            $("#" + link.attr('field')+ "_edit_container").html('');
            if (link.attr('change_color') == "false"){

            }else{
                $(".container_selected").removeClass("container_selected");
            }
        }

  
















       
       
    });
});


$(function(){
    $('.show_list_description').live('change', function(){
        $.ajax({
            type: "GET",
            url: "/group_lists" + "/show_list_des.js",
            data: "list_id=" + $(this).val(),
            dataType:"script"
        });


    });
});


/* Person Lookup*/
$(function(){
    $(".person_lookup").live('click', function(){
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

/*user--list*/

$(function(){
    $('.show_user_list_description').live('change', function(){
        $.ajax({
            type: "GET",
            url: "/user_lists" + "/show_list_des.js",
            data: "list_id=" + $(this).val(),
            dataType:"script"

        });

    });


      
});


//person eidt tabs image change
$(function(){
    $(".person_edit_tab:not(.active)").live("mouseover", function(){
        $(this).find("img").attr("src","/images/Icons/Core/Person/tabs/"+$(this).attr("field")+".png");
    });

    $(".person_edit_tab:not(.active)").live("mouseout", function(){
        $(this).find("img").attr("src","/images/Icons/Core/Person/tabs/"+$(this).attr("field")+"_BW.png");
    });

    $(".person_edit_tab:not(.active)").live("mouseup", function(){
        $(".person_edit_tab.active").find("img").attr("src", "/images/Icons/Core/Person/tabs/"+$(".person_edit_tab.active").attr("field")+"_BW.png");
        $(".person_edit_tab").removeClass("active");
        $(this).addClass("active");
        $(this).find("img").attr("src","/images/Icons/Core/Person/tabs/"+$(this).attr("field")+"_title.png");
    });
});

//organisatiomn eidt tabs image change
$(function(){
    $(".organisation_edit_tab:not(.active)").live("mouseover", function(){
        $(this).find("img").attr("src","/images/Icons/Core/Org/tabs/"+$(this).attr("field")+".png");
    });

    $(".organisation_edit_tab:not(.active)").live("mouseout", function(){
        $(this).find("img").attr("src","/images/Icons/Core/Org/tabs/"+$(this).attr("field")+"_BW.png");
    });

    $(".organisation_edit_tab:not(.active)").live("mouseup", function(){
        $(".organisation_edit_tab.active").find("img").attr("src", "/images/Icons/Core/Org/tabs/"+$(".organisation_edit_tab.active").attr("field")+"_BW.png");
        $(".organisation_edit_tab").removeClass("active");
        $(this).addClass("active");
        $(this).find("img").attr("src","/images/Icons/Core/Org/tabs/"+$(this).attr("field")+"_title.png");
    });
});

/*user account*/

$(function(){
    $('#generate_new_password').live('click', function(){

        $.ajax({
            type: "Post",
            url: "/login_accounts/generate_password.js",
            data: "login_account_id=" + $(this).attr('login_account_id'),
            dataType:"script"

        });

    });

});

/*Contact form add button form to default phone form*/
$(function(){
    $(".clear_form_to_phone").live("click", function(){
        $("#select_contact_type").val("Phone").change();

        //        if($("#phone_contact_meta_type_id").val() == null)
        //        {
        //            $("#phone_pre_value").attr('readonly','readonly');
        //            $("#phone_value").attr('readonly','readonly');
        //            $("#phone_post_value").attr('readonly','readonly');
        //            $("#phone_remarks").attr('readonly','readonly');
        //            $("#contact_phone_submit").attr('readonly','readonly');
        if($("#phone_contact_meta_type_id").val() == null)
        {
            $("#phone_pre_value").attr('readonly','readonly');
            $("#phone_value").attr('readonly','readonly');
            $("#phone_post_value").attr('readonly','readonly');
            $("#phone_remarks").attr('readonly','readonly');
            $("#contact_phone_submit").attr('disabled','disabled');

        }

        if($("#email_contact_meta_type_id").val() == null)
        {
            $("#email_remarks").attr('readonly','readonly');
            $("#email_value").attr('readonly','readonly');
            $("#submit_email_field").attr('readonly','readonly')
        }

        if($("#website_contact_meta_type_id").val() == null)
        {
            $("#website_value").attr('readonly','readonly');
            $("#website_remarks").attr('readonly','readonly');
            $("#submit_website_field").attr('readonly','readonly')
        }
    //            if($("#email_contact_meta_type_id").val() == null)
    //            {
    //                $("#email_remarks").attr('readonly','readonly');
    //                $("#email_value").attr('readonly','readonly');
    //                $("#submit_email_field").attr('disabled','disabled');
    //            }
    //
    //            if($("#website_contact_meta_type_id").val() == null)
    //            {
    //                $("#website_value").attr('readonly','readonly');
    //                $("#website_remarks").attr('readonly','readonly');
    //                $("#submit_website_field").attr('disabled','disabled');
    //            }

    //        }
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
            $('#feedback_form_submit_button').removeAttr('disabled');
        }
    });
});

$(function() {
    $('#feedback_item_content').keyup(function() {
        if($('#feedback_item_subject').val() == '' || $('#feedback_item_content').val() == '') {
            $('#feedback_form_submit_button').attr('disabled', true);
        } else {
            $('#feedback_form_submit_button').removeAttr('disabled');
        }
    });
});



$(function(){
    $(".clear_form_to_address").live("click", function(){

        if($("#address_address_type_id").val() == null)
        {
            $("#address_building_name").attr('readonly','readonly');
            $("#address_suite_unit").attr('readonly','readonly');
            $("#address_street_number").attr('readonly','readonly');
            $("#address_street_name").attr('readonly','readonly');
            $("#address_town").attr('readonly','readonly');
            $("#address_state").attr('readonly','readonly');
            $("#address_postal_code").attr('readonly','readonly');
            $("#address_country_id").attr('readonly','readonly');
            $("#address_submit_button").attr('disabled','disabled');

        }
    });
});

/*new-design--group permission*/

$(function(){

    $(".show_module_form").live('change',function(){

        if ($(this).val()!= ""){
            $.ajax({
                type:"GET",
                url: "/group_permissions/show_module.js",
                data:"system_permission_module_id="+$(this).val() + '&group_id=' + $("#group_permission_user_group_id").val(),
                dataType:"script"

            });
            $('#permission_form').show();
        }else{

            $('#permission_form').hide();
        }

    });
});



$(function(){
    $(".group_permission_color").live('mouseover', function(){
        $(this).addClass("color_change");
    });
});

$(function(){
    $(".group_permission_color").live('mouseout', function(){
        $(this).removeClass("color_change");
    });
});

/*use for click the module show the whole thing*/
$(function(){
    $("#show_controllers").live('click', function(){
        $.ajax({
            type:"GET",
            url:"/group_permissions/show_controllers.js",
            data:"main_module_id="+$(this).attr('main_module_id'),
            dataType:"script"

        });

    });

});

$(function(){
    $(".module_select_all").live('click', function(){
        if ($(this).attr("checked") == true){
            $('.controller_select_all').attr("checked", true);
            $('.method_select_all').attr("checked", true);
        }else{
            $('.controller_select_all').attr("checked", false);
            $('.method_select_all').attr("checked", false);
        }

    });
});

$(function(){
    $("#new_group_permission").live('click', function(){
        $(this).css("display", "none");
        $(".group_permission_delete").css("display", "none");

        $.ajax({
            type: "GET",
            url: "/group_permissions/new.js",
            data:"group_id="+$(this).attr('group_id'),
            dataType: "script"
        });
        $("#close_new_module").css("display", "");
    });
});

/*when you slecet the controller , all the method will be on*/
$(function(){
    $('.controller_select_all').live('click', function(){
        if ($(this).attr('checked') == true){
            $('.method_select_all[controller_id = ' + $(this).val() +']').attr("checked", true);
        }else{
            $('.method_select_all[controller_id='+ $(this).val()+']').attr("checked", false);
            $('.module_select_all').attr("checked", false);
        }
    });
});

$(function(){
    $('.method_select_all').live('click', function(){
        if ($(this).attr('checked') == false){
            $('.module_select_all').attr("checked", false);
            $('.controller_select_all[controller_id='+ $(this).attr("controller_id")+ ']').attr("checked", false);
        }
    });
});

$(function(){
    $("#close_new_module").live('click', function(){
        $(this).css("display", "none");
        $('#hide_module').html('');
        $('#new_group_permission').css("display", "");
        $(".group_permission_delete").css("display", "");
    });
});


/* disabled form */
$(function(){
    $(".disabled_form").find("input").attr("disabled", true);
    $(".disabled_form").find("select").attr("disabled", true);
});


/* Admin Add Keyword*/

$(function(){
    $("#keyword_add_entry").live('click', function(){
        $("#keyword_add_entry_form").show();
        $("#edit_keyword_entry").html("");

        //        $("#keyword_add_entry_form").attr("type_id", $("#keyword_type").val());
        $("#type_id").val($("#keyword_type").val());
        $("#keyword_type").attr("disabled",true);
        $("#keyword_close_entry").css("display","");
        
        $(".keyword_entry_selected").removeClass("keyword_entry_selected");

    });
});

$(function(){
    $("#keyword_close_entry").live('click', function(){
        
        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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
                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $("#keyword_add_entry_form").css('display','none');
                        $("#edit_keyword_entry").html("");
                        $("#keyword_type").attr("disabled",false);
                        $(".keyword_entry_selected").removeClass("keyword_entry_selected");
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
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $("#keyword_add_entry_form").hide();
            $("#edit_keyword_entry").html("");
            $("#keyword_type").attr("disabled",false);
            $(".keyword_entry_selected").removeClass("keyword_entry_selected");

        }



  
    });
});

$(function(){
    $("#close_edit_keyword_entry").live('click', function(){

        var link = $(this);
        if ( $('#check_input_change').val()=="true")
        {
            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
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

                        $('#'+link.attr('toggle_id_name')).toggle('blind');
                        $("#" + link.attr('field')+'_mode').attr('mode','show');
                        link.css("display","none");
                        $('.new_option[field='+ link.attr('field') +']').css("display","");
                        $('#check_input_change').val("false");
                        $(".container_selected").removeClass("container_selected");
                        $("#keyword_add_entry").css("display","");
                        $("#keyword_mode").attr('mode', 'show');
                        $("#keyword_add_entry_form").hide();
                        $("#keyword_type").attr("disabled",false);
                        $("#edit_keyword_entry").html("");
                        $(".keyword_entry_selected").removeClass("keyword_entry_selected");
                        $.ajax({
                            type: "GET",
                            url: "/keywords/keywords_finder.js",
                            data: 'type=' + $("#keyword_type").val(),
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

        }
        else
        {
            $('#'+link.attr('toggle_id_name')).toggle('blind');
            $("#" + link.attr('field')+'_mode').attr('mode','show');
            link.css("display","none");
            $('.new_option[field='+ link.attr('field') +']').css("display","");
            $('#check_input_change').val("false");
            $(".container_selected").removeClass("container_selected");
            $("#keyword_add_entry").css("display","");
            $("#keyword_mode").attr('mode', 'show');
            $("#keyword_add_entry_form").hide();
            $("#keyword_type").attr("disabled",false);
            $("#edit_keyword_entry").html("");
            $(".keyword_entry_selected").removeClass("keyword_entry_selected");
            $.ajax({
                type: "GET",
                url: "/keywords/keywords_finder.js",
                data: 'type=' + $("#keyword_type").val(),
                dataType: "script"
            });

        }
       
    });
});


$(function(){
    $("#keyword_type").live('change', function(){
        if($(this).val()==""){
            $("#keyword_main_contents").hide();
            $("#keyword_entries").html("");
            $("#edit_keyword_entry").html("");
        } else {
            $("#edit_keyword_entry").html("");
           
        
            $("#amazon_setting_type").val($(this).val());
            $.ajax({
                type: "GET",
                url: "/keywords/keywords_finder.js",
                data: 'type=' + $(this).val(),
                dataType: "script"
            });
            $("#keyword_main_contents").show();
        }
        $("#keyword_mode").attr('mode', 'show');
    });
});




$(document).ready(function() {
    $(".admin_password_reset").validationEngine({
        validationEventTriggers:"keyup blur",

        success :  false,

        failure : function() { 
            callFailFunction()
        }

    });
});


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

            "No ": function(){
                $(this).dialog('close');
                return true;

            },
 
            "Yes": function(){
                window.open("/signin/signout", "_self");
                $(this).dialog('close');
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


/* Powernet Menu Module*/
$(function(){
    $(".switch_module_status").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/available_modules/switch_status.js",
            data: 'id=' + $(this).attr("module_id"),
            dataType: "script"
        });
    });
});



$(function(){
    $("#hide_feedback_reply").live('click', function(){
        $("#hide_feedback_reply").hide();
        $("#display_feedback_reply").show();
        $("#feedback_reply").hide();
    });
});

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

/*Keyword double click0*/

$(function(){
    $("#add_person_keywords").live('dblclick', function(){
  
        $.ajax({
            type: "POST",
            url: "/keyword_links/add_key.js",
            data: 'person_id=' + $('#person_id').val()+"&add_person_keywords="+$(this).val(),
            dataType: "script"
        });
    });
});

$(function(){
    $("#remove_person_keywords").live('dblclick', function(){

        $.ajax({
            type: "POST",
            url: "/keyword_links/remove_key.js",
            data: 'person_id=' + $('#person_id').val()+"&remove_person_keywords="+$(this).val(),
            dataType: "script"
        });
    });
});

$(function(){
    $("#add_organisation_keywords").live('dblclick', function(){

        $.ajax({
            type: "POST",
            url: "/keyword_links/add_key.js",
            data: 'organisation_id=' + $('#organisation_id').val()+"&add_organisation_keywords="+$(this).val(),
            dataType: "script"
        });
    });
});

$(function(){
    $("#remove_organisation_keywords").live('dblclick', function(){

        $.ajax({
            type: "POST",
            url: "/keyword_links/remove_key.js",
            data: 'organisation_id=' + $('#organisation_id').val()+"&remove_organisation_keywords="+$(this).val(),
            dataType: "script"
        });
    });
});

$(function(){
    $(".check_delete ").live('click', function(){

        $.ajax({
            type: "GET",
            url: "/keywords/check_destroy.js",
            data: 'id=' + $(this).attr("keyword_id"),
            dataType: "script"
        });
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

//Member Zone Super User Password Confirmation
$(function(){
    $("#repeat_password").live('change', function(){
        if ($(this).val()!= $('#password').val()){
            $('#password_error').dialog( {
                modal: true,
                resizable: true,
                draggable: true,
                buttons: {
                    OK: function(){
                        $(this).dialog('destroy');
                        return true;

                    }
                }
            });
            $('#password_error').dialog('option', 'title', 'Error');
            $('#password_error').dialog('open');
        }else{
            $('#password_submit').attr('disabled',false);
        }
    });


});

// Postcode stuff



$(function(){
    $(".check_postcode_columns").blur(function(){
        if( ($(this).val() != '')  && (($(this).val() + "0") <= 0) ) {
            alert("Invalild Post Code Value");
            $(this).val('');
        };

    });
});

$(function(){
    // Ensure that the person entered at least one column
    $("#show_import_postcode_parameters").live('click', function(){
        var total = '';
        var l = $('.check_postcode_columns').length;

        for (i = 0; i < l; i++) {
            total = total + $('#'+$('.check_postcode_columns')[i].id).val();
        }
        if(total != '') {
            $('#import_postcodes_columns').dialog('close');
            $('#import_postcode_parameters').dialog( {
                modal: true,
                resizable: false,
                width: 600,
                height: 275,
                draggable: true
            });
            $('#import_postcode_parameters').dialog('open');
            $('#import_postcode_parameters').dialog('option', 'title', 'Postcode upload parameters');
        } else {
            alert("All Fields Must be Filled")
        }
    });
});




$(function(){
    $("#user_name").blur(function(){
        $.ajax({
            type: "GET",
            url: "/client_setups/system_log_verify_user_name.js",
            data: 'user_name='+$(this).val(),
            dataType: "script"
        });

    });
});

/*Check all input field change or not*/

$(function(){


    $("#content input[type='text']").live('change', function(){
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
});

$(function(){
    $("#content #left_content").find("input[type='text']").live('change', function(){
        $('#check_left_input_change').val("true");
    //        $('#check_input_change').val("true");
    });
});

$(function(){
    $("#content #right_content").find("input[type='text']").live('change', function(){
        right_tab = $("#right_content").find("#tabs");
        if(right_tab.length <= 0)
        {
            $('#check_right_input_change').val("true");
        //               alert($('#check_right_input_change').val());
        }


    //        $('#check_right_input_change').val("true");
    //        $('#check_input_change').val("true");

    });
});

check_input_change = function(){

    //    if($('#check_right_input_change').val() == "false")
    //    {
        
    if ($('#contact_input_change_or_not').val()=="true" || $('#address_input_change_or_not').val()=="true" ||  $('#master_doc_input_change_or_not').val()=="true" || $('#relationship_input_change_or_not').val() == "true" ||  $('#notes_input_change_or_not').val()=="true"||  $('#employment_input_change_or_not').val() == "true" || $('#role_input_change_or_not').val()=="true")
    {
                 
        $('#check_right_input_change').val("true");
    }
    else
    {
             
        $('#check_right_input_change').val("false");
    }
//     }

     

}

$(function(){
    $('#lc a').live('click', function(){

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
    }).attr("rel", "nofollow");
});

$(function(){
    $('#sysbar a').live('click', function(){

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
    }).attr("rel", "nofollow");
});


$(function(){
    $('#lol a').live('click', function(){

        var link = $(this);

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
            window.open(link.attr('href'),"_self"); 
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



/*check contact input field change or not*/

$(function(){
    $("#Contact").find('input').live('change', function(){
      

        $('#contact_input_change_or_not').val("true");

    });

    $('#Contact input[type="submit"]').live('click', function(){
        $('#contact_input_change_or_not').val("false");
    });

});


$(function(){
    $("#Address").find('input').live('change', function(){
        $('#address_input_change_or_not').val("true")
    });

    $('#Address input[type="submit"]').live('click', function(){
        $('#address_input_change_or_not').val("false");

    });

});

$(function(){
    $("#MasterDocs").find('input').live('change', function(){
        $('#master_doc_input_change_or_not').val("true")
    });

    $('#MasterDocs input[type="submit"]').live('click', function(){
        $('#master_doc_input_change_or_not').val("false");

    });

});


$(function(){
    $("#Rels").find('input').live('change', function(){
        $('#relationship_input_change_or_not').val("true");
    });

    $('#Rels input[type="submit"]').live('click', function(){
        $('#relationship_input_change_or_not').val("false");

    });

});

$(function(){
    $("#Note").find('input').live('change', function(){
        //        $('#check_right_input_change').val("true");
     
        $('#notes_input_change_or_not').val("true");
    
    });
    
    $("#Note").find('textarea').live('change', function(){
        //        $('#check_right_input_change').val("true");
    
        $('#notes_input_change_or_not').val("true");

    });



    $('#Note input[type="submit"]').live('click', function(){
        $('#notes_input_change_or_not').val("false");

    });

});

$(function(){
    $("#Role").find('input').live('change', function(){
        //        $('#check_right_input_change').val("true");
        $('#role_input_change_or_not').val("true");
    });

    $('#Role input[type="submit"]').live('click', function(){
        $('#role_input_change_or_not').val("false");

    });

});
$(function(){
    $("#Employment").find('input').live('change', function(){
        //        $('#check_right_input_change').val("true");
        $('#employment_input_change_or_not').val("true");
    });

    $('#Employment input[type="submit"]').live('click', function(){
        $('#employment_input_change_or_not').val("false");

    });

});


$(function(){
    $('#left_content input[type="submit"]').live('click', function(){
        $('#check_left_input_change').val("false");

    });
});

$(function(){
    $('#right_content input[type="submit"]').live('click', function(){
        if ( $('#contact_input_change_or_not').val()=="true" || $('#address_input_change_or_not').val()=="true" ||  $('#master_doc_input_change_or_not').val()=="true" || $('#relationship_input_change_or_not').val() == "true" ||  $('#notes_input_change_or_not').val()=="true"||  $('#employment_input_change_or_not').val() == "true" || $('#role_input_change_or_not').val()=="true")
        {
            $('#check_right_input_change').val("true");
     
        }
        else
        {
            $('#check_right_input_change').val("false");
                      
        }
    });
});

//$(function(){
//    $("#Group").find('input').live('change', function(){
////        $('#check_right_input_change').val("true");
//        $('#group_input_change_or_not').val("true");
//    });
//
//    $('#Group input[type="submit"]').live('click', function(){
//        $('#group_input_change_or_not').val("false");
//
//    });
//
//});

/*organisation close option*/
//$(function(){
//    $('.organisation_close_option').live('click',function(){
//        var link = $(this);
//
//        if( $('#contact_input_change_or_not').val() == "false")
//        {
//            $('#'+link.attr('toggle_id_name')).toggle('blind');
//            $("#" + link.attr('field')+'_mode').attr('mode','show');
//            link.css("display","none");
//            $('.new_option[field='+ link.attr('field') +']').css("display","");
//
//
//        }
//        else{
//            $('#warning_message_text').html("Data Not Saved. Are You Sure You Wish to EXIT?  ");
//            $('#warning_message_image').css("display","");
//            $('#warning_message').dialog({
//                modal: true,
//                resizable: false,
//                draggable: true,
//                height: 'auto',
//                width: 'auto',
//                buttons: {
//
//                    No: function(){
//                        $(this).dialog('destroy');
//                        return false;
//
//                    },
//                    Yes: function(){
//                        $('#'+link.attr('toggle_id_name')).toggle('blind');
//                        $("#" + link.attr('field')+'_mode').attr('mode','show');
//                        link.css("display","none");
//                        $('.new_option[field='+ link.attr('field') +']').css("display","");
//                        $('.organisation_contact_toggle_button').css("display","");
//                        $(this).dialog('destroy');
//                        return true;
//                    }
//                }
//            });
//            $('#warning_message').dialog('option', 'title', 'Warning');
//
//            $('#warning_message').parent().find("a").css("display","none");
//            $("#warning_message").parent().css('background-color','#D1DDE6');
//            $("#warning_message").css('background-color','#D1DDE6');
//
//            $('#warning_message').dialog('open');
//        }
//
//    });
//});

/*find clear form*/

$(function(){
    $("#new_email").find('input').live('change', function(){
        //        $('#check_right_input_change').val("true");
        $('#find_email_input_change_or_not').val("true");
    });

    $('#new_email input[type="submit"]').live('click', function(){
        $('#find_email_input_change_or_not').val("false");

    });

});

$(function(){
    $("#new_phone").find('input').live('change', function(){
        //        $('#check_right_input_change').val("true");
        $('#find_phone_input_change_or_not').val("true");
    });

    $('#new_phone input[type="submit"]').live('click', function(){
        $('#find_phone_input_change_or_not').val("false");

    });

});

$(function(){
    $("#new_address").find('input').live('change', function(){
        //        $('#check_right_input_change').val("true");
        $('#find_address_input_change_or_not').val("true");
    });

    $('#new_address input[type="submit"]').live('click', function(){
        $('#find_address_input_change_or_not').val("false");

    });

});

/*Person check duplication active status*/
$(function(){
    $("#switch_personal_formula_status").live('change', function(){
        
        $.ajax({
            type: "GET",
            url: "/personal_duplication_formulas/change_status.js",
            data: 'check_status='+$(this).val(),
            dataType: "script"
        });

    });
});






//add_new_role in Role Manager for control role_type dropdown list
$(function(){
    $("#new_role_bar #add_new_role").live('click',function(){
        $('#role_role_type_id').attr("disabled", true);
    });
    $("#new_role_bar #close_role").live('click', function(){
        $('#role_role_type_id').attr("disabled", false);
    });
});

/* Show Person Age*/



$(function(){
    $("#person_birth_date").live('change', function(){

        if($("#person_birth_date").val()!= "")
        {
            var current_year = new Date();
            $('#person_age').html(parseInt(current_year.getFullYear())-parseInt($(this).val().substring(6,10))).change();
        }
        else
        {

            $('#person_age').html('').change();
        }
    }
    );

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


$(function($) {
    $('.jclock').jclock();
    $('#clocktime').val($('.jclock').html());
});


/*arrow block */
$(function(){
    $('.person_arrow_block').click(function(){
        $.ajax({
            type: "GET",
            url: $(this).attr('url')+".js",
            data: 'active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.person_edit_tab.active').attr('field'),
            dataType: "script"
        });
    });
});

$(function(){
    $('.organisation_arrow_block').click(function(){

        $.ajax({
            type: "GET",
            url: $(this).attr('url')+".js",
            data: 'active_tab='+$('.container_icon_color').find('a').attr('show_id_name')+'&active_sub_tab='+$('.organisation_edit_tab.active').attr('field'),
            dataType: "script"
        });
    });
});





/* Ajax call system */
$(function(){
    $(".ajax_call").live("click", function(){
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("url")+".js",
            data: 'param1='+$(this).attr("param1")+'&param2='+$(this).attr("param2")+'&param3='+$(this).attr("param3"),
            dataType: "script"
        });
    });
});

/*CSS tab switch system*/
$(".tab_switch_button").live('click', function(){
    $('.active').removeClass("active");
    $(this).addClass("active");
    $(this).parent().addClass("active");
    $('.tab_switch_right[field='+ $(this).attr('field') +']').addClass("active");
    $('.tab_switch_left[field='+ $(this).attr('field') +']').addClass("active");
    $('#'+$(this).attr('field')).addClass("active");
});



//Country Data
$(function(){
    $(".show_languages").live('click', function(){
        if($('.update_flag[filed="'+$(this).attr('field')+'"]').val()=="true"){
            $.ajax({
                type: "GET",
                url: "/languages/show_languages.js",
                data: 'update='+$(this).attr('update'),
                dataType: "script"
            });
            $('.update_flag[filed="'+$(this).attr('field')+'"]').val("false");
        }else{
            $('.update_flag[filed="'+$(this).attr('field')+'"]').val("true");
        }
    });
});


/*matain---geo_area*/
$(function(){
    $(".select_ajax_call").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: $(this).attr("method"),
                url: $(this).attr("url")+".js",
                data: 'param1='+$(this).val()+'&type='+$(this).attr('type_class'),
                dataType: "script"
            });
        }else{

            $('#add_new_'+ $(this).attr('field')).html('');
            $('#existing_'+ $(this).attr('field')).html('');
            $('#edit_'+ $(this).attr('field')+'_form').html('');
        }
    });
});

/* Country Grid*/
$(function(){
    $("#show_countries_grid").flexigrid({
        url: '/grids/show_countries_grid',
        dataType: 'json',
        colModel : [
        {
            display: 'ID',
            name : 'id',
            width : 40,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Long Name',
            name : 'long_name',
            width : 100,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Short Name',
            name : 'short_name',
            width : 80,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Citizenship',
            name : 'citizenship',
            width : 100,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Capital',
            name : 'capital',
            width : 100,
            sortable : true,
            align: 'left'
        },

        {
            display: 'ISO Code',
            name : 'iso_code',
            width : 60,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Dialup Code',
            name : 'dialup_code',
            width : 60,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Main Language',
            name : 'govenment_language',
            width : 100,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Currency',
            name : 'currency',
            width : 60,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Currency Subunit',
            name : 'currency_subunit',
            width : 60,
            sortable : true,
            align: 'left'
        }
        ],
        searchitems : [
        {
            display: 'Long Name',
            name : 'long_name'
        },

        {
            display: 'Short Name',
            name : 'short_name'
        },

        {
            display: 'Citizenship',
            name : 'citizenship'
        },

        {
            display: 'Capital',
            name : 'capital'
        },

        {
            display: 'ISO Code',
            name : 'iso_code'
        },

        {
            display: 'Dialup Code',
            name : 'dialup_code'
        },

        {
            display: 'Main Language',
            name : 'govenment_language'
        },

        {
            display: 'Currency',
            name : 'currency'
        },

        {
            display: 'Currency Subunit',
            name : 'currency_subunit'
        }
        ],
        sortname: "id",
        sortorder: "asc",
        usepager: true,
        title: 'Countries',
        useRp: true,
        rp: 20,
        showTableToggleBtn: false,
        width: 'auto',
        height: 'auto'
    });

    $('table#show_countries_grid tbody tr').live('click',function(){
        if($('#country_mode').attr('mode')=="show"){
            $('table#show_countries_grid tbody tr.trSelected').removeClass('trSelected');
             $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_countries_grid tbody tr').live('dblclick',function(){
        if($('#country_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/countries/"+$(this).attr('id').substring(3)+"/edit.js",
                dataType: "script"
            });
        }
    });

    $('table#show_countries_grid tbody tr').live('mouseover',function(){
        if($('#country_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });
});


/* Language Grid*/
$(function(){
    $("#show_languages_grid").flexigrid({
        url: '/grids/show_languages_grid',
        dataType: 'json',
        colModel : [
        {
            display: 'ID',
            name : 'id',
            width : 40,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Name',
            name : 'name',
            width : 100,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Description',
            name : 'description',
            width : 200,
            sortable : true,
            align: 'left'
        }
        ],
        searchitems : [
        {
            display: 'Name',
            name : 'name'
        },

        {
            display: 'Description',
            name : 'description'
        }
        ],
        sortname: "id",
        sortorder: "asc",
        usepager: true,
        title: 'Languages',
        useRp: true,
        rp: 20,
        showTableToggleBtn: false,
        width: 'auto',
        height: 'auto'
    });

    $('table#show_languages_grid tbody tr').live('click',function(){
        if($('#language_mode').attr('mode')=="show"){
            $('table#show_languages_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }        
    });

    $('table#show_languages_grid tbody tr').live('dblclick',function(){
        if($('#language_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/languages/"+$(this).attr('id').substring(3)+"/edit.js",
                dataType: "script"
            });
        }
    });

    $('table#show_languages_grid tbody tr').live('mouseover',function(){
        if($('#language_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });
});

/*GeographicalArea_grid*/

$('table#show_geographicalarea_grid tbody tr').live('click',function(){
    if( $('#geo_area_mode').attr('mode') == "show"){
        $('table#show_geographicalarea_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
    }else{ 
        $(this).removeClass('trSelected');
    }
});

$('table#show_geographicalarea_grid tbody tr').live('dblclick',function(){
    if( $('#geo_area_mode').attr('mode') == "show"){
        $.ajax({
            type: 'GET',
            url: "/post_areas/"+$(this).attr('id').substring(3)+"/edit.js",
            data: '&type=GeographicalArea',
            dataType: "script"
        });
    }else{}
});

$('table#show_geographicalarea_grid tbody tr').live('mouseover',function(){
    if( $('#geo_area_mode').attr('mode') == "show"){
        $(this).css('cursor',"pointer");
    }else{
        $(this).css('cursor',"");
    }
});

/* Religion Grid*/
$(function(){
    $("#show_religions_grid").flexigrid({
        url: '/grids/show_religions_grid',
        dataType: 'json',
        colModel : [
        {
            display: 'ID',
            name : 'id',
            width : 40,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Name',
            name : 'name',
            width : 100,
            sortable : true,
            align: 'left'
        },

        {
            display: 'Description',
            name : 'description',
            width : 200,
            sortable : true,
            align: 'left'
        }
        ],
        searchitems : [
        {
            display: 'Name',
            name : 'name'
        },

        {
            display: 'Description',
            name : 'description'
        }
        ],
        sortname: "id",
        sortorder: "asc",
        usepager: true,
        title: 'Religions',
        useRp: true,
        rp: 20,
        showTableToggleBtn: false,
        width: 'auto',
        height: 'auto'
    });

    $('table#show_religions_grid tbody tr').live('click',function(){
        if($('#religion_mode').attr('mode')=="show"){
            $('table#show_religions_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_religions_grid tbody tr').live('dblclick',function(){
        if($('#religion_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/religions/"+$(this).attr('id').substring(3)+"/edit.js",
                dataType: "script"
            });
        }
    });

    $('table#show_religions_grid tbody tr').live('mouseover',function(){
        if($('#religion_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });

});

/*ElectoralArea_grid*/

$('table#show_electoral_area_grid tbody tr').live('click',function(){
    if( $('#electoral_area_mode').attr('mode') == "show"){
        $('table#show_electoral_area_grid tbody tr.trSelected').removeClass('trSelected');
        $(this).addClass('trSelected');
    }else{ 
        $(this).removeClass('trSelected');
    }
});

$('table#show_electoral_area_grid tbody tr').live('dblclick',function(){
    if( $('#electoral_area_mode').attr('mode') == "show"){
        $.ajax({
            type: 'GET',
            url: "/post_areas/"+$(this).attr('id').substring(3)+"/edit.js",
            data: '&type=ElectoralArea',
            dataType: "script"
        });
    }else{}
});

$('table#show_electoral_area_grid tbody tr').live('mouseover',function(){
    if( $('#electoral_area_mode').attr('mode') == "show"){
        $(this).css('cursor',"pointer");
    }else{
        $(this).css('cursor',"");
    }
});


/*select change*/

$(function(){
    $(".select_renew_tab").live('mousedown', function(){
        $.ajax({
            type: "GET",
            url:"/countries/select_renew.js",
            data: 'param1='+ $(this).attr('param1'),
            dataType: "script"
        });
    });
});

/*bank setting*/
$(function(){
    $('#open_add_new_bank').click(function(){
        $('#add_new_bank').show();
        $('#open_add_new_bank').hide();
        $('#close_add_new_bank').show();
    });
});

$(function(){
    $('#close_add_new_bank').click(function(){
        $('#add_new_bank').hide();
        $('#open_add_new_bank').show();
        $('#close_add_new_bank').hide();
    });
});

$(function(){
    $('#delete_bank_entry').live('click', function(){

        var link = $(this);
        $('#warning_message_text').html("Are You Sure You Wish to Delete This Bank?");
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
                        url: "/banks/delete_bank_entry",
                        data: 'id=' + link.attr('bank_id'),
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

    });
});

$(function(){
    $('#edit_bank_entry').live('click', function(){
       $.ajax({
            type: "GET",
            url: "/banks/edit_bank_entry",
            data: 'id=' + $(this).attr('bank_id'),
            dataType: "script"
        });
    });
});

$(function(){
    $('#edit_bank_entry_close_form').live('click', function(){
        $('#edit_bank_entry_form').hide();
    });
});


/* Show postcode by country Grid*/
$(function(){
    $('table#show_postcodes_by_country_grid tbody tr').live('click',function(){
        if($('#postcode_mode').attr('mode')=="show"){
            $('table#show_postcodes_by_country_grid tbody tr.trSelected').removeClass('trSelected');
            $(this).addClass('trSelected');
        }else{
            $(this).removeClass('trSelected');
        }
    });

    $('table#show_postcodes_by_country_grid tbody tr').live('dblclick',function(){
        if($('#postcode_mode').attr('mode')=="show"){
            $.ajax({
                type: 'GET',
                url: "/postcodes/"+$(this).attr('id').substring(3)+"/edit.js",
                dataType: "script"
            });
        }
    });

    $('table#show_postcodes_by_country_grid tbody tr').live('mouseover',function(){
        if($('#postcode_mode').attr('mode')=="show"){
            $(this).css('cursor',"pointer");
        }else{
            $(this).css('cursor',"");
        }
    });
});

