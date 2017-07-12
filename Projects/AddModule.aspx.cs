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
using Entity;
using System.Collections.Generic;

namespace EmailModule.Projects
{
    public partial class AddModule : System.Web.UI.Page
    {
        public int ModuleID
        {
            get
            {
                int _moduleid = 0;
                if (Request.QueryString["moduleid"] != null)
                {
                    int.TryParse(Request.QueryString["moduleid"].ToString(), out _moduleid);
                }
                return _moduleid;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                PopulateProject();
                if (ModuleID > 0)
                {
                    ModuleDAL newDal = new ModuleDAL();
                    Module newModule = newDal.GetModuleByID(ModuleID);
                    PopulateModule(newModule);
                    btnSave.Text = "Update Module";
                }
            }
        }
        private void PopulateProject() 
        {
            ProjectDAL newDAL = new ProjectDAL();
            IList<Project> projects = newDAL.GetAllprojects();
            foreach (Project project in projects)
            {
                ListItem newItem = new ListItem();
                newItem.Text = project.ProjectName;
                newItem.Value = project.ProjectID.ToString();
                ddlProject.Items.Add(newItem);
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveModule();
            Response.Redirect("Modules.aspx");
            lblMsg.Visible = true;
            lblMsg.Text = "Module saved successfully"; 
        }
        protected void SaveModule()
        {
            Module newModule = new Module();
            if (ViewState["moduleid"] != null)
            {
                newModule.ModuleID = Convert.ToInt32(ViewState["moduleid"]);
            }
            newModule.ModuleName = txtModule.Text;
            newModule.ProjectID = Convert.ToInt32(ddlProject.SelectedValue);
            newModule.Description = txtDesc.Text;
            newModule.Creator = GetLoggedUser();
            newModule.CreateDate = System.DateTime.Now;
            ModuleDAL newDal = new ModuleDAL();
            newDal.SaveModule(newModule);
        }
        public string GetLoggedUser()
        {
            string user = string.Empty;
            if (Session["user"] != null)
            {
                user = Session["user"].ToString();
            }
            return user;
        }
        protected void PopulateModule(Module newModule)
        {
            ViewState["moduleid"] = newModule.ModuleID.ToString();
            try
            {
                for (int index = 0; index < ddlProject.Items.Count; index++)
                {
                    if (Convert.ToInt32(ddlProject.Items[index].Value) == newModule.ProjectID)
                    {
                        ddlProject.SelectedIndex = index;
                        break;
                    }
                }
            }
            catch
            {

            }
            txtModule.Text = newModule.ModuleName;
            txtDesc.Text = newModule.Description;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Modules.aspx");
        }
    }
}
