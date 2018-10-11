using System;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile
{
    public partial class _404 : Page
    {
        private readonly PageSeo _pageSeo = new PageSeo();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var page = _pageSeo.GetPageById(MyConstant.PageIdDefault);
                imgLogo.ImageUrl = page.Logo;
                imgLogo.AlternateText = page.Title;
            }
        }
    }
}