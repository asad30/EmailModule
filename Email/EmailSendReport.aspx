<%@ Page Language="C#" AutoEventWireup="true" Codebehind="EmailSendReport.aspx.cs"
    Inherits="EmailModule.Email.EmailSendReport" %>

<%@ Register Src="UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Email Schedule Report</title>
    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <uc2:Menu ID="Menu1" runat="server"></uc2:Menu>
    <h2 style="text-align: center;">
        Email Schedule Status Report</h2>
    <div class="BodyContainer" style="width:1092px;">
        <form id="form1" runat="server">
            <div>
                <asp:Label ID="lblBatchID" runat="server" Text="Email Batch ID: "></asp:Label>
                <asp:DropDownList ID="ddlBatchID" runat="server">
                </asp:DropDownList>
                <asp:Button ID="btnShowReport" runat="server" OnClick="btnShowReport_Click" Text="Show Report" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Email Batch Request Time: <asp:Label ID="lblBatchReqTime" runat="server" Text=""></asp:Label>
            </div>
            <div style="text-align: right; padding-right: 150px;">
                <asp:LinkButton ID="lbCancelAll" runat="server" OnClick="lbCancelAll_Click" OnClientClick="javascript:return confirm('Are you sure you want to cancel all the emails?');">Cancel All Pending</asp:LinkButton>
            </div>
            <div>
                <asp:Label ID="lblCancelAll" runat="server" CssClass="msg"></asp:Label>
            </div>
            <div>
                <asp:Label ID="lblResult" runat="server"></asp:Label>
            </div>
            <div>
                <asp:GridView ID="gvEmailSend" runat="server" CellPadding="4" ForeColor="#333333"
                    AutoGenerateColumns="False" EmptyDataText="No Email is found." AllowPaging="true"
                    PageSize="10" OnPageIndexChanging="gvEmailSend_PageIndexChanging" AllowSorting="true"
                    OnSorting="gvEmailSend_Sorting" GridLines="Vertical" BorderColor="white" OnRowCommand="gvEmailSend_RowCommand"
                    OnRowDataBound="gvEmailSend_RowDataBound">
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <%--<HeaderStyle BackColor="#5D7B9DA1A3A2" Font-Bold="True" ForeColor="White#333333" Height="34px" />--%>
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Height="34px" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="UserID" HeaderText="UserID" SortExpression="UserID" />
                        <asp:BoundField DataField="NameToken" HeaderText="Name" SortExpression="NameToken" />
                        <%--<asp:BoundField DataField="BdayToken" HeaderText="Birth Day" SortExpression="BdayToken" />
                        <asp:BoundField DataField="ZipToken" HeaderText="Zip" SortExpression="ZipToken" />--%>
                        <asp:BoundField DataField="ToAddress" HeaderText="Email" SortExpression="ToAddress" />
                        <asp:TemplateField HeaderText="Subject" SortExpression="EmailSubject">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblEmailSubject" Text='<%# GetFormattedName(Eval("EmailSubject")) %>' />
                            </ItemTemplate>
                            <ItemStyle CssClass="gridSeparator" HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Template Name" SortExpression="TemplateName">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblTemplateName" Text='<%# GetFormattedName(Eval("TemplateName")) %>' />
                            </ItemTemplate>
                            <ItemStyle CssClass="gridSeparator" HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="ScheduleTime" HeaderText="Schedule Time" SortExpression="ScheduleTime" />
                        <asp:TemplateField HeaderText="Status" SortExpression="Status">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblStatus" Text='<%# GetFormattedStatus(Eval("Status")) %>' />
                            </ItemTemplate>
                            <ItemStyle CssClass="gridSeparator" HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../Email/images/trash.png"
                                    ToolTip="Cancel Email" CommandName="CancelEmail" CommandArgument='<%# Eval("EmailDeliveryID") %>'
                                    OnClientClick="javascript:return confirm('Are you sure you want to cancel this email?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <h3 style="text-align: left; padding-left: 8px;">
                Selection Criterions:
            </h3>
            <div class="division">
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblFName" runat="server" Text="First Name:"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="txtFName" runat="server"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblLName" runat="server" Text="Last Name:"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="txtLName" runat="server"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblEmail" runat="server" Text="Email:"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="txtEmail" runat="server"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblRegID" runat="server" Text="Registration ID:"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="txtRegID" runat="server"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblZip" runat="server" Text="Zip Code:"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="txtZip" runat="server"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblAcive" runat="server" Text="Active:"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="txtActive" runat="server"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblCompany" runat="server" Text="Company ID:"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="txtCompany" runat="server"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </div>
            <div class="division">
                <div>
                    <div class="columnFirst">
                        &nbsp;
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="lblRegister" runat="server" Text="Register Date"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblRegStart" runat="server" Text="Start Date:"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="txtRegStart" runat="server"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblRegEnd" runat="server" Text="End Date:"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="txtRegEnd" runat="server"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        &nbsp;
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="lblBirthDate" runat="server" Text="Birth Date"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblBdayStart" runat="server" Text="Start Date:"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="txtBdayStart" runat="server"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblBdayEnd" runat="server" Text="End Date:"></asp:Label>
                    </div>
                    <div class="columnMulti">
                        <asp:Label ID="txtBdayEnd" runat="server"></asp:Label>
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </div>
            <div class="clear">
            </div>
            <div>
                <h3 style="text-align: left; padding-left: 8px;">
                    Email Components:
                </h3>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblTemplate" runat="server" Text="Template:"></asp:Label>
                    </div>
                    <div class="columnSecond">
                        <asp:Label ID="txtTemplate" runat="server"></asp:Label>
                    </div>
                    <div style="clear: both;">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblFromEmail" runat="server" Text="From Address:"></asp:Label>
                    </div>
                    <div class="columnSecond">
                        <asp:Label ID="txtFromEmail" runat="server"></asp:Label>
                    </div>
                    <div style="clear: both;">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblReplytoEmail" runat="server" Text="Reply To:"></asp:Label>
                    </div>
                    <div class="columnSecond">
                        <asp:Label ID="txtReplytoEmail" runat="server"></asp:Label>
                    </div>
                    <div style="clear: both;">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblEmailSubject" runat="server" Text="Subject:"></asp:Label>
                    </div>
                    <div class="columnSecond">
                        <asp:Label ID="txtEmailSubject" runat="server"></asp:Label>
                    </div>
                    <div style="clear: both;">
                    </div>
                </div>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblEmailBody" runat="server" Text="EmailBody:"></asp:Label>
                    </div>
                    <div class="columnSecond">
                        <asp:Label ID="txtEmailBody" runat="server"></asp:Label>
                    </div>
                    <div style="clear: both;">
                    </div>
                </div>
                <%--<div>
                    <div class="columnFirst">
                        <asp:Label ID="Label1" runat="server" Text="Priority:"></asp:Label>
                    </div>
                    <div class="columnSecond">
                        <asp:Label ID="txtPriority" runat="server"></asp:Label>
                    </div>
                    <div style="clear: both;">
                    </div>
                </div>--%>
                <div>
                    <div class="columnFirst">
                        <asp:Label ID="lblScheduleTime" runat="server" Text="Schedule:"></asp:Label>
                    </div>
                    <div class="columnSecond">
                        <asp:Label ID="txtSchedule" runat="server"></asp:Label>
                    </div>
                    <div style="clear: both;">
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
