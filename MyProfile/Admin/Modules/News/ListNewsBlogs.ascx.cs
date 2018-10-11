using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using MyProfile.Class;
using System.Collections.Generic;
using System.Web.UI;
using MyProfile.Settings;

namespace MyProfile.Admin.Modules.News
{
    public partial class ListNewsBlogs : UserControl
    {
        private NewsBlogProvider _newsBlog = new NewsBlogProvider();
        Utility linq = new Utility();
        UserAdmin u = new UserAdmin();
        private List<GROUP_NEW> ddlGROUP_NEWs = null;

        public List<GROUP_NEW> ComboboxGroupNews
        {
            get
            {
                if (ddlGROUP_NEWs == null)
                {
                    ddlGROUP_NEWs = _newsBlog.LIST_CATEGORIES_NEWS();
                }
                return ddlGROUP_NEWs;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddl_FilterOfCategory.DataSource = ComboboxGroupNews;
                ddl_FilterOfCategory.DataBind();
                BindData_ListNews();
            }
        }

        private void BindData_ListNews(int pageIndex = 1)
        {            
            int idCatSelected = Convert.ToInt32(ddl_FilterOfCategory.SelectedValue);
            int pageSize = Convert.ToInt32(ddl_PageSize.SelectedValue);
            int recordCount;
            if (idCatSelected == 0)
            {                
                GridView_ListData.DataSource = _newsBlog.NEWS_PAGING(pageIndex, pageSize);
                GridView_ListData.DataBind();

                recordCount = _newsBlog.NEWS_PAGING_COUNT();                
            }
            else
            {
                GridView_ListData.DataSource = _newsBlog.NEWS_PAGING_GROUP_NEWS(idCatSelected, pageIndex, pageSize);
                GridView_ListData.DataBind();

                recordCount = _newsBlog.NEWS_PAGING_COUNT_GROUP_NEWS(idCatSelected);                
            }
            rpt_Pager.DataSource = linq.PagerListItems_Paginations(pageIndex, pageSize, recordCount);
            rpt_Pager.DataBind();
        }        

        protected void GridView_ListData_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            string user_ID = u.GetUsersByUsername(AccountSession<MyAccount>.Inst.AccountInfo.UserId.Trim()).FirstOrDefault().ID.ToString();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList rptGroupNews = e.Row.FindControl("ddl_GroupNews") as DropDownList;
                rptGroupNews.DataSource = ComboboxGroupNews;
                rptGroupNews.DataBind();
                HiddenField id = e.Row.FindControl("hdf_GroupNews") as HiddenField;
                rptGroupNews.SelectedValue = id.Value;                
                                
                if (DataBinder.Eval(e.Row.DataItem, "ID_UserPost").ToString() != user_ID)
                {//Nếu mẫu tin nào của User tạo mà User khác login thì ko đc xóa và thay đổi
                    var chkdel = e.Row.FindControl("chkdel") as System.Web.UI.HtmlControls.HtmlInputCheckBox;
                    chkdel.Visible = false;
                    rptGroupNews.Attributes.Add("disabled", "true");
                }
            }
        }        

        protected void GridView_ListData_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            int newsId = Convert.ToInt32(e.CommandArgument);
            var newsById = _newsBlog.GetTableNewsById(newsId);
            switch (e.CommandName)
            {                
                case ("isActive"):
                    bool k = Convert.ToBoolean(newsById.Active);
                    if (k)
                    {
                        _newsBlog.UPDATE_TABLE_NEWS_ACTIVE_ISPOST(0, newsId, false);
                        (e.CommandSource as LinkButton).Text = Utility.GetLabelIsActive(false, "Chưa duyệt", "Đã duyệt");
                    }
                    else
                    {
                        _newsBlog.UPDATE_TABLE_NEWS_ACTIVE_ISPOST(0, newsId, true);
                        (e.CommandSource as LinkButton).Text = Utility.GetLabelIsActive(true, "Chưa duyệt", "Đã duyệt");
                    }
                    break;
                case ("isHot"):
                    bool l = Convert.ToBoolean(newsById.IsHot);
                    if (l)
                    {
                        _newsBlog.UPDATE_TABLE_NEWS_ACTIVE_ISPOST(1, newsId, false);
                        (e.CommandSource as LinkButton).Text = Utility.GetLabelIsHot(false, "Tin nổi bật", "Tin thường");
                    }
                    else
                    {
                        _newsBlog.UPDATE_TABLE_NEWS_ACTIVE_ISPOST(1, newsId, true);
                        (e.CommandSource as LinkButton).Text = Utility.GetLabelIsHot(true, "Tin nổi bật", "Tin thường");
                    }                    
                    break;
            }            
        }

        /// <summary>
        /// AJAX
        /// </summary>
        public void DeleteRecordNews()
        {
            var id = HttpContext.Current.Request.Params["idRecord"];
            _newsBlog.DELETE_RECORD_TABLE_NEWS((string.IsNullOrEmpty(id) ? 0 : Convert.ToInt32(id)));
        }

        public void updateRecordNewsType()
        {
            var id = HttpContext.Current.Request.Params["idItem"];
            var idGroupNews = HttpContext.Current.Request.Params["idGroupNews"];
            _newsBlog.UPDATE_TABLE_NEWS_GROUPNEWS_ID(Convert.ToInt32(id), Convert.ToInt32(idGroupNews));
        }

        protected void ddl_PageSize_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            BindData_ListNews();
        }

        protected void ddl_FilterOfCategory_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            BindData_ListNews();
        }

        protected void lnkPage_OnClick(object sender, EventArgs e)
        {
            pageCurrent = Convert.ToInt32((sender as LinkButton).CommandArgument);
            BindData_ListNews(pageCurrent);
        }

        public int pageCurrent = 1;
    }
}