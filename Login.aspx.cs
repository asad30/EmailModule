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

namespace EmailModule
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            if (FormsAuthentication.Authenticate(Login1.UserName, Login1.Password))
            {
                FormsAuthentication.RedirectFromLoginPage(Login1.UserName, false);
                if (!Request.Url.AbsoluteUri.Contains("ReturnUrl"))
                {
                    Response.Redirect("/Email/EmailUsers.aspx");
                }
            } 
        }
    }
}
