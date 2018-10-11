using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Modules
{
    public partial class Business : UserControl
    {
        private NewsBlogProvider _newsBlog = new NewsBlogProvider();
        private GalleryImage g = new GalleryImage();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_PlatForm();
            }
        }

        private void BindData_PlatForm()
        {
            var tableNews = _newsBlog.GetTableNewsByIsActive();
            const int ePlatform = 8; //Business E-Platform
            rpt_Platform.DataSource = tableNews.Where(w => w.ID_GroupNews == ePlatform).Take(1).ToList();  
            rpt_Platform.DataBind();

            const int membershipPrivileges = 9; //NSO Membership Privileges
            rpt_Membership.DataSource = tableNews.Where(w => w.ID_GroupNews == membershipPrivileges).Take(1).ToList();
            rpt_Membership.DataBind();
        }

        protected void rpt_Membership_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {            
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                const int idCat = 25; //Our Partners Providing Privileges
                var childRepeater = (Repeater) e.Item.FindControl("rpt_childListGallery");
                if (e.Item.FindControl("ltr_Title") is Literal ltrTitle)
                    ltrTitle.Text = g.GET_TABLE_GROUP_GALLERY().FirstOrDefault(w => w.ID == idCat).Name;
                childRepeater.DataSource = g.GET_TABLE_GALLERY().Where(w => w.ID_GroupGallery == idCat && w.Active == true).Take(8).ToList();
                childRepeater.DataBind();
            }
        }
    }
}