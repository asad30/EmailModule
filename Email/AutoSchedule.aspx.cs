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

namespace EmailModule.Email
{
    public partial class AutoSchedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TAFDAL newTAF = new TAFDAL();
                IList<TAFTemplate> templates = newTAF.GetAllTAFTemplates();
                foreach (TAFTemplate template in templates)
                {
                    ListItem item = new ListItem();
                    item.Text = template.TemplateName;
                    item.Value = template.TemplateID.ToString();
                    ddlSelectTemplate.Items.Add(item);
                }
                if (System.DateTime.Now < System.DateTime.Today.AddHours(5))
                {
                    txtSchedularStart.Text = System.DateTime.Today.AddHours(5).ToString();
                }
                else
                {
                    txtSchedularStart.Text = System.DateTime.Today.AddDays(1).AddHours(5).ToString();
                }
            }
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

        protected void btnSave_Click(object sender, EventArgs e)
        {

        }

        protected AutoSchedular PopulateSchedular() 
        {
            AutoSchedular newSchedular = new AutoSchedular();
            newSchedular.UserID = 0;
            if (ddlActive.SelectedValue.Equals("1"))
            {
                newSchedular.SelectionActive = true;
            }
            else if (ddlActive.SelectedValue.Equals("0"))
            {
                newSchedular.SelectionActive = false;
            }
            else
            {
                newSchedular.SelectionActive = null;
            }

            newSchedular.SelectionSignUpPeriodStart = int.Parse(txtSignUpDurationStart.Text);
            newSchedular.SelectionSignUpPeriodEnd = int.Parse(txtSignUpDurationEnd.Text);
            newSchedular.SchedularName = txtSchedularName.Text.Trim();
            newSchedular.SchedularFrequency = int.Parse(ddlShedularFrequency.SelectedValue);
            newSchedular.StartDate = DateTime.Parse(txtSchedularStart.Text);
            newSchedular.TemplateID = int.Parse(ddlSelectTemplate.SelectedValue);
            newSchedular.FromAddress = txtFromEmail.Text;
            newSchedular.ReplyTo = txtReplytoEmail.Text;
            newSchedular.Subject = txtReplytoEmail.Text;
            newSchedular.EmailBody = HTMLEditor1.Text;
            newSchedular.EmailPriority = int.Parse(ddlPriority.SelectedValue);
            return newSchedular;
        }
    }
}
