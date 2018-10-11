using System;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Modules
{
    public partial class News : UserControl
    {
        private readonly NewsBlogProvider _newsBlog = new NewsBlogProvider();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDataListNewsByCategory(Request.QueryString["id"]);
            }
        }

        private void BindDataListNewsByCategory(string request)
        {
            if (request.IsNotNull())
            {
                var newsCategoryId = Convert.ToInt32(Request.QueryString["id"]);
                ltr_Title.Text = Page.Title = GetCategoryName(newsCategoryId, true);
                var tableNews = _newsBlog.GetTableNewsByIsActive().Where(w => w.ID_GroupNews == newsCategoryId).ToList();

                if (tableNews.Count == 1)
                {
                    var newsCategoryAlias = GetCategoryName(newsCategoryId, false);
                    var newsAlias = tableNews.FirstOrDefault()?.Tag;
                    var newsId = tableNews.FirstOrDefault().ID;
                    Response.Redirect("/{0}/{1}-{2}.html".Frmat(newsCategoryAlias, newsAlias, newsId));
                }
                else
                {
                    rpt_ListNewsEventOfCategory.DoBind(tableNews);
                }
            }
        }

        public string GetCategoryName(int categoryId, bool k)
        {
            return k
                ? _newsBlog.GET_TABLE_GROUP_NEWS().FirstOrDefault(w => w.ID == categoryId)?.Name
                : _newsBlog.GET_TABLE_GROUP_NEWS().FirstOrDefault(w => w.ID == categoryId)?.Tag;
        } 
    }
}