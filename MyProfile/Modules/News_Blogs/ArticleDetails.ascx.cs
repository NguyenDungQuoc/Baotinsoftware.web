using System;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Modules.News_Blogs
{
    public partial class ArticleDetails : UserControl
    {
        private readonly NewsBlogProvider _newsBlog = new NewsBlogProvider();

        public string GetTitleNews { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_NewsDetails(Request.QueryString["id"]);
            }
        }

        private void BindData_NewsDetails(string request)
        {

            if (request.IsNotNull())
            {
                var newsId = Convert.ToInt32(request);
                var newsById = _newsBlog.GetTableNewsById(newsId);
                //Cập nhật lượt xem
                _newsBlog.UPDATE_TABLE_NEWS_TOTALVIEW(newsId);
                //Bind Meta Info
                rpt_MetaNewsDetails.DataSource = newsById;
                rpt_MetaNewsDetails.DataBind();
                Page.Title = GetTitleNews = newsById.Title;
                ltrDetails.Text = newsById.Content;
                ltrSapo.Text = newsById.News_Sapo;
                var idGroupNews = Convert.ToInt32(newsById.ID_GroupNews);
                //Bind Tab

                var tableNews = _newsBlog.GetTableNewsByIsActive();
                rpt_ListNewsPost.DataSource = tableNews.Take(10);
                rpt_ListNewsPost.DataBind();

                rpt_ListNewsHot.DataSource = tableNews.Where(w => w.IsHot == true).Take(10);
                rpt_ListNewsHot.DataBind();

                rpt_ListNewsView.DataSource = tableNews.OrderByDescending(w => w.TotalView).Take(10);
                rpt_ListNewsView.DataBind();

                var titleGroup = _newsBlog.GET_TABLE_GROUP_NEWS().FirstOrDefault(w => w.ID == idGroupNews)?.Name;

                var domain = "http://{0}".Frmat(Request.Url.Authority);

                MyProfile.Site.MetaContext["Meta1"] = new Meta
                {
                    Attr = "itemprop",
                    Name = "datePublished",
                    Content = newsById.Date.ToString().Substring(0, 10)
                };
                MyProfile.Site.MetaContext["Meta2"] = new Meta
                {
                    Attr = "itemprop",
                    Name = "image",
                    Content = domain + newsById.Image
                };
                MyProfile.Site.MetaContext["Meta3"] = new Meta
                {
                    Attr = "itemprop",
                    Name = "headline",
                    Content = GetTitleNews
                };
                MyProfile.Site.MetaContext["Meta4"] = new Meta
                {
                    Attr = "itemprop",
                    Name = "genre",
                    Content = titleGroup
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
                    Content = titleGroup
                };
                MyProfile.Site.MetaContext["Meta8"] = new Meta
                {
                    Attr = "property",
                    Name = "og:image",
                    Content = domain + newsById.Image
                };
                MyProfile.Site.MetaContext["Meta9"] = new Meta
                {
                    Attr = "property",
                    Name = "og:title",
                    Content = GetTitleNews
                };
                MyProfile.Site.MetaContext["Meta10"] = new Meta
                {
                    Attr = "property",
                    Name = "og:description",
                    Content = Server.HtmlDecode(ltrSapo.Text)
                };
                MyProfile.Site.MetaContext["Meta11"] = new Meta
                {
                    Attr = "property",
                    Name = "article:published_time",
                    Content = newsById.Date.ToString().Substring(0, 10)
                };
            }
        }        
    }
}