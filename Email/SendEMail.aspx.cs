using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
using Utils;
using Entity;
using DAL;
using System.Collections.Generic;
using System.Net.Mail;

namespace EmailModule.Email
{
    public partial class SendEMail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TAFDAL newTAF = new TAFDAL();
                IList<TAFTemplate> templates = newTAF.GetAllTAFTemplates();
                foreach (TAFTemplate template in templates)
                {
                    ListItem item = new ListItem();
                    item.Text = template.TemplateName;
                    item.Value = template.TemplateID.ToString();
                    ddlSelectTemplate.Items.Add(item);
                }
                if (Session["Users"] != null) 
                {
                    txtUserIDs.Text = Session["Users"].ToString();
                    Session["Users"] = null;
                }
            }
        }

        protected void btnSendMail_Click(object sender, EventArgs e)
        {
            SendMailtoAll();
            txtUserIDs.Text = string.Empty;
        }
        protected string CreateEmailBody(string name) 
        {
            char[] separator = { ' ' };
            string[] names = name.Split(separator);
            string fName = string.Empty;
            string lName = string.Empty;
            string fNameText = string.Empty;
            if (names.Length > 1)
            {
                fName = names[0];
                lName = names[1];
            }
            fName = Utilities.UppercaseFirst(fName);
            if (!string.IsNullOrEmpty(fName)) 
            {
                fNameText = fName + ", " ;
            }
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<form action='http://www.thebirthdayregister.com/Email/GiftCertificate.aspx' method='post'>");
            sb.AppendLine("<div style='width: 600px; text-align: center;'>");
            sb.AppendLine("<div style='width: 320px; text-align: left; float: left;'>");
            sb.AppendLine("<p style='font-family: Arial; font-weight: bold; font-size: 18px; font-style: italic;'>");
            sb.AppendFormat("{0}", fNameText);
            sb.AppendLine("Free Gift Certificate for you and Free Certificates for your friends just");
            sb.AppendLine("for telling your friends about Free Gift Certificates for everyone!");
            sb.AppendLine("</p>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='width: 240px; text-align: center; float: right; vertical-align:middle;'>");
            sb.AppendLine("<p>&nbsp;</p>");
            sb.AppendLine("<p style='font-family: Arial; font-weight: bold; font-size: 18px; font-style: italic;'>");
            sb.AppendLine("watch this<br /> YouTube video");
            sb.AppendLine("</p>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='clear: both;'>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='margin: -15px 0px 5px 0px; text-align: left;'>");
            sb.AppendLine("<p style='font-family: Arial; font-weight: bold; font-size: 18px; font-style: italic;'>");
            sb.AppendLine("No cost, No SPAM, No kidding!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Just fill");
            sb.AppendLine("out below.");
            sb.AppendLine("</p>");
            sb.AppendLine("</div>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='width: 600px; text-align: center;'>");
            sb.AppendLine("<img src='http://www.thebirthdayregister.com/Email/images/Sample.jpg' width='520' alt='Sample Gift Certificate' />");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='width: 620px; margin: 10px 0px 10px 0px;'>");
            sb.AppendLine("<p style='font-family: Times New Roman; font-size:15px; font-weight: bold; font-style: italic;'>");
            sb.AppendLine("fill out below to send an email to your friends and get your $10 Gift Certificate");
            sb.AppendLine("right away!");
            sb.AppendLine("</p>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='background-color: #2F5B8A; font-family: Arial; font-weight: bold; color: White;");
            sb.AppendLine("width: 600px;'>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; width: 90px;'>");
            sb.AppendLine("Your Name:");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; z-index: 100;'>");
            sb.AppendLine("<input id='txtYourName' name='txtYourName' type='text' style='width: 220px;' />");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='clear: both'>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; width: 90px;'>");
            sb.AppendLine("Your Email:");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; z-index: 100;'>");
            sb.AppendLine("<input id='txtYourEmail' name='txtYourEmail' type='text' style='width: 220px;' />");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='clear: both'>");
            sb.AppendLine("</div>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='width: 600px; margin-top: 15px; font-family: Arial; font-weight: bold;'>");
            sb.AppendLine("<div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; width: 20px;'>");
            sb.AppendLine("&nbsp;");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; z-index: 100; width: 270px;'>");
            sb.AppendLine("Friend's Name");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; z-index: 100; width: 270px;'>");
            sb.AppendLine("Friend's Email");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='clear: both'>");
            sb.AppendLine("</div>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; width: 20px;'>");
            sb.AppendLine("#1");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; z-index: 100; width: 270px;'>");
            sb.AppendLine("<input id='txtFirstFriendName' name='txtFirstFriendName' type='text' style='width: 230px' />");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; z-index: 100; width: 270px;'>");
            sb.AppendLine("<input id='txtFirstFriendEmail' name='txtFirstFriendEmail' type='text' style='width: 230px' />");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='clear: both'>");
            sb.AppendLine("</div>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; width: 20px;'>");
            sb.AppendLine("#2");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; z-index: 100; width: 270px;'>");
            sb.AppendLine("<input id='txtSecondFriendName' name='txtSecondFriendName' type='text' style='width: 230px' />");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; z-index: 100; width: 270px;'>");
            sb.AppendLine("<input id='txtSecondFriendEmail' name='txtSecondFriendEmail' type='text' style='width: 230px' />");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='clear: both'>");
            sb.AppendLine("</div>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; width: 20px;'>");
            sb.AppendLine("#3");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; z-index: 100; width: 270px;'>");
            sb.AppendLine("<input id='txtThirdFriendName' name='txtThirdFriendName' type='text' style='width: 230px' />");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px; float: left; z-index: 100; width: 270px;'>");
            sb.AppendLine("<input id='txtThirdFriendEmail' name='txtThirdFriendEmail' type='text' style='width: 230px' />");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='clear: both'>");
            sb.AppendLine("</div>");
            sb.AppendLine("</div>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 20px 0px 0px 0px; font-family: Arial; font-weight: bold;'>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px;'>");
            sb.AppendLine("Subject:");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px;'>");
            sb.AppendLine("<input id='txtEmailSubject' name='txtEmailSubject' type='text' style='width: 500px'");
            sb.AppendLine("value='Hey [[friend_name]], check this out..' />");
            sb.AppendLine("</div>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 20px 0px 0px 0px; font-family: Arial; font-weight: bold;'>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px;'>");
            sb.AppendLine("Body:");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='padding: 5px 5px 5px 5px;'>");
            sb.AppendLine("<textarea id='txtEmailBody' name='txtEmailBody' style='width: 500px' rows='4'>Hi [[friend_name]], ");
            sb.AppendLine("");
            sb.AppendLine("It's [[your_name]],");
            sb.AppendLine("");
            sb.AppendLine("I just found out something so cool, and YOU were the first person I thought of. please check it out [[here]].</textarea>");
            sb.AppendLine("</div>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div style='text-align: center; padding-top: 10px; width: 500px;'>");
            sb.AppendLine("<input id='Submit1' type='submit' name='Submit1' value='I Told 3, Send Me My Free Gift' />");
            sb.AppendLine("</div>");
            sb.AppendLine("</form>");
            return sb.ToString();
        }
        protected void SendMailtoAll() 
        {
            string userIDs = txtUserIDs.Text;
            char[] separator = {','};
            string[] Ids = userIDs.Split(separator);
            int count = 0;
            StringBuilder sb = new StringBuilder(); 
            foreach (string ID in Ids)
            {
                int userId = 0;
                if (int.TryParse(ID, out userId))
                {
                    string status = SendMail(userId);
                    if (string.IsNullOrEmpty(status))
                    {
                        count++;
                    }
                    else 
                    {
                        sb.AppendFormat("For {0} : {1} <br/>",userId, status);
                    }
                }
            }
            sb.AppendFormat("{0} mail(s) Sent Successfully.", count);
            lblError.Text = sb.ToString();
        }
        protected string SendMail(int id)
        {
            Entity.User newUser = new Entity.User();
            DataAccess newDataAccess = new DataAccess();
            newUser = newDataAccess.GetUser(id);
            string emailBodyText = Utilities.ReplaceTokens(HTMLEditor1.Text, newUser);
            emailBodyText = ReplaceImageSource(emailBodyText);
            string emailSubject = Utilities.ReplaceTokens(txtEmailSubject.Text, newUser);
            string message = MailHelper.SendMailMessage(txtFromEmail.Text, string.Empty, newUser.Email, string.Empty, string.Empty, emailSubject, emailBodyText, MailPriority.Normal);
            lblError.Text = message; 
            return message;
        }
        protected void ddlSelectTemplate_SelectedIndexChanged(object sender, EventArgs e)
        {
            int templateID = 0;
            txtFromEmail.Text = string.Empty;
            txtEmailSubject.Text = string.Empty;
            HTMLEditor1.Text = string.Empty;
            int.TryParse(ddlSelectTemplate.SelectedValue, out templateID);
            if (templateID > 0) 
            {
                TAFDAL newTAF = new TAFDAL();
                TAFTemplate template = newTAF.GetTAFTemplateByID(templateID);
                txtFromEmail.Text = template.FromEmail; 
                txtEmailSubject.Text = template.EmailSubject;
                HTMLEditor1.Text = template.EmailBody;
            } 
        }
        protected string ReplaceImageSource(string replacableString) 
        {
            replacableString = replacableString.Replace("src=\"..", "src=\"http://bobwoolard.com");
            return replacableString;
        }
        
    }
}
