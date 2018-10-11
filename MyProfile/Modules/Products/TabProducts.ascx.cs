using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Modules.Products
{
    public partial class TabProducts : UserControl
    {
        public ProductProvider ProductProvider = new ProductProvider();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_TabOfCategories();
            }
        }

        private void BindData_TabOfCategories()
        {
            rpt_TabOfCategories.DataSource = rpt_TabContentOfCategory.DataSource = ProductProvider.GET_TABLE_TYPES();
            rpt_TabOfCategories.DataBind();
            rpt_TabContentOfCategory.DataBind();
        }
         
        
        protected void rpt_TabContentOfCategory_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var childRepeater = e.Item.FindControl("rpt_ListProductOfTabs") as Repeater;
                if (e.Item.FindControl("hdfID") is HiddenField hdfId)
                    childRepeater?.DoBind(ProductProvider.GET_PRODUCT_TYPE_ID(Convert.ToInt32(hdfId.Value)).Take(4));
            }
        }
    }
}