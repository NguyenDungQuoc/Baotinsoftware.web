using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;

namespace MyProfile.Class
{
    
        /// <summary>
        /// Thực hiện xử lý một Request Ajax
        /// </summary>
        public class AjaxHandler : IHttpHandler, IRequiresSessionState
        {
            /// <summary>
            /// Xử lý Request
            /// </summary>
            /// <param name="context"></param>
            public void ProcessRequest(HttpContext context)
            {
                // Request client  đang thực hiện
                var request = context.Request;

                // Type của đối tượng chứa phương thức Ajax mà client đang yêu cầu
                var typeAjaxable = string.Format("{0}.{1},{0}", request.QueryString["_n"], request.QueryString["_o"]);

                try
                {
                    //
                    var typeAjax = Type.GetType(typeAjaxable);

                    // Lấy phương thức cần thực hiện
                    var method = typeAjax.GetMethod(request.QueryString["_m"]);

                    // Gọi phương thức
                    method.Invoke(Activator.CreateInstance(typeAjax) as IAjax, new object[] { });
                }
                catch (Exception ex)
                {
                    // Lấy ra Exception ở bên trong
                    var exInner = ex.InnerException;

                    // Chừng nào mà Exception bên trong không phải null thì kiểm tra lấy tiếp
                    Exception exTemp = null;
                    while (exInner != null)
                    {
                        exTemp = exInner;
                        exInner = exInner.InnerException;
                    }

                    // Lấy ra Exeption
                    exTemp = exTemp ?? ex;

                    // Thông báo
                    ResponseMessage.Current.Data["MessageError"] = exTemp.Message;
                }
                finally
                {
                    context.Response.Write(JsonConvert.SerializeObject(ResponseMessage.Current));
                }
            }

            /// <summary>
            ///
            /// </summary>
            public bool IsReusable
            {
                get { return true; }
            }
        }

        public interface IAjax { }

        /// <summary>
        /// Message được dùng để truyền tải nội dung xuống client
        /// </summary>
        public class ResponseMessage
        {
            private string javaScript = string.Empty;
            /// <summary>
            /// JavaScript cần yêu cầu thực hiện xuống client
            /// </summary>
            public string JavaScript
            {
                get { return this.javaScript; }
                set { this.javaScript += value + ";"; }
            }

            private Dictionary<string, object> data = new Dictionary<string, object>();
            /// <summary>
            /// Data. Đối tượng kiểu mảng truyền xuống client
            /// </summary>
            public Dictionary<string, object> Data
            {
                get { return data; }
            }

            private string html = string.Empty;
            /// <summary>
            /// Nội dung Html muốn gửi xuống client
            /// </summary>
            public string Html
            {
                set { this.html = value; }
                get { return this.html; }
            }

            /// <summary>
            /// Response mong muốn trả về tại thời điểm hiện thời
            /// </summary>
            public static ResponseMessage Current
            {
                get
                {
                    // Lấy ra ResponseMessage ở trong Request hiện thời
                    var response = HttpContext.Current.Items["ResponseMessage"] as ResponseMessage;

                    // Nếu chưa có thì khởi tạo mời
                    if (response == null) HttpContext.Current.Items["ResponseMessage"] = response = new ResponseMessage();

                    // return
                    return response;
                }
            }
        }    
}