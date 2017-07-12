<%@ Page Language="C#" AutoEventWireup="true" Codebehind="EmailTemplates.aspx.cs"
    Inherits="EmailModule.Email.EmailTemplates" %>

<%@ Register Src="UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Email Templates</title>
    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .mediumColumn
        {
            Width:550px;            
        }
    </style>
</head>
<body>
    <uc2:Menu ID="Menu1" runat="server"></uc2:Menu>
    <h2 style="text-align: center;">
        Email Templates</h2>
    <div class="BodyContainer">
        <form id="form1" runat="server">
            <div>
                <asp:Label ID="lblCancelAll" runat="server" CssClass="msg"></asp:Label>
            </div>
            <div>
                <asp:Label ID="lblResult" runat="server"></asp:Label>
            </div>
            <div style="padding-left: 50px;">
                <asp:GridView ID="gvEmailTemplate" runat="server" CellPadding="4" ForeColor="#333333"
                    AutoGenerateColumns="False" EmptyDataText="No Template is found." GridLines="Vertical"
                    BorderColor="white" OnRowCommand="gvEmailTemplate_RowCommand">
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <%--<HeaderStyle BackColor="#5D7B9DA1A3A2" Font-Bold="True" ForeColor="White#333333" Height="34px" />--%>
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Height="34px" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="TemplateName" HeaderText="TemplateName" />
                        <asp:BoundField DataField="EmailSubject" HeaderText="Email Subject" HeaderStyle-CssClass="mediumColumn" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="hlEditTemplate" runat="server" NavigateUrl='<%#string.Format("CreateTemplate.aspx?templateid={0}", Eval("TemplateID"))%>'>
                                    <img src="../Email/images/edit.png" style="border-width: 0px; vertical-align:bottom;" alt="Edit" title="Edit" />
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="../Email/images/trash.png"
                                    ToolTip="Delete Template" CommandName="DeleteTemplate" CommandArgument='<%# Eval("TemplateID") %>'
                                    OnClientClick="javascript:return confirm('Are you sure you want to delete this template?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </form>
    </div>
</body>
</html>
