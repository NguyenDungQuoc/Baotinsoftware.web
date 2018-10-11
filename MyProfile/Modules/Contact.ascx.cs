using System;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Modules
{
    public partial class Contact : UserControl, IAjax
    {
        private readonly SendContact _sendContact = new SendContact();
        private readonly PageSeo _pageSeo = new PageSeo();
        private readonly UserAdmin _userAdmin = new UserAdmin();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {                
                BindData_ContactPage();
            }
        }

        private void BindData_ContactPage()
        {
            var t = _pageSeo.GET_TABLE_PAGE_IDPAGE(1).FirstOrDefault();
            if (t != null)
            {
                ltr_InfoContact.Text = t.Contact;
                ltrMaps.Text = t.MapCode;
            }
            ClearAllControlInput();
        }

        private void ClearAllControlInput()
        {
            txtFirstName.Text = "";
            txtEmail.Text = "";
            txtLastName.Text = "";
            txtPhone.Text = "";
            txtSubject.Text = "";
            txtMessage.Text = "";
        }

        protected void btnSendEmail_OnClick(object sender, EventArgs e)
        {
            ltrError.Text = "";
            var firstName = txtFirstName.Text.Trim();
            var lastName = txtLastName.Text.Trim();
            var email = txtEmail.Text.Trim();
            var mobile = txtPhone.Text.Trim();
            var fullname = firstName + " " + lastName;
            var subject = txtSubject.Text.Trim();
            var content = txtMessage.Text.Trim();
            if (fullname != "" && email != "" && mobile != "")
            {
                SendEmailForAdmin(fullname, email, mobile, content);
                _sendContact.INSERT_CONTACT(fullname, subject, email, mobile, content, 0, DateTime.Now);
                ltrError.Text = "<span style='color: #00BDF5; font-size: 16px;'><i class='fa fa-check-square-o'></i> Cảm ơn bạn đã liên hệ với chúng tôi. Chúng tôi sẽ xem xét và phản hồi sớm nhất có thể</span>";
                //MessageBox("Thank you for conacting us. We will respond to your inquiruy as soon as we can.");
                ClearAllControlInput();                
            }
            else
            {
                ltrError.Text = "<span style='color: #d9534f; font-size: 14px;'><i class='fa fa-exclamation-triangle'></i> Please enter complete information</span>";
            }
        }

        private void SendEmailForAdmin(string fullname, string email, string mobile, string content)
        {
            var t = _userAdmin.GET_TABLE_USER_PRIMARYKEY(10);
            var emailTo = t.Email;
            var subject = "SYSTEMS FUJITEK.NET - NOTIFICATION";
            var body = @"Xin chào " + t.Fullname + ",";
            body += "<br/><br/><a href='http://baotinsoftware.com/'>BAOTINSOFTWARE.COM</a> thông báo, có một 'Liên Hệ' mới từ khách hàng " + fullname + ", vui lòng kiểm tra và xác nhận thông tin từ trang quản trị của bạn.";
            body += "<br/><br/>---<b>THÔNG TIN LIÊN HỆ</b>---";
            body += "<br/><i>Khách hàng:</i> " + fullname;
            body += "<br/><i>Điện thoại:</i> " + mobile;
            body += "<br/><i>Email:</i> " + email;
            body += "<br/><i>Nội dung:</i> '" + content + "'";
            body += "<br/><br/>Please do not respond to this message as it is automatically generated and is for information purposes only.";
            body += "<br/>(Vui lòng không trả lời email này, đây là email tự động tạo ra với mục đích thông tin)";
            _sendContact.SendEmail(emailTo, subject, body);
        }

        //private void MessageBox(string msg)
        //{
        //    Label lbl = new Label();
        //    lbl.Text = "<script language='javascript'>" + Environment.NewLine + "window.alert('" + msg + "')</script>";
        //    Page.Controls.Add(lbl);
        //}        
    }
}