// JavaScript Document
$(document).ready(function() {
    $("#module_menu_top").click(function() {
        if($("div#module_menu_items").is(":hidden"))
            $("div#module_menu_items").slideDown("fast");
        else $("div#module_menu_items").slideUp("fast");
    });
    $("div#module_menu").hover( function() {}, function() {
        $("div#module_menu_items").slideUp("fast");
    });
    $("div#module_menu_items li").hover(
        function(){
            $(this).addClass("hover");
        },
        function(){
            $(this).removeClass("hover");
        }
        );
});