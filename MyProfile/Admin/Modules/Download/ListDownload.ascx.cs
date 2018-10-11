using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;
using MyProfile.Controls;

namespace MyProfile.Admin.Modules.Download
{
    public partial class ListDownload : UserControl
    {
        private readonly DownloadFile _downloadFile = new DownloadFile();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_DownloadInitial();
            }
        }

        private void BindData_DownloadInitial()
        {
            GridView_ListData.DataSource = _downloadFile.GetListDataDownloadFile();
            GridView_ListData.DataBind();
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            var fileName = txtName.Text.Trim();
            var filePath = txtPath.Text.Trim();
            var isActive = rdb_Show.Checked;
            if (fileName != "" && filePath != "")
            {
                _downloadFile.InsertRecordToTableDownload(fileName, filePath, txtDes.Text.Trim(), txtSize.Text.Trim(), isActive);
            }
            Response.Redirect(@"/Admin/listdownload.aspx");
        }

        protected void Update_Click(object sender, EventArgs e)
        {
            var row = (sender as LinkButton).NamingContainer as GridViewRow;
            var fileName = (row.Cells[1].Controls[0] as TextBox).Text;
            var filePath = (row.Cells[2].Controls[0].FindControl("txtFilePath") as FileInput).Text;
            var fileDes = (row.Cells[3].Controls[0] as TextBox).Text;
            var fileSize = (row.Cells[4].Controls[0].FindControl("txtSize") as TextBox).Text;
            var lnkUpdate = sender as LinkButton;
            var recordId = Convert.ToInt32(lnkUpdate.CommandArgument);
            if (fileName != "" && filePath != "")
            {
                _downloadFile.UpdateRecordToTableDownload(recordId, fileName, filePath, fileDes, fileSize);
                GridView_ListData.EditIndex = -1;
                BindData_DownloadInitial();
            }
        }

        protected void Cancel_Click(object sender, EventArgs e)
        {
            GridView_ListData.EditIndex = -1;
            BindData_DownloadInitial();
        }

        protected void GridView_ListData_RowCommand(object sender, GridViewCommandEventArgs e)
        {            
            switch (e.CommandName)
            {
                case "IsActive":
                    _downloadFile.UpdateIsActiveToTableDownload(Convert.ToInt32(e.CommandArgument));
                    break;
                case "DelRecord":
                    _downloadFile.DeleteRecordToTableDownload(Convert.ToInt32(e.CommandArgument));
                    break;
            }
            BindData_DownloadInitial();
        }

        protected void GridView_ListData_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView_ListData.EditIndex = e.NewEditIndex;
            BindData_DownloadInitial();
        }
    }
}