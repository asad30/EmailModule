<%@ Page Language="C#" AutoEventWireup="true" Codebehind="BounceReport.aspx.cs" Inherits="EmailModule.Email.BounceReport" %>

<%@ Register Src="UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Email Bounce Report</title>
    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <uc2:Menu ID="Menu1" runat="server"></uc2:Menu>
    <h2 style="text-align: center;">
        Email Bounce Report</h2>
    <div class="BodyContainer" style="width: 1092px;">
        <form id="form1" runat="server">
            <div>
                <div class="columnFirst" style="width: 120px;">
                    <asp:Label ID="lblModule" runat="server" Text="Module"></asp:Label>
                </div>
                <div class="columnMulti">
                    <asp:DropDownList ID="ddlModule" runat="server">
                        <asp:ListItem Selected="True" Text="New Module" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Old Module" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Select All" Value="3"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="clear">
                </div>
            </div>
            <div>
                <div class="columnFirst" style="width: 120px;">
                    <asp:Label ID="lblBounceCount" runat="server" Text="Min Bounce Count"></asp:Label>
                </div>
                <div class="columnMulti">
                    <asp:TextBox ID="txtBounceCount" runat="server" Text="1"></asp:TextBox>
                </div>
                <div class="clear">
                </div>
            </div>
            <div>
                <div class="columnFirst" style="width: 120px;">
                    <asp:Label ID="lblUnsubscribed" runat="server" Text="Unsubscribed"></asp:Label>
                </div>
                <div class="columnMulti">
                    <asp:DropDownList ID="ddlUnsubscribed" runat="server">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                        <asp:ListItem Selected="True" Text="No" Value="False"></asp:ListItem>
                        <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="clear">
                </div>
            </div>
            <div>
                <div class="columnFirst" style="width: 120px;">
                </div>
                <div class="columnMulti">
                    <asp:Button ID="btnShowReport" runat="server" OnClick="btnShowReport_Click" Text="Show Report" /></div>
                <div class="clear">
                </div>
            </div>
            <div style="padding: 10px 10px 10px 300px;">
                <asp:LinkButton ID="lnkUnsubscribe" runat="server" Visible="false" OnClick="lnkUnsubscribe_Click"
                    OnClientClick="javascript:return confirm('Are you sure you want to unsubscribe all the listed users?');">Unsubscribe the List</asp:LinkButton>
            </div>
            <div>
                <asp:Label ID="lblUnsMsg" runat="server"></asp:Label>
            </div>
            <div id="divNewMod" runat="server" visible="false">
                <div>
                    <h3>
                        New Module</h3>
                </div>
                <div>
                    <asp:Label ID="lblResultNew" runat="server" Text="No result found." CssClass="msg"></asp:Label>
                </div>
                <asp:GridView ID="gvBounceNewModule" runat="server" CellPadding="4" ForeColor="#333333"
                    GridLines="None" AllowPaging="True" EmptyDataText="No records found." 
                    OnPageIndexChanging="gvBounceNewModule_PageIndexChanging" AutoGenerateColumns="False">
                    <RowStyle BackColor="#EFF3FB" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="UserID" HeaderText="User ID" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Sent" HeaderText="Sent" />
                        <asp:BoundField DataField="Bounced" HeaderText="Bounced" />
                        <asp:TemplateField HeaderText="Unsubscribed">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblUnsubscribed" Text='<%# GetFormattedValue(Eval("Unsubscribed")) %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <div id="divOldMod" runat="server" visible="false">
                <div>
                    <h3>
                        Old Module</h3>
                </div>
                <div>
                    <asp:Label ID="lblResultOld" runat="server" Text="No result found." CssClass="msg"></asp:Label>
                </div>
                <asp:GridView ID="gvBounceOldModule" runat="server" CellPadding="4" ForeColor="#333333"
                    GridLines="None" AllowPaging="True" EmptyDataText="No records found." OnPageIndexChanging="gvBounceOldModule_PageIndexChanging" AutoGenerateColumns="False">
                    <RowStyle BackColor="#EFF3FB" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="UserID" HeaderText="User ID" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Sent" HeaderText="Sent" />
                        <asp:BoundField DataField="Bounced" HeaderText="Bounced" />
                        <asp:TemplateField HeaderText="Unsubscribed">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblUnsubscribed" Text='<%# GetFormattedValue(Eval("Unsubscribed")) %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </form>
    </div>
</body>
</html>
