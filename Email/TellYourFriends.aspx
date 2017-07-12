<%@ Page Language="C#" AutoEventWireup="true" Codebehind="TellYourFriends.aspx.cs"
    Inherits="EmailModule.Email.TellYourFriends" ValidateRequest="false" %>

<%@ Register Src="UserControl/HTMLEditor.ascx" TagName="HTMLEditor" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tell Your Friends</title>
    <link href="../Email/css/TAFform.css" rel="stylesheet" type="text/css" />
    <h2 style="text-align: center;">
        Tell Your Friends
    </h2>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="lblError" runat="server"></asp:Label>
        <div style="margin:20px 0px 0px 150px;">
            <div style="width: 600px; text-align: center;">
                <div class="leftText">
                    <p class="Para">
                        [FName], Free Gift Certificate for you and Free Certificates for your friends just
                        for telling your friends about Free Gift Certificates for everyone!
                    </p>
                </div>
                <div class="middleText">
                    <p>
                        &nbsp;</p>
                    <p class="Para">
                        watch this<br />
                        YouTube video
                    </p>
                </div>
                <div style="clear: both;">
                </div>
                <div class="bottomText">
                    <p class="Para">
                        No cost, No SPAM, No kidding!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Just fill
                        out below.
                    </p>
                </div>
            </div>
            <div class="imageHolder">
                <img src="images/Sample.jpg" width="520" alt="Sample Gift Certificate" />
            </div>
            <div class="titleHolder">
                <p class="Title">
                    fill out below to send an email to your friends and get your $10 Gift Certificate
                    right away!
                </p>
            </div>
            <div class="boxHolder">
                <div class="boxFirstcol">
                    Your Name:
                </div>
                <div class="boxSecondcol">
                    <asp:TextBox ID="txtYourName" Width="220" runat="server"></asp:TextBox>
                </div>
                <div style="clear: both">
                </div>
                <div class="boxFirstcol">
                    Your Email:
                </div>
                <div class="boxSecondcol">
                    <asp:TextBox ID="txtYourEmail" Width="220" runat="server"></asp:TextBox>
                </div>
                <div style="clear: both">
                </div>
            </div>
            <div class="friendSection">
                <div>
                    <div class="friendFirstcol">
                        &nbsp;
                    </div>
                    <div class="friendColumn">
                        Friend's Name
                    </div>
                    <div class="friendColumn">
                        Friend's Email
                    </div>
                    <div style="clear: both">
                    </div>
                </div>
                <div>
                    <div class="friendFirstcol">
                        #1
                    </div>
                    <div class="friendColumn">
                        <asp:TextBox ID="txtFirstFriendName" Width="230" runat="server"></asp:TextBox>
                    </div>
                    <div class="friendColumn">
                        <asp:TextBox ID="txtFirstFriendEmail" Width="230" runat="server"></asp:TextBox>
                    </div>
                    <div style="clear: both">
                    </div>
                </div>
                <div>
                    <div class="friendFirstcol">
                        #2
                    </div>
                    <div class="friendColumn">
                        <asp:TextBox ID="txtSecondFriendName" Width="230" runat="server"></asp:TextBox>
                    </div>
                    <div class="friendColumn">
                        <asp:TextBox ID="txtSecondFriendEmail" Width="230" runat="server"></asp:TextBox>
                    </div>
                    <div style="clear: both">
                    </div>
                </div>
                <div>
                    <div class="friendFirstcol">
                        #3
                    </div>
                    <div class="friendColumn">
                        <asp:TextBox ID="txtThirdFriendName" Width="230" runat="server"></asp:TextBox>
                    </div>
                    <div class="friendColumn">
                        <asp:TextBox ID="txtThirdFriendEmail" Width="230" runat="server"></asp:TextBox>
                    </div>
                    <div style="clear: both">
                    </div>
                </div>
            </div>
            <div class="subjectText">
                <div class="lightPadding">
                    Subject:
                </div>
                <div class="lightPadding">
                    <asp:TextBox ID="txtEmailSubject" Width="500" runat="server" Text="Hey [[friend_name]], check this out.."></asp:TextBox>
                </div>
            </div>
            <div class="subjectText">
                <div class="lightPadding">
                    Body:
                </div>
                <div class="lightPadding" style="width:750px;">                
                    <uc1:HTMLEditor ID="HTMLEditor1" runat="server" />
                    
                </div>
            </div>
            <div class="buttonDiv">
                <asp:Button ID="btnSubmit" runat="server" Text="I Told 3, Send Me My Free Gift" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </form>
</body>
</html>
