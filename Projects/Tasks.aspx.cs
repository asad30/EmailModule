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
    public partial class Tasks : System.Web.UI.Page
    {
        private double _gridTotalHour = 0;
        private double _gridTotalBill = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                PopulateModule();
            }
            TaskDAL newDal = new TaskDAL();
            Task newTask = PopulateTask();
            IList<Task> tasks = newDal.GetAlltasks(newTask);
            grdTasks.DataSource = tasks;
            grdTasks.DataBind();
            foreach (Task ntask in tasks)
            {
                _gridTotalHour = _gridTotalHour + ntask.Hour;
                _gridTotalBill = _gridTotalBill + Convert.ToDouble(GetBill(ntask.Hour, ntask.Type));
            }
        }
        protected void Page_PreRender()
        {
            IDataReader payReader = (IDataReader)dsPayment.Select(DataSourceSelectArguments.Empty);
            if (payReader.Read())
            {
                lbltxtPayInternalHour.Text = Convert.ToString(payReader["IHour"]);
                lbltxtMaintenanceHour.Text = Convert.ToString(payReader["MHour"]);
                lbltxtDevelopmentHour.Text = Convert.ToString(payReader["DHour"]);
                lblPaid.Text = Convert.ToString(payReader["Payment"]);
                double _totalHour = Convert.ToDouble(payReader["IHour"]) + Convert.ToDouble(payReader["MHour"]) + Convert.ToDouble(payReader["DHour"]);
                double _totalBill = (Convert.ToDouble(payReader["IHour"]) * 8) + (Convert.ToDouble(payReader["MHour"]) * 15) + (Convert.ToDouble(payReader["DHour"]) * 20);
                lblTotalHour.Text = _totalHour.ToString();
                lblTotalBill.Text = _totalBill.ToString();
                lblBalance.Text = (Convert.ToInt32(payReader["Payment"]) - _totalBill).ToString();
            }
            lblGridTotalHour.Text = _gridTotalHour.ToString();
            lblGridTotalBill.Text = _gridTotalBill.ToString();
            IDataReader noteReader = (IDataReader)dsNote.Select(DataSourceSelectArguments.Empty);
            if (noteReader.Read())
            {
                txtNotes.Text = Convert.ToString(noteReader["Note"]);
            }
        }
        protected void grdTasks_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.Cells.Count > 7)
            {
                if (e.Row.Cells[7].Text == "0")
                {
                    e.Row.Cells[7].Text = "New";
                }
                else if (e.Row.Cells[7].Text == "1")
                {
                    e.Row.Cells[7].Text = "In Progress";
                }
                else if (e.Row.Cells[7].Text == "2")
                {
                    e.Row.Cells[7].Text = "Completed";
                }

                if (e.Row.Cells[6].Text == "1")
                {
                    e.Row.Cells[6].Text = "Low";
                }
                else if (e.Row.Cells[6].Text == "2")
                {
                    e.Row.Cells[6].Text = "Moderate";
                }
                else if (e.Row.Cells[6].Text == "3")
                {
                    e.Row.Cells[6].Text = "Normal";
                }
                else if (e.Row.Cells[6].Text == "4")
                {
                    e.Row.Cells[6].Text = "High";
                }
                else if (e.Row.Cells[6].Text == "5")
                {
                    e.Row.Cells[6].Text = "Urgent";
                }

                if (e.Row.Cells[3].Text == "M")
                {
                    e.Row.Cells[3].Text = "Maintenance";
                }
                else if (e.Row.Cells[3].Text == "D")
                {
                    e.Row.Cells[3].Text = "Development";
                }
                else if (e.Row.Cells[3].Text == "I")
                {
                    e.Row.Cells[3].Text = "Internal";
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {            
        }
        public void PopulateModule()
        {
            ModuleDAL newDAL = new ModuleDAL();
            IList<Module> modules = newDAL.GetAllModules();
            foreach (Module module in modules)
            {
                ListItem newItem = new ListItem();
                newItem.Text = module.ModuleName;
                newItem.Value = module.ModuleID.ToString();
                ddlModule.Items.Add(newItem);
            }
        }
        private Task PopulateTask() 
        {
            Task newTask = new Task();
            newTask.ModuleID = Convert.ToInt32(ddlModule.SelectedValue);
            newTask.Type = ddlType.SelectedValue;
            newTask.Priority = Convert.ToInt32(ddlPriority.SelectedValue);
            newTask.CurrentStatus = ddlCurStatus.SelectedValue;
            return newTask;
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
            if (sName.Length > 30)
                return sName.Substring(0, 27) + "...";

            return sName;
        }
                
        protected void grdTasks_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdTasks.PageIndex = e.NewPageIndex;
            grdTasks.DataBind();
        }

        protected void btnAddPayment_Click(object sender, EventArgs e)
        {
            int _payAmount = 0;
            int.TryParse(txtPayAmount.Text, out _payAmount);
            DateTime _payDate = new DateTime();
            DateTime.TryParse(txtPayDate.Text, out _payDate);
            if (_payDate.Year < 2000)
            {
                _payDate = Convert.ToDateTime("01/01/2000");
            }
            Payment newPay = new Payment ();
            newPay.Amount = _payAmount;
            newPay.PaymentDate = _payDate;
            newPay.RecordDate = System.DateTime.Now;
            newPay.Comment = txtPayComment.Text.Trim();
            PaymentDAL newDal = new PaymentDAL();
            newDal.SavePayment(newPay);
            dsPaymentListing.DataBind();
            grdPaymentList.DataBind();
        }

        public string GetBill(object _hour, object type) 
        {
            double _result = 0;
            double hour = 0;
            double.TryParse(_hour.ToString(), out hour);
            if (type.ToString().Equals("I")) 
            {
                _result = hour * 8;
            }
            else if (type.ToString().Equals("M")) 
            {
                _result = hour * 15;
            }
            else if (type.ToString().Equals("D"))
            {
                _result = hour * 20;
            }
            return _result.ToString();
        }

        protected void btnUpdateNote_Click(object sender, EventArgs e)
        {
            dsSaveNote.Insert();
        }
    }
}
