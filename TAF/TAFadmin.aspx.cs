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

namespace EmailModule.TAF
{
    public partial class TAFadmin : System.Web.UI.Page
    {
        private string _imageFolder = "/Email/EmailCerts";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                populateImageDropDown();
                TAFContentDAL newDal = new TAFContentDAL();
                TAFContent newContent = newDal.GetTAFContent();
                AssignValues(newContent);
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            TAFContent newContent = PopulateContent();
            TAFContentDAL newDal = new TAFContentDAL();
            newDal.SaveTAFContent(newContent);
        }
        private TAFContent PopulateContent() 
        {
            TAFContent newContent = new TAFContent();
            newContent.YouTubeLink = txtYouTube.Text.Trim();
            newContent.SampleCertUrl = ddlImageSelector.SelectedValue;
            newContent.TafSubject = txtSubject.Text.Trim();
            newContent.TafBody = HTMLEditor1.Text.Trim();
            return newContent;
        }
        private void AssignValues(TAFContent newContent) 
        {
            txtYouTube.Text = newContent.YouTubeLink;
            txtSubject.Text = newContent.TafSubject;
            HTMLEditor1.Text = newContent.TafBody;
            int index = 0;
            foreach (ListItem item in ddlImageSelector.Items)
            {
                if (item.Value.Trim().Equals(newContent.SampleCertUrl.Trim()))
                {
                    ddlImageSelector.SelectedIndex = index;
                    break;
                }
                index++;
            }
        }

    }
}
