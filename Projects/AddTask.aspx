<%@ Page Language="C#" AutoEventWireup="true" Codebehind="AddTask.aspx.cs" Inherits="EmailModule.Projects.AddTask" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add New Task</title>
    <link href="../Projects/css/Common.css" rel="stylesheet" type="text/css" />
    <h2 style="text-align: center;">
        Add New Task</h2>
</head>
<body>
    <form id="form1" runat="server">
        <div class="BodyContainer">
            <div>
                <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblProject" runat="server" Text="Project Name"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList ID="ddlProject" runat="server" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblModule" runat="server" Text="Module Name"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList ID="ddlModule" runat="server">
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblName" runat="server" Text="Task Name"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:TextBox ID="txtName" runat="server" Width="500"></asp:TextBox>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblDesc" runat="server" Text="Description"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:TextBox ID="txtDesc" runat="server" Width="500" TextMode="MultiLine" Height="100"></asp:TextBox>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblType" runat="server" Text="Type"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList ID="ddlType" runat="server">
                        <asp:ListItem Text="Maintenance" Value="M"></asp:ListItem>
                        <asp:ListItem Text="Development" Value="D"></asp:ListItem>
                        <asp:ListItem Text="Internal" Value="I"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblPriority" runat="server" Text="Priority"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList ID="ddlPriority" runat="server">
                        <asp:ListItem Text="Urgent" Value="5"></asp:ListItem>
                        <asp:ListItem Text="High" Value="4"></asp:ListItem>
                        <asp:ListItem Selected="True" Text="Normal" Value="3"></asp:ListItem>
                        <asp:ListItem Text="Moderate" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Low" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblHour" runat="server" Text="Hour"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:TextBox ID="txtHour" runat="server"></asp:TextBox>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <%--<div>
                <div class="columnFirst">
                    <asp:Label ID="lblBudget" runat="server" Text="Budget"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:TextBox ID="txtBudget" runat="server"></asp:TextBox>
                </div>
                <div style="clear: both;">
                </div>
            </div>--%>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblCurStatus" runat="server" Text="Current Status"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList ID="ddlCurStatus" runat="server">
                        <asp:ListItem Text="New" Value="0"></asp:ListItem>
                        <asp:ListItem Text="In Progress" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Completed" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;</div>
                <div class="columnSecond">
                    <asp:Button ID="btnSave" runat="server" Text="Save Task" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" /></div>
                <div style="clear: both;">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
