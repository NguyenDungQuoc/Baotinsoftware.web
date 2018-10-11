using MyProfile.Class;
using System;
using System.Linq;
using System.Web.UI;

namespace MyProfile.Modules
{
    public partial class Header : UserControl
    {
        private PageSeo _pageSeoService;
        private NewsBlogProvider _newsBlogService;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHeader();
            }
            Bind_ActiveMenu();
        }

        public string mHome, mAbout, mSkill, mGalleries, mNews, mServices, mPartners, mFaqs, mContacts, mProducts, mDownload = string.Empty;
        private void LoadHeader()
        {
            _pageSeoService = new PageSeo();
            _newsBlogService = new NewsBlogProvider();
            var pageInfo = _pageSeoService.GET_TABLE_PAGE_IDPAGE(MyConstant.PageIdDefault)
                .Select(ps => new { ps.Title, ps.Logo, ps.Slogan, ps.Fanpage })
                .ToList();
            rptPageInfo.DataSource = pageInfo;
            rptPageInfo.DataBind();
            Page.Title = $"Trang chủ - {pageInfo.FirstOrDefault()?.Title}";
            imgLogo.ImageUrl = pageInfo.FirstOrDefault()?.Logo;
            imgLogo.AlternateText = Page.Title;
            imgLogo.ToolTip = Page.Title;
            rpt_Data.DataSource = _newsBlogService.GET_TABLE_GROUP_NEWS().Where(w => w.Active == true)
                .OrderBy(w => w.Position)
                .ToList();
            rpt_Data.DataBind();
        }        

        private void Bind_ActiveMenu()
        {
            var urlCurent = Request.Url.AbsolutePath;
            if (urlCurent == "/home.aspx")
                mHome = "active";
            if (urlCurent == "/profile.aspx")
                mAbout = "active";
            if (urlCurent == "/skills.aspx")
                mSkill = "active";
            if (urlCurent == "/gallery.aspx")
                mGalleries = "active";
            if (urlCurent == "/blog.aspx" || urlCurent == "/article.aspx" || urlCurent == "/news.aspx")
                mNews = "active";
            if (urlCurent == "/services.aspx")
                mServices = "active";
            if (urlCurent == "/partners.aspx")
                mPartners = "active";
            if (urlCurent == "/faqs.aspx")
                mFaqs = "active";
            if (urlCurent == "/contact.aspx")
                mContacts = "active";
            if (urlCurent == "/products.aspx" || urlCurent == "/productdetail.aspx")
                mProducts = "active";
            if (urlCurent == "/download.aspx")
                mDownload = "active";
        }        
    }    
}