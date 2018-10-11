using System;
using System.Linq;
using MyProfile.Class;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace MyProfile.Modules.Products
{
    public partial class ProductFeatureds : UserControl
    {
        private readonly ProductProvider _productEntity = new ProductProvider();
        public int GetRecordCount;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_ProductOfFeatureds();
            }
        }
        private void BindData_ProductOfFeatureds()
        {
            //MOD - NAM-NT - CHINH SUA SAN PHAM NOI BAT THEO DANH MUC
            /*
            int pageIndex = string.IsNullOrEmpty(Request.Params["page"]) ? 1 : Convert.ToInt32(Request.Params["page"]);
            int pageSize = 6;
            int flagId = 1; //IsHot = True
            int recordCount;
            rpt_ListProducts.DataSource = p.PRODUCTS_PAGING(flagId, pageIndex, pageSize).Where(w => w.IsActive == true).ToList();
            recordCount = p.PRODUCTS_PAGING_COUNT(flagId);
            rpt_Pager.DataSource = linq.PagerListItems_Paginations(pageIndex, pageSize, recordCount);
            if (recordCount > pageSize)
            {
                rpt_Pager.DataBind();
            }
            rpt_ListProducts.DataBind();
            */
            rptCategory.DoBind(_productEntity.GetCategoryProductByParentId());
        }

        protected int PageIndex => Request.QueryString["page"].IsNullOrWhiteSpace()
            ? 1
            : Convert.ToInt32(Request.QueryString["page"]);

        protected void rptCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (!e.IsItem()) return;
            var rptListProduct = e.Item.FindControl("rptListProduct") as Repeater;
            var categoryId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "ID"));

            var listProductIsHot = _productEntity.GetProductPagingByCategoryId(categoryId, 1, 6).Where(w => w.IsActive == true && w.IsHot == true).ToList();
            rptListProduct.DoBind(listProductIsHot);
            if (rptListProduct != null) GetRecordCount = rptListProduct.Items.Count;
        }
    }
}