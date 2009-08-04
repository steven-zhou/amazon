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
$('.datepick').live("mouseover", function(){
    $(this).datepicker({
        dateFormat: 'dd-mm-yy',
        altFormat: 'mm-dd-yy',
        changeMonth: true,
        changeYear: true,
        yearRange: '1930:2009'
    });
});

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

/* Employment Tab*/
$(function(){
    $(".find_organisation_field").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url: "/organisations/name_finder.js",
                data: 'organisation_id='+$(this).val()+'&employment_id='+$(this).attr('employment_id'),
                dataType: "script"
            });
        }else{
            $(".organisation_name_container#"+$(this).attr('employment_id')).val("");
        }
    });
});

$(function(){
    $(".find_person_field").live('change', function(){
        if($(this).val() != ""){
            $.ajax({
                type: "GET",
                url: "/people/name_finder.js",
                data: 'person_id='+$(this).val()+'&update='+$(this).attr('update')+'&employment_id='+$(this).attr('employment_id'),
                dataType: "script"
            });
        }else{
            $("#"+$(this).attr('update')+"_"+$(this).attr('employment_id')).val("");
        }
    });
});

$(function(){
    $(".calculate_field").live('change', function(){
        _salary = $("#hour_"+$(this).attr("employment_id")).val() * $("#rate_"+$(this).attr("employment_id")).val() * 52;
        $("#salary_"+$(this).attr("employment_id")).val(formatCurrency(_salary));
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
