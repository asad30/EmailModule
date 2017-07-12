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

namespace EmailModule.Email
{
    public partial class BounceReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblUnsMsg.Text = string.Empty;
            lnkUnsubscribe.Visible = false;
            if (!IsPostBack) 
            {
                GenerateReport();
            }
        }

        protected void btnShowReport_Click(object sender, EventArgs e)
        {
            GenerateReport();
        }

        protected void gvBounceNewModule_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            lnkUnsubscribe.Visible = true;
            int module = 2;
            int minBounceCount = 1;
            int.TryParse(txtBounceCount.Text, out minBounceCount);
            bool? unsubscribed = null;
            if (!string.IsNullOrEmpty(ddlUnsubscribed.SelectedValue))
            {
                unsubscribed = Convert.ToBoolean(ddlUnsubscribed.SelectedValue);
            }
            BounceDAL newdal = new BounceDAL();
            DataSet newDs = newdal.GetBouncedEmail(module, minBounceCount, unsubscribed);
            gvBounceNewModule.PageIndex = e.NewPageIndex;
            gvBounceNewModule.DataSource = newDs.Tables[0];
            gvBounceNewModule.DataBind();

            int _pageStart = ((e.NewPageIndex + 1) * 10) - 9;
            int _pageEnd = ((e.NewPageIndex + 1) * 10);
            if (_pageEnd > newDs.Tables[0].Rows.Count)
            {
                _pageEnd = newDs.Tables[0].Rows.Count;
            }
            if (newDs.Tables[0].Rows.Count > 10)
            {
                lblResultNew.Text = string.Format("Showing result(s) {0}-{1} of {2}", _pageStart.ToString(), _pageEnd.ToString(), newDs.Tables[0].Rows.Count.ToString());
            }
            else if (newDs.Tables[0].Rows.Count > 0)
            {
                lblResultNew.Text = string.Format("Showing result(s) 1-{0} of {1}", _pageEnd.ToString(), newDs.Tables[0].Rows.Count.ToString());
            }
            else
            {
                lblResultNew.Text = string.Empty;
            }
        }

        protected void gvBounceOldModule_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            lnkUnsubscribe.Visible = true;
            int module = 1;
            int minBounceCount = 1;
            int.TryParse(txtBounceCount.Text, out minBounceCount);
            bool? unsubscribed = null;
            if (!string.IsNullOrEmpty(ddlUnsubscribed.SelectedValue))
            {
                unsubscribed = Convert.ToBoolean(ddlUnsubscribed.SelectedValue);
            }
            BounceDAL newdal = new BounceDAL();
            DataSet newDs = newdal.GetBouncedEmail(module, minBounceCount, unsubscribed);
            gvBounceOldModule.PageIndex = e.NewPageIndex;
            gvBounceOldModule.DataSource = newDs.Tables[0];
            gvBounceOldModule.DataBind();
            int _pageStart = ((e.NewPageIndex + 1) * 10) - 9;
            int _pageEnd = ((e.NewPageIndex + 1) * 10);
            if (_pageEnd > newDs.Tables[0].Rows.Count)
            {
                _pageEnd = newDs.Tables[0].Rows.Count;
            }
            if (newDs.Tables[0].Rows.Count > 10)
            {
                lblResultOld.Text = string.Format("Showing result(s) {0}-{1} of {2}", _pageStart.ToString(), _pageEnd.ToString(), newDs.Tables[0].Rows.Count.ToString());
            }
            else if (newDs.Tables[0].Rows.Count > 0)
            {
                lblResultOld.Text = string.Format("Showing result(s) 1-{0} of {1}", _pageEnd.ToString(), newDs.Tables[0].Rows.Count.ToString());
            }
            else
            {
                lblResultOld.Text = string.Empty;
            }
        }

        protected void lnkUnsubscribe_Click(object sender, EventArgs e)
        {
            int module = Convert.ToInt32(ddlModule.SelectedValue);
            int minBounceCount = 1;
            int.TryParse(txtBounceCount.Text, out minBounceCount);
            bool? unsubscribed = null;
            if (!string.IsNullOrEmpty(ddlUnsubscribed.SelectedValue))
            {
                unsubscribed = Convert.ToBoolean(ddlUnsubscribed.SelectedValue);
            }
            BounceDAL newdal = new BounceDAL();
            int countRows = newdal.UnsubscribeBouncedEmail(module, minBounceCount, unsubscribed);
            lblUnsMsg.Text = string.Format("{0} User(s) Unsubscribed.", countRows.ToString());
            divOldMod.Visible = false;
            divNewMod.Visible = false;
        }

        protected void GenerateReport() 
        {
            lnkUnsubscribe.Visible = true;
            int module = Convert.ToInt32(ddlModule.SelectedValue);
            int minBounceCount = 1;
            int.TryParse(txtBounceCount.Text, out minBounceCount);
            bool? unsubscribed = null;
            if (!string.IsNullOrEmpty(ddlUnsubscribed.SelectedValue))
            {
                unsubscribed = Convert.ToBoolean(ddlUnsubscribed.SelectedValue);
            }
            BounceDAL newdal = new BounceDAL();
            DataSet newDs = newdal.GetBouncedEmail(module, minBounceCount, unsubscribed);
            if (newDs.Tables.Count == 2)
            {
                gvBounceOldModule.DataSource = newDs.Tables[0];
                gvBounceOldModule.PageIndex = 0;
                gvBounceOldModule.DataBind();
                int _pageStart = 1;
                int _pageEnd = 10;
                if (_pageEnd > newDs.Tables[0].Rows.Count)
                {
                    _pageEnd = newDs.Tables[0].Rows.Count;
                }
                if (newDs.Tables[0].Rows.Count > 10)
                {
                    lblResultOld.Text = string.Format("Showing result(s) {0}-{1} of {2}", _pageStart.ToString(), _pageEnd.ToString(), newDs.Tables[0].Rows.Count.ToString());
                }
                else if (newDs.Tables[0].Rows.Count > 0)
                {
                    lblResultOld.Text = string.Format("Showing result(s) 1-{0} of {1}", _pageEnd.ToString(), newDs.Tables[0].Rows.Count.ToString());
                }
                else
                {
                    lblResultOld.Text = string.Empty;
                }

                gvBounceNewModule.DataSource = newDs.Tables[1];
                gvBounceNewModule.PageIndex = 0;
                gvBounceNewModule.DataBind();
                _pageStart = 1;
                _pageEnd = 10;
                if (_pageEnd > newDs.Tables[1].Rows.Count)
                {
                    _pageEnd = newDs.Tables[1].Rows.Count;
                }
                if (newDs.Tables[1].Rows.Count > 10)
                {
                    lblResultNew.Text = string.Format("Showing result(s) {0}-{1} of {2}", _pageStart.ToString(), _pageEnd.ToString(), newDs.Tables[1].Rows.Count.ToString());
                }
                else if (newDs.Tables[1].Rows.Count > 0)
                {
                    lblResultNew.Text = string.Format("Showing result(s) 1-{0} of {1}", _pageEnd.ToString(), newDs.Tables[1].Rows.Count.ToString());
                }
                else
                {
                    lblResultNew.Text = string.Empty;
                }

                divNewMod.Visible = true;
                divOldMod.Visible = true;
            }
            else if (newDs.Tables.Count == 1)
            {
                if (module == 2)
                {
                    gvBounceOldModule.DataBind();
                    gvBounceNewModule.DataSource = newDs.Tables[0];
                    gvBounceNewModule.PageIndex = 0;
                    gvBounceNewModule.DataBind();
                    divNewMod.Visible = true;
                    divOldMod.Visible = false;

                    int _pageStart = 1;
                    int _pageEnd = 10;
                    if (_pageEnd > newDs.Tables[0].Rows.Count)
                    {
                        _pageEnd = newDs.Tables[0].Rows.Count;
                    }
                    if (newDs.Tables[0].Rows.Count > 10)
                    {
                        lblResultNew.Text = string.Format("Showing result(s) {0}-{1} of {2}", _pageStart.ToString(), _pageEnd.ToString(), newDs.Tables[0].Rows.Count.ToString());
                    }
                    else if (newDs.Tables[0].Rows.Count > 0)
                    {
                        lblResultNew.Text = string.Format("Showing result(s) 1-{0} of {1}", _pageEnd.ToString(), newDs.Tables[0].Rows.Count.ToString());
                    }
                    else
                    {
                        lblResultNew.Text = string.Empty;
                    }

                }
                else if (module == 1)
                {
                    gvBounceNewModule.DataBind();
                    gvBounceOldModule.DataSource = newDs.Tables[0];
                    gvBounceOldModule.PageIndex = 0;
                    gvBounceOldModule.DataBind();
                    divNewMod.Visible = false;
                    divOldMod.Visible = true;

                    int _pageStart = 1;
                    int _pageEnd = 10;
                    if (_pageEnd > newDs.Tables[0].Rows.Count)
                    {
                        _pageEnd = newDs.Tables[0].Rows.Count;
                    }
                    if (newDs.Tables[0].Rows.Count > 10)
                    {
                        lblResultOld.Text = string.Format("Showing result(s) {0}-{1} of {2}", _pageStart.ToString(), _pageEnd.ToString(), newDs.Tables[0].Rows.Count.ToString());
                    }
                    else if (newDs.Tables[0].Rows.Count > 0)
                    {
                        lblResultOld.Text = string.Format("Showing result(s) 1-{0} of {1}", _pageEnd.ToString(), newDs.Tables[0].Rows.Count.ToString());
                    }
                    else
                    {
                        lblResultOld.Text = string.Empty;
                    }
                }
            }
        }
       
        public string GetFormattedValue(object oName)
        {
            string sName = string.Empty;
            bool isUnsubscribed = Convert.ToBoolean(oName);
            if (isUnsubscribed == true)
            {
                sName = "Yes";
            }
            else 
            {
                sName = "No";
            }
            return sName;
        }
    }
}
