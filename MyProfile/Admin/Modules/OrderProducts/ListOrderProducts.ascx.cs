using MyProfile.Class;
using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace MyProfile.Admin.Modules.OrderProducts
{
    public partial class ListOrderProducts : System.Web.UI.UserControl
    {
        ProductProvider p = new ProductProvider();
        Utility linq = new Utility();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_ListOrderProducts();
            }
        }

        private void BindData_ListOrderProducts()
        {
            int pageIndex = string.IsNullOrEmpty(Request.Params["page"]) ? 1 : Convert.ToInt32(Request.Params["page"]);
            int pageSize = Convert.ToInt32(ddl_PageSize.SelectedValue);
            GridView_ListData.DataSource = p.ORDER_PRODUCT_PAGING(pageIndex, pageSize);
            GridView_ListData.DataBind();

            int recordCount = p.ORDER_PRODUCT_PAGING_COUNT();
            rpt_Pager.DataSource = linq.PagerListItems_Paginations(pageIndex, pageSize, recordCount);
            rpt_Pager.DataBind();
        }        

        protected void ddl_PageSize_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            this.BindData_ListOrderProducts();
        }

        protected int PageIndex
        {
            get
            {
                return string.IsNullOrEmpty(Request.Params["page"]) ? 1 : Convert.ToInt32(Request.Params["page"]);
            }
        }

        public string getStringOrderStatus(int statusID)
        {
            return p.GET_TABLE_ORDER_STATUS().Where(w => w.ID == statusID).FirstOrDefault().Name.ToString();
        }

        /// <summary>
        /// AJAX
        /// </summary>
        public void DeleteRecord()
        {
            var id = HttpContext.Current.Request.Params["idRecord"];
            p.DELETE_ORDER_PRODUCTS(Convert.ToInt32(id));
        }
        
    }
}