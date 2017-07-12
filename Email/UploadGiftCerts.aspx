<%@ Page Language="C#" AutoEventWireup="true" Codebehind="UploadGiftCerts.aspx.cs"
    Inherits="EmailModule.Email.UploadGiftCerts" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="UserControl/Menu.ascx" TagName="Menu" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Upload Gift Certificates</title>
    <link href="../Email/css/Common.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
    <link href="../../Email/css/pantheonMenu.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" language="javascript" src="../Email/js/jquery-1.4.1.min.js"></script>

    <script type="text/javascript">
    $(document).ready(function() {
        $(".imageSelector").change(function(){
            $('#GiftCertGraphics').attr("src", $(".imageSelector option:selected").val());
            $('#GiftCertGraphics').css("height", "150px");
        });
    });
    </script>
</head>
<body>
    <uc2:Menu ID="Menu1" runat="server"></uc2:Menu>
    <h2 style="text-align: center;">
        Upload Gift Certificates</h2>
    <form id="form1" runat="server">
        <div>
            <h3 style="text-align: left; padding-left: 8px;">
                Upload Gift Certificates
            </h3>
            <div>
                <asp:Label ID="lblMsg" runat="server" CssClass="msg"></asp:Label>
                <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblCert1" runat="server" Text="Certificate 1"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblCert2" runat="server" Text="Certificate 2"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:FileUpload ID="FileUpload2" runat="server" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblCert3" runat="server" Text="Certificate 3"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:FileUpload ID="FileUpload3" runat="server" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblCert4" runat="server" Text="Certificate 4"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:FileUpload ID="FileUpload4" runat="server" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblCert5" runat="server" Text="Certificate 5"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:FileUpload ID="FileUpload5" runat="server" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;</div>
                <div class="columnSecond">
                    <asp:Button ID="btnSave" runat="server" Text="Save Certificates" OnClick="btnSave_Click" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <h3 style="text-align: left; padding-left: 8px;">
                Delete Gift Certificate
            </h3>
            <div>
                <asp:Label ID="lblDelMsg" runat="server" CssClass="msg"></asp:Label>
                <asp:Label ID="lblDelError" runat="server" CssClass="error"></asp:Label>
            </div>
            <div>
                <div class="columnFirst">
                    <asp:Label ID="lblImageSelector" runat="server" Text="Certificate"></asp:Label>
                </div>
                <div class="columnSecond">
                    <asp:DropDownList CssClass="imageSelector" ID="ddlImageSelector" runat="server" AutoPostBack="false">
                        <asp:ListItem Value="../Email/images/blank.PNG" Selected="True" Text="-- Select Image --"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;
                </div>
                <div class="columnSecond">
                   <img id="GiftCertGraphics" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div>
                <div class="columnFirst">
                    &nbsp;</div>
                <div class="columnSecond">
                    <asp:Button ID="btnDel" runat="server" Text="Delete Certificate" OnClick="btnDel_Click" OnClientClick="return confirm('Are you sure you want to delete?')" />
                </div>
                <div style="clear: both;">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
