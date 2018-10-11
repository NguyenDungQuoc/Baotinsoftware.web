using MyProfile.Class;
using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace MyProfile.Modules.Services
{
    public partial class ListServices : System.Web.UI.UserControl
    {
        ServicesClass s = new ServicesClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind_DataServices();
            }
        }

        private void Bind_DataServices()
        {
            int CatID = 1;//Our Services
            rpt_ListServices.DataSource = s.GET_TABLE_GROUP_SERVICES().Where(w => w.ID == CatID && w.Active == true).ToList();
            rpt_ListServices.DataBind();
        }

        protected void rpt_ListServices_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater childRepeater = (Repeater)e.Item.FindControl("rpt_ListServiceCategories");
                HiddenField hdfID = e.Item.FindControl("hdfID") as HiddenField;
                childRepeater.DataSource =
                    s.GET_TABLE_GROUP_SERVICES()
                        .Where(w => w.ParentID == Convert.ToInt32(hdfID.Value) && w.Active == true)
                        .OrderBy(w => w.Position)
                        .ToList();
                childRepeater.DataBind();
                Literal ltrContent = e.Item.FindControl("ltr_Content") as Literal;
                var t = s.GET_TABLE_SERVICES().FirstOrDefault(w => w.ID_GroupServices == Convert.ToInt32(hdfID.Value) && w.Active == true);
                ltrContent.Text = t.Content;
            }
        }

        public string GetTagGroupServices(int idGroupServices)
        {
            return s.GET_TABLE_GROUP_SERVICES().Where(w => w.ID == idGroupServices).FirstOrDefault().Tag;
        }
    }
}