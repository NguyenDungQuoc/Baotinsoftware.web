using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.Gallery
{
    public partial class WebUserControl1 : UserControl
    {
        GalleryImage g = new GalleryImage();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                View_ListGallery();
                BindGroupGallery();
            }
        }
        /// <summary>
        /// Bind Data lên DropdownList
        /// </summary>
        private void BindGroupGallery()
        {
            rptGroupGallery.DataSource = g.GET_TABLE_GROUP_GALLERY();
            rptGroupGallery.DataBind();
        }

        /// <summary>
        /// Lấy danh sách Gallery
        /// </summary>
        private void View_ListGallery()
        {
            rptListGallery.DataSource =
                g.GET_TABLE_GALLERY().OrderByDescending(w => w.ID).ToList();
            rptListGallery.DataBind();
        }

        public void updateRecordGallery()
        {
            var id = HttpContext.Current.Request.Params["idItem"];
            string title = HttpContext.Current.Request.Params["title"];
            string content = HttpContext.Current.Request.Params["content"];
            string href = HttpContext.Current.Request.Params["href"];
            var idGroupGallery = HttpContext.Current.Request.Params["idGroupGallery"];
            var active = HttpContext.Current.Request.Params["active"];
            if (id != null)
            {
                g.UPDATE_GALLERY((string.IsNullOrEmpty(id) ? 0 : Convert.ToInt32(id)), title, href, content,
                    Convert.ToInt32(idGroupGallery), !string.IsNullOrEmpty(active) && bool.Parse(active));
            }
        }

        /// <summary>
        /// Insert New Record
        /// </summary>
        public void insertRecordGallery()
        {
            string title = HttpContext.Current.Request.Params["title"];
            string content = HttpContext.Current.Request.Params["content"];
            string href = HttpContext.Current.Request.Params["href"];
            var idGroupGallery = HttpContext.Current.Request.Params["idGroupGallery"];
            var active = HttpContext.Current.Request.Params["active"];
            g.INSERT_GALLERY(title, href, content, DateTime.Now, Convert.ToInt32(idGroupGallery), !string.IsNullOrEmpty(active) && bool.Parse(active));
        }

        /// <summary>
        /// Bind Data Record
        /// </summary>
        public void bindRecordToEdit()
        {
            try
            {
                var idRecord = HttpContext.Current.Request.Params["idRecord"];
                if (idRecord != null)
                {                    
                    var t = g.GET_TABLE_GALLERY().FirstOrDefault(w => w.ID == (string.IsNullOrEmpty(idRecord) ? 0 : Convert.ToInt32(idRecord)));
                    ShContext.Current.Data["Entity"] = new { t.Title, t.Content, t.ID_GroupGallery, t.Active, t.Href };
                }
                
            }
            catch (Exception)
            {
                ShContext.Current.Alert("Thất bại ! Vui lòng kiểm tra lại.");
            }
            
        }

        /// <summary>
        /// Delete Record
        /// </summary>
        public void DeleteRecordGallery()
        {
            try
            {
                var id = HttpContext.Current.Request.Params["idGallery"];
                g.DELETE_GALLERY_ID((string.IsNullOrEmpty(id) ? 0 : Convert.ToInt32(id)));
            }
            catch (Exception)
            {
                ShContext.Current.Alert("Thất bại ! Vui lòng kiểm tra lại.");
            }
        }        

        protected void rptListGallery_OnItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            var t = g.GET_TABLE_GALLERY().FirstOrDefault(w => w.ID == id);
            switch (e.CommandName)
            {
                case ("IsActive"):
                    bool k = Convert.ToBoolean(t.Active);
                    if (k)
                    {
                        g.UPDATE_ACTIVE_GALLERY(id, false);
                        (e.CommandSource as LinkButton).Text = Utility.GetLabelIsActive(false, "Ẩn", "Hiện");
                    }
                    else
                    {
                        g.UPDATE_ACTIVE_GALLERY(id, true);
                        (e.CommandSource as LinkButton).Text = Utility.GetLabelIsActive(true, "Ẩn", "Hiện");
                    }
                    break;
            }
        }
    }
}