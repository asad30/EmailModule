<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegAutoNotifyer.aspx.cs" Inherits="EmailModule.Email.RegAutoNotifyer" %>
<%@ Register Src="UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Registration Auto Notification Report</title>
    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <uc2:Menu ID="Menu1" runat="server"></uc2:Menu>
    <h2 style="text-align: center;">
        Registration Auto Notification Report</h2>
    <div class="BodyContainer" style="width: 1400px;">
        <form id="form1" runat="server">
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label><br /> <br /> 
            <asp:LinkButton ID="lnkBtnExport" runat="server" OnClick="btnExport_Click">Export Report</asp:LinkButton> 
            <br />
            <br />
            <asp:Button ID="btnShowReport" runat="server" Text="Generate report" OnClick="btnShowReport_Click" /><br />
            <br />   
            <asp:GridView ID="GridView1" AutoGenerateColumns="False" CellPadding="4" AllowPaging="true" PageSize="50"  
            ForeColor="#333333" GridLines="None" runat="server" EmptyDataText="No records found." >
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="Reg ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="ID" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" HeaderStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" HeaderStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="Active" HeaderText="Active" SortExpression="Active" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Birthday" HeaderText="Birthday" SortExpression="Birthday" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="Zipcode" HeaderText="Zipcode" SortExpression="Zipcode" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="SignupDate" HeaderText="SignupDate" SortExpression="SignupDate" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="NotificationSent" HeaderText="Sent Count" SortExpression="NotificationSent" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="NextNotificationDate" HeaderText="NextNotificationDate" ItemStyle-HorizontalAlign="Center" SortExpression="NextNotificationDate" />
                    <asp:BoundField DataField="Activationdate" HeaderText="Activationdate" ItemStyle-HorizontalAlign="Center" SortExpression="Activationdate" />
                </Columns>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#999999" />
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=BIRTHDAY\SQLEXPRESS;Initial Catalog=thefreebirthday;User ID=thefreebirthday;pwd=deadFax186"
                ProviderName="System.Data.SqlClient" SelectCommand="Select ID, LEFT(Name, 32) AS Name, LEFT(Email, 32) AS Email, (CASE WHEN Active = 1 THEN 'Yes' ELSE ' ' END) AS Active, CONVERT(VARCHAR(10), Birthday, 101) AS Birthday, Gender, Zipcode, SignupDate, NotificationSent, NextNotificationDate, Activationdate from tblUSer where notificationsent > 0 AND (Unsubscribed IS NULL OR Unsubscribed = 0) ORDER BY ID DESC&#13;&#10;">
            </asp:SqlDataSource>
        </form>
    </div>
</body>
</html>
