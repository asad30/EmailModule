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

namespace EmailModule.Projects
{
    public partial class Modules : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ModuleDAL newDal = new ModuleDAL();
            grdModule.DataSource = newDal.GetAllModules();
            grdModule.DataBind();
        }
        public string GetFormattedName(object oName)
        {
            string sName = string.Empty;

            try
            {
                sName = (string)oName;
            }
            catch
            {
            }
            if (sName.Length > 48)
                return sName.Substring(0, 45) + "...";

            return sName;
        }
    }
}
