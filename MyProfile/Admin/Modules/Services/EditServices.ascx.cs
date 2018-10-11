using System;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.Services
{
    public partial class EditServices : UserControl
    {
        ServicesClass s = new ServicesClass();
        UserAdmin n = new UserAdmin();
        public string detailContent = string.Empty;
        public string subDetail = string.Empty;
        private bool k;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == "" || Request.QueryString["id"] == null)
            {//Insert
                k = false;
                if (!IsPostBack)
                {
                    BindData_DropDownList_GroupServices();
                    Page.Title = "Thêm mới dịch vụ";
                }
            }
            else
            {//Update
                k = true;
                if (!IsPostBack)
                {
                    BindData_DropDownList_GroupServices();
                    BindData_ServicesEdit();
                    Page.Title = "Chỉnh sửa bài viết dịch vụ";
                }
            }
        }

        private void BindData_ServicesEdit()
        {
            try
            {
                var id = Convert.ToInt32(Request.QueryString["id"]);
                var t = s.GET_TABLE_SERVICES().Where(w => w.ID == id).FirstOrDefault();
                if (t != null)
                {
                    txtTitle.Text = t.Title;
                    ddl_GroupServices.SelectedValue = t.ID_GroupServices.ToString();
                    ddl_IsHot.SelectedValue = t.IsHot.ToString();
                    subDetail = t.Sub;
                    InputFile_Avatar.Text = t.Image;
                    detailContent = t.Content;
                    if (Convert.ToBoolean(t.Active))
                    { rdb_Show.Checked = true; }
                    else
                    { rdb_Hide.Checked = true; }
                }
            }
            catch (Exception)
            {
                Response.Redirect(@"/Admin/listservices.aspx");
            }            
        }

        private void BindData_DropDownList_GroupServices()
        {
            ddl_GroupServices.DataSource = s.LIST_SERVICE_CATEGORIES();
            ddl_GroupServices.DataBind();
        }

        protected void btn_Update_OnClick(object sender, EventArgs e)
        {
            try
            {
                if (txtTitle.Text.IsNotNull())
                {
                    var sub = Request.Form["editor_subdescription"];
                    var content = Request.Form["editor_content"];
                    var idPost = Convert.ToInt32(Request.QueryString["id"]);
                    var tag = txtTitle.Text.UnicodeFormat();
                    var idUser = Convert.ToInt32(n.GetUsersByUsername(AccountSession<MyAccount>.Inst.AccountInfo.UserId).FirstOrDefault().ID);
                    var l = rdb_Show.Checked;
                    if (k)
                    {
                        //Update
                        if (idPost > 0)
                        {
                            s.UPDATE_VALUE_TABLE_SERVICES(idPost, txtTitle.Text.Trim(), tag, sub, InputFile_Avatar.Text.Trim(), content,
                                Convert.ToBoolean(ddl_IsHot.SelectedValue), l, Convert.ToInt32(ddl_GroupServices.SelectedValue));
                            BindData_ServicesEdit();
                        }
                        else
                        {
                            Response.Redirect(@"/Admin/listservices.aspx");
                        }
                    }
                    else
                    {
                        //Insert
                        s.INSERT_RECORD_TABLE_SERVICES(txtTitle.Text.Trim(), tag, sub, InputFile_Avatar.Text.Trim(), content, 1, 
                            Convert.ToBoolean(ddl_IsHot.SelectedValue), l, Convert.ToInt32(ddl_GroupServices.SelectedValue), DateTime.Now, idUser);
                        Response.Redirect(@"/Admin/listservices.aspx");
                    }
                }
            }
            catch (Exception)
            {
                ShContext.Current.Alert("Lỗi hệ thống! Vui lòng kiểm tra lại");
            }
        }
    }
}