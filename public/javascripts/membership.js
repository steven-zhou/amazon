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
        $.ajax({
            type: "GET",
            url: "/membership/membership_intiator_lookup/",
            data: 'id=' + $(this).val()+"&update_field="+$(this).attr("update_field"),
            dataType: "script"
        });
    });
});

