using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.Banners
{
    public partial class BannersSliders : UserControl
    {
        private readonly BannerSlides _bannerSlides = new BannerSlides();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind_DataBannerSlides();
            }
        }

        private void Bind_DataBannerSlides()
        {
            GridView_ListData.DataSource = _bannerSlides.GET_TABLE_BANNER().OrderByDescending(p => p.ID).ToList();
            GridView_ListData.DataBind();
        }

        protected void GridView_ListData_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "IsActive":
                    var id = e.CommandArgument;
                    var k =
                        Convert.ToBoolean(
                            _bannerSlides.GET_TABLE_BANNER().FirstOrDefault(w => w.ID == Convert.ToInt32(id)).Active);
                    _bannerSlides.UPDATE_BANNER_ACTIVE(Convert.ToInt32(id), !k);
                    Bind_DataBannerSlides();
                    break;
            }
        }

        /// <summary>
        /// DELETE CALL AJAX
        /// </summary>
        public void DeleteRecord()
        {
            var id = HttpContext.Current.Request.Params["idRecord"];
            _bannerSlides.DELETE_BANNERS(string.IsNullOrEmpty(id) ? 0 : Convert.ToInt32(id));
        }

        /// <summary>
        /// Bind Data Record
        /// </summary>
        public void bindRecordToEdit()
        {
            var idRecord = HttpContext.Current.Request.Params["idRecord"];
            if (idRecord != null)
            {
                var t =
                    _bannerSlides.GET_TABLE_BANNER()
                        .FirstOrDefault(w => w.ID == (string.IsNullOrEmpty(idRecord) ? 0 : Convert.ToInt32(idRecord)));
                ShContext.Current.Data["Entity"] = new {t.Title, t.Image, t.Href, t.Position, t.Active};
            }
        }

        /// <summary>
        /// UPDATE
        /// </summary>
        public void updateRecordBanners()
        {
            var id = HttpContext.Current.Request.Params["idItem"];
            var title = HttpContext.Current.Request.Params["title"];
            var content = HttpContext.Current.Request.Params["content"];
            var img = HttpContext.Current.Request.Params["image"];
            var href = HttpContext.Current.Request.Params["href"];
            var position = HttpContext.Current.Request.Params["position"];
            var active = HttpContext.Current.Request.Params["active"];
            if (id != null)
            {
                _bannerSlides.UPDATE_BANNERS(string.IsNullOrEmpty(id) ? 0 : Convert.ToInt32(id), title, content, img, href,
                    string.IsNullOrEmpty(position) ? 0 : Convert.ToInt32(position),
                    !string.IsNullOrEmpty(active) && bool.Parse(active));
            }
        }

        /// <summary>
        /// INSERT
        /// </summary>
        public void insertRecordBanners()
        {
            var title = HttpContext.Current.Request.Params["title"];
            var content = HttpContext.Current.Request.Params["content"];
            var img = HttpContext.Current.Request.Params["image"];
            var href = HttpContext.Current.Request.Params["href"];
            var position = HttpContext.Current.Request.Params["position"];
            var active = HttpContext.Current.Request.Params["active"];
            _bannerSlides.INSERT_BANNER(title.Trim(), content, img, href.Trim(),
                string.IsNullOrEmpty(position) ? 0 : Convert.ToInt32(position),
                !string.IsNullOrEmpty(active) && bool.Parse(active));
        }
    }
}