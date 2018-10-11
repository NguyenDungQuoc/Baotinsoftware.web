using System;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.Seo
{
    public partial class SeoPage : UserControl
    {
        private readonly PageSeo _pageSeo = new PageSeo();
        private readonly NewsBlogProvider _newsBlog = new NewsBlogProvider();
        private readonly ServicesClass _servicesClass = new ServicesClass();
        private readonly SendContact _sendContact = new SendContact();

        public string DetailContent = string.Empty;
        public string DetailCopyright = string.Empty;
        public string DetailContact = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData_PageSeo();
            }
        }

        private void LoadData_PageSeo()
        {
            var t = _pageSeo.GetPageById(MyConstant.PageIdDefault);
            if (t != null)
            {
                DetailContent = t.Content;
                DetailCopyright = t.Copyright;
                DetailContact = t.Contact;

                txtTitle.Text = t.Title;
                txtSlogan.Text = t.Slogan;
                txtDes.Text = t.Description;
                txtKeyword.Text = t.Keyword;
                txtAnalytics.Text = t.GoogleAnalytics;
                txtFanpage.Text = t.Fanpage;
                txtMaps.Text = t.MapCode;
                fileUploadAvatar.Text = t.Image;
                FileInputLogo.Text = t.Logo;
                FileInputFavicon.Text = t.Favicon;
                txtCountContact.Text = _sendContact.GET_TABLE_CONTACTS().Count.ToString();
                txtCountMember.Text = "10";
                txtCountNews.Text = _newsBlog.GET_TABLE_NEWS().Count.ToString();
                txtCountService.Text = _servicesClass.GET_TABLE_SERVICES().Count.ToString();
            }
        }
        protected void btnCapNhat_Click(object sender, EventArgs e)
        {
            // Update Content - About
            var content = Request.Form["editor_content"];
            _pageSeo.UPDATE_CONTENT_ABOUT_PAGE_ID(MyConstant.PageIdDefault, content);
            Response.Redirect(@"/Admin/home.aspx");
        }

        protected void btnSaves_Click(object sender, EventArgs e)
        {
            // Update SEO
            _pageSeo.UPDATE_TABLE_PAGE(MyConstant.PageIdDefault, txtTitle.Text.Trim(), FileInputLogo.Text,
                txtSlogan.Text, txtKeyword.Text, txtDes.Text, fileUploadAvatar.Text,
                FileInputFavicon.Text, txtAnalytics.Text, txtMaps.Text, txtFanpage.Text);
            Response.Redirect(@"/Admin/home.aspx");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // Footer-Copyright
            var copyright = Request.Form["editor_copyright"];
            var contact = Request.Form["editor_contact"];
            _pageSeo.UPDATE_COPYRIGHT_CONTACT_PAGE_ID(MyConstant.PageIdDefault, copyright, contact);
            Response.Redirect(@"/Admin/home.aspx");
        }
    }
}