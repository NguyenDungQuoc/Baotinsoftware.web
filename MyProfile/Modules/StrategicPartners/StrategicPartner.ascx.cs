using MyProfile.Class;
using System;
using System.Linq;

namespace MyProfile.Modules.StrategicPartners
{
    public partial class StrategicPartner : System.Web.UI.UserControl
    {
        GalleryImage g = new GalleryImage();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData_PartnersInitial();
            }            
        }

        private void LoadData_PartnersInitial()
        {
            int galleryCategoryId = 1; // Strategic Partners
            rpt_StrategicPartners.DataSource =
                g.GET_TABLE_GALLERY()
                .Where(w => w.Active == true && w.ID_GroupGallery == galleryCategoryId)
                .OrderByDescending(w => w.ID).ToList();
            rpt_StrategicPartners.DataBind();
        }
    }
}