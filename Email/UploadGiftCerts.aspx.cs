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
using System.Text;

namespace EmailModule.Email
{
    public partial class UploadGiftCerts : System.Web.UI.Page
    {
        private string _imageFolder = "/Email/EmailCerts";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                populateImageDropDown();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            ClearMessages();
            StringBuilder sb = new StringBuilder();
            bool uploaded = false;
            if (FileUpload1.HasFile)
            {
                if (FileUpload1.FileName.Contains(" ")) 
                {
                    lblError.Text = "File 1 Name contains space. Please replace space with underscore(_).";
                    return;
                }
                try
                {
                    if (FileUpload1.PostedFile.ContentType == "image/jpeg" || FileUpload1.PostedFile.ContentType == "image / pjpeg")
                    {
                        if (FileUpload1.PostedFile.ContentLength < 1024000)
                        {
                            string filename = Path.GetFileName(FileUpload1.FileName);
                            FileUpload1.SaveAs(Server.MapPath("~/Email/EmailCerts/") + filename);
                            uploaded = true;
                        }
                        else
                            sb.Append("Certificate 1 Upload status: The file has to be less than 1 mb!<br/>");
                    }
                    else
                        sb.Append("Certificate 1 Upload status: Only Image files are accepted!<br/>");
                }
                catch (Exception ex)
                {
                    sb.AppendFormat("Certificate 1 Upload status: The file could not be uploaded. The following error occured: {0}<br/>", ex.Message);
                }
            }

            if (FileUpload2.HasFile)
            {
                if (FileUpload2.FileName.Contains(" ")) 
                {
                    lblError.Text = "File 2 Name contains space. Please replace space with underscore(_).";
                    return;
                }
                try
                {
                    if (FileUpload2.PostedFile.ContentType == "image/jpeg")
                    {
                        if (FileUpload2.PostedFile.ContentLength < 1024000)
                        {
                            string filename = Path.GetFileName(FileUpload2.FileName);
                            FileUpload2.SaveAs(Server.MapPath("~/Email/EmailCerts/") + filename);
                            uploaded = true;
                        }
                        else
                            sb.Append("Certificate 2 Upload status: The file has to be less than 1 mb!<br/>");
                    }
                    else
                        sb.Append("Certificate 2 Upload status: Only Image files are accepted!<br/>");
                }
                catch (Exception ex)
                {
                    sb.AppendFormat("Certificate 2 Upload status: The file could not be uploaded. The following error occured: {0}<br/>", ex.Message);
                }
            }

            if (FileUpload3.HasFile)
            {
                if (FileUpload3.FileName.Contains(" "))
                {
                    lblError.Text = "File 3 Name contains space. Please replace space with underscore(_).";
                    return;
                }
                try
                {
                    if (FileUpload3.PostedFile.ContentType == "image/jpeg")
                    {
                        if (FileUpload3.PostedFile.ContentLength < 1024000)
                        {
                            string filename = Path.GetFileName(FileUpload3.FileName);
                            FileUpload3.SaveAs(Server.MapPath("~/Email/EmailCerts/") + filename);
                            uploaded = true;
                        }
                        else
                            sb.Append("Certificate 3 Upload status: The file has to be less than 1 mb!<br/>");
                    }
                    else
                        sb.Append("Certificate 3 Upload status: Only Image files are accepted!<br/>");
                }
                catch (Exception ex)
                {
                    sb.AppendFormat("Certificate 3 Upload status: The file could not be uploaded. The following error occured: {0}<br/>", ex.Message);
                }
            }

            if (FileUpload4.HasFile)
            {
                if (FileUpload4.FileName.Contains(" "))
                {
                    lblError.Text = "File 4 Name contains space. Please replace space with underscore(_).";
                    return;
                }
                try
                {
                    if (FileUpload4.PostedFile.ContentType == "image/jpeg")
                    {
                        if (FileUpload4.PostedFile.ContentLength < 1024000)
                        {
                            string filename = Path.GetFileName(FileUpload4.FileName);
                            FileUpload4.SaveAs(Server.MapPath("~/Email/EmailCerts/") + filename);
                            uploaded = true;
                        }
                        else
                            sb.Append("Certificate 4 Upload status: The file has to be less than 1 mb!<br/>");
                    }
                    else
                        sb.Append("Certificate 4 Upload status: Only Image files are accepted!<br/>");
                }
                catch (Exception ex)
                {
                    sb.AppendFormat("Certificate 4 Upload status: The file could not be uploaded. The following error occured: {0}<br/>", ex.Message);
                }
            }

            if (FileUpload5.HasFile)
            {
                if (FileUpload4.FileName.Contains(" "))
                {
                    lblError.Text = "File 4 Name contains space. Please replace space with underscore(_).";
                    return;
                }
                try
                {
                    if (FileUpload5.PostedFile.ContentType == "image/jpeg")
                    {
                        if (FileUpload5.PostedFile.ContentLength < 1024000)
                        {
                            string filename = Path.GetFileName(FileUpload5.FileName);
                            FileUpload5.SaveAs(Server.MapPath("~/Email/EmailCerts/") + filename);
                            uploaded = true;
                        }
                        else
                            sb.Append("Certificate 5 Upload status: The file has to be less than 1 mb!<br/>");
                    }
                    else
                        sb.Append("Certificate 5 Upload status: Only Image files are accepted!<br/>");
                }
                catch (Exception ex)
                {
                    sb.AppendFormat("Certificate 5 Upload status: The file could not be uploaded. The following error occured: {0}<br/>", ex.Message);
                }
            }
            if (string.IsNullOrEmpty(sb.ToString()) && uploaded == true)
            {
                lblMsg.Text = "File(s) uploaded successfully";
            }
            else 
            {
                lblError.Text = sb.ToString();
            }
            populateImageDropDown();
        }
        protected void populateImageDropDown()
        {
            ddlImageSelector.Items.Clear();
            ListItem bImage = new ListItem();
            bImage.Value = "../Email/images/blank.PNG";
            bImage.Text = "-- Select Image --";
            ddlImageSelector.Items.Add(bImage);
            DirectoryInfo di = new DirectoryInfo(Server.MapPath(_imageFolder));
            FileInfo[] rgFiles = di.GetFiles();
            foreach (FileInfo fi in rgFiles)
            {
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

        protected void btnDel_Click(object sender, EventArgs e)
        {
            ClearMessages();
            try
            {
                FileInfo TheFile = new FileInfo(Server.MapPath(_imageFolder) + "\\" + ddlImageSelector.SelectedValue.Replace("../Email/EmailCerts/",""));
                if (TheFile.Exists)
                {
                    TheFile.Delete();
                    lblDelMsg.Text = "File deleted successfully.";
                }
                else
                {
                    throw new FileNotFoundException();
                }
            }
            catch (FileNotFoundException ex)
            {
                lblDelError.Text += ex.Message;
            }
            catch (Exception ex)
            {
                lblDelError.Text += ex.Message;
            }
            populateImageDropDown();
        }

        protected void ClearMessages() 
        {
            lblError.Text = string.Empty;
            lblMsg.Text = string.Empty;
            lblDelError.Text = string.Empty;
            lblDelMsg.Text = string.Empty;
        }
    }
}
