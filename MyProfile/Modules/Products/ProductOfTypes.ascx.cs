using System;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Modules.Products
{
    public partial class ProductOfTypes : UserControl
    {
        public ProductProvider ProductProvider = new ProductProvider();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_ProductOfTypes();
            }
        }

        private void BindData_ProductOfTypes()
        {
            if (Request.QueryString["id"].IsNullOrWhiteSpace())
            {
                Response.Redirect(MyConstant.PageNotFoundUrl);
            }
            else
            {
                var idType = Convert.ToInt32(Request.QueryString["id"]);
                if (idType > 0)
                {
                    ltr_Title.Text  = ProductProvider.GET_TABLE_TYPES().FirstOrDefault(w => w.ID_Type == idType)?.Name;
                    Page.Title = "Sản phẩm - " + ltr_Title.Text;
                    var t = ProductProvider.GET_TABLE_PRODUCT_TYPE().Where(w => w.ID_Type == idType).Select(w => w.ID_Product).ToList();
                    rpt_ListProducts.DataSource = ProductProvider.GetTableProduct().Where(w => t.Contains(w.ID) && w.IsActive == true).ToList();
                    rpt_ListProducts.DataBind();
                }
                else
                {
                    Response.Redirect(MyConstant.PageNotFoundUrl);
                }
            }
        }

        protected int PageIndex => string.IsNullOrEmpty(Request.QueryString["page"]) ? 1 : Convert.ToInt32(Request.QueryString["page"]);
    }
}