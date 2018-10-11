using System;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile
{
    public partial class _default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect(MyConstant.HomeUrl);
        }
    }
}