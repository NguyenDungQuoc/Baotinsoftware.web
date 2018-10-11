using System;
using MyProfile.Class;

namespace MyProfile.Admin
{
    public partial class login : System.Web.UI.Page
    {
        UserAdmin n = new UserAdmin();
        protected void Page_Load(object sender, EventArgs e)
        {            
            if (AccountSession<MyAccount>.Inst.IsLoging) // Nếu đã login rồi thì vào trang quản trị luôn.
            {
                Response.Redirect(@"/Admin/home.aspx");
            }            
        }

        protected void btn_Login_Click(object sender, EventArgs e)
        {
            lblshow.Text = "";
            if (txt_userID.Text.Trim() == "" || txt_password.Text == "")
            {
                lblshow.Text = "<i class='fa fa-warning'></i> Please enter Username and Password.";
            }
            else
            {
                MyAccount t = new MyAccount();
                if (t.Login(txt_userID.Text.Trim(), txt_password.Text.Trim()))
                {
                    if (n.CHECK_ISACTIVE_USER(txt_userID.Text.Trim().Trim()))
                    {
                        Response.Redirect(@"/Admin/home.aspx");
                    }
                    else
                    {
                        AccountSession<MyAccount>.Inst.SignOut();
                        lblshow.Text = "<i class='fa fa-warning'></i> Your account is locked, please wait confirmation from administrator.";
                    }                    
                }
                else
                {
                    lblshow.Text = "<i class='fa fa-warning'></i> Username or Password incorrect.";
                }
                                
            }
        }
    }
}