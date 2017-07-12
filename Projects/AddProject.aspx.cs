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
using DAL;

namespace EmailModule.Projects
{
    public partial class AddProject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveProject();
            lblMsg.Visible = true;
            lblMsg.Text = "Project saved successfully";   
        }
        protected void SaveProject()
        {
            Project newProject = new Project();
            newProject.ProjectName = txtName.Text;
            newProject.Description = txtDesc.Text;
            newProject.Creator = GetLoggedUser();
            newProject.CreateDate = System.DateTime.Now;
            ProjectDAL newDal = new ProjectDAL();
            newDal.SaveProject(newProject);
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

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Tasks.aspx");
        }
    }
}
