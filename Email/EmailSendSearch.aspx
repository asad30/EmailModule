<%@ Page Language="C#" AutoEventWireup="true" Codebehind="EmailSendSearch.aspx.cs"
    Inherits="EmailModule.Email.EmailSendSearch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Email Schedule Search</title>
    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../Email/css/jquery-ui.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript" src="../Email/js/jquery-1.4.2.min.js"></script>

    <script type="text/javascript" language="javascript" src="../Email/js/jquery-ui.js"></script>

    <script type="text/javascript" language="javascript" src="../Email/js/jquery-ui-timepicker-addon-0.5.min.js"></script>

    <script type="text/javascript" language="javascript" src="../Email/js/pantheonMenu.js"></script>

    <link href="../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
		$(document).ready(function(){
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
        Email Schedule Search</h2>
    <div class="BodyContainer" style="width: 2050px;">
        <form id="form1" runat="server">
            <h3 style="text-align: left; padding-left: 8px;">
                Search Components
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
                        <asp:Label ID="lblSearchFName" runat="server" Text="First Name"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchFName" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchLName" runat="server" Text="Last Name"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchLName" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchEmail" runat="server" Text="Email"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchEmail" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="* Please Enter a valid Email"
                            SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ValidationGroup="SearchValidator" ControlToValidate="txtSearchEmail" Display="None"></asp:RegularExpressionValidator>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchRegID" runat="server" Text="Registration ID"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchRegID" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revRegID" runat="server" ErrorMessage="* Please Enter a valid Registration ID"
                            SetFocusOnError="True" ValidationExpression="^\d+$" ValidationGroup="SearchValidator"
                            ControlToValidate="txtSearchRegID" Display="None"></asp:RegularExpressionValidator>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchZip" runat="server" Text="Zip Code"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchZip" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        &nbsp;
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="lblSearchBdayHeader" runat="server" Text="Birth Date"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchBdayStart" runat="server" Text="Start Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:DropDownList ID="ddlSearchBdayStartDay" runat="server">
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
                        <asp:DropDownList ID="ddlSearchBdayStartMonth" runat="server" CssClass="bdayMonth">
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
                        <asp:Label ID="lblSearchBdayEnd" runat="server" Text="End Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:DropDownList ID="ddlSearchBdayEndDay" runat="server">
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
                        <asp:DropDownList ID="ddlSearchBdayEndMonth" CssClass="bdayMonth" runat="server">
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
                </div>
                <div style="display:none;">
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchActive" runat="server" Text="Active"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:DropDownList ID="ddlSearchActive" runat="server">
                            <asp:ListItem Value="" Text="" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Active Only"></asp:ListItem>
                            <asp:ListItem Value="0" Text="Inactive Only"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div style="display:none;">
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchCompany" runat="server" Text="Company ID"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:DropDownList ID="ddlSearchCompany" runat="server">
                            <asp:ListItem Value="" Text="" Selected="True"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchTemplate" runat="server" Text="Template: "></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:DropDownList ID="ddlSearchTemplate" runat="server">
                            <asp:ListItem Value="" Text="" Selected="True"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblBatchID" runat="server" Text="Email Batch ID: "></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchBatchID" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="rgvBatchID" runat="server" ErrorMessage="* Please Enter a valid Email Batch ID"
                            SetFocusOnError="True" ValidationExpression="^\d+$" ValidationGroup="SearchValidator"
                            ControlToValidate="txtSearchBatchID" Display="None"></asp:RegularExpressionValidator>
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </div>
            <div class="division">
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSeachStatus" runat="server" Text="Status: "></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:DropDownList ID="ddlSeachStatus" runat="server">
                            <asp:ListItem Value="-1" Text="" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="0" Text="Pending"></asp:ListItem>
                            <asp:ListItem Value="5" Text="Sent"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Sent-Not Opened"></asp:ListItem>
                            <asp:ListItem Value="3" Text="Sent-Opened"></asp:ListItem>
                            <asp:ListItem Value="4" Text="Sent-Bounced"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div style="display:none;">
                    <div class="columnFirst">
                        &nbsp;
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="lblSearchRequestHeader" runat="server" Text="Request Date"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchRequestStart" runat="server" Text="Start Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchRequestStart" CssClass="datepicker" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchRequestEnd" runat="server" Text="End Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchRequestEnd" CssClass="datepicker" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                 <div>
                    <div class="columnFirst">
                        &nbsp;
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="lblSearchScheduleDateHeader" runat="server" Text="Schedule Date"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchScheduleStart" runat="server" Text="Start Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchScheduleStart" CssClass="datepicker" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchScheduleEnd" runat="server" Text="End Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchScheduleEnd" CssClass="datepicker" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        &nbsp;
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="lblSearchSentDateHeader" runat="server" Text="Sent Date"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchSentStart" runat="server" Text="Start Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchSentStart" CssClass="datepicker" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchSentEnd" runat="server" Text="End Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchSentEnd" CssClass="datepicker" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        &nbsp;
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="lblSearchOpenedHeader" runat="server" Text="Opened Date"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchOpenedStart" runat="server" Text="Start Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchOpenedStart" CssClass="datepicker" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblSearchOpenedEnd" runat="server" Text="End Date"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:TextBox ID="txtSearchOpenedEnd" CssClass="datepicker" runat="server"></asp:TextBox>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        &nbsp;
                    </div>
                    <div class="columnMulti">
                        <asp:Button ID="btnShowReport" runat="server" OnClick="btnShowReport_Click" Text="Show Report"
                            Width="100" ValidationGroup="SearchValidator" />
                    </div>
                    <div style="clear: both;">
                    </div>
                </div>
            </div>
            <div class="clear">
            </div>
            <div style="text-align: left; padding: 0px 0px 20px 5px;">
                <asp:LinkButton ID="lbExport" runat="server" OnClick="lbExport_Click">Export Report</asp:LinkButton>
            </div>
            <div>
                <div class="columnFirst">
                    Show Records:
                </div>
                <div class="columnMulti">
                    <asp:DropDownList ID="ddlPageSize" runat="server" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged"
                        AutoPostBack="true">
                        <asp:ListItem Value="10" Text="10"></asp:ListItem>
                        <asp:ListItem Value="20" Text="20" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="50" Text="50"></asp:ListItem>
                        <asp:ListItem Value="100" Text="100"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div style="padding: 8px 0px 8px 0px;">          
            </div>
            <div>
                <asp:Label ID="lblResult" runat="server"></asp:Label>
            </div>
            <div>
                <%--AllowSorting="true" OnSorting="gvEmailSchedule_Sorting"--%>
                <asp:GridView ID="gvEmailSchedule" runat="server" CellPadding="4" ForeColor="#333333"
                    AutoGenerateColumns="False" EmptyDataText="No Email Schedule found." AllowPaging="true"
                    PageSize="10" OnPageIndexChanging="gvEmailSchedule_PageIndexChanging" GridLines="Vertical"
                    BorderColor="white">
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Height="34px" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="UserID" HeaderText="User ID" SortExpression="UserID" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Bday" HeaderText="Birthday" SortExpression="Bday" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="ZipCode" HeaderText="ZipCode" SortExpression="ZipCode" />
                        <%--<asp:BoundField DataField="SignUpDate" HeaderText="SignUpDate" SortExpression="SignUpDate" />
                        <asp:BoundField DataField="Active" HeaderText="Active" SortExpression="Active" />
                        <asp:BoundField DataField="CompanyName" HeaderText="Company" SortExpression="CompanyName" />
                        <asp:BoundField DataField="TemplateName" HeaderText="TemplateName" SortExpression="TemplateName" />--%>
                        <asp:BoundField DataField="EmailContentID" HeaderText="Batch ID" SortExpression="EmailContentID" />
                        <asp:BoundField DataField="EmailPriority" HeaderText="Priority" SortExpression="EmailPriority" />
                        <%--<asp:BoundField DataField="EmailRequestTime" HeaderText="RequestTime" SortExpression="EmailRequestTime" />--%>
                        <asp:BoundField DataField="EmailScheduleTime" HeaderText="ScheduleTime" SortExpression="EmailScheduleTime" />
                        <asp:BoundField DataField="EmailSendTime" HeaderText="SendTime" SortExpression="EmailSendTime" />
                        <asp:BoundField DataField="EmailOpenTime" HeaderText="OpenTime" SortExpression="EmailOpenTime" />
                        <asp:BoundField DataField="EmailOpenCount" HeaderText="OpenCount" SortExpression="EmailOpenCount" />
                        <asp:BoundField DataField="EmailBounceMailTime" HeaderText="BounceTime" SortExpression="EmailBounceMailTime" />
                    </Columns>
                </asp:GridView>
            </div>
        </form>
    </div>
</body>
</html>
