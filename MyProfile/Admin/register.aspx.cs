using System;
using System.Drawing;
using MyProfile.Class;

namespace MyProfile.Admin
{
    public partial class register : System.Web.UI.Page
    {       
        UserAdmin tn = new UserAdmin();

        protected void btnSignUp_OnClick(object sender, EventArgs e)
        {
            if (txtUsername.Text.Trim() != "" && txtPassword.Text.Trim() != "" && txtFullname.Text.Trim() != "" &&
                txtEmail.Text.Trim() != "")
            {
                if (tn.VALIDATION_REGISTER_MEMBERSHIP(true, txtUsername.Text.Trim(), ""))
                {
                    if (tn.VALIDATION_REGISTER_MEMBERSHIP(false, "", txtEmail.Text.Trim()))
                    {
                        tn.INSERT_TABLE_USERS_NEWMEMBERSHIP(txtUsername.Text.Trim(), txtPassword.Text.Trim(),
                            txtFullname.Text.Trim(), "/Upload/images/Icons/user-big.jpg", DateTime.Now, false,
                            txtEmail.Text.Trim());
                        lblshow.Text =
                            "<i class='fa fa-cogs'></i> Register success, please wait confrim of Administrator.";
                        txtUsername.Text = txtFullname.Text = txtEmail.Text = "";
                        lblshow.ForeColor = Color.Blue;
                    }
                    else
                    {
                        lblshow.Text =
                            "<i class='fa fa-exclamation-triangle'></i> Email already exists. Please choose another email.";
                        lblshow.ForeColor = Color.Red;
                    }
                }
                else
                {
                    lblshow.Text =
                        "<i class='fa fa-exclamation-triangle'></i> Username already exists. Please choose another name.";
                    lblshow.ForeColor = Color.Red;
                }
            }
            else
            {
                lblshow.Text = "<i class='fa fa-exclamation-triangle'></i> Please complete the registration infomation.";
                lblshow.ForeColor = Color.Red;
            }
        }
    }
}