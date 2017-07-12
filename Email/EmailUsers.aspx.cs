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
using System.Text;
using Utils;
using System.Net.Mail;

namespace EmailModule.Email
{
    public partial class EmailUsers : System.Web.UI.Page
    {
        private string _scheduleTime = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Text = string.Empty;
            lblMsg.Text = string.Empty;
            if (!IsPostBack)
            {
                CompanyDAL newCompanyDal = new CompanyDAL();
                IList<Company> companies = newCompanyDal.GetAllCompany();
                foreach (Company company in companies)
                {
                    ListItem item = new ListItem();
                    item.Text = company.CompanyName;
                    item.Value = company.CompanyRegID.ToString();
                    ddlCompany.Items.Add(item);
                }

                TAFDAL newTAF = new TAFDAL();
                IList<TAFTemplate> templates = newTAF.GetAllTAFTemplates();
                foreach (TAFTemplate template in templates)
                {
                    ListItem item = new ListItem();
                    item.Text = template.TemplateName;
                    item.Value = template.TemplateID.ToString();
                    ddlSelectTemplate.Items.Add(item);
                }
            }
        }

        protected void btnSelect_Click(object sender, EventArgs e)
        {
            UserSelection newSelection = populateSelectionParameters();
            UserDAL newUserDal = new UserDAL();
            IList<Entity.User> users = newUserDal.GetUsers(newSelection);
            if (users.Count > 50000)
            {
                lblError.Text = "Your selection criterion returns more than 50000 records. Please redefine the criterions.";
                return;
            }
            gvUsers.DataSource = users;
            gvUsers.PageIndex = 0;
            gvUsers.DataBind();
            if (users.Count > 10)
            {
                lblResult.Text = string.Format("Showing result(s) 1-10 of {0}", users.Count.ToString());
            }
            else if (users.Count > 0)
            {
                lblResult.Text = string.Format("Showing result(s) 1-{0} of {0}", users.Count.ToString());
            }
            else 
            {
                lblResult.Text = string.Empty;
            }
        }   
        protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            UserSelection newSelection = populateSelectionParameters();
            UserDAL newUserDal = new UserDAL();
            IList<Entity.User> users = newUserDal.GetUsers(newSelection);
            DataTable dataTable = Utilities.ConvertToDataTable(users);
            if (dataTable != null)
            {
                DataView dataView = new DataView(dataTable);
                if (ViewState["SortString"]!=null)
                {
                    dataView.Sort = ViewState["SortString"].ToString();
                }
                gvUsers.DataSource = dataView;
                gvUsers.PageIndex = e.NewPageIndex;
                gvUsers.DataBind();
            }
            int _pageStart = ((e.NewPageIndex + 1) * 10) - 9;
            int _pageEnd = ((e.NewPageIndex + 1) * 10);
            if (_pageEnd > users.Count) 
            {
                _pageEnd = users.Count;
            }
            if (users.Count > 10)
            {
                lblResult.Text = string.Format("Showing result(s) {0}-{1} of {2}", _pageStart.ToString(), _pageEnd.ToString(), users.Count.ToString());
            }
            else if (users.Count > 0)
            {
                lblResult.Text = string.Format("Showing result(s) 1-{0} of {1}", _pageEnd.ToString(), users.Count.ToString());
            }
            else
            {
                lblResult.Text = string.Empty;
            }
        }
        public string GetFormattedDate(Object bday)
        {
            return Convert.ToDateTime(bday).ToShortDateString();
        }        
        protected void ddlSelectTemplate_SelectedIndexChanged(object sender, EventArgs e)
        {
            int templateID = 0;
            txtFromEmail.Text = string.Empty;
            txtReplytoEmail.Text = string.Empty;
            txtEmailSubject.Text = string.Empty;
            HTMLEditor1.Text = string.Empty;
            int.TryParse(ddlSelectTemplate.SelectedValue, out templateID);
            if (templateID > 0)
            {
                TAFDAL newTAF = new TAFDAL();
                TAFTemplate template = newTAF.GetTAFTemplateByID(templateID);
                txtFromEmail.Text = template.FromEmail;
                txtReplytoEmail.Text = template.ReplyToEmail;
                txtEmailSubject.Text = template.EmailSubject;
                HTMLEditor1.Text = template.EmailBody;
            }
        }
        protected void btnSendMail_Click(object sender, EventArgs e)
        {
            UserSelection newSelection = populateSelectionParameters();
            UserDAL newUserDal = new UserDAL();
            IList<Entity.User> users = newUserDal.GetUsers(newSelection);
            if (users.Count > 50000) 
            {
                lblError.Text = "Your selection criterion returns more than 50000 records. Please redefine the criterions.";
                return;
            }
            SendMailtoList(users);
        }
        protected void SendMailtoList(IList<Entity.User> users)
        {
            EmailContent newContent = populateEmailContent();
            UserSelection newSelection = populateSelectionParameters();
            EmailContentDAL newContentDal = new EmailContentDAL();
            int emailContentID = newContentDal.SaveEmailContent(newContent, newSelection);
            int count = 0;
            StringBuilder sb = new StringBuilder();
            foreach (Entity.User _user in users)
            {
                string status = SendMail(_user, emailContentID);
                if (string.IsNullOrEmpty(status))
                {
                    count++;
                }                
            }
            sb.AppendFormat("Email(s) are Scheduled Successfully for {0} user(s). Click <a href='EmailSendReport.aspx'>here</a> to view the schedule status.", count);
            lblMsg.Text = sb.ToString();
        }
        protected string SendMail(Entity.User newUser, int emailContentID)
        {
            EmailDelivery emaildelivery = populateEmailDelivery(newUser, emailContentID);
            EmailDeliveryDAL emailDeliveryDAL = new EmailDeliveryDAL();
            emailDeliveryDAL.SaveEmailDelivery(emaildelivery);

            DateTime originalSchedule = emaildelivery.ScheduleTime;
            if (chkReschedule1.Checked == true) 
            {
                emaildelivery.ScheduleTime = RescheduleTime(ddlReschedule1.SelectedValue, originalSchedule);
                emailDeliveryDAL.SaveEmailDelivery(emaildelivery);
            }
            if (chkReschedule2.Checked == true)
            {
                emaildelivery.ScheduleTime = RescheduleTime(ddlReschedule2.SelectedValue, originalSchedule);
                emailDeliveryDAL.SaveEmailDelivery(emaildelivery);
            }
            if (chkReschedule3.Checked == true)
            {
                emaildelivery.ScheduleTime = RescheduleTime(ddlReschedule3.SelectedValue, originalSchedule);
                emailDeliveryDAL.SaveEmailDelivery(emaildelivery);
            }
            if (chkReschedule4.Checked == true)
            {
                emaildelivery.ScheduleTime = RescheduleTime(ddlReschedule4.SelectedValue, originalSchedule);
                emailDeliveryDAL.SaveEmailDelivery(emaildelivery);
            }
            if (chkReschedule5.Checked == true)
            {
                emaildelivery.ScheduleTime = RescheduleTime(ddlReschedule5.SelectedValue, originalSchedule);
                emailDeliveryDAL.SaveEmailDelivery(emaildelivery);
            }
            if (chkReschedule6.Checked == true)
            {
                emaildelivery.ScheduleTime = RescheduleTime(ddlReschedule6.SelectedValue, originalSchedule);
                emailDeliveryDAL.SaveEmailDelivery(emaildelivery);
            }
            //string emailBodyText = Utilities.ReplaceTokens(HTMLEditor1.Text, newUser);
            //emailBodyText = ReplaceImageSource(emailBodyText);
            //string emailSubject = Utilities.ReplaceTokens(txtEmailSubject.Text, newUser);
            //string message = MailHelper.SendMailMessage(txtFromEmail.Text, txtReplytoEmail.Text, newUser.Email, string.Empty, string.Empty, emailSubject, emailBodyText, MailPriority.Normal);
            //return message;
            return string.Empty;
        }
        private DateTime RescheduleTime(string token, DateTime prevSchedule) 
        {
            DateTime newSchedule = System.DateTime.Now;
            if (token.StartsWith("D"))
            {
                int intervalDay = 0;
                int.TryParse(token.Substring(1), out intervalDay);
                newSchedule = prevSchedule.AddDays(intervalDay);
            }
            else if (token.StartsWith("M"))
            {
                int intervalMonth = 0;
                int.TryParse(token.Substring(1), out intervalMonth);
                newSchedule = prevSchedule.AddMonths(intervalMonth);
            }
            else if (token.StartsWith("Y"))
            {
                int intervalYear = 0;
                int.TryParse(token.Substring(1), out intervalYear);
                newSchedule = prevSchedule.AddYears(intervalYear);
            }
            return newSchedule;
        }
        protected string ReplaceImageSource(string replacableString)
        {
            replacableString = replacableString.Replace("src=\"..", "src=\"http://thebirthdayregister.com");
            return replacableString;
        }
        protected UserSelection populateSelectionParameters()
        {
            UserSelection newSelection = new UserSelection();

            newSelection.FirstName = txtFName.Text.Trim();

            newSelection.LastName = txtLName.Text.Trim();

            newSelection.Email = txtEmail.Text.Trim();
            int temp = -1;
            int.TryParse(txtRegID.Text.Trim(), out temp);
            if (temp > 0)
            {
                newSelection.RegID = temp;
            }

            newSelection.ZipCode = txtZip.Text.Trim();

            if (ddlActive.SelectedValue.Equals("1"))
            {
                newSelection.Active = true;
            }
            else if (ddlActive.SelectedValue.Equals("0"))
            {
                newSelection.Active = false;
            }
            else
            {
                newSelection.Active = null;
            }

            temp = -1;
            int.TryParse(ddlCompany.SelectedValue, out temp);
            if (temp > 0)
            {
                newSelection.CompanyID = temp;
            }

            if (string.IsNullOrEmpty(txtRegStart.Text.Trim()))
            {
                newSelection.RegStartDate = Convert.ToDateTime("1/1/1900");
            }
            else
            {
                newSelection.RegStartDate = Convert.ToDateTime(txtRegStart.Text.Trim());
            }

            if (string.IsNullOrEmpty(txtRegEnd.Text.Trim()))
            {
                newSelection.RegEndDate = Convert.ToDateTime("1/1/2099");
            }
            else
            {
                newSelection.RegEndDate = Convert.ToDateTime(txtRegEnd.Text.Trim());
                newSelection.RegEndDate = newSelection.RegEndDate.AddDays(1);
            }

            newSelection.BdayStartDate = Convert.ToDateTime(ddlBdayStartMonth.SelectedValue + "/" + ddlBdayStartDay.SelectedValue + "/2000");

            newSelection.BdayEndDate = Convert.ToDateTime(ddlBdayEndMonth.SelectedValue + "/" + ddlBdayEndDay.SelectedValue + "/2000");

            newSelection.Offer = chkOffer.Checked;
            newSelection.Referrer = txtReferrer.Text.Trim();
            //Age Range start
            int ageStart = 0;
            int ageEnd = 0;
            int.TryParse(txtAgeRangeStart.Text, out ageStart);
            int.TryParse(txtAgeRangeEnd.Text, out ageEnd);
            if (ageEnd < ageStart) 
            {
                int tempV = ageEnd;
                ageEnd = ageStart;
                ageStart = tempV;
            }
            newSelection.AgeRangeStart = DateTime.Now.AddYears(-ageStart);
            newSelection.AgeRangeEnd = DateTime.Now.AddYears(-(ageEnd+1)).AddDays(1);
            //Age Range end
            newSelection.Gender = ddlGender.SelectedValue;
            int minCount = 0;
            int.TryParse(txtSentCount.Text.Trim(), out minCount);
            newSelection.MinSentCount = minCount;
            minCount = 0;
            int.TryParse(txtOpenedCount.Text.Trim(), out minCount);
            newSelection.MinOpenedCount = minCount;
            minCount = 0;
            int.TryParse(txtOpenRate.Text.Trim(), out minCount);
            newSelection.MinOpenRate = minCount;
            if (newSelection.MinOpenRate > 0 && newSelection.MinSentCount == 0) // to avoid Divide by zero error 
            {
                newSelection.MinSentCount = 1;
            }
            return newSelection;
        }
        protected EmailContent populateEmailContent()
        {
            EmailContent emailContent = new EmailContent();
            emailContent.EmailFromAddress = txtFromEmail.Text.Trim();
            emailContent.EmailReplyToAddress = txtReplytoEmail.Text.Trim();
            emailContent.EmailCcAddress = string.Empty;
            emailContent.EmailSubject = txtEmailSubject.Text;
            emailContent.EmailBody = HTMLEditor1.Text;
            emailContent.RequestTime = System.DateTime.Now;
            if (rdbScheduleBy.SelectedValue.Equals("0"))
            {
                _scheduleTime = string.Format("Now:{0}", System.DateTime.Now.AddMinutes(5.0));
            }
            else if (rdbScheduleBy.SelectedValue.Equals("1"))
            {
                DateTime deliveryDate = new DateTime();
                _scheduleTime = string.Format("{0} {1}",txtScheduleDate.Text.Trim(), txtScheduleTime.Text.Trim());
                DateTime.TryParse(_scheduleTime, out deliveryDate);
                _scheduleTime = string.Format("Tim:{0}", deliveryDate.ToString());
            }
            else if (rdbScheduleBy.SelectedValue.Equals("2"))
            {
                _scheduleTime = string.Format("Tok:{0}", ddlScheduleToken.SelectedValue);
            }
            emailContent.ScheduleTime = _scheduleTime;
            emailContent.TemplateID = Convert.ToInt32(ddlSelectTemplate.SelectedValue);
            return emailContent;
        }
        protected EmailDelivery populateEmailDelivery(Entity.User newUser, int emailContentID) 
        {
            EmailDelivery emailDelivery = new EmailDelivery();
            emailDelivery.UserID = newUser.UserID;
            emailDelivery.FromAddress = txtFromEmail.Text.Trim();
            emailDelivery.ToAddress = newUser.Email;
            emailDelivery.CcAddress = string.Empty;
            emailDelivery.ReplyToAddress = txtReplytoEmail.Text.Trim();
            emailDelivery.TemplateID = Convert.ToInt32(ddlSelectTemplate.SelectedValue);
            emailDelivery.EmailSubject = Utilities.ReplaceTokens(txtEmailSubject.Text, newUser);
            emailDelivery.EmailContentID = emailContentID;
            emailDelivery.NameToken = Utils.Utilities.UppercaseName(newUser.Name);
            emailDelivery.BdayToken = newUser.BirthDay.ToString("MMMM dd");
            emailDelivery.ZipToken = newUser.ZipCode;
            emailDelivery.EmailToken = newUser.Email;
            if (rdbScheduleBy.SelectedValue.Equals("0"))
            {
                emailDelivery.ScheduleTime = System.DateTime.Now.AddMinutes(5.0);
            }
            else if (rdbScheduleBy.SelectedValue.Equals("1"))
            {
                DateTime deliveryDate = new DateTime();
                _scheduleTime = string.Format("{0} {1}", txtScheduleDate.Text.Trim(), txtScheduleTime.Text.Trim());
                DateTime.TryParse(_scheduleTime, out deliveryDate);
                emailDelivery.ScheduleTime = deliveryDate;
            }
            else if (rdbScheduleBy.SelectedValue.Equals("2"))
            {
                double hour = 0.0;
                double.TryParse(ddlScheduleToken.SelectedValue, out hour);
                if (newUser.BirthDay.Month == 2 && newUser.BirthDay.Day == 29 && !IsLeapYear(System.DateTime.Now.Year))
                {
                    _scheduleTime = string.Format("{0}/{1}/{2}", newUser.BirthDay.Month, newUser.BirthDay.Day - 1, System.DateTime.Now.Year);
                }
                else
                {
                    _scheduleTime = string.Format("{0}/{1}/{2}", newUser.BirthDay.Month, newUser.BirthDay.Day, System.DateTime.Now.Year);
                }
                DateTime deliveryDate = Convert.ToDateTime(_scheduleTime);
                if (deliveryDate < System.DateTime.Now)
                {
                    TimeSpan diffDate = System.DateTime.Now.Subtract(deliveryDate);
                    if (diffDate.Days > 30) 
                    {
                        deliveryDate = deliveryDate.AddYears(1);
                    }
                }
                if (deliveryDate > System.DateTime.Now)
                {
                    TimeSpan diffDate = deliveryDate.Subtract(System.DateTime.Now);
                    if (diffDate.Days > 330)
                    {
                        deliveryDate = deliveryDate.AddYears(-1);
                    }
                }  
                deliveryDate = deliveryDate.AddHours(hour);
                emailDelivery.ScheduleTime = deliveryDate;
            }
            emailDelivery.Status = (int)Utils.Enum.Status.Pending;
            emailDelivery.Priority = Convert.ToInt32(ddlPriority.SelectedValue);
            return emailDelivery;
        }

        protected void gvUsers_Sorting(object sender, GridViewSortEventArgs e)
        {
            UserSelection newSelection = populateSelectionParameters();
            UserDAL newUserDal = new UserDAL();
            IList<Entity.User> users = newUserDal.GetUsers(newSelection);
            DataTable dataTable = Utilities.ConvertToDataTable(users);

            if (dataTable != null)
            {
                DataView dataView = new DataView(dataTable);
                if (ViewState["SortExpression"]!=null && ViewState["SortDirection"]!=null)
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
                gvUsers.DataSource = dataView;
                gvUsers.PageIndex = 0;
                gvUsers.DataBind();
            }
                        
            int _pageStart = 1;
            int _pageEnd = 10;
            if (_pageEnd > users.Count)
            {
                _pageEnd = users.Count;
            }
            if (users.Count > 10)
            {
                lblResult.Text = string.Format("Showing result(s) {0}-{1} of {2}", _pageStart.ToString(), _pageEnd.ToString(), users.Count.ToString());
            }
            else if (users.Count > 0)
            {
                lblResult.Text = string.Format("Showing result(s) 1-{0} of {1}", _pageEnd.ToString(), users.Count.ToString());
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

        protected void lbExport_Click(object sender, EventArgs e)
        {
            UserSelection newSelection = populateSelectionParameters();
            UserDAL newUserDal = new UserDAL();
            DataTable dataTable = newUserDal.GetUsersTable(newSelection);

            string FileName = string.Format("EmailUserSearch{0}.csv", System.DateTime.Now.ToFileTime().ToString());
            Export newExport = new Export("Web");
            //int[] ColList = { 1, 2, 3, 4, 5, 6, 7, 9, 11, 12, 14, 15, 17, 18, 19, 20, 21, 22 };
            newExport.ExportDetails(dataTable, /*ColList,*/ Export.ExportFormat.CSV, FileName, string.Empty);
        }
        public bool IsLeapYear(int year)
        {
            if ((year % 400) == 0)
                return true;
            else if ((year % 100) == 0)
                return false;
            else if ((year % 4) == 0)
                return true;
            else
                return false;
        }
    }
}
