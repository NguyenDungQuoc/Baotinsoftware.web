using System;
using System.Web;
using MyProfile.Class;

namespace MyProfile.Services.Web.Images
{
    /// <inheritdoc />
    /// <summary>
    /// Xử lý tạo đường dẫn ảnh
    /// </summary>
    public class PathImage : Singleton<PathImage>
    {
        /// <summary>
        /// Đường dẫn chứa ảnh thum
        /// </summary>
        /// <param name="src"></param>
        /// <param name="w"></param>
        /// <param name="h"></param>
        /// <returns></returns>
        public string GetPath(string src, int w, int h)
        {
            if (!string.IsNullOrEmpty(src) && src.Length > 0 && src.LastIndexOf(".", StringComparison.Ordinal) != -1)
            {
                var strFirst = src.Substring(0, src.LastIndexOf(".", StringComparison.Ordinal));
                var strLast = src.Substring(src.LastIndexOf(".", StringComparison.Ordinal), src.Length - src.LastIndexOf(".", StringComparison.Ordinal));
                src = $"{strFirst}_w{w}_h{h}{strLast}";
                return $"/{AppSettings.Inst.SaveFolder}/{src.TrimStart('/')}";
            }
            return string.Empty;
        }

        /// <summary>
        /// Full Path For Tag
        /// </summary>
        /// <param name="src"></param>
        /// <param name="title"></param>
        /// <param name="cssClass"></param>
        /// <returns></returns>
        public string GetTagFullImage(object src, object title, string cssClass = "")
        {
            return $"<img src='{src}' title=\"{HttpUtility.HtmlEncode(title)}\" class=\"{cssClass}\" />";
        }

        private readonly string img = "<img data-src='{0}' title=\"{1}\" class=\"{2}\" />";

        /// <summary>
        /// Tạo tag img có chứa thumb ảnh
        /// </summary>
        /// <param name="src"></param>
        /// <param name="w"></param>
        /// <param name="h"></param>
        /// <param name="title"></param>
        /// <param name="cssClass"></param>
        /// <returns></returns>
        public string GetImageTag(object src, int w, int h, object title, string cssClass = "")
        {
            var path = GetPath(src.ToString(), w, h);

            if (string.IsNullOrEmpty(path)) return string.Empty;
            //return img.Frmat(AppSettings.Inst.StaticDomain + "/images/noimage.jpg", HttpUtility.HtmlEncode(title));

            return string.Format(img, path, HttpUtility.HtmlEncode(title), cssClass);
        }
    }
}
