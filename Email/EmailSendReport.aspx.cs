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
using Utils;

namespace EmailModule.Email
{
    public partial class EmailSendReport : System.Web.UI.Page
    {        
        public int BatchID
        {
            get 
            {
                int _batchID = 0;
                int.TryParse(ddlBatchID.SelectedValue, out _batchID);
                return _batchID;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            lblCancelAll.Text = string.Empty;
            if (!IsPostBack)
            {
                EmailContentDAL newContentDal = new EmailContentDAL ();
                IList<UserSelection> newSelection = new List<UserSelection>();
                IList<EmailContent> emailContents = newContentDal.GetEmailContents(out newSelection);
                int limit = 0;
                foreach (EmailContent content in emailContents)
                {
                    ListItem item = new ListItem();
                    item.Text = content.EmailContentID.ToString();
                    item.Value = content.EmailContentID.ToString();
                    ddlBatchID.Items.Add(item);
                    limit++;
                    //if (limit > 49) break;
                }
                ddlBatchID.SelectedIndex = 0;
                if (newSelection != null && newSelection.Count > 0)
                {
                    PopulateSelectionCriterion(newSelection[0]);
                }
                if (emailContents != null && emailContents.Count > 0)
                {
                    PopulateEmailContent(emailContents[0]);
                }
                EmailDeliveryDAL newDal = new EmailDeliveryDAL();
                IList<EmailDelivery> emails = newDal.GetSendEmail(BatchID);
                gvEmailSend.DataSource = emails;
                gvEmailSend.DataBind();
                if (emails.Count > 10)
                {
                    lblResult.Text = string.Format("Showing result(s) 1-10 of {0}", emails.Count.ToString());
                }
                else if (emails.Count > 0)
                {
                    lblResult.Text = string.Format("Showing result(s) 1-{0} of {0}", emails.Count.ToString());
                }
                else
                {
                    lblResult.Text = string.Empty;
                }
            }
        }
        
        protected void gvEmailSend_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            EmailDeliveryDAL newDal = new EmailDeliveryDAL();
            IList<EmailDelivery> emails = newDal.GetSendEmail(BatchID);
            DataTable dataTable = Utilities.ConvertToDataTable(emails);
            if (dataTable != null)
            {
                DataView dataView = new DataView(dataTable);
                if (ViewState["SortString"] != null)
                {
                    dataView.Sort = ViewState["SortString"].ToString();
                }
                gvEmailSend.DataSource = dataView;
                gvEmailSend.PageIndex = e.NewPageIndex;
                gvEmailSend.DataBind();
            }
            int _pageStart = ((e.NewPageIndex + 1) * 10) - 9;
            int _pageEnd = ((e.NewPageIndex + 1) * 10);
            if (_pageEnd > emails.Count)
            {
                _pageEnd = emails.Count;
            }
            if (emails.Count > 10)
            {
                lblResult.Text = string.Format("Showing result(s) {0}-{1} of {2}", _pageStart.ToString(), _pageEnd.ToString(), emails.Count.ToString());
            }
            else if (emails.Count > 0)
            {
                lblResult.Text = string.Format("Showing result(s) 1-{0} of {1}", _pageEnd.ToString(), emails.Count.ToString());
            }
            else
            {
                lblResult.Text = string.Empty;
            }
        }
        protected void gvEmailSend_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ImageButton btnCancel = (ImageButton)e.Row.Cells[6].FindControl("btnCancel");
                if (btnCancel == null)
                    return;
                Label _status = (Label)e.Row.Cells[5].FindControl("lblStatus");
                if (_status == null)
                    return;
                if (_status.Text.ToLower() != "pending")
                {
                    btnCancel.Attributes.Add("style", "display:none;");
                }
            }
        }
        protected void gvEmailSend_Sorting(object sender, GridViewSortEventArgs e)
        {
            EmailDeliveryDAL newDal = new EmailDeliveryDAL();
            IList<EmailDelivery> emails = newDal.GetSendEmail(BatchID);
            DataTable dataTable = Utilities.ConvertToDataTable(emails);

            if (dataTable != null)
            {
                DataView dataView = new DataView(dataTable);
                if (ViewState["SortExpression"] != null && ViewState["SortDirection"] != null)
                {
                    if (ViewState["SortExpression"].ToString().Equals(e.SortExpression) && ViewState["SortDirection"].ToString().Equals(e.SortDirection.ToString()))
                    {
                        if (e.SortDirection == SortDirection.Ascending)
                        {
                            e.SortDirection = SortDirection.Descending;
                        }
                        else
                        {
                            e.SortDirection = SortDirection.Ascending;
                        }
                    }
                }
                dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);
                ViewState["SortExpression"] = e.SortExpression;
                ViewState["SortDirection"] = e.SortDirection;
                ViewState["SortString"] = dataView.Sort;
                gvEmailSend.DataSource = dataView;
                gvEmailSend.PageIndex = 0;
                gvEmailSend.DataBind();
            }

            int _pageStart = 1;
            int _pageEnd = 10;
            if (_pageEnd > emails.Count)
            {
                _pageEnd = emails.Count;
            }
            if (emails.Count > 10)
            {
                lblResult.Text = string.Format("Showing result(s) {0}-{1} of {2}", _pageStart.ToString(), _pageEnd.ToString(), emails.Count.ToString());
            }
            else if (emails.Count > 0)
            {
                lblResult.Text = string.Format("Showing result(s) 1-{0} of {1}", _pageEnd.ToString(), emails.Count.ToString());
            }
            else
            {
                lblResult.Text = string.Empty;
            }
        }
        private string ConvertSortDirectionToSql(SortDirection sortDirection)
        {
            string newSortDirection = String.Empty;

            switch (sortDirection)
            {
                case SortDirection.Ascending:
                    newSortDirection = "ASC";
                    break;

                case SortDirection.Descending:
                    newSortDirection = "DESC";
                    break;
            }

            return newSortDirection;
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
        public string GetFormattedStatus(object status)
        {
            int _status = -1;
            string sName = string.Empty;
            try
            {
                _status = (int)status;
            }
            catch
            {
            }
            if (_status == 0)
            {
                sName = "Pending";
            }
            if (_status == 1)
            {
                sName = "Sent-Not Opened ";
            }
            if (_status == 2)
            {
                sName = "Cancelled";
            }
            if (_status == 3)
            {
                sName = "Sent-Opened";
            }
            if (_status == 4)
            {
                sName = "Sent-Bounced";
            }
            return sName;
        }
        protected void gvEmailSend_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName.ToLower())
            {
                case "cancelemail":
                    CancelEmail(e.CommandArgument.ToString());
                    break;
            }
        }
        private void CancelEmail(string ID)
        {
            int emailID = int.Parse(ID);
            EmailDeliveryDAL newDal = new EmailDeliveryDAL();
            int status = newDal.CancelEmailDelivery(emailID);

            IList<EmailDelivery> emails = newDal.GetSendEmail(BatchID);
            DataTable dataTable = Utilities.ConvertToDataTable(emails);
            if (dataTable != null)
            {
                DataView dataView = new DataView(dataTable);
                if (ViewState["SortString"] != null)
                {
                    dataView.Sort = ViewState["SortString"].ToString();
                }
                gvEmailSend.DataSource = dataView;
                gvEmailSend.DataBind();
            }
        }

        protected void lbCancelAll_Click(object sender, EventArgs e)
        {
            EmailDeliveryDAL newDal = new EmailDeliveryDAL();
            int status = newDal.CancelLatestEmailDeliveryAll(BatchID);

            IList<EmailDelivery> emails = newDal.GetSendEmail(BatchID);
            DataTable dataTable = Utilities.ConvertToDataTable(emails);
            if (dataTable != null)
            {
                DataView dataView = new DataView(dataTable);
                if (ViewState["SortString"] != null)
                {
                    dataView.Sort = ViewState["SortString"].ToString();
                }
                gvEmailSend.DataSource = dataView;
                gvEmailSend.DataBind();
            }
            lblCancelAll.Text = string.Format("{0} items are in Cancel Status", status.ToString());
        }

        protected void btnShowReport_Click(object sender, EventArgs e)
        {
            
            EmailContentDAL newContentDal = new EmailContentDAL();
            UserSelection newSelection = new UserSelection();
            EmailContent emailContent = newContentDal.GetEmailContentByID(BatchID, out newSelection);            
            if (newSelection != null)
            {
                PopulateSelectionCriterion(newSelection);
            }
            if (emailContent != null)
            {
                PopulateEmailContent(emailContent);
            }
            EmailDeliveryDAL newDal = new EmailDeliveryDAL();
            IList<EmailDelivery> emails = newDal.GetSendEmail(BatchID);
            gvEmailSend.PageIndex = 0;
            gvEmailSend.DataSource = emails;
            gvEmailSend.DataBind();
            if (emails.Count > 10)
            {
                lblResult.Text = string.Format("Showing result(s) 1-10 of {0}", emails.Count.ToString());
            }
            else if (emails.Count > 0)
            {
                lblResult.Text = string.Format("Showing result(s) 1-{0} of {0}", emails.Count.ToString());
            }
            else
            {
                lblResult.Text = string.Empty;
            }
        }
        private void PopulateSelectionCriterion(UserSelection newSelection) 
        {
            txtFName.Text = newSelection.FirstName;
            txtLName.Text = newSelection.LastName;
            txtEmail.Text = newSelection.Email;
            txtRegID.Text = string.Empty;
            txtCompany.Text = string.Empty;
            txtRegStart.Text = string.Empty;
            txtRegEnd.Text = string.Empty;
            txtBdayStart.Text = string.Empty;
            txtBdayEnd.Text = string.Empty;
            if (newSelection.RegID > -1)
            {
                txtRegID.Text = newSelection.RegID.ToString();
            }            
            txtZip.Text = newSelection.ZipCode;
            if (newSelection.Active == null)
            {
                txtActive.Text = "Select All";
            }
            else if (newSelection.Active == true)
            {
                txtActive.Text = "Active Only";
            }
            else if (newSelection.Active == false)
            {
                txtActive.Text = "Inactive Only";
            }
            
            if (newSelection.CompanyID > -1)
            {
                txtCompany.Text = newSelection.CompanyID.ToString();
            }

            if (newSelection.RegStartDate != null && newSelection.RegStartDate.Year > 1910)
            {
                txtRegStart.Text = newSelection.RegStartDate.ToString("dd MMMM yyyy");
            }
            if (newSelection.RegEndDate != null && newSelection.RegEndDate.Year < 2099)
            {
                txtRegEnd.Text = newSelection.RegEndDate.ToString("dd MMMM yyyy");
            }
            if (newSelection.BdayStartDate != null)
            {
                txtBdayStart.Text = newSelection.BdayStartDate.ToString("dd MMMM");
            }
            if (newSelection.BdayEndDate != null)
            {
                txtBdayEnd.Text = newSelection.BdayEndDate.ToString("dd MMMM");
            }
        }

        private void PopulateEmailContent(EmailContent emailCont)
        {
            lblBatchReqTime.Text = emailCont.RequestTime.ToString();
            txtTemplate.Text = emailCont.TemplateName.ToString();
            txtFromEmail.Text = Server.HtmlEncode(emailCont.EmailFromAddress);
            txtReplytoEmail.Text = Server.HtmlEncode(emailCont.EmailReplyToAddress);
            txtEmailSubject.Text = emailCont.EmailSubject;
            txtEmailBody.Text = emailCont.EmailBody;
            //txtPriority.Text
            if (emailCont.ScheduleTime.Contains("Tok:-"))
            {
                int tokDay = Convert.ToInt32(Math.Ceiling(Convert.ToDecimal(emailCont.ScheduleTime.Substring(5))/24));
                txtSchedule.Text = string.Format("{0} day(s) before Birthday", tokDay.ToString());
            }
            else if (emailCont.ScheduleTime.Contains("Tok:+"))
            {
                int hour = Convert.ToInt32(emailCont.ScheduleTime.Substring(5));
                int tokDay = hour / 24;
                if (tokDay != 0)
                {
                    txtSchedule.Text = string.Format("{0} day(s) after Birthday", tokDay.ToString());
                }
                else 
                {
                    txtSchedule.Text = string.Format("at Birthday {0}:00", hour.ToString());
                }
            }
            else if (emailCont.ScheduleTime.Contains("Tim:"))
            {
                DateTime tokDay = Convert.ToDateTime(emailCont.ScheduleTime.Substring(4));
                txtSchedule.Text = string.Format("Time: {0}", tokDay.ToString());
            }
            else if (emailCont.ScheduleTime.Contains("Now:"))
            {
                DateTime tokDay = Convert.ToDateTime(emailCont.ScheduleTime.Substring(4));
                txtSchedule.Text = string.Format("Now: {0}", tokDay.ToString());
            }
        }
    }
}

