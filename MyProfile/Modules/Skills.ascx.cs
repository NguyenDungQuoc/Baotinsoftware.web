using MyProfile.Class;
using System;
using System.Linq;
using System.Web.UI;

namespace MyProfile.Modules
{
    public partial class Skills : UserControl
    {
        private NewsBlogProvider _newsBlog = new NewsBlogProvider();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_SiteMaps();
            }
        }

        private void BindData_SiteMaps()
        {
            const int newsEvent = 1;
            const int serviceId = 2;

            var tableNews = _newsBlog.GetTableNewsByIsActive();
            //Dịch vụ
            rpt_ListServices.DataSource = tableNews.Where(w => w.ID_GroupNews == serviceId).OrderByDescending(w => w.Date).ToList();
            rpt_ListServices.DataBind();

            //Tin tức
            rpt_ListNews.DataSource = tableNews.Where(w => w.ID_GroupNews == newsEvent).OrderByDescending(w => w.Date).ToList();
            rpt_ListNews.DataBind();
        }
    }
}