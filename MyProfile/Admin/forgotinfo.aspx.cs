using System;
using System.Drawing;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Admin
{
    public partial class forgotinfo : Page
    {
        private readonly UserAdmin _userAdmin = new UserAdmin();

        protected void btn_SendRequest_OnClick(object sender, EventArgs e)
        {
            if (txtEmail.Text.Trim().IsEmail())
            {
                var t = _userAdmin.GetUserByEmail(txtEmail.Text.Trim());
                if (t != null)
                {
                    var newPwd = "{0}n{1}t{2}n{3}".Frmat(DateTime.Now.Millisecond, DateTime.Now.Minute, DateTime.Now.Day, DateTime.Now.Month);
                    //===== CONTENT EMAIL =====
                    var recipient = txtEmail.Text.Trim();
                    var subject = "SYSTEMS {0} - NOTIFICATION".Frmat(MyConstant.DomainVisoftware.ToUpper());
                    var body = "Hello " + t.Fullname + ",";
                    body += "<br/>You asked for password retrieval SYSTEMS {0}".Frmat(MyConstant.DomainVisoftware.ToUpper());
                    body += "<br/>This email contains your password to log in to {0}".Frmat(MyConstant.LinkVisoftware);
                    body += "<br/><br/>New Password: {0}".Frmat(newPwd);
                    body += "<br/><br/>Please do not respond to this message as it is automatically generated and is for information purposes only.";
                    body += "<br/>(Vui lòng không trả lời email này, đây là email tự động tạo ra với mục đích thông tin)";
                    var email = new EmailHandle();
                    email.Mail.To.Add(recipient);
                    email.Mail.Subject = subject;
                    email.Mail.Body = body;
                    if (email.Send())
                    {
                        _userAdmin.CHANGE_PASSWORD(t.Username, newPwd);
                        txtEmail.Text = "";
                        lblshow.Text = "<i class='fa fa-cogs'></i> Please check your email to receive a new password";
                        lblshow.ForeColor = Color.Blue;
                    }
                    else
                    {
                        lblshow.Text = "<i class='fa fa-cogs'></i> Systems are incidents occurred. Please try again in a few minutes";
                    }
                }
                else
                {
                    lblshow.Text =
                        "<i class='fa fa-cogs'></i> This email does not exist in the system. Please enter a different email";
                }
            }
            else
            {
                lblshow.Text = "<i class='fa fa-cogs'></i> This email is invalid. Please enter a different email";
            }
        }
    }
}