<%@ Page Language="C#" AutoEventWireup="true" Codebehind="Tasks.aspx.cs" Inherits="EmailModule.Projects.Tasks" %>

<%@ Register Src="../Email/UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tasks</title>
    <link href="../Projects/css/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript" src="../Projects/js/jquery-1.4.1.min.js"></script>

    <script type="text/javascript">
      $(document).ready(function() {
        $('.toggler').toggle(function() {
            $('.showPayment').show('fast');
            $(".toggler").text("Hide Payment history")
        }, function() {
            $('.showPayment').hide('fast');
            $(".toggler").text("Add Payment history")
        });
      });
    </script>

    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <uc1:Menu ID="Menu1" runat="server" />
        <h2 style="text-align: center;">
            Tasks</h2>
        <div class="BodyContainer">
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblModule" runat="server" Text="Module Name"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList ID="ddlModule" runat="server">
                        <asp:ListItem Selected="True" Text="--Select All--" Value="-1"></asp:ListItem>
                    </asp:DropDownList>
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
                        <asp:ListItem Selected="True" Text="--Select All--" Value=""></asp:ListItem>
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
                        <asp:ListItem Selected="True" Text="--Select All--" Value="-1"></asp:ListItem>
                        <asp:ListItem Text="Urgent" Value="5"></asp:ListItem>
                        <asp:ListItem Text="High" Value="4"></asp:ListItem>
                        <asp:ListItem Text="Normal" Value="3"></asp:ListItem>
                        <asp:ListItem Text="Moderate" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Low" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblCurStatus" runat="server" Text="Current Status"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList ID="ddlCurStatus" runat="server">
                        <asp:ListItem Selected="True" Text="--Select All--" Value=""></asp:ListItem>
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
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div class="Padding">
                <asp:HyperLink ID="hlNewTask" runat="server" NavigateUrl="~/Projects/AddTask.aspx">Create New Task</asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Projects/Modules.aspx">Modules</asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:HyperLink ID="hlNewModule" runat="server" NavigateUrl="~/Projects/AddModule.aspx">Create New Module</asp:HyperLink>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:HyperLink ID="hlNewProject" runat="server" NavigateUrl="~/Projects/AddProject.aspx">Create New Project</asp:HyperLink>
            </div>
            <asp:GridView ID="grdTasks" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None"
                AutoGenerateColumns="False" OnRowDataBound="grdTasks_RowDataBound" EmptyDataText="No record is matched with the search criterion."
                AllowPaging="true" PageSize="10" OnPageIndexChanging="grdTasks_PageIndexChanging">
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Height="34" />
                <EditRowStyle BackColor="#999999" />
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:TemplateField HeaderText="Module">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblModuleName" Text='<%# GetFormattedName(Eval("ModuleName")) %>' />
                        </ItemTemplate>
                        <ItemStyle CssClass="gridSeparator" HorizontalAlign="Left" />
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Task">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblTaskName" Text='<%# GetFormattedName(Eval("TaskName")) %>' />
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
                    <asp:BoundField DataField="Type" HeaderText="Type" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Hour" HeaderText="Hour" ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderText="Bill" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblTaskName" Text='<%# GetBill(Eval("Hour"), Eval("Type")) %>' />
                        </ItemTemplate>
                        <ItemStyle CssClass="gridSeparator" HorizontalAlign="Center" />
                        <HeaderStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Priority" HeaderText="Priority" />
                    <asp:BoundField DataField="CurrentStatus" HeaderText="Status" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="hlEditTask" runat="server" Target="_blank" NavigateUrl='<%# String.Format("AddTask.aspx?taskid={0}", DataBinder.Eval(Container.DataItem,"TaskID")) %>'
                                Text="Edit"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <div style="width: 925px;">
                <hr />
            </div>
            <div style="padding-left: 600px;">
                <asp:Label ID="lbltxtGridTotalHour" runat="server" Text="Total : "></asp:Label>
                <asp:Label ID="lblGridTotalHour" runat="server"></asp:Label>
                hour and
                <asp:Label ID="lbltxtGridTotalBill" runat="server" Text="Bill: "></asp:Label>
                <asp:Label ID="lblGridTotalBill" runat="server"></asp:Label>$
            </div>
            <div>
                <h2 style="text-align: left;">
                    Payment <span style="font-size: medium; font-weight: normal;">(for Completed tasks only)</span></h2>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnFirst" style="width: 200px;">
                    <asp:Label ID="lblPayInternalHour" runat="server" Text="Total Internal Hour:"></asp:Label>
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lbltxtPayInternalHour" runat="server"></asp:Label>
                </div>
                <div class="columnFirst" style="width: 200px;">
                    <asp:Label ID="lblICharge" runat="server" Text="Charge Per Hour:"></asp:Label>
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lbltxtICharge" runat="server" Text="8$"></asp:Label>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnFirst" style="width: 200px;">
                    <asp:Label ID="lblMaintenanceHour" runat="server" Text="Total Maintenance Hour:"></asp:Label>
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lbltxtMaintenanceHour" runat="server"></asp:Label>
                </div>
                <div class="columnFirst" style="width: 200px;">
                    <asp:Label ID="lblMCharge" runat="server" Text="Charge Per Hour:"></asp:Label>
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lbltxtMCharge" runat="server" Text="15$"></asp:Label>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnFirst" style="width: 200px;">
                    <asp:Label ID="lblDevelopmentHour" runat="server" Text="Total Development Hour:"></asp:Label>
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lbltxtDevelopmentHour" runat="server"></asp:Label>
                </div>
                <div class="columnFirst" style="width: 200px;">
                    <asp:Label ID="lblDCharge" runat="server" Text="Charge Per Hour:"></asp:Label>
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lbltxtDCharge" runat="server" Text="20$"></asp:Label>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnFirst" style="width: 560px;">
                    <hr />
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lbltxtTotalHour" runat="server" Text="Total Hour : "></asp:Label>
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lblTotalHour" runat="server"></asp:Label>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lbltxtTotalBill" runat="server" Text="Total Bill : "></asp:Label>
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lblTotalBill" runat="server"></asp:Label>
                </div>
                <div class="columnFirst" style="width: 200px;">
                    <a href="javascript:void(0)" class="toggler">Add Payment history</a>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lbltxtPaid" runat="server" Text="Total Paid : "></asp:Label>
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lblPaid" runat="server"></asp:Label>
                </div>
                <div class="columnFirst showPayment" style="width: 400px; display: none;">
                    <div class="columnFirst">
                        <asp:Label ID="lblPayAmount" runat="server" Text="Amount: "></asp:Label>
                    </div>
                    <div class="columnFirst">
                        <asp:TextBox ID="txtPayAmount" runat="server"></asp:TextBox>
                    </div>
                    <div style="clear: both;">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblPayDate" runat="server" Text="Payment Date: "></asp:Label>
                    </div>
                    <div class="columnFirst">
                        <asp:TextBox ID="txtPayDate" runat="server"></asp:TextBox>
                    </div>
                    <div style="clear: both;">
                    </div>
                    <div class="columnFirst">
                        <asp:Label ID="lblPayComment" runat="server" Text="Comment: "></asp:Label>
                    </div>
                    <div class="columnFirst">
                        <asp:TextBox ID="txtPayComment" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div style="clear: both;">
                    </div>
                    <div class="columnFirst">
                        &nbsp;
                    </div>
                    <div class="columnFirst">
                        <asp:Button ID="btnAddPayment" runat="server" ValidationGroup="AddPayment" Text="Update Payment"
                            OnClick="btnAddPayment_Click" />
                    </div>
                    <div style="clear: both;">
                    </div>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnFirst" style="width: 560px;">
                    <hr />
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lbltxtBalance" runat="server" Text="Balance : "></asp:Label>
                </div>
                <div class="columnFirst">
                    <asp:Label ID="lblBalance" runat="server"></asp:Label>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <asp:SqlDataSource ID="dsPayment" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnect %>"
                SelectCommand="Payment_Get" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"
                CancelSelectOnNullParameter="False"></asp:SqlDataSource>
            <div>
                <h2 style="text-align: left;">
                    Payment History:</h2>
            </div>
            <div style="padding: 10px 10px 10px 150px">
                <asp:GridView ID="grdPaymentList" runat="server" CellPadding="4" DataSourceID="dsPaymentListing"
                    ForeColor="#333333" GridLines="None">
                    <RowStyle BackColor="#EFF3FB" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </div>
            <asp:SqlDataSource ID="dsPaymentListing" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnect %>"
                SelectCommand="Payment_GetALL" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"
                CancelSelectOnNullParameter="False"></asp:SqlDataSource>
            <div>
                <h2 style="text-align: left;">
                    Note: <span style="font-size: medium; font-weight: normal;">(special instruction)</span></h2>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnFirst">
                    <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Height="300" Width="700"></asp:TextBox>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnFirst">
                    <asp:Button ID="btnUpdateNote" runat="server" Text="Update Note" OnClick="btnUpdateNote_Click" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <asp:SqlDataSource ID="dsNote" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnect %>"
                ProviderName="System.Data.SqlClient" SelectCommand="SELECT [ID], [Note] FROM [Notes]"
                DataSourceMode="DataReader"></asp:SqlDataSource>
            <asp:SqlDataSource ID="dsSaveNote" runat="server" ConnectionString="<%$ ConnectionStrings:dbConnect %>"
                ProviderName="System.Data.SqlClient" InsertCommand="UPDATE Notes SET [Note] = @Note"
                CancelSelectOnNullParameter="False">
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtNotes" Name="Note" ConvertEmptyStringToNull="true"
                        PropertyName="Text" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
