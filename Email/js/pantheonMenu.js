/*
Pantheon Menu
Dev: Tarek Jubaer
*/
jQuery.fn.pantheonMenu = function(options) 
{
	// Settings for the menu
	settings = jQuery.extend(
	{		
		menuItems: [
						{
							menuName : "Help",
							menuLink : "Help Link 1",
							level2MenuItems :
							[
								{
									level2MenuItemName : "Help 1", 
									level2MenuItemLink : "Link 1",
									level3MenuItems :
									[
										{
											level3MenuItemName : "Help 11", 
											level3MenuItemLink : "Link 11"											
										},
										{
											level3MenuItemName : "Help 12", 
											level3MenuItemLink : "Link 12"											
										}
									]
								},
								{level2MenuItemName : "Help 2", level2MenuItemLink : "Link 2"}
							]
						}
					]
	}, options);

	//Draw drop down menus
	var mainMenuCode = '';
	if(settings.menuItems.length && settings.menuItems.length > 0)
	{		
		for(var j = 0; j < settings.menuItems.length; j++)
		{
			//Draw main menu items
			if(settings.menuItems[j].menuLink)
				mainMenuCode = mainMenuCode + '<li id="li_'+j+'"><a href="'+ jQuery.trim(settings.menuItems[j].menuLink) +'">'+ jQuery.trim(settings.menuItems[j].menuName) +'</a>';
			else
				mainMenuCode = mainMenuCode + '<li>'+ jQuery.trim(settings.menuItems[j].menuName) +'';

			//Draw level 2 menu items
			if(settings.menuItems[j].level2MenuItems && settings.menuItems[j].level2MenuItems.length > 0)
			{
				mainMenuCode = mainMenuCode + '<ul class="pantheonMenu_subnav" id="pantheonMenu_level2MenuItem_'+ j +'">';
				for(var k = 0; k < settings.menuItems[j].level2MenuItems.length; k++)
				{					
					mainMenuCode = mainMenuCode + '<li>';
					
					if(settings.menuItems[j].level2MenuItems[k].level2MenuItemLink)
						mainMenuCode = mainMenuCode + '<a href="'+ jQuery.trim(settings.menuItems[j].level2MenuItems[k].level2MenuItemLink) +'">'+ jQuery.trim(settings.menuItems[j].level2MenuItems[k].level2MenuItemName) +'</a>';
					else
						mainMenuCode = mainMenuCode + jQuery.trim(settings.menuItems[j].level2MenuItems[k].level2MenuItemName);
					//Draw level 3 menu items
					if(settings.menuItems[j].level2MenuItems[k].level3MenuItems && settings.menuItems[j].level2MenuItems[k].level3MenuItems.length > 0)
					{
						mainMenuCode = mainMenuCode + '<ul class="pantheonMenu_subSubnav" id="pantheonMenu_level3MenuItem_'+ k +'">';
						for(var h = 0; h < settings.menuItems[j].level2MenuItems[k].level3MenuItems.length; h++)
						{					
							mainMenuCode = mainMenuCode + '<li>';
							
							if(settings.menuItems[j].level2MenuItems[k].level3MenuItems[h].level3MenuItemLink)
								mainMenuCode = mainMenuCode + '<a href="'+ jQuery.trim(settings.menuItems[j].level2MenuItems[k].level3MenuItems[h].level3MenuItemLink) +'">'+ jQuery.trim(settings.menuItems[j].level2MenuItems[k].level3MenuItems[h].level3MenuItemName) +'</a>';
							else
								mainMenuCode = mainMenuCode + jQuery.trim(settings.menuItems[j].level2MenuItems[k].level3MenuItems[h].level3MenuItemName);
								
							mainMenuCode = mainMenuCode + '</li>';
						}
						mainMenuCode = mainMenuCode + '</ul>';
					}
					//close level 2 LI
					mainMenuCode = mainMenuCode + '</li>';
				}
				mainMenuCode = mainMenuCode + '</ul><span></span>';
			}
			//Close main menu LI
			mainMenuCode = mainMenuCode + '</li>';
		}
	}			
	//Construct menu
	$(this).append('<ul class="pantheonMenu_topnav">\
						'+ mainMenuCode +'\
					</ul>');
	//Last item break fix for IE 7 (bogus browser :(()
	if($.browser.msie && $.browser.version == 7)
	{
		$("ul.pantheonMenu_topnav").children("li:last").each(function()
		{
			var IE7WidthFix = parseInt($(this).width())+2;
			$(this).css({'width' : IE7WidthFix+'px'});
		});
	}
	//set fixed width based on the contents so that menu dont break.
	$("ul.pantheonMenu_topnav").css({'width' : $("ul.pantheonMenu_topnav").width()+'px'});
	//alert($("#li_11").width());
	
	$("ul.pantheonMenu_topnav li span").bind("mouseover", function() { //When trigger is clicked...		
		//Following events are applied to the subnav itself (moving subnav up and down)
		$(this).parent().find("ul.pantheonMenu_subnav").slideDown('fast').show(); //Drop down the subnav on click

		$(this).parent().hover(function() {
		}, function(){	
			$(this).parent().find("ul.pantheonMenu_subnav").slideUp('slow'); //When the mouse hovers out of the subnav, move it back up
		});

		//Following events are applied to the trigger (Hover events for the trigger)
		}).hover(function() { 
			$(this).addClass("pantheonMenu_subhover"); //On hover over, add class "subhover"
		}, function(){	//On Hover Out
			$(this).removeClass("pantheonMenu_subhover"); //On hover out, remove class "subhover"
	});
	
	$("ul.pantheonMenu_subSubnav").parent().bind("mouseover", function(e) { //When trigger is clicked...
		//switch sub menu postion to left from right based on window size
		var winSize = getClientSize();
		//alert(e.pageX)
		var sizeToCheck = parseInt(e.pageX) + parseInt($(this).width()) + parseInt($(this).width());
		//alert(sizeToCheck + " | " + winSize.w + " | " + e.pageX + " | " + $(this).width());
		if(sizeToCheck > winSize.w)
			$(this).find("ul.pantheonMenu_subSubnav").css({'margin-left' : '-170px'});
		//Following events are applied to the subnav itself (moving subnav up and down)
		$(this).find("ul.pantheonMenu_subSubnav").slideDown('fast').show(); //Drop down the subnav on click
		$(this).children("a").css({'background-image' : 'url(images/pantheonMenu/dropdown_linkbgHvr.gif)'});
		$(this).hover(function() {
		}, function(){	
			$(this).children("a").css({'background-image' : 'url(images/pantheonMenu/dropdown_linkbg.gif)'});
			$(this).find("ul.pantheonMenu_subSubnav").slideUp('slow'); //When the mouse hovers out of the subnav, move it back up
		});		
	});
	//Get client size
	function getClientSize()
	{
		var x=0,y=0,w=0,h=0,doc=document,win=window;
		var cond = (!doc.compatMode || doc.compatMode == 'CSS1Compat') && !win.opera && doc.documentElement;
	
		if(cond && doc.documentElement.clientHeight) 
			h=doc.documentElement.clientHeight;
		else if(doc.body && doc.body.clientHeight) 
			h=doc.body.clientHeight;
		else if(getClientDef(win.innerWidth,win.innerHeight,doc.width)) 
		{
			h=win.innerHeight;
			if(doc.width>win.innerWidth) 
				h-=16;
		};
	
		if(cond && doc.documentElement.clientWidth) 
			w=doc.documentElement.clientWidth;
		else if(doc.body && doc.body.clientWidth) 
			w=doc.body.clientWidth;
		else if(xDef(win.innerWidth,win.innerHeight,doc.height)) 
		{
			w=win.innerWidth;
			if(doc.height>win.innerHeight) w-=16;
		}
	
		if(win.document.documentElement && win.document.documentElement.scrollLeft) 
			x=win.document.documentElement.scrollLeft;
		else if(win.document.body && getClientDef(win.document.body.scrollLeft)) 
			x=win.document.body.scrollLeft;
	
		if(win.document.documentElement && win.document.documentElement.scrollTop) 
			y=win.document.documentElement.scrollTop;
		else if(win.document.body && getClientDef(win.document.body.scrollTop)) 
			y=win.document.body.scrollTop;
		
		return {x:x,y:y,w:w,h:h};		
	}
	function getClientDef()
	{
		for(var i=0; i<arguments.length; ++i){if(typeof(arguments[i])=='undefined') return false;}
		return true;
	}
}