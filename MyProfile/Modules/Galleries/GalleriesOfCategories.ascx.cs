using System;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Modules.Galleries
{
    public partial class GalleriesOfCategories : UserControl
    {
        GalleryImage g = new GalleryImage();
        NewsBlogProvider n = new NewsBlogProvider();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind_DataGalleriesOfCAtegories();
            }
        }

        private void Bind_DataGalleriesOfCAtegories()
        {
            var galleryCategoryId = 1;
            rpt_GalleriesOfCategories.DataSource =
                g.GET_TABLE_GALLERY()
                    .Where(w => w.Active == true && w.ID_GroupGallery == galleryCategoryId)
                    .OrderByDescending(w => w.ID)
                    .ToList();
            rpt_GalleriesOfCategories.DataBind();
            const int catId = 11; //STRATEGIC PARTNERS
            var t = n.GET_TABLE_NEWS().Where(w => w.ID_GroupNews == catId).Take(1).FirstOrDefault();
            ltrTitle.Text = t.Title;
            if (Request.Url.AbsolutePath == "/home.aspx")
            {
                hdf_Style.Value = "";
                ltr_Content.Text = "";
            }
            else
            {
                hdf_Style.Value = "margin-top: 200px;";                                
                ltr_Content.Text = t.Content;                
            }
        }
    }
}