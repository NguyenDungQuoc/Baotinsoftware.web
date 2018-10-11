using System;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Modules
{
    public partial class Platform : UserControl
    {
        private NewsBlogProvider _newsBlog = new NewsBlogProvider();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_PlatForm();
            }
        }

        private void BindData_PlatForm()
        {
            const int Eplatform = 3; //Business E-Platform
            var t = _newsBlog.GetTableNewsByIsActive().FirstOrDefault(x => x.ID == Eplatform);
            Page.Title = ltr_Title.Text = t.Title;
            ltr_Content.Text = t.Content;
        }
    }
}