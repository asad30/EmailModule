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

namespace EmailModule.Email.UserControl
{
    public partial class HTMLEditor : System.Web.UI.UserControl
    {
        public string Text
        {
            get { return txtEditor.Text; }
            set { txtEditor.Text = value; }
        }        
        public bool Visible
        {
            get { return txtEditor.Visible; }
            set { txtEditor.Visible = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}