using MyProfile.Class;
using System;
using System.Linq;
using System.Web.UI;

namespace MyProfile.Modules
{
    public partial class Footer : UserControl
    {
        private readonly PageSeo _pageSeo = new PageSeo();
        private readonly NewsBlogProvider _newsBlog = new NewsBlogProvider();    
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData_Footer();
            }
        }                

        private void LoadData_Footer()
        {
            var tableNews = _newsBlog.GetTableNewsByIsActive();

            //Bind News / Services        
            const int newsCategoryId = 2;
            rpt_LinkNews.DataSource = tableNews.Where(w => w.ID_GroupNews == newsCategoryId).Take(5).ToList();
            rpt_LinkNews.DataBind();

            const int serviceCategoryId = 7;
            rpt_LinkServices.DataSource = tableNews.Where(w => w.ID_GroupNews == serviceCategoryId).Take(5).ToList();
            rpt_LinkServices.DataBind();
        }

        public string get_CategoryName(int categoryId, bool k)
        {
            return k
                ? _newsBlog.GET_TABLE_GROUP_NEWS().FirstOrDefault(w => w.ID == categoryId)?.Name
                : _newsBlog.GET_TABLE_GROUP_NEWS().FirstOrDefault(w => w.ID == categoryId)?.Tag;
        }
    }
}