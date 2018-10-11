using System;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Modules.News_Blogs
{
    public partial class ListNewsjCarouselLite : UserControl
    {
        private NewsBlogProvider _newsBlogProvider;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_Initial();
            }
        }

        private void BindData_Initial()
        {
            _newsBlogProvider = new NewsBlogProvider();
            const int newsCategoryId = 2; //News & Event Categories
            //_newsBlogProvider.GetTableNewsByIsActive().Where(w => w.ID_GroupNews == newsCategoryId).ToList();
            var newsResult = _newsBlogProvider.Sp_GetNewsPaging(1, MyConstant.PageSizeMin).Where(x => x.NewsCategoryId == newsCategoryId).ToList();
            rptListNews.DataSource = newsResult;
            rptListNews.DataBind();
        }
    }
}