// All ajax requests will trigger the wants.js block
// of +respond_to do |wants|+ declarations

$(function(){
    $("#tabs").tabs();
});

$(function(){
    $("#tabs2").tabs();
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

    $('a.delete').live('click', function() {
        var link = $(this);
        $.post($(this).attr('href'), "_method=delete", null, 'script');
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
}

$(document).ready(function() {
    $(".ajax_form").submitWithAjax();

    // AJAX search form *Not Used*
    /*
    $(".ajax_search_form").submitWithAjax( function(){
      $('#search_results').dataTable({ 
        "bLengthChange":false, 
        "iDisplayLength":20,
        "bAutoWidth":false,
        "aoColumns":[{'sWidth':"20%"},{'sWidth':"30%"},{'sWidth':"50%"}]
      })
    });*/
    
    $('#search_results').dataTable({
        "bLengthChange":false,
        "iDisplayLength":20,
        "bAutoWidth":false,
        "sDom":'lfrtpi',
        "aoColumns":[{
                'sWidth':"12%"
            },{
                'sWidth':"15%"
            },{
                'sWidth':"30%"
            },{
                "sWdith":"15%"
            },{
                'sWidth':"25%"
            }]
    })
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
    $(this).datepicker({
        dateFormat: 'dd-mm-yy',
        altFormat: 'mm-dd-yy',
        changeMonth: true,
        changeYear: true
    });
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

/* Disable form*/

$(document).ready(function() {
    toggleFormStatus();
});

toggleFormStatus = function(){
    if ($('#system_id_tag').val() == '') {
        $('#left :input').attr('disabled', true);
        $('#system_id_tag').attr('disabled', false);
    }
}

/* Photo */
//$("#edit_photo").live("submit",function(){
//    $(this).ajaxSubmit({
//        iframe:true,
//        dataType:"script"
//    })
//    return false;
//});

$("#edit_photo_link").live("click",function() {
    $("#edit_photo").toggle('blind');
    return false;
});

/*Keywords*/
showKeyword = function(){
    $("#add_keywords option:selected").removeAttr("selected");
    $("#add_keywords").find("option").hide();
    $("#keyword_types").find("option:selected").each(function(){
        if($(this).val() == ""){
            $("#add_keywords").find("option").show();
        }else{
            $("#add_keywords option[class=" + $(this).text() + "]").show();
        }
    });
}

showTooltip = function(){
    $("#add_keywords option ,#remove_keywords option").each(function(){
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

$(document).ready(function(){
    showKeyword();
    showTooltip();
});

$("#keyword_types").live("change", showKeyword);

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
            alert("This field has be a number!");
            $(this).focus();
            $(this).val(0);
            $("#salary_"+$(this).attr("employment_id")).val(formatCurrency(0));
        }
    });
});





/* FLASH */
$.fn.wait = function(time, type) {
    time = time || 1000;
    type = type || "fx";
    return this.queue(type, function() {
        var self = this;
        setTimeout(function() {
            $(self).dequeue();
        }, time);
    });
};


$(function(){
    $('#flash').wait(5000).slideUp();
    $('#flash').click(function(){
        $('#flash').hide();
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

//Admin - System Data Tab

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
        }else{

            $("#downside").html("");
            $("#role_type_description_label").html('')


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
    $(".find_master_doc_meta_type_field_for_role_condition").live('change', function(){
        $.ajax({
            type: "GET",
            url: "/roles/master_doc_meta_type_finder1.js",
            data: 'master_doc_meta_meta_type_id='+$(this).val()+'&id='+$(this).val(),
            dataType: "script"
        });

    });
});


$(function(){
    $(".find_master_doc_meta_type_field_for_role_condition").live('change', function(){
        $.ajax({
            type: "GET",
            url:
                "/roles/meta_name_finder.js",
            data:
                'id='+$(this).val(),
            dataType: "script"
        });
    });
});

$(function(){
    $("#master_doc_meta_type_id_for_role_condition").live('change', function(){
        $.ajax({
            type: "GET",
            url: "/roles/meta_type_name_finder.js",
            data:'id='+$(this).val(),
            dataType: "script"
        });
    });
});

$(function(){

    $("#master_doc_meta_type_id_for_role_condition").live('change', function(){
        $.ajax({
            type: "GET",
            url:
                "/roles/doc_type_finder.js",
            data:
                'master_doc_meta_type_id='+$(this).val(),
            dataType: "script"
        });
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
            if($(this).val() != "4"){
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
    $(".check_login_id").live('change', function(){
        if($(this).val()!= ""){
            $.ajax({
                type: "GET",
                url: "/people/login_id_finder.js",
                data: 'person_id='+$(this).val()+'&login_account_id='+$(this).attr('login_account_id'),
                dataType:"script"
            });
        }else{
            $("#login_name_container_"+$(this).attr('login_account_id')).html("");
        }
    });
});

$(function(){
    $(".check_username_unique").live('change', function(){
        if($(this).val()!= ""){
            $.ajax({
                type: "GET",
                url: "/login_accounts/user_name_unique.js",
                data: 'user_name='+$(this).val()+'&login_account_id='+$(this).attr('login_account_id'),
                dataType:"script"
            });
        }else{
            $("#login_name_container_"+$(this).attr('login_account_id')).html("");
        }
    });
});





$(function(){
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
    $('#login_account_user_name').live("mouseover", function(){

        $(this).qtip(
        {
            content: 'username must between 6~20<br>username can\'t the same as password',
            style: 'dark'
        }
    );
    });

});



$(function() {
    $(".password").jpassword(

    {
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
        }
    },
    {
        length: 6
    }
);
});




$(function(){
    $("#add_user_bar").live('click', function(){
        $(".user_clear_form").click();
    });

});


$(function(){
    $("#login_account_password_confirmation").live('change', function(){
        if ($(this).val()!= $('#login_account_password').val()){

            $('#password_confirm').dialog( {
                modal: true,
                resizable: true,
                draggable: true
            });
            $('#password_confirm').dialog('open');

        }
    });
});

$(function(){
    $("#login_account_user_name").live('change', function(){
     
        if ($(this).val().length < 6 ||$(this).val().length > 30 ){
      
            $('#user_length').dialog( {
                modal: true,
                resizable: true,
                draggable: true
            });
            $('#user_length').dialog('open');
        }
      
    });
});


$(function(){
    $("#login_account_password").live('change', function(){

        if ($(this).val().length < 6 ||$(this).val().length > 30 ){

            $('#password_length').dialog( {
                modal: true,
                resizable: true,
                draggable: true
            });
            $('#password_length').dialog('open');
        }

    });
});


$(function(){
    $(".show_users").live('click', function(){
        $.ajax({
            type: "GET",
            url: "/login_accounts/" + $(this).attr('id') + "/edit.js",
            data:'id='+$(this).attr('id'),
            dataType: "script"
        });
    });
});


$(function(){
    $(".user_clear_edit_form").live('click', function(){
        $('#'+$(this).parents("form").get(0).id)[0].reset();
      
        $('#user_name_container_' + $(this).attr('login_account_id')).html('');
      
        
    })

});


/* Admin List Management - Query*/

$(function(){
$(".show_fields").live('change', function(){
    if($(this).val()){
        $.ajax({
            type: "GET",
            url: "/tag_types/show_fields.js",
            data:'table_name=' + $(this).val() + '&update_field=' + $(this).attr("update_field"),
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
$(".show_new_query").live('click', function(){
    $.ajax({
        type: "GET",
        url: "/query_headers/new.js",
        dataType: "script"
    });
});
});

$(function(){
$("#save_button").live('click', function(){
    $('#save_form').toggle('blind');
    $('#save_form').dialog( {
        modal: true,
        resizable: true,
        draggable: true
    });
    $('#save_form').dialog('open');
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