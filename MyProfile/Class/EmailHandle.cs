using System.Net;
using System.Net.Mail;
using System.Text;

namespace MyProfile.Class
{
    public class EmailHandle
    {
        public SmtpClient Smtp { set; get; } = new SmtpClient();

        public MailMessage Mail { set; get; } = new MailMessage();

        /// <summary>
        /// Email của người gửi
        /// </summary>
        public string EmailFrom { set; get; } = "web.system247@gmail.com";

        /// <summary>
        /// Mật khẩu địa chỉ Email người gửi
        /// </summary>
        public string PasswordEmailFrom { set; get; } = "elite1251";

        /// <summary>
        /// Tên người gửi
        /// </summary>
        public string SendBy { set; get; } = "SYSTEMS VISOFTWARE.VN";

        /// <summary>
        /// Phương thức khởi tạo
        /// </summary>
        public EmailHandle()
        {
            Smtp.EnableSsl = true;
            Smtp.Host = "smtp.gmail.com";
            Smtp.UseDefaultCredentials = false;
            Smtp.Credentials = new NetworkCredential(EmailFrom, PasswordEmailFrom);
            Smtp.Port = 587;
            Mail.From = new MailAddress(EmailFrom, SendBy);
            Mail.BodyEncoding = Mail.SubjectEncoding = Encoding.UTF8;
            Mail.IsBodyHtml = true;
            Mail.Priority = MailPriority.High;
        }

        /// <summary>
        /// Gửi mail
        /// </summary>
        /// <returns></returns>
        public bool Send()
        {
            try
            {
                Smtp.Send(Mail);
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}