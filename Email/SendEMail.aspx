<%@ Page Language="C#" AutoEventWireup="true" Codebehind="SendEMail.aspx.cs" 
Inherits="EmailModule.Email.SendEMail" ValidateRequest="false" %>
<%@ Register Src="UserControl/HTMLEditor.ascx" TagName="HTMLEditor" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Send TAF Email</title>
    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <h2 style="text-align: center;">
        Send TAF Email</h2>
</head>
<body>
    <form id="form1" runat="server">        
        <div>
            <div>
                <asp:Label ID="lblError" runat="server" Text="" CssClass="msg"></asp:Label>
            </div>
        </div>
        <div>
            <div class="columnFirst">
                <asp:Label ID="lblUserIDs" runat="server" Text="User IDs"></asp:Label>
            </div>
            <div class="columnSecond">
                <asp:TextBox ID="txtUserIDs" runat="server" TextMode="MultiLine" Width="500"></asp:TextBox>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div>
            <div class="columnFirst">
                <asp:Label ID="lblTemplate" runat="server" Text="Select Template"></asp:Label>
            </div>
            <div class="columnSecond">
                <asp:DropDownList ID="ddlSelectTemplate" runat="server" OnSelectedIndexChanged="ddlSelectTemplate_SelectedIndexChanged" AutoPostBack="true">
                <asp:ListItem Selected="True" Text="--Select Template--" Value="0"></asp:ListItem> 
                </asp:DropDownList>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div>
            <div class="columnFirst">
                <asp:Label ID="lblFromEmail" runat="server" Text="From Email"></asp:Label>
            </div>
            <div class="columnSecond">
                <asp:TextBox ID="txtFromEmail" runat="server" Width="500"></asp:TextBox>
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
                 <uc1:HTMLEditor ID="HTMLEditor1" runat="server" >
                </uc1:HTMLEditor>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div>
            <div class="columnFirst">
                &nbsp;
            </div>
            <div class="columnSecond">
                <asp:Button ID="btnSendMail" runat="server" Text="Send" Width="50" OnClick="btnSendMail_Click" />
            </div>
            <div style="clear: both;">
            </div>
        </div>
    </form>
</body>
</html>
