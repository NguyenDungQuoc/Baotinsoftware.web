using System;
using System.Web;
using System.Web.UI;
using System.Web.SessionState;
using System.IO;

namespace MyProfile.Class
{
    /// <summary>
    /// Class Rewrite Url Base
    /// </summary>
    public class RewriteBase : IHttpHandlerFactory, IRequiresSessionState
    {
        /// <summary>
        /// Lấy ra đường link đang thực hiện request
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        private string GetUrl(HttpContext context)
        {
            if (context.Request.Url.Query != string.Empty)
                if (context.Request.Url.Query.Length > 0)
                {
                    context.Items["VirtualUrl"] = context.Request.Path + context.Request.Url.Query;
                    context.Items["VirtualQuery"] = context.Request.Url.Query;
                }

            if (context.Items["VirtualUrl"] == null)
                context.Items["VirtualUrl"] = context.Request.Path;

            var url = context.Request.Url.AbsolutePath;

            while (url.EndsWith("/") && !string.IsNullOrEmpty(url))
                url = url.Substring(0, url.Length - 1);

            url = "http://" + HttpContext.Current.Request.Url.Authority + url;

            return url;
        }

        /// <summary>
        /// Thực hiện Request
        /// </summary>
        /// <param name="context"></param>
        /// <param name="requestType"></param>
        /// <param name="url"></param>
        /// <param name="pathTranslated"></param>
        /// <returns></returns>
        public IHttpHandler GetHandler(HttpContext context, string requestType, string url, string pathTranslated)
        {
            // Lấy ra Url đang thực hiện request
            var urlPath = GetUrl(context);

            // Map lấy ra url thật
            var rewrite = GetMatchingRewrite(urlPath);//url la ao => rewrite

            // Nếu không lấy được thì trả url có nội dung rỗng
            if (string.IsNullOrEmpty(rewrite))
            {
                if (File.Exists(context.Server.MapPath("~/" + url)))
                {
                    context.Response.Write(File.ReadAllText(context.Server.MapPath("~/" + url)));
                    context.Response.ContentType = "text/html";
                    return null;
                }
                rewrite = @"/404.aspx";
            }

            // Lấy các QueryString
            var newFilePath = rewrite.IndexOf("?", StringComparison.Ordinal) > 0 ? rewrite.Substring(0, rewrite.IndexOf("?", StringComparison.Ordinal)) : rewrite;

            foreach (var k in context.Request.QueryString.AllKeys)
                rewrite += $"&{k}={context.Request.QueryString[k]}";

            // Rewrite lại đường link
            context.RewritePath(rewrite);

            return PageParser.GetCompiledPageInstance(newFilePath, context.Server.MapPath(newFilePath), context);
        }

        /// <summary>
        /// Mở ra phương thức lấy đường link thật từ đường link ảo
        /// </summary>
        /// <param name="urlGetten"></param>
        /// <returns></returns>
        public virtual string GetMatchingRewrite(string urlGetten)
        {
            throw new Exception("Chưa viết lại hàm GetMatchingRewrite khi kế thừa RewriteBase");
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="handler"></param>
        public void ReleaseHandler(IHttpHandler handler)
        {
        }
    }
}