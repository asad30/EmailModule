<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TAFAutoNotifyer.aspx.cs" Inherits="EmailModule.Email.TAFAutoNotifyer" %>

<%@ Register Src="UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>TAF Auto Notification Report</title>
    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <uc2:Menu ID="Menu1" runat="server"></uc2:Menu>
    <h2 style="text-align: center;">
        TAF Auto Notification Report</h2>
    <div class="BodyContainer" style="width: 1600px;">
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
                    <asp:BoundField DataField="FriendName" HeaderText="Friend Name" ReadOnly="True" SortExpression="FriendName" />
                    <asp:BoundField DataField="FriendEmail" HeaderText="Friend Email" ReadOnly="True"
                        SortExpression="FriendEmail"  />
                    <asp:BoundField DataField="FriendRegID" HeaderText="Friend RegID" ReadOnly="True"
                        SortExpression="FriendRegID"  />
                    <asp:BoundField DataField="ReferrerName" HeaderText="Referrer Name" ReadOnly="True"
                        SortExpression="ReferrerName" />
                    <asp:BoundField DataField="ReferrerEmail" HeaderText="Referrer Email" ReadOnly="True"
                        SortExpression="ReferrerEmail" />
                    <asp:BoundField DataField="ReferrerID" HeaderText="Referrer ID" ReadOnly="True" SortExpression="ReferrerID" />                    
                    <asp:BoundField DataField="InvitationTime" HeaderText="Invitation Time" ReadOnly="True"
                        SortExpression="InvitationTime" />
                    <asp:BoundField DataField="SentNotifyCount" HeaderText="Sent Count" ReadOnly="True"
                    SortExpression="SentNotifyCount" />
                    <asp:BoundField DataField="NextEmail" HeaderText="Next Schedule" ReadOnly="True"
                    SortExpression="NextEmail" />
                </Columns>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#999999" />
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=BIRTHDAY\SQLEXPRESS;Initial Catalog=thefreebirthday;User ID=thefreebirthday;pwd=deadFax186"
                ProviderName="System.Data.SqlClient" SelectCommand="SELECT Recipient1 AS FriendName, Email1 AS FriendEmail,  (SELECT TOP 1 ID FROM tblUser WHERE Email = Email1 ORDER BY ID DESC) AS FriendRegID, SenderName AS ReferrerName, SenderEmail AS ReferrerEmail, RegID AS ReferrerID, ISNULL(Email1SentNotifyCount, 0) AS SentNotifyCount, RequestTime AS InvitationTime, Email1NextAutoNotify AS NextEmail FROM Tellafriend WHERE (Tellafriend.id > 271) AND (Email1SentNotifyCount IS NULL OR Email1SentNotifyCount>-1)&#13;&#10;UNION&#13;&#10;SELECT Recipient2 AS FriendName, Email2 AS FriendEmail, (SELECT TOP 1 ID FROM tblUser WHERE Email = Email2 ORDER BY ID DESC) AS FriendRegID, SenderName AS ReferrerName, SenderEmail AS ReferrerEmail, RegID AS ReferrerID, ISNULL(Email2SentNotifyCount, 0) AS SentNotifyCount, RequestTime AS InvitationTime, Email2NextAutoNotify AS NextEmail  FROM Tellafriend WHERE (Tellafriend.id > 271) AND (Email2SentNotifyCount IS NULL OR Email2SentNotifyCount>-1)&#13;&#10;UNION&#13;&#10;SELECT Recipient3 AS FriendName, Email3 AS FriendEmail, (SELECT TOP 1 ID FROM tblUser WHERE Email = Email3 ORDER BY ID DESC) AS FriendRegID, SenderName AS ReferrerName, SenderEmail AS ReferrerEmail, RegID AS ReferrerID, ISNULL(Email3SentNotifyCount, 0) AS SentNotifyCount, RequestTime AS InvitationTime, Email3NextAutoNotify AS NextEmail  FROM Tellafriend WHERE (Tellafriend.id > 271) AND (Email3SentNotifyCount IS NULL OR Email3SentNotifyCount>-1)&#13;&#10;ORDER BY RequestTime DESC&#13;&#10;">
            </asp:SqlDataSource>
        </form>
    </div>
</body>
</html>
