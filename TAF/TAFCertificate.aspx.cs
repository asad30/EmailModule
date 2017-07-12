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
using System.IO;

namespace EmailModule.TAF
{
    public partial class TAFCertificate : System.Web.UI.Page
    {
        private string _imageFolder = "/Email/EmailCerts";
        public int CertID
        {
            get 
            {
                int id = 0;
                string qid = Request.QueryString["id"];
                int.TryParse(qid, out id);
                return id;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                populateImageDropDown();
                TAFCertDAL newDal = new TAFCertDAL();
                gvTAFCert.DataSource = newDal.GetAllTAFCerts();
                gvTAFCert.DataBind();
                if (CertID > 0)
                {
                    TAFCert newCert = newDal.GetTAFCert(CertID);
                    AssignValues(newCert);
                    btnSaveGiftCert.Text = "Update";
                }
            }            
        }
        private void AssignValues(TAFCert newCert)
        {
            txtZip.Text = newCert.ZipCodes;
            int index = 0;
            foreach (ListItem item in ddlGiftCert.Items)
            {
                if (item.Value.Trim().Equals(newCert.TAFCertificate.Trim()))
                {
                    ddlGiftCert.SelectedIndex = index;
                    break;
                }
                index++;
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
                    ddlGiftCert.Items.Add(newImage);
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
        protected void btnSaveGiftCert_Click(object sender, EventArgs e)
        {
            TAFCert newCert = PopulateTAFCert();
            newCert.Id = CertID;
            TAFCertDAL newDal = new TAFCertDAL();
            newDal.SaveTAFContent(newCert);
            gvTAFCert.DataSource = newDal.GetAllTAFCerts();
            gvTAFCert.DataBind();
        }
        protected void gvTAFCert_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName.ToLower())
            {
                case "delete":
                    Delete(e.CommandArgument.ToString());
                    break;
            }
        }

        private void Delete(string ID)
        {
            int certId = int.Parse(ID);
            TAFCert newCert = PopulateTAFCert();
            newCert.Id = certId;
            newCert.Active = false;
            TAFCertDAL newDal = new TAFCertDAL();
            newDal.SaveTAFContent(newCert);
            gvTAFCert.DataSource = newDal.GetAllTAFCerts();
            gvTAFCert.DataBind();
            
        }
        private TAFCert PopulateTAFCert() 
        {
            TAFCert newCert = new TAFCert();
            newCert.Id = 0;
            newCert.Active = true;
            newCert.TAFCertificate = ddlGiftCert.SelectedValue;
            newCert.ZipCodes = txtZip.Text.Trim();
            return newCert;
        }

        protected void gvTAFCert_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }
        public string GetCertSubstring(object newObj)
        {
            string newString = newObj.ToString();
            return newString.Substring(20).Replace(".jpg","").Replace(".png","").Replace(".bmp","").Replace(".jpeg","");
        }
    }
}
