using MyProfile.Class;
using System;
using System.Web.UI;

namespace MyProfile.Modules.Products
{
    public partial class FindProduct : UserControl
    {
        private readonly ProductProvider _productProvider = new ProductProvider();
        private readonly HashtagProvider _hashtagProvider = new HashtagProvider();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FindData_Initial();
            }
        }

        public string ResultAlert = string.Empty;
        private void FindData_Initial()
        {
            var keyword = Request.QueryString["keyword"];
            var hashtagId = Request.QueryString["ht"];
            if (keyword.IsNotNullOrNotWhiteSpace())
            {
                rptListProduct.DoBind(_productProvider.GetProductByKeyword(keyword.StripHtml()));
            }
            else if (hashtagId.IsNotNullOrNotWhiteSpace())
            {
                if (hashtagId.StripHtml().IsInteger())
                {
                    rptListProduct.DoBind(
                        _hashtagProvider.Fe_GetProduct_Paging_By_HashtagId(Convert.ToInt32(hashtagId.StripHtml()), 1, 100));
                }
            }

            ResultAlert = rptListProduct.Items.Count == 0
                ? @"<div class='col-md-12'><h4 style='color:red;'>Không có kết quả nào được tìm thấy</h4></div>"
                : "";
        }
    }
}