using MyProfile.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Settings;
using MyProfile.DAO.Providers;

namespace MyProfile.Modules.Products
{
    public partial class ProductInformation : UserControl
    {
        private ProductProvider _productProvider = new ProductProvider();
        public string GetLinkYoutube { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GenerateStopSpamText();
                BindDataProductInitial(Request.QueryString["id"]);
            }
        }
        
        private void BindDataProductInitial(string request)
        {
            if (request.IsNotNull())
            {
                var productId = Convert.ToInt32(request);
                var product = _productProvider.Fe_GetProductById(productId);

                if (product == null) Response.Redirect(MyConstant.PageNotFoundUrl);
                rptProductInformation.DoBind(new List<Fe_GetProductByIdResult> { product });
                var productSimilars = _productProvider.Fe_GetProductByCategoryId(product.ProductCategoryId).Where(p => p.ProductId != productId);
                rpt_ListProductSimilar.DoBind(productSimilars.ToList());

                Page.Title = product.ProductName;
                GetLinkYoutube = "https://www.youtube.com/embed/{0}".Frmat(product.Youtube.GetYoutubeId());

                var domain = "http://{0}".Frmat(Request.Url.Authority);
                var image = "{0}{1}".Frmat(domain, product.Avatar);
                var url = "{0}{1}".Frmat(domain, Request.RawUrl.Trim());

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
                    Content = image
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
                    Content = url
                };

                MyProfile.Site.MetaContext["Meta6"] = new Meta
                {
                    Attr = "property",
                    Name = "og:url",
                    Content = url
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
                    Content = image
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

                BindDataRelatedNews(productId);
                //Update View
                _productProvider.UPDATE_VIEW_OR_BUY_TABLE_PRODUCT(true, productId);
            }
            else
            {
                Response.Redirect(MyConstant.PageNotFoundUrl);
            }
        }

        private void BindDataRelatedNews(int productId)
        {
            rptListRelatedNews.DataSource = ProductNewsProvider.Inst.GetNewsByProductId(productId);
            rptListRelatedNews.DataBind();
        }

        protected void rptProductInformation_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (!e.IsItem()) return;
            var rptListImages = e.Item.FindControl("rptListImages") as Repeater;
            var productId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "ProductId"));
            //Bind Image Product
            var productImage = _productProvider.GET_TABLE_PRODUCT_IMAGE().Where(w => w.ID_Products == productId).ToList();            
            rptListImages.DoBind(productImage);
        }

        private void GenerateStopSpamText()
        {
            var random = new Random();
            var firstNumber = random.Next(1, 9);
            var secondNumber = random.Next(1, 9);
            ltrStopSpam.Text = $"{firstNumber} + {secondNumber} =";
            hdfResultStopSpam.Value = (firstNumber + secondNumber).ToString();
        }
    }
}