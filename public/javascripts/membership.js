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
