using System;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Modules.Customers
{
    public partial class Customer : UserControl
    {
        NewsBlogProvider n = new NewsBlogProvider();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_Membership();
            }
        }

        private void BindData_Membership()
        {
            const int catId = 10; //Customer Focus Commitment
            var t = n.GET_TABLE_NEWS().Where(w => w.ID_GroupNews == catId).Take(1).FirstOrDefault();
            ltrTitle.Text = t.Title;
            img_Photo.AlternateText = t.Title;
            img_Photo.ImageUrl = t.Image;
            if (Request.Url.AbsolutePath == "/home.aspx")
            {
                ltr_Content.Text = t.News_Sapo;
                hdf_Style.Value = "";
            }
            else
            {
                Page.Title = ltrTitle.Text;
                ltr_Content.Text = t.Content;
                hdf_Style.Value = "margin-top: 200px;";
            }
        }
    }
}