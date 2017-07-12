<%@ Page Language="C#" AutoEventWireup="true" Codebehind="TAFadmin.aspx.cs" Inherits="EmailModule.TAF.TAFadmin" ValidateRequest="false" %>

<%@ Register Src="../Email/UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc1" %>
<%@ Register Src="../Email/UserControl/HTMLEditor.ascx" TagName="HTMLEditor" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TAF Admin Page</title>
    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <style>
    .columnFirst
    {
        width:140px;
    }
    .columnSecond 
    {
        width:840px;
    }
    </style>
</head>
<body>
    <uc1:Menu ID="Menu2" runat="server" />
    <form id="form1" runat="server">
        <div class="BodyContainer">
            <h2 style="text-align: center;">
                TAF Admin</h2>
            <div style="display:none;">
                <div class="columnFirst">
                    <asp:Label ID="lblYouTube" runat="server" Text="You Tube Video Link:"></asp:Label>
                </div>
                <div class="columnSecond">
                    <%--<uc2:HTMLEditor ID="HTMLEditor1" runat="server"></uc2:HTMLEditor>--%>
                    <asp:TextBox ID="txtYouTube" runat="server" Width="400"></asp:TextBox>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblImageSelector" runat="server" Text="Sample Certificate:"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList CssClass="imageSelector" ID="ddlImageSelector" runat="server" AutoPostBack="false">
                        <asp:ListItem Value="../Email/images/blank.PNG" Selected="True" Text="-- Select Image --"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblSubject" runat="server" Text="TAF Email Subject:"></asp:Label>
                </div>
                <div class="columnSecond">
                    <%--<uc2:HTMLEditor ID="HTMLEditor1" runat="server"></uc2:HTMLEditor>--%>
                    <asp:TextBox ID="txtSubject" runat="server" Width="400"></asp:TextBox>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblBody" runat="server" Text="TAF Email Body:"></asp:Label>
                </div>
                <div class="columnSecond">
                    <uc2:HTMLEditor ID="HTMLEditor1" runat="server"></uc2:HTMLEditor>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;</div>
                <div class="columnSecond">
                    <asp:Button ID="btnUpdate" runat="server" Text="Update TAF" OnClick="btnUpdate_Click" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
