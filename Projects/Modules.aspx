<%@ Page Language="C#" AutoEventWireup="true" Codebehind="Modules.aspx.cs" Inherits="EmailModule.Projects.Modules" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Modules</title>
    <link href="../Projects/css/Common.css" rel="stylesheet" type="text/css" />
    <h2 style="text-align: center;">
        Modules</h2>
</head>
<body>
    <form id="form1" runat="server">
        <div class="BodyContainer">
            <div class="Padding">
                <asp:HyperLink ID="hlNewModule" runat="server" NavigateUrl="~/Projects/AddModule.aspx">Create New Module</asp:HyperLink>&nbsp;&nbsp;&nbsp;
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Projects/Tasks.aspx">Return to Tasks</asp:HyperLink>
            </div>
            <asp:GridView ID="grdModule" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#999999" />
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:TemplateField HeaderText="Project">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblProjectName" Text='<%# GetFormattedName(Eval("ProjectName")) %>' />
                        </ItemTemplate>
                        <ItemStyle CssClass="gridSeparator" HorizontalAlign="Left" />
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Module">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblModuleName" Text='<%# GetFormattedName(Eval("ModuleName")) %>' />
                        </ItemTemplate>
                        <ItemStyle CssClass="gridSeparator" HorizontalAlign="Left" />
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblDescription" Text='<%# GetFormattedName(Eval("Description")) %>' />
                        </ItemTemplate>
                        <ItemStyle CssClass="gridSeparator" HorizontalAlign="Left" />
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="hlEditModule" runat="server" Target="_blank" NavigateUrl='<%# String.Format("AddModule.aspx?moduleid={0}", DataBinder.Eval(Container.DataItem,"ModuleID")) %>'
                                Text="Edit"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
