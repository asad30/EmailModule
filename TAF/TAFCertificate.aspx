<%@ Page Language="C#" AutoEventWireup="true" Codebehind="TAFCertificate.aspx.cs"
    Inherits="EmailModule.TAF.TAFCertificate" ValidateRequest="false" %>

<%@ Register Src="../Email/UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TAF Certificates</title>
    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <uc1:Menu ID="Menu2" runat="server" />
    <h2 style="text-align: center;">
        TAF Certificates</h2>
    <div class="BodyContainer">
        <form id="form1" runat="server">
            <h3 style="text-align: left; padding-left: 8px;">
                Assign Gift Certificate:
            </h3>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblGiftCert" runat="server" Text="Gift Certificate:"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList CssClass="imageSelector" ID="ddlGiftCert" runat="server" AutoPostBack="false">
                        <asp:ListItem Value="../Email/images/blank.PNG" Selected="True" Text="-- Select Image --"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblZip" runat="server" Text="Zip Codes:"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:TextBox ID="txtZip" runat="server" Width="300"></asp:TextBox>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;</div>
                <div class="columnSecond">
                    <asp:Button ID="btnSaveGiftCert" runat="server" Text="Save" OnClick="btnSaveGiftCert_Click" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <h3 style="text-align: left; padding-left: 8px;">
                Assigned List:
            </h3>
            <div>
                <asp:Label ID="lblCancelAll" runat="server" CssClass="msg"></asp:Label>
            </div>
            <div>
                <asp:Label ID="lblResult" runat="server"></asp:Label>
            </div>
            <div style="padding-left: 50px;">
                <asp:GridView ID="gvTAFCert" runat="server" CellPadding="4" ForeColor="#333333" AutoGenerateColumns="False"
                    EmptyDataText="No Record found." GridLines="Vertical" BorderColor="white" OnRowCommand="gvTAFCert_RowCommand"
                    OnRowDeleting="gvTAFCert_RowDeleting">
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <%--<HeaderStyle BackColor="#5D7B9DA1A3A2" Font-Bold="True" ForeColor="White#333333" Height="34px" />--%>
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Height="34px" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="Gift Certificate">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblTAFCertName" Text='<%# GetCertSubstring(Eval("TAFCertificate")) %>' />
                            </ItemTemplate>
                            <ItemStyle CssClass="gridSeparator" HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField='<%# Eval("TAFCertificate") %>' HeaderText="Gift Certificate" />--%>
                        <asp:BoundField DataField="ZipCodes" HeaderText="Zip Codes" HeaderStyle-CssClass="mediumColumn" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="hlEditTemplate" runat="server" NavigateUrl='<%#string.Format("TAFCertificate.aspx?id={0}", Eval("ID"))%>'>
                                    <img src="../Email/images/edit.png" style="border-width: 0px; vertical-align:bottom;" alt="Edit" title="Edit" />
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="../Email/images/trash.png"
                                    ToolTip="Delete" CommandName="Delete" CommandArgument='<%# Eval("ID") %>' OnClientClick="javascript:return confirm('Are you sure you want to delete this?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </form>
    </div>
</body>
</html>
