using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Modules.Services
{
    public partial class ServicesModules : UserControl
    {
        ServicesClass s = new ServicesClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_Services();
            }
        }

        private void BindData_Services()
        {
            const int catId = 1; //OUR SERVICES OF TABLE GROUP SERVICES
            rpt_ServicesAbout.DataSource = s.GET_TABLE_GROUP_SERVICES().Where(w => w.ID == catId).ToList();
            rpt_ServicesAbout.DataBind();

            rpt_ListServiceOfCategory.DataSource =
                s.GET_TABLE_GROUP_SERVICES()
                    .Where(w => w.ParentID == catId && w.Active == true)
                    .OrderBy(w => w.Position)
                    .ToList();
            rpt_ListServiceOfCategory.DataBind();
        }

        protected void rpt_ServicesAbout_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var childRepeater = (Repeater)e.Item.FindControl("rpt_ServicesDetail");
                var hdfId = (HiddenField)e.Item.FindControl("hdfID");
                childRepeater.DataSource = s.GET_TABLE_SERVICES().Where(w => w.ID_GroupServices == Convert.ToInt32(hdfId.Value) && w.Active == true).ToList();                    
                childRepeater.DataBind();
            }
        }

        protected void rpt_ListServiceOfCategory_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var childRepeater = (Repeater)e.Item.FindControl("rpt_ChildListSerives");
                var hdfId = (HiddenField)e.Item.FindControl("hdfID");
                childRepeater.DataSource = s.GET_TABLE_SERVICES().Where(w => w.ID_GroupServices == Convert.ToInt32(hdfId.Value) && w.Active == true).ToList();
                childRepeater.DataBind();
            }
        }

        public string GetTagGroupServices(int idGroupServices)
        {
            return s.GET_TABLE_GROUP_SERVICES().Where(w => w.ID == idGroupServices).FirstOrDefault().Tag;
        }
    }
}