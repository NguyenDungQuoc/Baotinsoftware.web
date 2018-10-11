using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.Links
{
    public partial class LinkWebsites : System.Web.UI.UserControl
    {
        LinksWebsites l = new LinksWebsites();
        UserAdmin u = new UserAdmin();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind_DataLinkWebsites();
            }
        }

        private void Bind_DataLinkWebsites()
        {
            GridView_ListData.DataSource = l.GET_TABLE_LINKS_WEBSITES().OrderByDescending(w => w.ID);
            GridView_ListData.DataBind();
        }

        public void DeleteRecord()
        {
            var id = HttpContext.Current.Request.Params["idRecord"];
            l.DELETE_TABLE_LINKS((string.IsNullOrEmpty(id) ? 0 : Convert.ToInt32(id)));
        }

        protected void GridView_ListData_OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView_ListData.EditIndex = e.NewEditIndex;
            this.Bind_DataLinkWebsites();
        }

        protected void Update_OnClick(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;
                string name = (row.Cells[1].Controls[0] as TextBox).Text;
                string href = (row.Cells[2].Controls[0] as TextBox).Text;                
                LinkButton lnkUpdate = (sender as LinkButton);
                var key = lnkUpdate.CommandArgument;
                l.UPDATE_VALUE_TABLE_LINKS(Convert.ToInt32(key), name, href, "");
                GridView_ListData.EditIndex = -1;
                Bind_DataLinkWebsites();
            }
            catch (Exception)
            {
                u.ShowMessageBox("Thất bại ! Vui lòng kiểm tra lại.");
            }
        }

        protected void Cancel_OnClick(object sender, EventArgs e)
        {
            GridView_ListData.EditIndex = -1;
            this.Bind_DataLinkWebsites();
        }

        protected void btnInsert_OnClick(object sender, EventArgs e)
        {
            if (txtName.Text.Trim() != "" && txtHref.Text.Trim() != "")
            {
                l.INSERT_INTO_TABLE_LINKS(txtName.Text.Trim(), txtHref.Text.Trim(), "");
                u.ShowMessageBox("Thêm mới thành công!");
                Bind_DataLinkWebsites();
                txtName.Text = txtHref.Text = "";
            }
            else
            {
                u.ShowMessageBox("Tiêu đề và Đường dẫn không được bỏ trống");
            }
        }
    }
}