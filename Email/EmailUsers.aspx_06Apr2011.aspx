<%@ Page Language="C#" AutoEventWireup="true" Codebehind="EmailUsers.aspx.cs" Inherits="EmailModule.Email.EmailUsers"
    ValidateRequest="false" %>

<%@ Register Src="UserControl/HTMLEditor.ascx" TagName="HTMLEditor" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Schedule Email</title>
    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <link href="../Email/css/jquery-ui.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript" src="../Email/js/jquery-1.4.2.min.js"></script>

    <script type="text/javascript" language="javascript" src="../Email/js/jquery-ui.js"></script>

    <script type="text/javascript" language="javascript" src="../Email/js/jquery-ui-timepicker-addon-0.5.min.js"></script>

    <script type="text/javascript" language="javascript" src="../Email/js/pantheonMenu.js"></script>

    <link href="../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
    /* css for timepicker */
        #ui-timepicker-div dl{ text-align: left; }
        #ui-timepicker-div dl dt{ height: 25px; }
        #ui-timepicker-div dl dd{ margin: -25px 0 10px 65px; }
                
    </style>

    <script type="text/javascript">
		$(document).ready(function()
		{
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
		    $("button, input:submit, a", ".demo").button();
			$(".datepicker").datepicker({
				appendText: ' (mm-dd-yyyy)', //Show hint of date format
				buttonImage: 'images/calenderIcon.gif', //Display icon
				buttonImageOnly: true, //Enable icon click
				changeMonth: true, //Display month drop down
				changeYear: true, //Display year drop down
				maxDate: '+9Y +1M +10D', //Add maximum date restriction
				minDate: '-9Y -1M -10D', //Add minimum date restriction
				currentText: 'Today',
				dateFormat: 'mm-dd-yy', //Display date format
				duration: 'slow', //Setup the animation speed				
				showButtonPanel: true, 
				showOn: 'both', //Attach click to both input and button
				showOtherMonths: true, //Show other months date
				selectOtherMonths: true, //Allow to select date from other months
				yearRange: '2000:2020' //Setup the year range				
			});
			
			$(".timepicker").timepicker({
			    appendText: ' (hh:mm)',
	            showButtonPanel: true, 
				showOn: 'both', 
	            buttonImage: 'images/calenderIcon1.gif',
	            buttonImageOnly: true,
	            duration: 'slow',
	            timeFormat: 'hh:mm TT',
	            ampm: true
            });
            
            if($("input[@name='rdbScheduleBy']:checked").val()=="1")
            {
                $("#scheduleNowDiv").hide(); 
                $("#scheduleTokenDiv").hide(); 
                $("#scheduleTimeDiv").show();
            }
            else if($("input[@name='rdbScheduleBy']:checked").val()=="2")
            {
                $("#scheduleNowDiv").hide(); 
                $("#scheduleTimeDiv").hide();
                $("#scheduleTokenDiv").show();
            }
            else
            {
                $("#scheduleTokenDiv").hide();
                $("#scheduleTimeDiv").hide();
                $("#scheduleNowDiv").show();
            }
            
            $("#rdbScheduleBy_0").click(function(){                
                $("#scheduleTokenDiv").hide();
                $("#scheduleTimeDiv").hide();
                $("#scheduleNowDiv").show();
            });
            
            $("#rdbScheduleBy_1").click(function(){  
                $("#scheduleNowDiv").hide(); 
                $("#scheduleTokenDiv").hide(); 
                $("#scheduleTimeDiv").show();
            });            
            $("#rdbScheduleBy_2").click(function(){
                $("#scheduleNowDiv").hide(); 
                $("#scheduleTimeDiv").hide();
                $("#scheduleTokenDiv").show();
            });
            
			$(".bdayMonth").change(function(e){
			    if($(this).val()=="2" || $(this).val()=="4" || $(this).val()=="6" || $(this).val()=="9" || $(this).val()=="11")
			    {			        
			        $(this).prev().find("option[value='31']").remove();
			        if($(this).val()=="2")
			        {
			            $(this).prev().find("option[value='30']").remove();
			        }			            
			    }
			    if($(this).val()=="1" || $(this).val()=="3" || $(this).val()=="5" || $(this).val()=="7" || $(this).val()=="8" || $(this).val()=="10" || $(this).val()=="12")
			    {
			        if($(this).prev().find("option").size()<30)
			        {
			            $(this).prev().append($("<option></option>").val("30").html("30"));
			        }
			        if($(this).prev().find("option").size()<31)
			        {
			            $(this).prev().append($("<option></option>").val("31").html("31"));
			        }			            
			    }
			});
			            
		});
    </script>

