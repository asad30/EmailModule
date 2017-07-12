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
using Entity;
using Utils;
using System.Text;

namespace EmailModule.Email
{
    public partial class TellYourFriends : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("Hi [[friend_name]],<br/><br/>");
            sb.AppendLine("It's [[your_name]],<br/><br/>");
            sb.Append("I just found out something so cool,");
            sb.Append(" and YOU were the first person I thought of.");
            sb.Append(" please check it out <a href='http://www.thebirthdayregister.com/selectyourgifts.asp'>here</a>.");
            HTMLEditor1.Text = sb.ToString();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            TellYourFriend newTaf = GetFormValues();
            SendMailToFriends(newTaf);
            Response.Redirect("../Email/images/GiftCertificate.jpg");
        }
        protected void SendMailToFriends(TellYourFriend newTaf)
        {
            SendMail(newTaf.UserName, newTaf.FirstFriendName, newTaf.UserEmail, newTaf.FirstFriendEmail, newTaf.EmailSubject, newTaf.EmailBody);
            SendMail(newTaf.UserName, newTaf.SecondFriendName, newTaf.UserEmail, newTaf.SecondFriendEmail, newTaf.EmailSubject, newTaf.EmailBody);
            SendMail(newTaf.UserName, newTaf.ThirdFriendName, newTaf.UserEmail, newTaf.ThirdFriendEmail, newTaf.EmailSubject, newTaf.EmailBody);
        }
        protected TellYourFriend GetFormValues()
        {
            TellYourFriend newTaf = new TellYourFriend();
            newTaf.UserName = txtYourName.Text;
            newTaf.UserEmail = txtYourEmail.Text;

            newTaf.FirstFriendName = txtFirstFriendName.Text;
            newTaf.FirstFriendEmail = txtFirstFriendEmail.Text;

            newTaf.SecondFriendName = txtSecondFriendName.Text;
            newTaf.SecondFriendEmail = txtSecondFriendEmail.Text;

            newTaf.ThirdFriendName = txtThirdFriendName.Text;
            newTaf.ThirdFriendEmail = txtThirdFriendEmail.Text;

            newTaf.EmailSubject = txtEmailSubject.Text;
            newTaf.EmailBody = HTMLEditor1.Text;
            
            return newTaf;
        }
        protected void SendMail(string myName, string friendName, string myEmail, string friendEmail, string emailSubject, string emailBodyText)
        {
            emailSubject = ReplaceString(emailSubject, myName, friendName);
            emailBodyText = ReplaceString(emailBodyText, myName, friendName);
            string message = MailHelper.SendMailMessage(myEmail, string.Empty, friendEmail, string.Empty, string.Empty, emailSubject, emailBodyText, System.Net.Mail.MailPriority.Normal);
            lblError.Text = message;
            if (string.IsNullOrEmpty(message))
            {
                
            }
        }
        protected string ReplaceString(string message, string myName, string friendName)
        {
            string friendString = "[[friend_name]]";
            if (message.Contains(friendString))
            {
                message = message.Replace(friendString, friendName);
            }
            friendString = "[friend_name]";
            if (message.Contains(friendString))
            {
                message = message.Replace(friendString, friendName);
            }
            string myString = "[[your_name]]";
            if (message.Contains(myString))
            {
                message = message.Replace(myString, myName);
            }
            myString = "[your_name]";
            if (message.Contains(myString))
            {
                message = message.Replace(myString, myName);
            }
            return message;
        }
    }
}
