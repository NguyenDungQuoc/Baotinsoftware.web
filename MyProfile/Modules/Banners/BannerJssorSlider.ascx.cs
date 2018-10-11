using System;
using System.Linq;
using MyProfile.Class;

namespace MyProfile.Modules.Banners
{
    public partial class BannerJssorSlider : System.Web.UI.UserControl
    {
        BannerSlides bs = new BannerSlides();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind_DataSlideJssor();
            }
        }

        private void Bind_DataSlideJssor()
        {
            rpt_SlideJssor.DataSource =
                bs.GET_TABLE_BANNER().Where(w => w.Active == true).OrderBy(w => w.Position).ToList();
            rpt_SlideJssor.DataBind();
        }
    }
}