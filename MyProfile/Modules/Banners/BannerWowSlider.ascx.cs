using System;
using MyProfile.Class;
using System.Linq;

namespace MyProfile.Modules.Banners
{
    public partial class BannerWowSlider : System.Web.UI.UserControl
    {
        BannerSlides banner = new BannerSlides();
        protected void Page_Load(object sender, EventArgs e)
        {
            BindData_BannerInitial();
        }

        private void BindData_BannerInitial()
        {
            var data = banner.GET_TABLE_BANNER().Where(w => w.Active == true).OrderBy(w => w.Position).ToList();
            rptBannerSlider.DataSource = data;
            rptBannerSlider.DataBind();
            rptBannerNavigation.DataSource = data;            
            rptBannerNavigation.DataBind();
        }
    }
}