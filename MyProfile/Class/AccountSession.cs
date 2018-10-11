using System;
using System.Web;
using System.Web.Security;

namespace MyProfile.Class
{
    /// <summary>
    /// T Ở đây là thông tin của một Account
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class AccountSession<T> : Singleton<AccountSession<T>> where T : class, IAccount, new()
    {
        private string _keySession = string.Empty;
        /// <summary>
        /// Key lưu session và cookies của account login
        /// </summary>
        protected string KeySession
        {
            get
            {
                // Tên Session
                if (string.IsNullOrEmpty(_keySession)) _keySession = typeof(T).FullName;
                return _keySession;
            }
        }

        /// <summary>
        /// Đối tượng chứa thông tin Account được lưu tong session
        /// </summary>
        private T Info
        {
            get => HttpContext.Current.Session[KeySession] as T;
            set => HttpContext.Current.Session[KeySession] = value;
        }

        /// <summary>
        /// Kiểm tra xem đã được đăng nhập hay chưa
        /// </summary>
        public bool IsLoging => Refresh();

        /// <summary>
        /// Refresh
        /// </summary>
        /// <returns></returns>
        private bool Refresh()
        {
            // Khai báo biến để kiểm ra account đang đăng nhập hay chưa
            var isLogin = false;

            // Kiểm tra trong session có dữ liệu hay không
            // Không có nghĩa là chưa đănng nhập
            isLogin = Info != null;

            // Nếu trong session không có dữ liệu thì kiểu tra trong cookies
            if (!isLogin)
            {
                // Lấy ra cookie
                var cookie = HttpContext.Current.Request.Cookies[KeySession];

                // Kiểm tra xem cookie có rỗng hay không
                // Rỗng thì là chưa đăng nhập
                isLogin = !string.IsNullOrEmpty(cookie?.Value);

                // Nếu cookie có dữ liệu thì lấy ra thông tin người dùng và lại đưa vào session
                if (isLogin)
                {
                    // Khởi tạo thông tin Account
                    T t = new T();

                    // Truy vấn lấy thông tin. Nếu như tồn tại Member thì thiết lập vào Session
                    if (t.GetAccount(cookie.Value)) Info = t;
                }
            }

            return isLogin;
        }

        /// <summary>
        /// Session lưu trữ thông tin về Acccount
        /// </summary>
        public T AccountInfo
        {
            get
            {
                if (this.Info == null) Refresh();

                // Trả ra thông tin account đăng nhập
                return this.Info;
            }
        }

        /// <summary>
        /// Authen account 
        /// </summary>
        /// <param name="model"></param>
        public void Authen(T model)
        {
            // Đưa vào Session
            this.Info = model;

            // Đưa vào Cookie
            this.ExtendTimeCookie();
        }

        /// <summary>
        /// Thực hiện thoát ra khỏi hệ thống
        /// </summary>
        public void SignOut()
        {
            // Đưa cookie về giá trị Empty
            var cookie = new HttpCookie(KeySession) {Value = string.Empty};
            HttpContext.Current.Response.Cookies.Set(cookie);

            // Hủy session
            this.Info = null;
        }

        /// <summary>
        /// Gia hạn thêm cho cookie về thông tin account đăng nhập
        /// </summary>
        public void ExtendTimeCookie()
        {
            if (IsLoging)
            {
                // Tạo đối tượng Cookie lưu xuống client
                var cookie = new HttpCookie(KeySession)
                {
                    Value = this.Info.GetKey(),
                    Expires = DateTime.Now.AddDays(1)
                };

                // Gán giá trị cookie cần lưu xuống client

                // Thiết lập bảo mật
                // cookie.Secure = true;

                // Tăng thời gian hủy cookie lên 1 ngày

                // SetAuthCookie
                FormsAuthentication.SetAuthCookie(this.Info.GetKey(), true);

                // Đưa cookie xuống client
                // this.Page.Response.Cookies.Add(cookie);
                HttpContext.Current.Response.Cookies.Set(cookie);
            }
        }
    }
}