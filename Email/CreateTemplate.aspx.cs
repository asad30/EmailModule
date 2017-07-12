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
using System.IO;
using Entity;
using DAL;
using System.Collections.Generic;

namespace EmailModule.Email
{
    public partial class CreateTemplate : System.Web.UI.Page
    {
        private string _imageFolder = "/Email/EmailCerts";

        private int TemplateID
        {
            get 
            {
                int _templateID = 0;
                if (Request.QueryString["templateid"] != null) 
                {
                    int.TryParse(Request.QueryString["templateid"].ToString().Trim(), out _templateID);
                }
                return _templateID; 
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {            
            if (!IsPostBack)
            {
                if (TemplateID > 0)
                {
                    TAFDAL newDal = new TAFDAL();
                    TAFTemplate newTemplate = newDal.GetTAFTemplateByID(TemplateID);
                    PopulateTemplate(newTemplate);
                }
                else
                {
                    populateImageDropDown();
                }
                TAFDAL newTAF = new TAFDAL();
                IList<TAFTemplate> templates = newTAF.GetAllTAFTemplates();
                foreach (TAFTemplate template in templates)
                {
                    ListItem item = new ListItem();
                    item.Text = template.TemplateName;
                    item.Value = template.TemplateID.ToString();
                    ddlDuplicateTemplate.Items.Add(item);
                }
            }
        }
        protected void ddlDuplicateTemplate_SelectedIndexChanged(object sender, EventArgs e)
        {
            int templateID = 0;
            int.TryParse(ddlDuplicateTemplate.SelectedValue, out templateID);
            if (templateID > 0)
            {
                TAFDAL newTAF = new TAFDAL();
                TAFTemplate template = newTAF.GetTAFTemplateByID(templateID);
                txtFromEmail.Text = template.FromEmail;
                txtReplyTo.Text = template.ReplyToEmail;
                txtEmailSubject.Text = template.EmailSubject;
                HTMLEditor1.Text = template.EmailBody;
            }
            else {
                txtFromEmail.Text = "Happy Birthday <HappyBirthday@TheBirthdayRegister.com>";
                txtReplyTo.Text = "Info@TheBirthdayRegister.com";
                txtEmailSubject.Text = "Happy Birthday [Name]!";
                HTMLEditor1.Text = "<img id='GiftCertGraphics' class='imgSelection' src='../Email/images/blank.PNG' alt='Please allow your browser to display the GiftCertificate image' /><p></p>";
            }
        }
        protected void populateImageDropDown()
        {
            DirectoryInfo di = new DirectoryInfo(Server.MapPath(_imageFolder));
            FileInfo[] rgFiles = di.GetFiles();
            foreach (FileInfo fi in rgFiles)
            {
                if (fi.Name.Contains(" ")) continue;
                if (fi.Extension.ToLower().Equals(".jpg") || fi.Extension.ToLower().Equals(".jpeg") || fi.Extension.ToLower().Equals(".png") || fi.Extension.ToLower().Equals(".bmp"))
                {
                    ListItem newImage = new ListItem();
                    newImage.Value = ".." + _imageFolder + "/" + fi.Name;
                    newImage.Text = GetExtensionLessName(fi.Name, fi.Extension);
                    ddlImageSelector.Items.Add(newImage);
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveTemplate();
            lblMsg.Visible = true;
            lblMsg.Text = "Template saved successfully";            
        }

        protected void SaveTemplate()
        {
            TAFTemplate emailTemplate = new TAFTemplate();
            emailTemplate.TemplateID = TemplateID;
            emailTemplate.TemplateName = txtTemplate.Text;
            emailTemplate.User = GetLoggedUser();
            emailTemplate.FromEmail = txtFromEmail.Text;
            emailTemplate.ReplyToEmail = txtReplyTo.Text;
            emailTemplate.EmailSubject = txtEmailSubject.Text;
            emailTemplate.EmailBody = HTMLEditor1.Text;
            emailTemplate.TemplateImage = ddlImageSelector.SelectedItem.Text;
            TAFDAL newDal = new TAFDAL();
            newDal.SaveTemplate(emailTemplate);
            Response.Redirect("EmailTemplates.aspx");
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

        public string GetExtensionLessName(string fileName, string extension)
        {
            string[] separator = { extension };
            string[] name = fileName.Split(separator, StringSplitOptions.RemoveEmptyEntries);
            string extLessFileName = string.Empty;
            if (name.Length > 0)
            {
                extLessFileName = name[0];
            }
            return extLessFileName;
        }

        private void PopulateTemplate(TAFTemplate emailTemplate) 
        {
            txtTemplate.Text = emailTemplate.TemplateName;
            txtFromEmail.Text = emailTemplate.FromEmail;
            txtReplyTo.Text = emailTemplate.ReplyToEmail;
            txtEmailSubject.Text = emailTemplate.EmailSubject;
            HTMLEditor1.Text = emailTemplate.EmailBody;
            populateImageDropDown();
            int index = 0;
            foreach (ListItem item in ddlImageSelector.Items) 
            {
                if(item.Text.Trim().Equals(emailTemplate.TemplateImage.Trim()))
                {
                    ddlImageSelector.SelectedIndex = index;
                    break;
                }
                index++;
            }
            btnSave.Text = "Update";
        }
    }
}
