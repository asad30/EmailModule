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
using DAL;

namespace EmailModule.Email
{
    public partial class EmailOpen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int _emailID = 0;
            if (Request.QueryString["emailid"] != null) 
            {
                int.TryParse(Request.QueryString["emailid"].ToString(), out _emailID);
            }
            EmailDeliveryDAL newDal = new EmailDeliveryDAL();
            newDal.UpdateOpenStatus(_emailID, System.DateTime.Now);
            Response.Redirect("../Email/images/blank.PNG");
        }
    }
}
