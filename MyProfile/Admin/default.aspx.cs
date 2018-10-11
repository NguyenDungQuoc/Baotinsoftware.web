using System;
using System.Web.UI;

namespace MyProfile.Admin
{
    public partial class _default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect(@"/Admin/home.aspx");
        }
    }
}