</head>
<body>
    <div id="mainContainer">
    </div>
    <div class="clear">
    </div>
    <h2 style="text-align: center;">
        Schedule Email</h2>
    <form id="form1" runat="server">
        <div class="BodyContainer" style="width:1150px;">
            <h3 style="text-align: left; padding-left: 8px;">
                Select Users
            </h3>
            <div>
                <div>
                    <asp:Label ID="lblError" runat="server" Text="" CssClass="error"></asp:Label>
                    <asp:Label ID="lblMsg" runat="server" Text="" CssClass="msg"></asp:Label><br />
                    <asp:ValidationSummary ID="vsSearch" ValidationGroup="SearchValidator" runat="server"
                        ShowSummary="true" DisplayMode="List" />
                </div>
            </div>
            <div class="division">
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblFName" runat="server" Text="First Name"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtFName" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblLName" runat="server" Text="Last Name"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtLName" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="* Please Enter a valid Email"
                            SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ValidationGroup="SearchValidator" ControlToValidate="txtEmail" Display="None"></asp:RegularExpressionValidator>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblRegID" runat="server" Text="Registration ID"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtRegID" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revRegID" runat="server" ErrorMessage="* Please Enter a valid Registration ID"
                            SetFocusOnError="True" ValidationExpression="^\d+$" ValidationGroup="SearchValidator"
                            ControlToValidate="txtRegID" Display="None"></asp:RegularExpressionValidator>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblZip" runat="server" Text="Zip Code"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtZip" runat="server" Text="782,788,780,781"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblAcive" runat="server" Text="Active"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:DropDownList ID="ddlActive" runat="server">
                            <asp:ListItem Value="1" Text="Active Only" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="0" Text="Inactive Only"></asp:ListItem>
                            <asp:ListItem Value="" Text="Select All"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblCompany" runat="server" Text="Company ID"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:DropDownList ID="ddlCompany" runat="server">
                            <asp:ListItem Value="" Text="" Selected="True"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblAgeRange" runat="server" Text="Age Range"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtAgeRangeStart" runat="server" MaxLength="2" Text="00" Width="30" ></asp:TextBox>&nbsp; - &nbsp;
                        <asp:TextBox ID="txtAgeRangeEnd" runat="server" MaxLength="2" Text="99"  Width="30" ></asp:TextBox> Years
                    </div>
                    <div class="clear">
                    </div>
                </div>
                 <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblGender" runat="server" Text="Gender"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:DropDownList ID="ddlGender" runat="server">
                        <asp:ListItem Selected="True" Text="" Value="" ></asp:ListItem>
                        <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </div>
            <div class="division">
                <div>
                    <div class="columnFirst">
                        &nbsp;
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="lblRegister" runat="server" Text="Register Date"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblRegStart" runat="server" Text="Start Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtRegStart" CssClass="datepicker" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblRegEnd" runat="server" Text="End Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtRegEnd" CssClass="datepicker" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        &nbsp;
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="lblBirthDate" runat="server" Text="Birth Date"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblBdayStart" runat="server" Text="Start Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:DropDownList ID="ddlBdayStartDay" runat="server">
                            <asp:ListItem Selected="True" Text="01" Value="1"></asp:ListItem>
                            <asp:ListItem Text="02" Value="2"></asp:ListItem>
                            <asp:ListItem Text="03" Value="3"></asp:ListItem>
                            <asp:ListItem Text="04" Value="4"></asp:ListItem>
                            <asp:ListItem Text="05" Value="5"></asp:ListItem>
                            <asp:ListItem Text="06" Value="6"></asp:ListItem>
                            <asp:ListItem Text="07" Value="7"></asp:ListItem>
                            <asp:ListItem Text="08" Value="8"></asp:ListItem>
                            <asp:ListItem Text="09" Value="9"></asp:ListItem>
                            <asp:ListItem Text="10" Value="10"></asp:ListItem>
                            <asp:ListItem Text="11" Value="11"></asp:ListItem>
                            <asp:ListItem Text="12" Value="12"></asp:ListItem>
                            <asp:ListItem Text="13" Value="13"></asp:ListItem>
                            <asp:ListItem Text="14" Value="14"></asp:ListItem>
                            <asp:ListItem Text="15" Value="15"></asp:ListItem>
                            <asp:ListItem Text="16" Value="16"></asp:ListItem>
                            <asp:ListItem Text="17" Value="17"></asp:ListItem>
                            <asp:ListItem Text="18" Value="18"></asp:ListItem>
                            <asp:ListItem Text="19" Value="19"></asp:ListItem>
                            <asp:ListItem Text="20" Value="20"></asp:ListItem>
                            <asp:ListItem Text="21" Value="21"></asp:ListItem>
                            <asp:ListItem Text="22" Value="22"></asp:ListItem>
                            <asp:ListItem Text="23" Value="23"></asp:ListItem>
                            <asp:ListItem Text="24" Value="24"></asp:ListItem>
                            <asp:ListItem Text="25" Value="25"></asp:ListItem>
                            <asp:ListItem Text="26" Value="26"></asp:ListItem>
                            <asp:ListItem Text="27" Value="27"></asp:ListItem>
                            <asp:ListItem Text="28" Value="28"></asp:ListItem>
                            <asp:ListItem Text="29" Value="29"></asp:ListItem>
                            <asp:ListItem Text="30" Value="30"></asp:ListItem>
                            <asp:ListItem Text="31" Value="31"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlBdayStartMonth" runat="server" CssClass="bdayMonth">
                            <asp:ListItem Selected="True" Text="January" Value="1"></asp:ListItem>
                            <asp:ListItem Text="February" Value="2"></asp:ListItem>
                            <asp:ListItem Text="March" Value="3"></asp:ListItem>
                            <asp:ListItem Text="April" Value="4"></asp:ListItem>
                            <asp:ListItem Text="May" Value="5"></asp:ListItem>
                            <asp:ListItem Text="June" Value="6"></asp:ListItem>
                            <asp:ListItem Text="July" Value="7"></asp:ListItem>
                            <asp:ListItem Text="August" Value="8"></asp:ListItem>
                            <asp:ListItem Text="September" Value="9"></asp:ListItem>
                            <asp:ListItem Text="October" Value="10"></asp:ListItem>
                            <asp:ListItem Text="November" Value="11"></asp:ListItem>
                            <asp:ListItem Text="December" Value="12"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblBdayEnd" runat="server" Text="End Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:DropDownList ID="ddlBdayEndDay" runat="server">
                            <asp:ListItem Text="01" Value="1"></asp:ListItem>
                            <asp:ListItem Text="02" Value="2"></asp:ListItem>
                            <asp:ListItem Text="03" Value="3"></asp:ListItem>
                            <asp:ListItem Text="04" Value="4"></asp:ListItem>
                            <asp:ListItem Text="05" Value="5"></asp:ListItem>
                            <asp:ListItem Text="06" Value="6"></asp:ListItem>
                            <asp:ListItem Text="07" Value="7"></asp:ListItem>
                            <asp:ListItem Text="08" Value="8"></asp:ListItem>
                            <asp:ListItem Text="09" Value="9"></asp:ListItem>
                            <asp:ListItem Text="10" Value="10"></asp:ListItem>
                            <asp:ListItem Text="11" Value="11"></asp:ListItem>
                            <asp:ListItem Text="12" Value="12"></asp:ListItem>
                            <asp:ListItem Text="13" Value="13"></asp:ListItem>
                            <asp:ListItem Text="14" Value="14"></asp:ListItem>
                            <asp:ListItem Text="15" Value="15"></asp:ListItem>
                            <asp:ListItem Text="16" Value="16"></asp:ListItem>
                            <asp:ListItem Text="17" Value="17"></asp:ListItem>
                            <asp:ListItem Text="18" Value="18"></asp:ListItem>
                            <asp:ListItem Text="19" Value="19"></asp:ListItem>
                            <asp:ListItem Text="20" Value="20"></asp:ListItem>
                            <asp:ListItem Text="21" Value="21"></asp:ListItem>
                            <asp:ListItem Text="22" Value="22"></asp:ListItem>
                            <asp:ListItem Text="23" Value="23"></asp:ListItem>
                            <asp:ListItem Text="24" Value="24"></asp:ListItem>
                            <asp:ListItem Text="25" Value="25"></asp:ListItem>
                            <asp:ListItem Text="26" Value="26"></asp:ListItem>
                            <asp:ListItem Text="27" Value="27"></asp:ListItem>
                            <asp:ListItem Text="28" Value="28"></asp:ListItem>
                            <asp:ListItem Text="29" Value="29"></asp:ListItem>
                            <asp:ListItem Text="30" Value="30"></asp:ListItem>
                            <asp:ListItem Selected="True" Text="31" Value="31"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlBdayEndMonth" CssClass="bdayMonth" runat="server">
                            <asp:ListItem Text="January" Value="1"></asp:ListItem>
                            <asp:ListItem Text="February" Value="2"></asp:ListItem>
                            <asp:ListItem Text="March" Value="3"></asp:ListItem>
                            <asp:ListItem Text="April" Value="4"></asp:ListItem>
                            <asp:ListItem Text="May" Value="5"></asp:ListItem>
                            <asp:ListItem Text="June" Value="6"></asp:ListItem>
                            <asp:ListItem Text="July" Value="7"></asp:ListItem>
                            <asp:ListItem Text="August" Value="8"></asp:ListItem>
                            <asp:ListItem Text="September" Value="9"></asp:ListItem>
                            <asp:ListItem Text="October" Value="10"></asp:ListItem>
                            <asp:ListItem Text="November" Value="11"></asp:ListItem>
                            <asp:ListItem Selected="True" Text="December" Value="12"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="clear">
                    </div>
                    <div>
                        <div class="columnFirst">
                        </div>
                        <div class="columnMulti">
                            <asp:CheckBox ID="chkOffer" runat="server" />                            
                            <asp:Label ID="lblOffer" runat="server" Text="Offer"></asp:Label>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                    <div>
                        <div class="columnFirst">
                        Referrer
                        </div>
                        <div class="columnMulti">
                            <asp:TextBox ID="txtReferrer" runat="server"></asp:TextBox>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                </div>
            </div>
            <div class="clear">
            </div>
            <div class="division">
                &nbsp;</div>
            <div class="division">
                <div>
                    <div class="columnFirst">
                        &nbsp;
                    </div>
                    <div class="columnMulti">
                        <asp:Button ID="btnSelect" runat="server" Text="Select Users" OnClick="btnSelect_Click"
                            ValidationGroup="SearchValidator" />
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </div>
            <div class="clear">
            </div>
            <h3 style="text-align: left; padding-left: 8px;">
                Selected Users
            </h3>
            <div style="text-align: left; padding: 0px 0px 20px 5px;">
                <asp:LinkButton ID="lbExport" runat="server" OnClick="lbExport_Click">Export Report</asp:LinkButton>
            </div>
            <asp:Label ID="lblResult" runat="server" Text="No User is selected." CssClass="msg"></asp:Label>
            <div>
                <asp:GridView ID="gvUsers" runat="server" CellPadding="4" ForeColor="#333333" AutoGenerateColumns="False"
                    EmptyDataText="No record is matched with the search criterion." AllowPaging="true"
                    PageSize="10" OnPageIndexChanging="gvUsers_PageIndexChanging" AllowSorting="true"
                    OnSorting="gvUsers_Sorting" GridLines="Vertical" BorderColor="white">
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <%--<HeaderStyle BackColor="#5D7B9DA1A3A2" Font-Bold="True" ForeColor="White#333333" Height="34px" />--%>
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Height="34px" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="UserID" HeaderText="ID" SortExpression="UserID" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:TemplateField HeaderText="Birth Day" SortExpression="BirthDay">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblBirthDay" Text='<%# GetFormattedDate(Eval("BirthDay")) %>' />
                            </ItemTemplate>
                            <ItemStyle CssClass="gridSeparator" HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Gender" HeaderText="Gender" ItemStyle-HorizontalAlign="Center"
                            SortExpression="Gender" />
                        <asp:BoundField DataField="ZipCode" HeaderText="Zip" SortExpression="ZipCode" />
                        <asp:TemplateField HeaderText="Signup Date" SortExpression="SignupDate">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblSignupDate" Text='<%# GetFormattedDate(Eval("SignupDate")) %>' />
                            </ItemTemplate>
                            <ItemStyle CssClass="gridSeparator" HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Active" HeaderText="Active" SortExpression="Active" />
                        <asp:BoundField DataField="CorporateID" HeaderText="Company ID" SortExpression="CorporateID" />
                        <asp:BoundField DataField="Referrer" HeaderText="Referrer" SortExpression="Referrer" />
                        <asp:BoundField DataField="SendEmail1"  HeaderText="Offers" SortExpression="SendEmail1" />
                        <asp:BoundField DataField="SendEmail2" HeaderText="Other Offers" SortExpression="SendEmail2" />
                        <asp:BoundField DataField="CellPhone" HeaderText="Cell Number" />
                    </Columns>
                </asp:GridView>
            </div>
            <h3 style="text-align: left; padding-left: 8px;">
                Email to Users
            </h3>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblTemplate" runat="server" Text="Select Template"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList ID="ddlSelectTemplate" runat="server" OnSelectedIndexChanged="ddlSelectTemplate_SelectedIndexChanged"
                        AutoPostBack="true">
                        <asp:ListItem Selected="True" Text="--Select Template--" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblFromEmail" runat="server" Text="From Address"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:TextBox ID="txtFromEmail" runat="server" Width="500"></asp:TextBox>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblReplytoEmail" runat="server" Text="Reply To"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:TextBox ID="txtReplytoEmail" runat="server" Width="500"></asp:TextBox>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblEmailSubject" runat="server" Text="Subject"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:TextBox ID="txtEmailSubject" runat="server" Width="500"></asp:TextBox>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblEmailBody" runat="server" Text="EmailBody"></asp:Label>
                </div>
                <div class="columnSecond">
                    <uc1:HTMLEditor ID="HTMLEditor1" runat="server"></uc1:HTMLEditor>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="Label1" runat="server" Text="Priority"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList ID="ddlPriority" CssClass="bdayMonth" runat="server">
                        <asp:ListItem Text="High" Value="3"></asp:ListItem>
                        <asp:ListItem Text="Normal" Selected="True" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Low" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblScheduleTime" runat="server" Text="Schedule By"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:RadioButtonList ID="rdbScheduleBy" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Value="0" Selected="True">Now &nbsp; &nbsp; &nbsp; &nbsp;</asp:ListItem>
                        <asp:ListItem Value="1">Time &nbsp; &nbsp; &nbsp; &nbsp;</asp:ListItem>
                        <asp:ListItem Value="2">Birth Day &nbsp; &nbsp; &nbsp; &nbsp;</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div id="scheduleNowDiv" style="height: 60px;">
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnSecond" id="divClock">
                    &nbsp;
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div id="scheduleTimeDiv" style="height: 60px;">
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnSecond" style="padding-left: 30px; width: 400px;">
                    <div style="padding-bottom: 2px;">
                        <asp:TextBox ID="txtScheduleDate" CssClass="datepicker" runat="server"></asp:TextBox></div>
                    <div>
                        <asp:TextBox ID="txtScheduleTime" CssClass="timepicker" runat="server"></asp:TextBox></div>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div id="scheduleTokenDiv" style="height: 60px;">
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnSecond" style="padding-left: 127px; width: 400px;">
                    <asp:DropDownList ID="ddlScheduleToken" runat="server">
                        <asp:ListItem Value="-2155">90 days Before</asp:ListItem>
                        <asp:ListItem Value="-1435">60 days Before</asp:ListItem>
                        <asp:ListItem Value="-1075">45 days Before</asp:ListItem>
                        <asp:ListItem Value="-715">30 days Before</asp:ListItem>
                        <asp:ListItem Value="-595">25 days Before</asp:ListItem>
                        <asp:ListItem Value="-475">20 days Before</asp:ListItem>
                        <asp:ListItem Value="-355">15 days Before</asp:ListItem>
                        <asp:ListItem Value="-235">10 days Before</asp:ListItem>
                        <asp:ListItem Value="-211">9 days Before</asp:ListItem>
                        <asp:ListItem Value="-187">8 days Before</asp:ListItem>
                        <asp:ListItem Value="-163">7 days Before</asp:ListItem>
                        <asp:ListItem Value="-139">6 days Before</asp:ListItem>
                        <asp:ListItem Value="-115">5 days Before</asp:ListItem>
                        <asp:ListItem Value="-91">4 Days Before</asp:ListItem>
                        <asp:ListItem Value="-67">3 Days Before</asp:ListItem>
                        <asp:ListItem Value="-43">2 Days Before</asp:ListItem>
                        <asp:ListItem Value="-19">1 day Before</asp:ListItem>
                        <asp:ListItem Selected="True" Value="+5">Birth Day</asp:ListItem>
                        <asp:ListItem Value="+29">1 Day After</asp:ListItem>
                        <asp:ListItem Value="+53">2 Days After</asp:ListItem>
                        <asp:ListItem Value="+77">3 Days After</asp:ListItem>
                        <asp:ListItem Value="+101">4 Days After</asp:ListItem>
                        <asp:ListItem Value="+125">5 Days After</asp:ListItem>
                        <asp:ListItem Value="+149">6 days After</asp:ListItem>
                        <asp:ListItem Value="+173">7 Days After</asp:ListItem>
                        <asp:ListItem Value="+197">8 days After</asp:ListItem>
                        <asp:ListItem Value="+221">9 days After</asp:ListItem>
                        <asp:ListItem Value="+245">10 days After</asp:ListItem>
                        <asp:ListItem Value="+365">15 days After</asp:ListItem>
                        <asp:ListItem Value="+485">20 days After</asp:ListItem>
                        <asp:ListItem Value="+605">25 days After</asp:ListItem>
                        <asp:ListItem Value="+725">30 days After</asp:ListItem>
                        <asp:ListItem Value="+1085">45 days After</asp:ListItem>
                        <asp:ListItem Value="+1445">60 days After</asp:ListItem>
                        <asp:ListItem Value="+2165">90 days After</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnSecond">
                    <asp:Button ID="btnSendMail" runat="server" Text="Send" OnClick="btnSendMail_Click"
                        Width="100" ValidationGroup="SearchValidator" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript" language="javascript">
    function startTime()
    {
        var today=new Date();
        var month = today.getMonth() + 1;
        var day = today.getDate();
        var year = today.getFullYear();
        var h=today.getHours();
        var m=today.getMinutes();
        var s=today.getSeconds();
        var ampm = 'AM'
        if(h>12)
        {
            h = h-12;
            ampm = 'PM';
        }
        // add a zero in front of numbers<10
        month=checkTime(month);
        day=checkTime(day);
        h=checkTime(h);
        m=checkTime(m);
        s=checkTime(s);
        $('#divClock').html(month + "/" + day + "/" + year+ " " + h + ":" + m + ":" + s + " " + ampm);
        t=setTimeout('startTime()',500);
    }

    function checkTime(i)
    {
      if (i<10) 
      {
         i="0" + i;
      }
      return i;
    }
    startTime();
    </script>

</body>
</html>
