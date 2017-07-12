<%@ Control Language="C#" AutoEventWireup="true" Codebehind="Menu.ascx.cs" Inherits="EmailModule.Email.UserControl.Menu" %>
<link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" language="javascript" src="../../Email/js/jquery-1.4.1.min.js"></script>

<script type="text/javascript" language="javascript" src="../../Email/js/pantheonMenu.js"></script>

<script type="text/javascript">

$(document).ready(function() {

        $('#mainContainer').pantheonMenu({
				menuItems: [
								{
									menuName : "Templates",
									menuLink : "../Email/EmailTemplates.aspx",
									level2MenuItems :
									[
										{
											level2MenuItemName : "Create Template", 
											level2MenuItemLink : "../Email/CreateTemplate.aspx"
											
										},
										{
											level2MenuItemName : "Upload Certificate", 
											level2MenuItemLink : "../Email/UploadGiftCerts.aspx"
											
										}
									]
								},
								{
									menuName : "Schedule Email",
									menuLink : "../Email/EmailUsers.aspx",
									level2MenuItems :
									[
										{
											level2MenuItemName : "Email Schedule Report", 
											level2MenuItemLink : "../Email/EmailSendReport.aspx"											
										},
										{
											level2MenuItemName : "Email Schedule Search", 
											level2MenuItemLink : "../Email/EmailSendSearch.aspx"											
										}
									]
								},
								{
									menuName : "TAF",
									menuLink : "../TAF.aspx",
									level2MenuItems :
									[
										{
											level2MenuItemName : "TAF Admin", 
											level2MenuItemLink : "../TAF/TAFadmin.aspx"											
										},
										{
											level2MenuItemName : "Assign Certificates", 
											level2MenuItemLink : "../TAF/TAFCertificate.aspx"											
										}
									]
								},
								{
									menuName : "Bounce Report",
									menuLink : "../Email/BounceReport.aspx"									
								},
								{
									menuName : "Task List",
									menuLink : "../Projects/Tasks.aspx"									
								},
								{
									menuName : "Auto Notifyer",
									menuLink : "#",
									level2MenuItems :
									[
										{
											level2MenuItemName : "TAF Auto Notifyer", 
											level2MenuItemLink : "../Email/TAFAutoNotifyer.aspx"											
										},
										{
											level2MenuItemName : "Reg Auto Notifyer", 
											level2MenuItemLink : "../Email/RegAutoNotifyer.aspx"											
										}
									]
								},
								{
									menuName : "Logout",
									menuLink : "../Logout.aspx"									
								}
							]
			});

});
</script>

<div id="mainContainer">
</div>
<div class="clear">
</div>
