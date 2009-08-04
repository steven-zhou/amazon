$(function() {
	
    /*
	  Objects withe class toggle_button will 
	  toggle the DOM object associated with it
	  via an attribute toggle_id_name
	*/
    $(".toggle_button").click(function(){
        $('#'+$(this).attr('toggle_id_name')).toggle('blind');
    });

    $(".toggle_button1").click(function(){
        $('#'+$(this).attr('toggle_id_name1')).show();
        $('#'+$(this).attr('toggle_id_name2')).hide();
        
    });

	
    /*
	  Replaces text of the toggle link, with the alt_text,
	  and toggles an object with the class assigned to
	  toggle_more_id
	*/
	
    $(".toggle_more").click(function(){
        var $alt_text = $(this).attr('alt_text')
        $(this).attr({
            alt_text: $(this).html()
            })
        $(this).html($alt_text)
        $('#'+$(this).attr('toggle_more_id')).toggle();
    })

    $("#select_contact_type").ready(function(){
        $('form.active').removeClass('active');
        $("form."+$('#select_contact_type option:selected').val()).addClass('active');
    });

    $("#select_contact_type").change(function(){
        $('form.active').removeClass('active');
        $("form."+$('#select_contact_type option:selected').val()).addClass('active');
    });



    $(".clear_form").click(function(){
        $('#'+$(this).parents("form").get(0).id)[0].reset();
    })

    $("#accordion").accordion();
    $("#accordion01").accordion();
    $("#accordion02").accordion();

    $("#delete_photo").click(function(){
       $("#photo").attr("src", "/images/no_photo.jpeg");
       $("#delete_photo").hide();
    });

});

