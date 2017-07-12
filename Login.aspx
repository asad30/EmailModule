<%@ Page Language="C#" AutoEventWireup="true" Codebehind="Login.aspx.cs" Inherits="EmailModule.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
    <link href="Email/css/Common.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div class="BodyContainer">
        <form id="form1" runat="server">
            <div style="padding: 150px 50px 50px 350px;">
                <asp:Login ID="Login1" runat="server" BackColor="#EFF3FB" BorderColor="#B5C7DE" BorderPadding="4"
                    BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em"
                    ForeColor="#333333" OnAuthenticate="Login1_Authenticate">
                    <TextBoxStyle Font-Size="0.9em" />
                    <LoginButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px"
                        Font-Names="Verdana" Font-Size="0.9em" ForeColor="#284E98" />
                    <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                    <TitleTextStyle BackColor="#507CD1" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
                </asp:Login>
            </div>            
        </form>
    </div>
</body>
</html>
