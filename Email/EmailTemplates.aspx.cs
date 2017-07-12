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
    public partial class EmailTemplates : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TAFDAL newDal = new TAFDAL();
                gvEmailTemplate.DataSource = newDal.GetAllTAFTemplates();
                gvEmailTemplate.DataBind();
            }
        }

        protected void gvEmailTemplate_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName.ToLower())
            {
                case "deletetemplate":
                    DeleteTemplate(e.CommandArgument.ToString());
                    break;
            }
        }

        private void DeleteTemplate(string ID)
        {
            int templateID = int.Parse(ID);
            TAFDAL newDal = new TAFDAL();
            newDal.DeleteTemplate(templateID);
            gvEmailTemplate.DataSource = newDal.GetAllTAFTemplates();
            gvEmailTemplate.DataBind();
        }
    }
}
