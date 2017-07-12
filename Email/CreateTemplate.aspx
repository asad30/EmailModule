<%@ Page Language="C#" AutoEventWireup="true" Codebehind="CreateTemplate.aspx.cs"
    Inherits="EmailModule.Email.CreateTemplate" ValidateRequest="false" %>

<%@ Register Src="UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc2" %>
<%@ Register Src="UserControl/HTMLEditor.ascx" TagName="HTMLEditor" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Email Templates</title>

    <script type="text/javascript" language="javascript" src="../Email/ckeditor/ckeditor.js"></script>

    <script type="text/javascript" language="javascript" src="../Email/js/jquery-1.4.1.min.js"></script>

    <script type="text/javascript">
$(document).ready(function() {    
    $(".imageSelector").change(function(){
        $("iframe").contents().find('#GiftCertGraphics').attr("src", $(".imageSelector option:selected").val());
        $("iframe").contents().find('#GiftCertGraphics').attr("_cke_saved_src", $(".imageSelector option:selected").val());
        $("#cke_contents_HTMLEditor1_txtEditor").css("height", "600px");
    });    
    setTimeout(function() {
        if($("iframe").contents().find('#GiftCertGraphics').attr("src")!="../Email/images/blank.PNG")
            $('#cke_contents_HTMLEditor1_txtEditor').css('height', '600px');
    },2000);    
});
    </script>

    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <uc2:Menu ID="Menu1" runat="server"></uc2:Menu>
    <h2 style="text-align: center;">
        Email Templates</h2>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>
        <div>
            <div class="columnFirst">
                <asp:Label ID="lbltemplate" runat="server" Text="Template Name"></asp:Label>
            </div>
            <div class="columnSecond">
                <asp:TextBox ID="txtTemplate" runat="server" Width="500"></asp:TextBox>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div>
            <div class="columnFirst">
                <asp:Label ID="lblFromEmail" runat="server" Text="From Email"></asp:Label>
            </div>
            <div class="columnSecond">
                <asp:TextBox ID="txtFromEmail" runat="server" Width="500" Text="Happy Birthday <HappyBirthday@TheBirthdayRegister.com>"></asp:TextBox>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div>
            <div class="columnFirst">
                <asp:Label ID="lblReplyTo" runat="server" Text="Reply To"></asp:Label>
            </div>
            <div class="columnSecond">
                <asp:TextBox ID="txtReplyTo" runat="server" Width="500" Text="Info@TheBirthdayRegister.com"></asp:TextBox>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div>
            <div class="columnFirst">
                <asp:Label ID="lblEmailSubject" runat="server" Text="Email Subject"></asp:Label>
            </div>
            <div class="columnSecond">
                <asp:TextBox ID="txtEmailSubject" runat="server" Width="500" Text="Happy Birthday [Name]!"></asp:TextBox>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div>
            <div class="columnFirst">
                <asp:Label ID="lblImageSelector" runat="server" Text="Certificate"></asp:Label>
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
                <asp:Label ID="lblDupTemplate" runat="server" Text="Copy Template"></asp:Label>
            </div>
            <div class="columnSecond">
                <asp:DropDownList ID="ddlDuplicateTemplate" runat="server" OnSelectedIndexChanged="ddlDuplicateTemplate_SelectedIndexChanged"
                    AutoPostBack="true">
                    <asp:ListItem Selected="True" Text="--Select Template--" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div>
            <div class="columnFirst">
                <asp:Label ID="lblEmailBody" runat="server" Text="Email Body"></asp:Label>
            </div>
            <div class="columnSecond">
                <uc1:HTMLEditor ID="HTMLEditor1" runat="server" Text="<img id='GiftCertGraphics' class='imgSelection' src='../Email/images/blank.PNG' alt='GiftCertGraphics' /><p></p>">
                </uc1:HTMLEditor>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div>
            <div class="columnFirst">
                &nbsp;</div>
            <div class="columnSecond">
                <asp:Button ID="btnSave" runat="server" Text="Save Template" OnClick="btnSave_Click" />
            </div>
            <div style="clear: both;">
            </div>
        </div>
    </form>
</body>
</html>
