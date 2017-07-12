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
using Utils;

namespace EmailModule.Email
{
    public partial class GiftCertificate : System.Web.UI.Page
    {
        #region TellYourFriend Properties
        string _userName;

        public string UserName
        {
            get { return _userName; }
            set { _userName = value; }
        }

        string _userEmail;

        public string UserEmail
        {
            get { return _userEmail; }
            set { _userEmail = value; }
        }

        string _firstFriendName;

        public string FirstFriendName
        {
            get { return _firstFriendName; }
            set { _firstFriendName = value; }
        }

        string _firstFriendEmail;

        public string FirstFriendEmail
        {
            get { return _firstFriendEmail; }
            set { _firstFriendEmail = value; }
        }

        string _secondFriendName;

        public string SecondFriendName
        {
            get { return _secondFriendName; }
            set { _secondFriendName = value; }
        }

        string _secondFriendEmail;

        public string SecondFriendEmail
        {
            get { return _secondFriendEmail; }
            set { _secondFriendEmail = value; }
        }

        string _thirdFriendName;

        public string ThirdFriendName
        {
            get { return _thirdFriendName; }
            set { _thirdFriendName = value; }
        }

        string _thirdFriendEmail;

        public string ThirdFriendEmail
        {
            get { return _thirdFriendEmail; }
            set { _thirdFriendEmail = value; }
        }

        string _emailSubject;

        public string EmailSubject
        {
            get { return _emailSubject; }
            set { _emailSubject = value; }
        }

        string _emailBody;

        public string EmailBody
        {
            get { return _emailBody; }
            set { _emailBody = value; }
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Form.Count > 0)
            {
                GetFormValues();
                SendMailToFriends();
            }
        }
        protected void SendMailToFriends()
        {
            SendMail(UserName, FirstFriendName, UserEmail, FirstFriendEmail, EmailSubject, EmailBody);
            SendMail(UserName, SecondFriendName, UserEmail, SecondFriendEmail, EmailSubject, EmailBody);
            SendMail(UserName, ThirdFriendName, UserEmail, ThirdFriendEmail, EmailSubject, EmailBody);
        }
        protected void GetFormValues()
        {
            UserName = Request.Form.Get(Utilities.GetAppSettingString("UserName"));
            UserEmail = Request.Form.Get(Utilities.GetAppSettingString("UserEmail"));

            FirstFriendName = Request.Form.Get(Utilities.GetAppSettingString("FirstFriendName"));
            FirstFriendEmail = Request.Form.Get(Utilities.GetAppSettingString("FirstFriendEmail"));

            SecondFriendName = Request.Form.Get(Utilities.GetAppSettingString("SecondFriendName"));
            SecondFriendEmail = Request.Form.Get(Utilities.GetAppSettingString("SecondFriendEmail"));

            ThirdFriendName = Request.Form.Get(Utilities.GetAppSettingString("ThirdFriendName"));
            ThirdFriendEmail = Request.Form.Get(Utilities.GetAppSettingString("ThirdFriendEmail"));

            EmailSubject = Request.Form.Get(Utilities.GetAppSettingString("EmailSubject"));
            EmailBody = Request.Form.Get(Utilities.GetAppSettingString("EmailBody"));
        }
        protected void SendMail(string myName, string friendName, string myEmail, string friendEmail, string emailSubject, string emailBodyText)
        {
            emailSubject = ReplaceString(emailSubject, myName, friendName);
            emailBodyText = ReplaceString(emailBodyText, myName, friendName);
            string message = MailHelper.SendMailMessage(myEmail, string.Empty, friendEmail, string.Empty, string.Empty, emailSubject, emailBodyText, System.Net.Mail.MailPriority.Normal);
            lblError.Text = message;
            if (string.IsNullOrEmpty(message))
            {
                imgGiftCertificate.ImageUrl = "../TellYourFriend/images/GiftCertificate.jpg";
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
            string giftPage = "http://www.bobwoolard.com/selectyourgifts.asp";
            string clickUrl = "[[here]]";
            if (message.Contains(clickUrl))
            {
                message = message.Replace(clickUrl, "<a href='" + giftPage + "'>here</a>");
            }
            clickUrl = "[here]";
            if (message.Contains(clickUrl))
            {
                message = message.Replace(clickUrl, "<a href='" + giftPage + "'>here</a>");
            }
            return message;
        }
    }
}
