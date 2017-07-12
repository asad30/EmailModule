<%@ Page Language="C#" AutoEventWireup="true" Codebehind="AddModule.aspx.cs" Inherits="EmailModule.Projects.AddModule" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add New Module</title>
    <link href="../Projects/css/Common.css" rel="stylesheet" type="text/css" />
    <h2 style="text-align: center;">
        Add New Module</h2>
</head>
<body>
    <form id="form1" runat="server">
        <div class="BodyContainer">
            <div class="Padding">
                <asp:HyperLink ID="hlTasks" runat="server" NavigateUrl="~/Projects/Tasks.aspx">Tasks</asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:HyperLink ID="hlNewTask" runat="server" NavigateUrl="~/Projects/AddTask.aspx">Create New Task</asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Projects/Modules.aspx">Modules</asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:HyperLink ID="hlNewProject" runat="server" NavigateUrl="~/Projects/AddProject.aspx">Create New Project</asp:HyperLink>
            </div>
            <div>
                <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblName" runat="server" Text="Project Name"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList ID="ddlProject" runat="server">
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
                    <asp:TextBox ID="txtModule" runat="server" Width="500"></asp:TextBox>
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
                    &nbsp;</div>
                <div class="columnSecond">
                    <asp:Button ID="btnSave" runat="server" Text="Save Module" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" /></div>
                <div style="clear: both;">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
