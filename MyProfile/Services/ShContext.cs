using System.Web;
using System.Collections.Generic;
using Newtonsoft.Json;
namespace MyProfile.Class
{
    /// <summary>
    /// ShContext
    /// </summary>
    public class ShContext
    {
        /// <summary>
        /// 
        /// </summary>
        private ShContext() { }

        /// <summary>
        /// Context Current
        /// </summary>
        public static ShContext Current
        {
            get
            {
                var context = HttpContext.Current.Items["ShContext"] as ShContext;
                if (context == null)
                    HttpContext.Current.Items["ShContext"] = context = new ShContext();
                return context;
            }
        }

        private string javaScript = string.Empty;
        /// <summary>
        /// Javascript
        /// </summary>
        public string JavaScript
        {
            get { return javaScript; }
            set { javaScript += value + ";"; }
        }

        private Dictionary<string, object> data = new Dictionary<string, object>();
        /// <summary>
        /// Data
        /// </summary>
        public Dictionary<string, object> Data
        {
            get { return data; }
            set { data = value; }
        }
    }

    /// <summary>
    /// Mở rộng phương thức cho ShContext => gọi các hàm Js
    /// </summary>
    public static class ShContextExtension
    {
        /// <summary>
        /// Gọi hàm Alert
        /// </summary>
        /// <param name="context"></param>
        /// <param name="msg"></param>
        public static void Alert(this ShContext context, string msg)
        {
            context.JavaScript = "alert(" + JsonConvert.SerializeObject(msg) + ")";
        }
    }
}