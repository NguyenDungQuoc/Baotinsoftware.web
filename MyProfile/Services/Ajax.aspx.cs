using System;
using System.Web.UI;
using Newtonsoft.Json;
using MyProfile.Class;

namespace MyProfile.Services
{
    /// <summary>
    /// Thực hiện nhận yêu cầu từ client gửi lên
    /// </summary>
    public partial class Ajax : Page
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            // Type của đối tượng chứa phương thức Ajax mà client đang yêu cầu
            var typeAjaxable = string.Format("{0}.{1},{0}", Request.QueryString["_n"], Request.QueryString["_o"]);

            try
            {
                // Khởi tạo đối tượng ajax theo string type
                var objAjax = Activator.CreateInstance(Type.GetType(typeAjaxable));

                // Lấy phương thức cần thực hiện
                var method = objAjax.GetType().GetMethod(Request.QueryString["_m"]);

                // Gọi phương thức
                method.Invoke(objAjax, new object[] { });
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

                // Lỗi khác
                ShContext.Current.Data["MessageError"] = exTemp.Message;
            }
        }

        /// <summary>
        /// Thực hiện Render
        /// </summary>
        /// <param name="writer"></param>
        protected override void Render(HtmlTextWriter writer)
        {
            Response.Write(JsonConvert.SerializeObject(ShContext.Current));
        }
    }
}