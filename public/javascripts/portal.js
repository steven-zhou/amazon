
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


$(function(){
    compulsory_check = function(link){
        var current_form = $('#'+link.closest('form').get(0).id);
        var compulsory_fields = current_form.find('.compulsory_field');
        var length = compulsory_fields.length;
        var disable = true;
        for(i=0; i<length; i++){
            if ($('#'+compulsory_fields[i].id).val()==''){
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
        compulsory_check($(this));
    });

    $(".compulsory_field").live('change', function(){
        compulsory_check($(this));

    });
});

$(function() {
    $('#regenerate_captcha').live('click', function(){
        $.ajax({
            type: "GET",
            url: "/signin/captcha",
            data: '',
            dataType: "script"
        });
        return false;
    });

    $('#potential_member_first_name').blur(function(){
       $('#captcha').addClass('compulsory_field');
    });

    $('#captcha').click(function(){
        $(this).addClass('compulsory_field');
    })
});