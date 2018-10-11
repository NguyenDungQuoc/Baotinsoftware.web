using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web;
namespace MyProfile.Class
{
    public class RewriteAspx : RewriteBase
    {
        /// <summary>
        /// Ðây là hàm
        /// urlGetten là url ảo => trên thanh địa chỉ
        /// trả ra là url thật
        /// </summary>
        /// <param name="urlGetten"></param>
        /// <returns></returns>
        public override string GetMatchingRewrite(string urlGetten)
        {
            foreach (var rw in PageConfigs)
            {
                var rex = new Regex("http://" + HttpContext.Current.Request.Url.Authority + "/" + rw.Virtual + ".html");

                // Kiểm tra xem url trên thanh địa chỉ có đúng định dạng ko
                var match = rex.Match(urlGetten);

                if (match.Success) return rex.Replace(urlGetten, rw.Real);
            }

            return string.Empty;
        }

        /// <summary>
        /// Cái này sau này lưu ở db hoặc file xml
        /// 
        /// </summary>
        public static List<RewiteItem> PageConfigs = new List<RewiteItem> 
        {
            new RewiteItem { Virtual = "trang-chu", Real = "/home.aspx" },
            new RewiteItem { Virtual = "trang-chu/page-([0-9]+)", Real = "/home.aspx?page=$1" },
            new RewiteItem { Virtual = "404", Real = "/404.aspx" },
            new RewiteItem { Virtual = "download", Real = "/download.aspx" },            
            new RewiteItem { Virtual = "lien-he", Real = "/contact.aspx" },
            new RewiteItem { Virtual = "tim-kiem", Real = "/search.aspx" },
            new RewiteItem { Virtual = $"{MyConstant.HashtagAliasVn}/([^/]+)-([0-9]+)", Real = "/search.aspx?ht=$2" },
            new RewiteItem { Virtual = "the-loai/([^/]+)-([0-9]+)", Real = "/portfolio.aspx?id=$2" },
            new RewiteItem { Virtual = "san-pham-0", Real = "/products.aspx?id=0" },
            new RewiteItem { Virtual = "san-pham", Real = "/products.aspx" },
            new RewiteItem { Virtual = "san-pham/([^/]+)-([0-9]+)", Real = "/category.aspx?id=$2" },
            new RewiteItem { Virtual = "san-pham/([^/]+)-([0-9]+)/page-([0-9]+)", Real = "/category.aspx?id=$2&page=$3" },            
            new RewiteItem { Virtual = "san-pham/([^/]+)/([^/]+)-([0-9]+)", Real = "/productdetail.aspx?id=$3" },
            new RewiteItem { Virtual = "([^/]+)-([0-9]+)", Real = "/news.aspx?id=$2" },
            new RewiteItem { Virtual = "([^/]+)/([^/]+)-([0-9]+)", Real = "/article.aspx?id=$3" }
        };
    }

    public class RewiteItem
    {
        public string Virtual { set; get; }
        public string Real { set; get; }
    }
}