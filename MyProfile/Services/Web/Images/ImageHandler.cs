using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using MyProfile.Class;

namespace MyProfile.Services.Web.Images
{
    /// <summary>
    /// Xử lý request image
    /// </summary>
    public class ImageHandler : IHttpHandler
    {
        /// <summary>
        /// Thực hiện xử lý request tài nguyên image
        /// </summary>
        /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {
            // context.Response.Write("Hello from custom handler.");
            var strRegex = "http://{0}/w([0-9]+)h([0-9]+)/(.*).img".Frmat(context.Request.Url.Authority);
            var rex = new Regex(strRegex, RegexOptions.IgnoreCase);
            var url = HttpUtility.UrlDecode(context.Request.Url.AbsoluteUri);
            var match = rex.Match(url);

            if (!match.Success) return;
            
            // Độ rộng cần thumb
            var w = Convert.ToInt32(match.Groups[1].Value);
            // Chiều cao ảnh cần thumb
            var h = Convert.ToInt32(match.Groups[2].Value);

            // if (!(w == 300 && h == 250)) return;
           

            var path = match.Groups[3].Value;

            var fileName = GetFileName(path, w, h);
            var saveFolder = AppSettings.Inst.SaveFolder;

            var filePath = context.Server.MapPath("~/{0}/{1}/{2}".Frmat(saveFolder, fileName[0], fileName[1]));

            var exits = File.Exists(filePath);

            if (!exits)
            {
                var root = "/";
                Image image;
                if (root.IndexOf("http://", StringComparison.Ordinal) >= 0)
                {
                    var request = (HttpWebRequest)WebRequest.Create(root + path);
                    request.Timeout = 10000;
                    var response = (HttpWebResponse)request.GetResponse();
                    image = Image.FromStream(response.GetResponseStream() ?? throw new InvalidOperationException());
                }
                else
                {
                    var imageFile = context.Server.MapPath("~{0}{1}".Frmat(root, path));
                    image = Image.FromFile(imageFile);
                }

                if (AppSettings.Inst.IsSaveThumb)
                {
                    var folder = context.Server.MapPath("~/{0}/{1}/".Frmat(saveFolder, fileName[0]));
                    if (!Directory.Exists(folder))
                        Directory.CreateDirectory(folder);
                }

                DoImage(image, w, h, filePath);
            }

            if (AppSettings.Inst.IsSaveThumb)
                context.Response.Redirect("/{0}/{1}/{2}".Frmat(saveFolder, fileName[0], fileName[1]));
        }

        private string _exten = string.Empty;
        private string[] GetFileName(string path, int w, int h)
        {
            var fileNameOri = path.Substring(path.LastIndexOf("/", StringComparison.Ordinal) + 1); // file.extension
            var folder = path.Substring(0, path.LastIndexOf("/", StringComparison.Ordinal));
            var extension = fileNameOri.Substring(fileNameOri.LastIndexOf(".", StringComparison.Ordinal) + 1);
            var fileName = fileNameOri.Substring(0, fileNameOri.LastIndexOf(".", StringComparison.Ordinal));

            var str = new string[2];
            str[0] = folder;
            str[1] = fileName + (w < 0 ? string.Empty : "_w" + w) + (h < 0 ? string.Empty : "_h" + h) + "." + extension;
            _exten = extension;
            return str;
        }

