using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.User
{
    public partial class ListUserAdmin : System.Web.UI.UserControl
    {
        UserAdmin n = new UserAdmin();
        Utility linq = new Utility();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData_ListAdmin();
            }
        }

        private void LoadData_ListAdmin()
        {
            int pageIndex = string.IsNullOrEmpty(Request.Params["page"]) ? 1 : Convert.ToInt32(Request.Params["page"]);
            int pageSize = Convert.ToInt32(ddl_PageSize.SelectedValue);
            GridView_ListData.DataSource = n.USERS_PAGING(pageIndex, pageSize);//.Where(w => w.ID != 2).ToList();            
            GridView_ListData.DataBind();

            int recordCount = n.USERS_PAGING_COUNT();
            rpt_Pager.DataSource = linq.PagerListItems_Paginations(pageIndex, pageSize, recordCount);
            rpt_Pager.DataBind();
        }

        protected void GridView_ListData_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView_ListData.EditIndex = e.NewEditIndex;
            LoadData_ListAdmin();
        }

        protected void Update_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;
                Image img = (row.Cells[1].Controls[0].FindControl("Image_User") as Image);
                string fullname = (row.Cells[2].Controls[0] as TextBox).Text;
                string email = (row.Cells[3].Controls[0].FindControl("txtEmail") as TextBox).Text;
                string note = (row.Cells[4].Controls[0] as TextBox).Text;
                LinkButton lnkUpdate = (sender as LinkButton);
                string username = lnkUpdate.CommandArgument;
                if (fullname != "" && email != "")
                {
                    if (n.CHECK_EMAIL_USER_WHEN_UPDATE(username, email.Trim()))
                    {
                        n.UPDATE_TABLE_USER_USERNAME(1, username, fullname, img.ImageUrl, note, false, email);
                        GridView_ListData.EditIndex = -1;
                        LoadData_ListAdmin();
                    }
                    else
                    {
                        n.ShowMessageBox("Email này đã tồn tại, vui lòng nhập 1 email khác");
                    }
                }
                else
                {
                    n.ShowMessageBox("Họ tên & Email không được bỏ trống");
                }
            }
            catch (Exception)
            {
                n.ShowMessageBox("Cập nhật thất bại");
            }
        }

        protected void Cancel_Click(object sender, EventArgs e)
        {
            GridView_ListData.EditIndex = -1;
            LoadData_ListAdmin();
        }

        protected void GridView_ListData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // Cập nhật IsActive cho USer
            switch (e.CommandName)
            {
                case ("IsActive"):
                    string id = e.CommandArgument.ToString();
                    bool k = Convert.ToBoolean(n.GetUsersByUsername(id).SingleOrDefault().Active);
                    if (k == true)
                        n.UPDATE_TABLE_USER_USERNAME(0, id, "", "", "", false, "");
                    else
                        n.UPDATE_TABLE_USER_USERNAME(0, id, "", "", "", true, "");
                    LoadData_ListAdmin();
                    break;
            }
        }

        protected void GridView_ListData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (DataBinder.Eval(e.Row.DataItem, "Username").ToString() == "namnguyen1251")
                {                    
                    LinkButton link = e.Row.FindControl("LinkButtonStatus") as LinkButton;
                    LinkButton linkEdit = e.Row.FindControl("LinkButtonEdit") as LinkButton;
                    linkEdit.Visible = false;
                    link.Visible = false;
                    var checkbox2 = e.Row.FindControl("chkdel") as System.Web.UI.HtmlControls.HtmlInputCheckBox;
                    checkbox2.Visible = false;
                }
                if (DataBinder.Eval(e.Row.DataItem, "Username").ToString() == AccountSession<MyAccount>.Inst.AccountInfo.UserId.Trim())
                {
                    var checkbox2 = e.Row.FindControl("chkdel") as System.Web.UI.HtmlControls.HtmlInputCheckBox;
                    checkbox2.Visible = false;
                    LinkButton LinkButtonStatus = e.Row.FindControl("LinkButtonStatus") as LinkButton;
                    LinkButtonStatus.Visible = false;
                }
            }
        }
        
        public void DeleteAdmin()
        {
            try
            {
                var id = HttpContext.Current.Request.Params["idUser"];
                n.DELETE_USER_ADMIN((string.IsNullOrEmpty(id) ? 0 : Convert.ToInt32(id)));                
            }
            catch (Exception)
            {
                n.ShowMessageBox("Thất bại ! Vui lòng kiểm tra lại.");
            }            
        }

        protected int PageIndex
        {
            get
            {
                return string.IsNullOrEmpty(Request.Params["page"]) ? 1 : Convert.ToInt32(Request.Params["page"]);
            }
        }

        protected void ddl_PageSize_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            this.LoadData_ListAdmin();
        }
    }
}