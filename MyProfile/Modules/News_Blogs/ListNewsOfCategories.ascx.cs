using MyProfile.Class;
using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace MyProfile.Modules.News_Blogs
{
    public partial class ListNewsOfCategories : System.Web.UI.UserControl
    {
        NewsBlogProvider n = new NewsBlogProvider();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_ListNewsCategories();
            }
        }

        private void BindData_ListNewsCategories()
        {
            int idGroupNews = 2; //News & Event Categories
            rpt_ListNewsCategories.DataSource =
                n.GET_TABLE_GROUP_NEWS().Where(w => w.ID == idGroupNews && w.Active == true).ToList();
            rpt_ListNewsCategories.DataBind();
        }

        protected void rpt_ListNewsCategories_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rpt_ChildCategories = e.Item.FindControl("rpt_ChildCategories") as Repeater;
                HiddenField hdf_ID = e.Item.FindControl("hdfID") as HiddenField;
                rpt_ChildCategories.DataSource =
                    n.GET_TABLE_GROUP_NEWS()
                        .Where(w => w.ParentID == Convert.ToInt32(hdf_ID.Value) && w.Active == true)
                        .OrderBy(w => w.Position)
                        .ToList();
                rpt_ChildCategories.DataBind();
            }
        }
    }
}