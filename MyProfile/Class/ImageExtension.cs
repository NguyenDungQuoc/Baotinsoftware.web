using System;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace MyProfile.Class
{
    public static class ImageExtension
    {
        /// <summary>
        /// Kiểm tra string có phải là Url Image hay không?
        /// </summary>
        /// <param name="img">(.png|.jpg|.jpe|.gif)</param>
        /// <returns></returns>
        public static bool IsImage(this string img)
        {
            var regex = new Regex(@"([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.jpe|.gif)$");
            return img.IsNotNullOrNotWhiteSpace() && regex.IsMatch(img.ToLower());
        }

        /// <summary>
        /// Convert Base64 Image To Image
        /// </summary>
        /// <param name="base64String"></param>
        /// <param name="path">Đường dẫn lưu file</param>
        /// <returns></returns>
        public static string Base64ToImage(this string base64String, string path)
        {
            if (!base64String.IsNotNullOrNotWhiteSpace() || base64String.Equals(MyConstant.AvatarAnonymous)) return base64String;
            const string flagJpg = "data:image/jpeg;base64,";
            const string flagPng = "data:image/png;base64,";
            const string flagGif = "data:image/gif;base64,";
            var format = string.Empty;

            if (base64String.Contains(flagJpg))
            {
                format = ".jpg";
                base64String = base64String.Replace(flagJpg, "");
            }
            else if (base64String.Contains(flagPng))
            {
                format = ".png";
                base64String = base64String.Replace(flagPng, "");
            }
            else if (base64String.Contains(flagGif))
            {
                format = ".gif";
                base64String = base64String.Replace(flagGif, "");
            }

            if (!format.IsNotNullOrNotWhiteSpace()) return base64String;
            // Convert Base64 String to byte[]
            var imageBytes = Convert.FromBase64String(base64String);
            var ms = new MemoryStream(imageBytes, 0, imageBytes.Length);
            // Convert byte[] to Image
            ms.Write(imageBytes, 0, imageBytes.Length);
            var image = Image.FromStream(ms, true);

            //Đường dẫn hình ảnh. {duongdan}{tenfile}{duoifile}
            var imgUrl = $"namnt_{DateTime.Now:HHmmss}{format}";
            //Save image
            image.Save(HttpContext.Current.Server.MapPath($"{path}{imgUrl}"));
            return $"{path}{imgUrl}";
        }

        /// <summary>
        /// Get list image attach and render string html
        /// </summary>
        /// <param name="obj">Array attach files</param>
        /// <returns></returns>
        public static string GetImageAttachComment(object obj)
        {
            if (!obj.IsNotNull()) return string.Empty;
            var imageList = obj.ToString().Split(',').ToList();
            var htmlBuilder = new StringBuilder("<div class='list-img-comment'>");
            foreach (var item in imageList)
            {
                if (item.IsNotNullOrNotWhiteSpace() && item.IsImage())
                    htmlBuilder.Append(
                        "<a style='background-image: url({0})' class='fancybox-thumb' rel='comment-thumb' href='{0}'></a>"
                            .Frmat(item.Trim()));
            }
            htmlBuilder.Append("</div>");
            return htmlBuilder.ToString();
        }
    }
}