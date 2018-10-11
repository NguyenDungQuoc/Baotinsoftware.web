using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;
using MyProfile.Settings;

namespace MyProfile.Modules.News_Blogs
{
    public partial class NewsDetail : UserControl
    {
        private readonly NewsBlogProvider _newsBlog = new NewsBlogProvider();       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDataNewsDetails(Request.QueryString["id"]);
            }
        }

        private void BindDataNewsDetails(string requestId)
        {
            if (requestId.IsNotNull())
            {
                var newsId = Convert.ToInt32(requestId);
                var newsDetail = _newsBlog.GetTableNewsById(newsId);
                if (newsDetail != null)
                {
                    //Bind Detail                
                    rpt_PostDetail.DataSource = new List<NEW> { newsDetail };
                    rpt_PostDetail.DataBind();

                    var newsCategoryId = Convert.ToInt32(newsDetail.ID_GroupNews);
                    //Bind ListNewsOther
                    rpt_ListNewsOther.DataSource = _newsBlog.GetTableNewsByIsActive().Where(p => p.ID_GroupNews == newsCategoryId && p.ID != newsId).ToList();
                    rpt_ListNewsOther.DataBind();

                    var categoryName = GetCategoryName(Convert.ToInt32(newsDetail.ID_GroupNews));
                    var pTitle = Page.Title = newsDetail.Title;
                    ltrCategoryName.Text = categoryName;
                    var domain = "http://{0}".Frmat(Request.Url.Authority);

                    MyProfile.Site.MetaContext["Meta1"] = new Meta
                    {
                        Attr = "itemprop",
                        Name = "datePublished",
                        Content = newsDetail.Date.ToString().Substring(0, 10)
                    };
                    MyProfile.Site.MetaContext["Meta2"] = new Meta
                    {
                        Attr = "itemprop",
                        Name = "image",
                        Content = domain + newsDetail.Image
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
                        Content = domain + newsDetail.Image
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
                        Content = newsDetail.News_Sapo
                    };
                    MyProfile.Site.MetaContext["Meta11"] = new Meta
                    {
                        Attr = "property",
                        Name = "article:published_time",
                        Content = newsDetail.Date.ToString().Substring(0, 10)
                    };
                    _newsBlog.UPDATE_TABLE_NEWS_TOTALVIEW(newsId);
                }
            }
        }

        public string GetCategoryName(int newsCategoryId, string flag = "N")
        {
            return flag == "N"
                ? _newsBlog.GET_TABLE_GROUP_NEWS().FirstOrDefault(w => w.ID == newsCategoryId)?.Name
                : _newsBlog.GET_TABLE_GROUP_NEWS().FirstOrDefault(w => w.ID == newsCategoryId)?.Tag;
        }        
    }
}