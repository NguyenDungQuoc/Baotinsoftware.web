using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;
using MyProfile.Settings;

namespace MyProfile.Modules
{
    public partial class About : UserControl
    {
        private readonly NewsBlogProvider _newsBlog = new NewsBlogProvider();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_AboutUs();
            }
        }

        private void BindData_AboutUs()
        {
            var newsDefault = _newsBlog.GET_TABLE_NEWS().FirstOrDefault(w => w.ID_GroupNews == MyConstant.AboutUsId);
            if (newsDefault != null)
            {
                //Bind Detail                
                rpt_PostDetail.DataSource = new List<NEW> {newsDefault};
                rpt_PostDetail.DataBind();
                var categoryName = get_CategoryName(Convert.ToInt32(newsDefault.ID_GroupNews));
                var pTitle = Page.Title = newsDefault.Title;
                var domain = Request.Url.Authority;

                MyProfile.Site.MetaContext["Meta1"] = new Meta
                {
                    Attr = "itemprop",
                    Name = "datePublished",
                    Content = newsDefault.Date.ToString().Substring(0, 10)
                };
                MyProfile.Site.MetaContext["Meta2"] = new Meta
                {
                    Attr = "itemprop",
                    Name = "image",
                    Content = domain + newsDefault.Image
                };
                MyProfile.Site.MetaContext["Meta3"] = new Meta
                {
                    Attr = "itemprop",
                    Name = "headline",
                    Content = pTitle
                };
                MyProfile.Site.MetaContext["Meta4"] = new Meta
                {
                    Attr = "itemprop",
                    Name = "genre",
                    Content = categoryName
                };
                MyProfile.Site.MetaContext["Meta5"] = new Meta
                {
                    Attr = "itemprop",
                    Name = "url",
                    Content = domain + Request.RawUrl.Trim()
                };

                MyProfile.Site.MetaContext["Meta6"] = new Meta
                {
                    Attr = "property",
                    Name = "og:url",
                    Content = domain + Request.RawUrl.Trim()
                };
                MyProfile.Site.MetaContext["Meta7"] = new Meta
                {
                    Attr = "property",
                    Name = "og:type",
                    Content = categoryName
                };
                MyProfile.Site.MetaContext["Meta8"] = new Meta
                {
                    Attr = "property",
                    Name = "og:image",
                    Content = domain + newsDefault.Image
                };
                MyProfile.Site.MetaContext["Meta9"] = new Meta
                {
                    Attr = "property",
                    Name = "og:title",
                    Content = pTitle
                };
                MyProfile.Site.MetaContext["Meta10"] = new Meta
                {
                    Attr = "property",
                    Name = "og:description",
                    Content = Server.HtmlDecode(newsDefault.News_Sapo)
                };
                MyProfile.Site.MetaContext["Meta11"] = new Meta
                {
                    Attr = "property",
                    Name = "article:published_time",
                    Content = newsDefault.Date.ToString().Substring(0, 10)
                };

                _newsBlog.UPDATE_TABLE_NEWS_TOTALVIEW(newsDefault.ID);
            }
        }

        public string get_CategoryName(int idCat)
        {
            return _newsBlog.GET_TABLE_GROUP_NEWS().FirstOrDefault(w => w.ID == idCat)?.Name;
        }
    }
}