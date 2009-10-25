// JavaScript Document
$(document).ready(function() {
						   $("#module_menu_top").click(function() {								
								if($("div#module_menu_items").is(":hidden")) 
									$("div#module_menu_top").addClass("hover"),
									$("div#module_menu_items").fadeIn("fast");
								else $("div#module_menu_top").removeClass("hover"),
									$("div#module_menu_items").fadeOut("fast");
								});
						   		$("div#module_menu").hover( function() {}, function() {$("div#module_menu_items").fadeOut("fast"),$("div#module_menu_top").removeClass("hover","fast");});
								$("div#module_menu_items li").hover( 
																	function(){$(this).addClass("hover","fast"); return false;},
																	function(){$(this).removeClass("hover", "normal");return false;}
																	);
						   });