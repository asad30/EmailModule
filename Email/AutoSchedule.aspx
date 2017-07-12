<%@ Page Language="C#" AutoEventWireup="true" Codebehind="AutoSchedule.aspx.cs" Inherits="EmailModule.Email.AutoSchedule" ValidateRequest="false" %>

<%@ Register Src="UserControl/HTMLEditor.ascx" TagName="HTMLEditor" TagPrefix="uc1" %>
<%@ Register Src="UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Auto Schedule Email</title>
    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <link href="../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
    .columnFirst
    {
        width:110px;
    }
    </style>
</head>
<body>
    <uc2:Menu ID="Menu1" runat="server"></uc2:Menu>
    <h2 style="text-align: center;">
        Auto Schedule Email
    </h2>
    <div class="BodyContainer">
        <form id="form1" runat="server">
            <div>
                <h3 style="text-align: left; padding-left: 8px;">
                    User Selection
                </h3>
                <div>
                    <div>
                        <div class="columnFirst">
                            <asp:Label ID="lblAcive" runat="server" Text="Active"></asp:Label>
                        </div>
                        <div class="columnMulti">
                            <asp:DropDownList ID="ddlActive" runat="server">
                                <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                <asp:ListItem Value="0" Text="Inactive" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="-1" Text="Select All"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                    <div>
                        <div class="columnFirst">
                            <asp:Label ID="lblSignUpDuration" runat="server" Text="Sign Up Period"></asp:Label>
                        </div>
                        <div class="columnMulti">
                            <asp:TextBox ID="txtSignUpDurationStart" runat="server" Text="1" Width="25" MaxLength="3"></asp:TextBox>
                            &nbsp;Day(s) -
                            <asp:TextBox ID="txtSignUpDurationEnd" runat="server" Text="5" Width="25" MaxLength="3"></asp:TextBox>
                            &nbsp; Day(s)
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                </div>
            </div>
            <p>
                &nbsp;</p>
            <div>
                <h3 style="text-align: left; padding-left: 8px;">
                    Auto Schedular Properties
                </h3>
                <div>
                    <div>
                        <div class="columnFirst">
                            <asp:Label ID="lblSchedularName" runat="server" Text="Schedular Name"></asp:Label>
                        </div>
                        <div class="columnMulti">
                            <asp:TextBox ID="txtSchedularName" runat="server" Width="500"></asp:TextBox>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                    <div>
                        <div class="columnFirst">
                            <asp:Label ID="lblFrequency" runat="server" Text="Frequency"></asp:Label>
                        </div>
                        <div class="columnMulti">
                            <asp:DropDownList ID="ddlShedularFrequency" runat="server">
                                <asp:ListItem Value="24" Text="in everyday" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="12" Text="in every 12 hours"></asp:ListItem>
                                <asp:ListItem Value="6" Text="in every 6 hours"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                    <div>
                        <div class="columnFirst">
                            <asp:Label ID="lblSchedularStart" runat="server" Text="Starting Date"></asp:Label>
                        </div>
                        <div class="columnMulti">
                            <asp:TextBox ID="txtSchedularStart" runat="server" Text=""></asp:TextBox>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                </div>
            </div>
            <p>
                &nbsp;</p>
            <div>
                <h3 style="text-align: left; padding-left: 8px;">
                    Email Contents
                </h3>
                <div>
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
                </div>
            </div>
            <div style="padding:15px 0px 100px 0px">
                <div>
                    <div>
                        <div class="columnFirst">
                            &nbsp;
                        </div>
                        <div class="columnMulti">
                            <asp:Button ID="btnSave" runat="server" Text="Save Schedule" OnClick="btnSave_Click" />
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
