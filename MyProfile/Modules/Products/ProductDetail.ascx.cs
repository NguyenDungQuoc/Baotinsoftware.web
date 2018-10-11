using System;
using System.Collections.Generic;
using System.Linq;
using MyProfile.Class;
using System.Web.UI.WebControls;
using System.Web.UI;
using MyProfile.Settings;

namespace MyProfile.Modules.Products
{
    public partial class ProductDetail : UserControl
    {
        private readonly ProductProvider _productEntity = new ProductProvider();
        private readonly ProductSize _productSize = new ProductSize();
        private readonly ProductColor _productColor = new ProductColor();
        public int DataCountSize, DataCountColor, DataCountImage;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDataProductDetail(Request.QueryString["id"]);
            }
        }

        private void BindDataProductDetail(string request)
        {
            if (request.IsNotNull())
            {
                var productId = Convert.ToInt32(request);
                var product = _productEntity.Fe_GetProductById(productId);
                if (product != null)
                {
                    rpt_ProductDetail.DoBind(new List<Fe_GetProductByIdResult> {product});
                    var productSimilar = _productEntity.Fe_GetProductByCategoryId(product.ProductCategoryId).Where(p => p.ProductId != productId);
                    rpt_ListProductSimilar.DoBind(productSimilar.ToList());

                    Page.Title = product.ProductName;
                    ltr_Content.Text = product.Content;
                    var domain = "http://{0}".Frmat(Request.Url.Authority);

                    MyProfile.Site.MetaContext["Meta1"] = new Meta
                    {
                        Attr = "itemprop",
                        Name = "datePublished",
                        Content = product.DatePublish.ToString().Substring(0, 10)
                    };
                    MyProfile.Site.MetaContext["Meta2"] = new Meta
                    {
                        Attr = "itemprop",
                        Name = "image",
                        Content = domain + product.Avatar
                    };
                    MyProfile.Site.MetaContext["Meta3"] = new Meta
                    {
                        Attr = "itemprop",
                        Name = "headline",
                        Content = product.ProductName
                    };
                    MyProfile.Site.MetaContext["Meta4"] = new Meta
                    {
                        Attr = "itemprop",
                        Name = "genre",
                        Content = product.ProductCategoryName
                    };
                    MyProfile.Site.MetaContext["Meta5"] = new Meta
                    {
                        Attr = "itemprop",
                        Name = "url",
                        Content = domain + Request.RawUrl.Trim()
                    };

                    MyProfile.Site.MetaContext["Meta6"] = new Meta
                    {
                        Attr = "property",
                        Name = "og:url",
                        Content = domain + Request.RawUrl.Trim()
                    };
                    MyProfile.Site.MetaContext["Meta7"] = new Meta
                    {
                        Attr = "property",
                        Name = "og:type",
                        Content = product.ProductCategoryName
                    };
                    MyProfile.Site.MetaContext["Meta8"] = new Meta
                    {
                        Attr = "property",
                        Name = "og:image",
                        Content = domain + product.Avatar
                    };
                    MyProfile.Site.MetaContext["Meta9"] = new Meta
                    {
                        Attr = "property",
                        Name = "og:title",
                        Content = product.ProductName
                    };
                    MyProfile.Site.MetaContext["Meta10"] = new Meta
                    {
                        Attr = "property",
                        Name = "og:description",
                        Content = product.Sapo
                    };
                    MyProfile.Site.MetaContext["Meta11"] = new Meta
                    {
                        Attr = "property",
                        Name = "article:published_time",
                        Content = product.DatePublish.ToString().Substring(0, 10)
                    };
                    _productEntity.UPDATE_VIEW_OR_BUY_TABLE_PRODUCT(true, productId);
                }
                else
                {
                    Response.Redirect(MyConstant.PageNotFoundUrl);
                }
            }
        }

        protected void rpData_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (!e.IsItem()) return;
            if (e.Item.FindControl("rpItem") is Repeater rpItem)
            {
                rpItem.DoBind(DataBinder.Eval(e.Item.DataItem, "ListImgs"));
            }
        }
       
        protected void rpt_ProductDetail_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (!e.IsItem()) return;
            var productId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "ProductId"));
            
            //Bind Image Product
            var productImage = _productEntity.GET_TABLE_PRODUCT_IMAGE().Where(w => w.ID_Products == productId).ToList();
            var dataImages = productImage.Select((img, i) => new {img, grp = i / 3}).GroupBy(imgGroup => imgGroup.grp)
                .Select(g => new {g.Key, ListImgs = g.Select(gi => gi.img).ToList()}).ToList();
            if (e.Item.FindControl("rpData") is Repeater rptData)
            {
                rptData.DoBind(dataImages);
                DataCountImage = rptData.Items.Count;
            }

            //Bind Size Of Product
            if (e.Item.FindControl("rpt_ListSizeOfProduct") is Repeater rptSizeOfProduct)
            {
                rptSizeOfProduct.DoBind(_productSize.Get_ProductSize_By_ProductId(productId).Where(w => w.SelectedId != null).ToList());
                DataCountSize = rptSizeOfProduct.Items.Count;
            }

            //Bind Color Of Product
            if (e.Item.FindControl("rpt_ListColorOfProduct") is Repeater rptColorOfProduct)
            {
                rptColorOfProduct.DoBind(_productColor.GetProductColorByProductId(productId).Where(w => w.SelectedId != null).ToList());
                DataCountColor = rptColorOfProduct.Items.Count;
            }
        }
    }
}