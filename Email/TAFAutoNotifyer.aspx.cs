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
using Utils;

namespace EmailModule.Email
{
    public partial class TAFAutoNotifyer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //GridView1.DataSourceID = "SqlDataSource1";
            SqlDataSource1.Selected += new SqlDataSourceStatusEventHandler(SqlDataSource1_Selected);
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            //Label1.Text = string.Format("Total {0} friends(s) listed", GridView1.Rows.Count);
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            DataView dv;
            DataSourceSelectArguments args = new DataSourceSelectArguments();
            dv = SqlDataSource1.Select(args) as DataView;
            DataTable dataTable = dv.Table;

            string FileName = string.Format("TAFAutoNotifyer{0}.csv", System.DateTime.Now.ToFileTime().ToString());
            Export newExport = new Export("Web");
            //int[] ColList = { 1, 2, 3, 4, 5, 6, 7, 9, 11, 12, 14, 15, 17, 18, 19, 20, 21, 22 };
            newExport.ExportDetails(dataTable, /*ColList,*/ Export.ExportFormat.CSV, FileName, string.Empty);
        }

        protected void btnShowReport_Click(object sender, EventArgs e)
        {
            GridView1.DataSourceID = "SqlDataSource1";
            //Label1.Text = string.Format("Total {0} friends(s) listed", SqlDataSource1.);
        }
        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            Label1.Text = string.Format("Total {0} friends(s) listed", e.AffectedRows.ToString());
        }
    }
}
