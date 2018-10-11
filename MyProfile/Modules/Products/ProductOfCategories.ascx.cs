using System;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Modules.Products
{
    public partial class ProductOfCategories : UserControl
    {
        public ProductProvider ProductProvider = new ProductProvider();
        private readonly Utility _utility = new Utility();

        protected void Page_Load(object sender, EventArgs e)
        {            
            if (!IsPostBack)
            {
                BindData_ProductOfCategories();
            }
        }

        private void BindData_ProductOfCategories()
        {
            if (Request.QueryString["id"].IsNullOrWhiteSpace())
            {
                Response.Redirect(MyConstant.PageNotFoundUrl);
            }
            else
            {
                var categoryId = Convert.ToInt32(Request.QueryString["id"]);
                const int pageSize = 12;
                var recordCount = 0;
                if (categoryId > 0)
                {
                    ltr_Title.Text = Page.Title = ProductProvider.GET_TABLE_GROUP_PRODUCTS().FirstOrDefault(w => w.ID == categoryId)?.Name;
                    rpt_ListProducts.DataSource = ProductProvider.GetProductPagingByCategoryId(categoryId, PageIndex, pageSize);
                    recordCount = ProductProvider.TotalProductPagingByCategoryIdCount(categoryId);
                    rpt_Pager.DataSource = _utility.PagerListItems_Paginations(PageIndex, pageSize, recordCount);
                }
                if (recordCount > pageSize)
                {
                    rpt_Pager.DataBind();
                }
                rpt_ListProducts.DataBind();
            }
        }

        protected int PageIndex => Request.QueryString["page"].IsNullOrWhiteSpace()
            ? 1
            : Convert.ToInt32(Request.QueryString["page"]);
    }
}