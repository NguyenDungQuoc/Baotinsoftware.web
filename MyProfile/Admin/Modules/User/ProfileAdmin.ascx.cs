using System;
using System.Linq;
using MyProfile.Class;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyProfile.Admin.Modules.User
{
    public partial class ProfileAdmin : UserControl
    {
        UserAdmin n = new UserAdmin();
        NewsBlogProvider b = new NewsBlogProvider();        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData_ProfileAdmin();
            }
        }        

        public string getAvatar,getDate = string.Empty;

        private void LoadData_ProfileAdmin()
        {
            var t = n.GetUsersByUsername(AccountSession<MyAccount>.Inst.AccountInfo.UserId).SingleOrDefault();
            if (t != null)
            {
                txtFullname.Text = t.Fullname;
                txtNote.Text = t.Note;
                txtEmail.Text = t.Email;                
                getAvatar = t.Image;
                getDate = t.Date.ToString();
                fileUploadImage.Text = t.Image;                
                //Lấy danh sách bài viết của user
                GridView_ListData.DataSource = b.GET_TABLE_NEWS_USERID_POST(t.ID);
                GridView_ListData.DataBind();
            }
        }

        public string getActivePost(bool t)
        {
            return t
                ? "<span class='glyphicon glyphicon-eye-open' style='color: #33A6C6;' title='Đã duyệt'></span>"
                : "<span class='glyphicon glyphicon-eye-close' style='color: #33A6C6;' title='Chưa duyệt'></span>";
        }

        protected void btnCapNhat_Click(object sender, EventArgs e)
        {
            var key = AccountSession<MyAccount>.Inst.AccountInfo.UserId;
            if (txtPassOld.Text == "" && txtPassword.Text == "")
            {
                if (n.CHECK_EMAIL_USER_WHEN_UPDATE(key.Trim(), txtEmail.Text.Trim()))
                {
                    n.UPDATE_TABLE_USER_USERNAME(1, key, txtFullname.Text, fileUploadImage.Text, txtNote.Text, true,
                        txtEmail.Text.Trim());
                    lblShow.Text = "Cập nhật thành công!";
                }
                else
                {
                    lblShow.Text = "Email này đã tồn tại. Vui lòng nhập 1 email khác";
                }
            }
            else
            {
                if (n.CHANGE_PASSWORD_USER(key, txtPassOld.Text, txtPassword.Text))
                {
                    n.UPDATE_TABLE_USER_USERNAME(1, key, txtFullname.Text, fileUploadImage.Text, txtNote.Text, false,
                        txtEmail.Text.Trim());
                    lblShow.Text = "Cập nhật thành công!";
                }
                else
                {
                    lblShow.Text = "Mật khẩu cũ không hợp lệ!";
                }
            }
            lblShow.ControlStyle.ForeColor = Color.Red;
            LoadData_ProfileAdmin();
        }

        protected void GridView_ListData_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView_ListData.PageIndex = e.NewPageIndex;
            GridView_ListData.EditIndex = -1;
            LoadData_ProfileAdmin();
        }
    }
}