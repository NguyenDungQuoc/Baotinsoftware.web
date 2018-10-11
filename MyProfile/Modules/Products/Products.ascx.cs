using System;
using System.Linq;
using MyProfile.Class;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyProfile.Modules.Products
{
    public partial class Products : UserControl
    {
        public ProductProvider ProductProvider = new ProductProvider();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_ProductOfCategories();
            }
        }

        private void BindData_ProductOfCategories()
        {

            //int pageIndex = string.IsNullOrEmpty(Request.Params["page"]) ? 1 : Convert.ToInt32(Request.Params["page"]);
            //int flagId = 2;
            //if (categoryId == 0)
            //{
            //    ltr_Title.Text = "Sản phẩm";
            //    rpt_ListProducts.DataSource = p.PRODUCTS_PAGING(flagId, pageIndex, pageSize).Where(w => w.IsActive == true).ToList();
            //    recordCount = p.PRODUCTS_PAGING_COUNT(flagId);
            //    rpt_Pager.DataSource = linq.PagerListItems_Paginations(pageIndex, pageSize, recordCount);                    
            //}
            var categoryId = Request.QueryString["id"].IsNullOrWhiteSpace() ? 0 : Convert.ToInt32(Request.QueryString["id"]);
            if (categoryId == 0)
            {
                const int parentId = 0;
                rptCategory.DataSource = ProductProvider.GET_TABLE_GROUP_PRODUCTS()
                    .Where(w => w.ParentID == parentId && w.Active == true)
                    .OrderBy(w => w.Position)
                    .ToList();
                rptCategory.DataBind();
            }
            else
            {
                Response.Redirect(MyConstant.PageNotFoundUrl);
            }
        }

        protected int PageIndex => string.IsNullOrEmpty(Request.QueryString["page"]) ? 1 : Convert.ToInt32(Request.QueryString["page"]);

        protected void rptCategory_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (!e.IsItem()) return;
            var rptListProducts = e.Item.FindControl("rptListProducts") as Repeater;
            var categoryId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "ID"));
            rptListProducts.DataSource = ProductProvider.GetProductPagingByCategoryId(categoryId, 1, 6).Where(w => w.IsActive == true).ToList();
            rptListProducts.DataBind();
        }
    }
}