        private void DoImage(Image image, int toWidth, int toHeight, string path)
        {
            var rWidth = image.Width; // Chiều rộng của ảnh
            var rHeight = image.Height; // Chiều cao của ảnh

            //Nếu một trong 2 kích thước cần thumb = 0
            if (toWidth == 0 || toHeight == 0)
            {
                // Thumb theo chiều rộng
                if (toWidth != 0 && toHeight == 0 && toWidth < rWidth)
                {
                    toHeight = (toWidth * rHeight) / rWidth;
                }
                // Thumb theo chiều cao
                else if (toHeight != 0 && toWidth == 0 && toHeight < rHeight)
                {
                    toWidth = (toHeight * rWidth) / rHeight;
                }
                // Các trường hợp còn lại thì ko thumb, giữ nguyên kích thước ảnh
                else
                {
                    toWidth = rWidth;
                    toHeight = rHeight;
                }
            }
            // Nếu cả hai kích thước khác không
            else
            {
                // Cả 2 kích thước đều nhỏ hơn kích thước thực thì chỉ crop
                if (toWidth <= rWidth && toHeight <= rHeight)
                {
                    //Giữ nguyên kích thước thumb
                }
                // Một trong 2 kích thước nhỏ hơn kích thước thực thì mới thực hiện
                else if (toWidth < rWidth || toHeight < rHeight)
                {
                    if ((rWidth / toWidth) > (rHeight / toHeight))
                        toHeight = (int)(rHeight * ((double)toWidth / (double)rWidth));
                    else
                        toWidth = (int)(rWidth * ((double)toHeight / (double)rHeight));
                }
                else if (toWidth < rWidth && toHeight > rHeight)
                    toHeight = rHeight;
                // Trường hợp còn lại thì không thumb, giữ nguyên kích thước ảnh
                else
                {
                    toWidth = rWidth;
                    toHeight = rHeight;
                }
            }

            var img = Crop(image, toWidth, toHeight, AnchorPosition.Center);
            using (var thumb = new Bitmap(img))
            {
                //thumb.SetResolution(P_Width, P_Width);
                using (var g = Graphics.FromImage(thumb)) // Create Graphics object from original Image
                {
                    g.SmoothingMode = SmoothingMode.HighQuality;
                    g.InterpolationMode = InterpolationMode.High;
                    g.CompositingQuality = CompositingQuality.HighQuality;
                    //Set Image codec of JPEG type, the index of JPEG codec is "1"
                    var codec = ImageCodecInfo.GetImageEncoders()[1];
                    //Set the parameters for defining the quality of the thumbnail... here it is set to 100%
                    var eParams = new EncoderParameters(1);
                    eParams.Param[0] = new EncoderParameter(Encoder.Quality, 92L);
                    //Now draw the image on the instance of thumbnail Bitmap object
                    g.DrawImage(thumb, new Rectangle(0, 0, thumb.Width, thumb.Height));

                    if (AppSettings.Inst.IsSaveThumb)
                        thumb.Save(path, codec, eParams);
                    else
                        thumb.Save(HttpContext.Current.Response.OutputStream, codec, eParams);
                }
            }
        }
        private Image Crop(Image imgPhoto, int width, int height, AnchorPosition anchor)
        {
            var sourceWidth = imgPhoto.Width;
            var sourceHeight = imgPhoto.Height;
            var sourceX = 0;
            var sourceY = 0;
            var destX = 0;
            var destY = 0;

            float nPercent = 0;
            float nPercentW = 0;
            float nPercentH = 0;

            nPercentW = (float)width / (float)sourceWidth;
            nPercentH = (float)height / (float)sourceHeight;

            if (nPercentH < nPercentW)
            {
                nPercent = nPercentW;
                switch (anchor)
                {
                    case AnchorPosition.Top:
                        destY = 0;
                        break;
                    case AnchorPosition.Bottom:
                        destY = (int)(height - (sourceHeight * nPercent));
                        break;
                    default:
                        destY = (int)((height - (sourceHeight * nPercent)) / 2);
                        break;
                }
            }
            else
            {
                nPercent = nPercentH;
                switch (anchor)
                {
                    case AnchorPosition.Left:
                        destX = 0;
                        break;
                    case AnchorPosition.Right:
                        destX = (int)(width - (sourceWidth * nPercent));
                        break;
                    default:
                        destX = (int)((width - (sourceWidth * nPercent)) / 2);
                        break;
                }
            }

            var destWidth = (int)(sourceWidth * nPercent);
            var destHeight = (int)(sourceHeight * nPercent);

            var bmPhoto = new Bitmap(width, height, PixelFormat.Format24bppRgb);
            bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

            var grPhoto = Graphics.FromImage(bmPhoto);
            grPhoto.Clear(Color.White);
            grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;
            grPhoto.DrawImage(imgPhoto,
                new Rectangle(destX, destY, destWidth, destHeight),
                new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
                GraphicsUnit.Pixel);

            grPhoto.Dispose();
            return bmPhoto;
        }

        enum AnchorPosition
        {
            Top,
            Center,
            Bottom,
            Left,
            Right
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}
