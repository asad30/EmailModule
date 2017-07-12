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
using Utils;

namespace EmailModule.Email
{
    public partial class EmailSendSearch : System.Web.UI.Page
    {
        private int _pageSize = 20;

        public int PageSize
        {
            get { return _pageSize; }
            set { _pageSize = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            gvEmailSchedule.PageSize = PageSize;
            if (!IsPostBack)
            {
                CompanyDAL newCompanyDal = new CompanyDAL();
                IList<Company> companies = newCompanyDal.GetAllCompany();
                foreach (Company company in companies)
                {
                    ListItem item = new ListItem();
                    item.Text = company.CompanyName.Substring(0,company.CompanyName.Length>45?45:company.CompanyName.Length);
                    item.Value = company.CompanyRegID.ToString();
                    ddlSearchCompany.Items.Add(item);
                }

                TAFDAL newTAF = new TAFDAL();
                IList<TAFTemplate> templates = newTAF.GetAllTAFTemplates();
                foreach (TAFTemplate template in templates)
                {
                    ListItem item = new ListItem();
                    item.Text = template.TemplateName;
                    item.Value = template.TemplateID.ToString();
                    ddlSearchTemplate.Items.Add(item);
                }
            }
        }

        protected void btnShowReport_Click(object sender, EventArgs e)
        {
            EmailScheduleSearch scheduleSearch = PopulateSearchEntity();
            EmailScheduleDAL newDal = new EmailScheduleDAL();
            IList<EmailScheduleResult> schedules = newDal.SearchEmailSchedule(scheduleSearch);
            gvEmailSchedule.PageIndex = 0;
            gvEmailSchedule.DataSource = schedules;
            gvEmailSchedule.DataBind();
            if (schedules.Count > PageSize)
            {
                lblResult.Text = string.Format("Showing result(s) 1-{0} of {1}", PageSize, schedules.Count.ToString());
            }
            else if (schedules.Count > 0)
            {
                lblResult.Text = string.Format("Showing result(s) 1-{0} of {0}", schedules.Count.ToString());
            }
            else
            {
                lblResult.Text = string.Empty;
            }
        }

        protected void lbExport_Click(object sender, EventArgs e)
        {
            EmailScheduleSearch scheduleSearch = PopulateSearchEntity();
            EmailScheduleDAL newDal = new EmailScheduleDAL();
            DataTable dataTable = newDal.SearchEmailScheduleTable(scheduleSearch);
            string FileName = string.Format("EmailSchedule{0}.csv", System.DateTime.Now.ToFileTime().ToString());
            Export newExport = new Export("Web");
            int[] ColList = { 1, 2, 3, 4, 5, 12, 14, 17, 18, 19, 20, 21, 22 };
            newExport.ExportDetails(dataTable, ColList, Export.ExportFormat.CSV, FileName, string.Empty);
        }

        private EmailScheduleSearch PopulateSearchEntity() 
        {
            EmailScheduleSearch newSchedule = new EmailScheduleSearch();
            newSchedule.FirstName = txtSearchFName.Text.Trim();
            newSchedule.LastName = txtSearchLName.Text.Trim();
            newSchedule.Email = txtSearchEmail.Text.Trim();
            if (!string.IsNullOrEmpty(txtSearchRegID.Text.Trim()))
            {
                int regId = -1;
                int.TryParse(txtSearchRegID.Text.Trim(), out regId);
                newSchedule.RegID = regId;
            }
            newSchedule.ZipCode = txtSearchZip.Text.Trim();
            newSchedule.BdayStartDate = Convert.ToDateTime(ddlSearchBdayStartMonth.SelectedValue + "/" + ddlSearchBdayStartDay.SelectedValue + "/2000");
            newSchedule.BdayEndDate = Convert.ToDateTime(ddlSearchBdayEndMonth.SelectedValue + "/" + ddlSearchBdayEndDay.SelectedValue + "/2000");
            if (ddlSearchActive.SelectedValue.Equals("1"))
            {
                newSchedule.Active = true;
            }
            else if (ddlSearchActive.SelectedValue.Equals("0"))
            {
                newSchedule.Active = false;
            }
            else
            {
                newSchedule.Active = null;
            }
            if (!string.IsNullOrEmpty(ddlSearchCompany.SelectedValue))
            {
                int companyId = -1;
                int.TryParse(ddlSearchCompany.SelectedValue, out companyId);
                newSchedule.CompanyID = companyId;
            }
            if (!string.IsNullOrEmpty(ddlSearchTemplate.SelectedValue))
            {
                int templateId = -1;
                int.TryParse(ddlSearchTemplate.SelectedValue, out templateId);
                newSchedule.TemplateID = templateId;
            }
            if (!string.IsNullOrEmpty(txtSearchBatchID.Text.Trim()))
            {
                int emailBatchID = -1;
                int.TryParse(txtSearchBatchID.Text.Trim(), out emailBatchID);
                newSchedule.EmailContentID = emailBatchID;
            }
            int status = -1;
            int.TryParse(ddlSeachStatus.SelectedValue, out status);
            newSchedule.Status = status;
            if (string.IsNullOrEmpty(txtSearchRequestStart.Text.Trim()))
            {
                newSchedule.RequestSearchStart = Convert.ToDateTime("1/1/1900");
            }
            else
            {
                newSchedule.RequestSearchStart = Convert.ToDateTime(txtSearchRequestStart.Text.Trim());
            }

            if (string.IsNullOrEmpty(txtSearchRequestEnd.Text.Trim()))
            {
                newSchedule.RequestSearchEnd = Convert.ToDateTime("1/1/2099");
            }
            else
            {
                newSchedule.RequestSearchEnd = Convert.ToDateTime(txtSearchRequestEnd.Text.Trim());
                newSchedule.RequestSearchEnd = newSchedule.RequestSearchEnd.AddDays(1);
            }
            if (string.IsNullOrEmpty(txtSearchScheduleStart.Text.Trim()))
            {
                newSchedule.ScheduleSearchStart = Convert.ToDateTime("1/1/1900");
            }
            else
            {
                newSchedule.ScheduleSearchStart = Convert.ToDateTime(txtSearchScheduleStart.Text.Trim());
            }

            if (string.IsNullOrEmpty(txtSearchScheduleEnd.Text.Trim()))
            {
                newSchedule.ScheduleSearchEnd = Convert.ToDateTime("1/1/2099");
            }
            else
            {
                newSchedule.ScheduleSearchEnd = Convert.ToDateTime(txtSearchScheduleEnd.Text.Trim());
                newSchedule.ScheduleSearchEnd = newSchedule.ScheduleSearchEnd.AddDays(1);
            }
            if (string.IsNullOrEmpty(txtSearchSentStart.Text.Trim()))
            {
                newSchedule.SendSearchStart = Convert.ToDateTime("1/1/1900");
            }
            else
            {
                newSchedule.SendSearchStart = Convert.ToDateTime(txtSearchSentStart.Text.Trim());
            }

            if (string.IsNullOrEmpty(txtSearchSentEnd.Text.Trim()))
            {
                newSchedule.SendSearchEnd = Convert.ToDateTime("1/1/2099");
            }
            else
            {
                newSchedule.SendSearchEnd = Convert.ToDateTime(txtSearchSentEnd.Text.Trim());
                newSchedule.SendSearchEnd = newSchedule.SendSearchEnd.AddDays(1);
            }
            if (string.IsNullOrEmpty(txtSearchOpenedStart.Text.Trim()))
            {
                newSchedule.OpenSearchStart = Convert.ToDateTime("1/1/1900");
            }
            else
            {
                newSchedule.OpenSearchStart = Convert.ToDateTime(txtSearchOpenedStart.Text.Trim());
            }

            if (string.IsNullOrEmpty(txtSearchOpenedEnd.Text.Trim()))
            {
                newSchedule.OpenSearchEnd = Convert.ToDateTime("1/1/2099");
            }
            else
            {
                newSchedule.OpenSearchEnd = Convert.ToDateTime(txtSearchOpenedEnd.Text.Trim());
                newSchedule.OpenSearchEnd = newSchedule.OpenSearchEnd.AddDays(1);
            }
            return newSchedule;
        }

        protected void gvEmailSchedule_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            EmailScheduleSearch scheduleSearch = PopulateSearchEntity();
            EmailScheduleDAL newDal = new EmailScheduleDAL();
            IList<EmailScheduleResult> schedules = newDal.SearchEmailSchedule(scheduleSearch);
            gvEmailSchedule.PageIndex = e.NewPageIndex;
            gvEmailSchedule.DataSource = schedules;
            gvEmailSchedule.DataBind();
            int _pageStart = ((e.NewPageIndex + 1) * PageSize) - PageSize + 1;
            int _pageEnd = ((e.NewPageIndex + 1) * PageSize);
            if (_pageEnd > schedules.Count)
            {
                _pageEnd = schedules.Count;
            }
            if (schedules.Count > PageSize)
            {
                lblResult.Text = string.Format("Showing result(s) {0}-{1} of {2}", _pageStart.ToString(), _pageEnd.ToString(), schedules.Count.ToString());
            }
            else if (schedules.Count > 0)
            {
                lblResult.Text = string.Format("Showing result(s) 1-{0} of {1}", _pageEnd.ToString(), schedules.Count.ToString());
            }
            else
            {
                lblResult.Text = string.Empty;
            }
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            EmailScheduleSearch scheduleSearch = PopulateSearchEntity();
            EmailScheduleDAL newDal = new EmailScheduleDAL();
            IList<EmailScheduleResult> schedules = newDal.SearchEmailSchedule(scheduleSearch);
            gvEmailSchedule.PageIndex = 0;
            gvEmailSchedule.DataSource = schedules;
            gvEmailSchedule.DataBind();
            if (schedules.Count > PageSize)
            {
                lblResult.Text = string.Format("Showing result(s) 1-{0} of {1}", PageSize, schedules.Count.ToString());
            }
            else if (schedules.Count > 0)
            {
                lblResult.Text = string.Format("Showing result(s) 1-{0} of {0}", schedules.Count.ToString());
            }
            else
            {
                lblResult.Text = string.Empty;
            }
        }
    }
}
