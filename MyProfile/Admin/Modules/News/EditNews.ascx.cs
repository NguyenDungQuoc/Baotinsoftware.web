using System;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.News
{
    public partial class EditNews : UserControl
    {
        private readonly NewsBlogProvider _newsBlog = new NewsBlogProvider();
        private readonly UserAdmin _userAdmin = new UserAdmin();
        private bool k;

        protected void Page_Load(object sender, EventArgs e)
        {            
            if (Request.QueryString["id"] == "" || Request.QueryString["id"] == null)
            {
                //Insert
                k = false;                
                if (!IsPostBack)
                {
                    BindData_DropDownList_GroupNews();
                    Page.Title = "Thêm mới bài viết";
                }
            }
            else
            {
                //Update
                k = true;
                if (!IsPostBack)
                {
                    BindData_DropDownList_GroupNews();
                    BindData_NewsEdit();
                    Page.Title = "Chỉnh sửa bài viết";
                }
            }            
        }

        private void BindData_DropDownList_GroupNews()
        {
            ddl_GroupNews.DataSource = _newsBlog.LIST_CATEGORIES_NEWS();
            ddl_GroupNews.DataBind();
        }

        public string detailContent = string.Empty;
        public string subDetail = string.Empty;

        private void BindData_NewsEdit()
        {
            try
            {
                var newsId = Convert.ToInt32(Request.QueryString["id"]);
                var t = _newsBlog.GetTableNewsById(newsId);
                if (t != null)
                {
                    txtTitle.Text = t.Title;
                    ddl_GroupNews.SelectedValue = t.ID_GroupNews.ToString();
                    ddl_IsHot.SelectedValue = t.IsHot.ToString();
                    subDetail = t.News_Sapo;
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
                Response.Redirect(@"/Admin/listnews.aspx");
            }            
        }

        protected void btn_Update_OnClick(object sender, EventArgs e)
        {
            try
            {
                if (txtTitle.Text != "")
                {
                    var newsId = Convert.ToInt32(Request.Params["id"]);
                    var title = txtTitle.Text.Trim();
                    var sub = Request.Form["editor_subdescription"];
                    var content = Request.Form["editor_content"];                    
                    var tag = txtTitle.Text.UnicodeFormat();
                    var avatar = InputFile_Avatar.Text.Trim();
                    var userId = Convert.ToInt32(_userAdmin.GetUsersByUsername(AccountSession<MyAccount>.Inst.AccountInfo.UserId).FirstOrDefault().ID);
                    var flagShow = false;
                    var flagIsHot = Convert.ToBoolean(ddl_IsHot.SelectedValue);
                    var newsCategoryId = Convert.ToInt32(ddl_GroupNews.SelectedValue);
                    if (rdb_Show.Checked)                    
                        flagShow = true;
                    if (k)
                    {
                        //Update
                        if (newsId > 0)
                        {
                            _newsBlog.UPDATE_TABLE_NEWS(newsId, title, tag, sub, avatar, content, flagIsHot, flagShow,
                                newsCategoryId);
                            BindData_NewsEdit();
                        }
                        else
                        {
                            Response.Redirect(@"/Admin/listnews.aspx");
                        }
                    }
                    else
                    {
                        //Insert
                        _newsBlog.INSERT_TABLE_NEWS_BLOGS(title, tag, sub, avatar, content, 1, flagIsHot, flagShow,
                            newsCategoryId, userId);
                        Response.Redirect(@"/Admin/listnews.aspx");
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