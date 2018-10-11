using System;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Modules
{
    public partial class Gallery : UserControl
    {
        GalleryImage g = new GalleryImage();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData_GalleryImage();
            }
        }

        private void LoadData_GalleryImage()
        {
            rpt_Gallery.DataSource = g.GET_TABLE_GALLERY().Where(p => p.Active ?? false).OrderByDescending(w => w.ID).ToList();
            rpt_Gallery.DataBind();            
        }        

        public string GetTagFullImage(string path, int w, int h)
        {
            //Hàm Thumb Ảnh
            if (path != null)
            {
                var s = Server.MapPath(path);
                var image = Image.FromFile(s);
                using (var thumbnail = image.GetThumbnailImage(w, h, new Image.GetThumbnailImageAbort(ThumbnailCallback), IntPtr.Zero))
                {
                    using (var memoryStream = new MemoryStream())
                    {
                        thumbnail.Save(memoryStream, ImageFormat.Png);
                        var bytes = new byte[memoryStream.Length];
                        memoryStream.Position = 0;
                        memoryStream.Read(bytes, 0, bytes.Length);
                        var base64String = Convert.ToBase64String(bytes, 0, bytes.Length);

                        return "data:image/png;base64," + base64String;
                    }
                }
            }
            return "";
        }

        public bool ThumbnailCallback()
        {
            return false;
        }     
        
    }
}