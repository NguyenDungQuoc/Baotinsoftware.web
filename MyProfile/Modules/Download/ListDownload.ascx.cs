using MyProfile.Class;
using System;

namespace MyProfile.Modules.Download
{

    public partial class ListDownload : System.Web.UI.UserControl
    {
        DownloadFile dl = new DownloadFile();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_DownloadFile_Initial();
            }
        }

        private void BindData_DownloadFile_Initial()
        {
            rpt_DownloadFile.DataSource = dl.GetListDataDownloadFile();
            rpt_DownloadFile.DataBind();
        }
    }
}