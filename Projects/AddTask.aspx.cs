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
using System.Collections.Generic;
using Entity;

namespace EmailModule.Projects
{
    public partial class AddTask : System.Web.UI.Page
    {
        public int TaskID
        {
            get
            {
                int _taskid = 0;
                if (Request.QueryString["taskid"] != null)
                {
                    int.TryParse(Request.QueryString["taskid"].ToString(), out _taskid);
                }
                return _taskid;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateProject();
                PopulateModule();
                if (TaskID > 0)
                {
                    TaskDAL newDal = new TaskDAL();
                    Task newTask = newDal.GetTaskByID(TaskID);
                    PopulateTask(newTask);
                    btnSave.Text = "Update Task";
                }                
            }
        }

        protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateModule();
        }

        public void PopulateModule()
        {
            ModuleDAL newDAL = new ModuleDAL();
            IList<Module> modules = newDAL.GetAllModulesByProjectID(Convert.ToInt32(ddlProject.SelectedValue));
            ddlModule.Items.Clear();
            foreach (Module module in modules)
            {
                ListItem newItem = new ListItem();
                newItem.Text = module.ModuleName;
                newItem.Value = module.ModuleID.ToString();
                ddlModule.Items.Add(newItem);
            }
        }
        public void PopulateProject()
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
            SaveTask();
            Response.Redirect("Tasks.aspx");
            lblMsg.Visible = true;
            lblMsg.Text = "Task saved successfully";
        }
        protected void SaveTask()
        {
            Task newTask = new Task();
            if (ViewState["taskid"] != null) 
            {
                newTask.TaskID = Convert.ToInt32(ViewState["taskid"]);
            }            
            newTask.Billed = false;
            int _budget = 0;
            //int.TryParse(txtBudget.Text, out _budget);
            newTask.Budget = _budget;
            newTask.CurrentStatus = ddlCurStatus.SelectedValue;
            double _hour = 0.0;
            double.TryParse(txtHour.Text, out _hour);
            newTask.Hour = _hour;
            newTask.ModuleID = Convert.ToInt32(ddlModule.SelectedValue);
            newTask.ProjectID = Convert.ToInt32(ddlProject.SelectedValue);
            newTask.Description = txtDesc.Text;
            newTask.Creator = GetLoggedUser();
            newTask.CreateDate = System.DateTime.Now;
            newTask.Priority = Convert.ToInt32(ddlPriority.SelectedValue); ;
            newTask.TaskName = txtName.Text;
            newTask.Type = ddlType.SelectedValue;
            TaskDAL newDal = new TaskDAL();
            newDal.SaveTask(newTask);
        }
        protected void PopulateTask(Task newTask)
        {
            ViewState["taskid"] = newTask.TaskID.ToString();
            try
            {
                for (int index = 0; index < ddlProject.Items.Count; index++)
                {
                    if (Convert.ToInt32(ddlProject.Items[index].Value) == newTask.ProjectID)
                    {
                        ddlProject.SelectedIndex = index;
                        break;
                    }
                }
            }
            catch
            {

            }
            try
            {
                for (int index = 0; index < ddlModule.Items.Count; index++)
                {
                    if (Convert.ToInt32(ddlModule.Items[index].Value) == newTask.ModuleID)
                    {
                        ddlModule.SelectedIndex = index;
                        break;
                    }
                }
            }
            catch
            {

            }
            txtName.Text = newTask.TaskName;
            txtDesc.Text = newTask.Description;
            if (newTask.Type.Equals("M"))
            {
                ddlType.Items[0].Selected = true;
            }
            else if (newTask.Type.Equals("D"))
            {
                ddlType.Items[1].Selected = true;
            }
            else
            {
                ddlType.Items[2].Selected = true;
            }
            try
            {
                ddlPriority.SelectedIndex = 5 - newTask.Priority;
            }
            catch
            {

            }
            txtHour.Text = newTask.Hour.ToString();
            try
            {
                ddlCurStatus.SelectedIndex = Convert.ToInt32(newTask.CurrentStatus);
            }
            catch
            {
            }
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
