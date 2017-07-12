<%@ Control Language="C#" AutoEventWireup="true" Codebehind="HTMLEditor.ascx.cs"
    Inherits="EmailModule.Email.UserControl.HTMLEditor" %>
<div id="dvEditor" runat="server">
    <asp:TextBox ID="txtEditor" runat="server" TextMode="MultiLine"></asp:TextBox>
    <script type="text/javascript" language="javascript" src="/Email/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
        CKEDITOR.config.scayt_autoStartup = false; 
        CKEDITOR.replace( '<%= txtEditor.ClientID %>');
    </script>

</div>
