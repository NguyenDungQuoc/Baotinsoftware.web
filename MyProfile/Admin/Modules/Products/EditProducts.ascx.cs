using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;
using MyProfile.DAO.Providers;
using MyProfile.Enums;
using MyProfile.Settings;

namespace MyProfile.Admin.Modules.Products
{
    public partial class EditProducts : UserControl
    {
        /// <summary>
        /// Cờ báo Insert hay Upload
        /// Insert = false
        /// Update = true
        /// </summary>
        private bool _isUpdate;
        private readonly ProductProvider _productProvider = new ProductProvider();
        private readonly ProductSize _productSizeService = new ProductSize();
        private readonly ProductColor _productColorService = new ProductColor();
        private readonly HashtagProvider _hashtagProvider = new HashtagProvider();
        private readonly HashTagLinkProvider _hashtagLinkProvider = new HashTagLinkProvider();
        private readonly NewsBlogProvider _newsBlogService = new NewsBlogProvider();

        public string DetailContent { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            var requestId = Request.QueryString["id"];
            if (requestId.IsNullOrWhiteSpace())
            {
                
                _isUpdate = false;
                if (IsPostBack) return;
                //Insert
                Page.Title = "Thêm mới sản phẩm";
                BindDataCombobox();
            }
            else
            {
                _isUpdate = true;
                if (IsPostBack) return;
                //Update                
                Page.Title = "Chỉnh sửa thông tin sản phẩm";
                BindDataCombobox(requestId);
                BindDataProductDetail(Convert.ToInt32(requestId));
            }
        }        

        private void BindDataProductDetail(int productId)
        {
            try
            {                                
                var product = _productProvider.GetProductById(productId);
                if (product == null) return;
                txtName.Text = product.Name;
                txtCode.Text = product.Code;
                txtPrice.Text = product.Price.IsNotNull() ? product.Price.ToString() : string.Empty;
                txtPriceOld.Text = product.PriceOld.IsNotNull() ? product.PriceOld.ToString() : string.Empty;
                ddl_CategoriesProducts.SelectedValue = product.ID_GroupProduct.ToString();
                InputFile_Avatar.Text = product.Image;
                txtSummary.Text = product.Sapo.StripHtml();
                DetailContent = product.Content;
                ddl_StatusProducts.SelectedValue = product.StatusID.ToString();
                txtLinkY.Text = product.LinkY;

                rdb_Show.Checked = Convert.ToBoolean(product.IsActive) ? true : false;
                rdb_Hide.Checked = Convert.ToBoolean(product.IsActive) ? false : true;

                rdb_IsHot.Checked = Convert.ToBoolean(product.IsHot) ? true : false;
                rdb_NotIsHot.Checked = Convert.ToBoolean(product.IsHot) ? false : true;

                //Bind Gallery Product Image
                BindDataProductImages(productId);
                BindDataHashtagProduct(productId);
                //Bind ProductNews 
                BindDataProductNews(productId);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }         
        }

        private void BindDataProductNews(int productId)
        {
            var productNews = ProductNewsProvider.Inst.GetProductNewsByProductId(productId);
            foreach (ListItem item in chklProductNews.Items)
            {
                foreach (var p in productNews)
                {
                    if (item.Value.Equals(p.NewsId.ToString()))
                    {
                        item.Selected = true;
                    }
                }
            }
        }

        private void BindDataHashtagProduct(int productId)
        {
            var hashtags = _hashtagLinkProvider.GetHashTagLinkByLinkId(productId);
            hashtags.ForEach(x =>
            {
                for (var i = 0; i < ddlHashtags.Items.Count; i++)
                {
                    if (ddlHashtags.Items[i].Value.Equals(x.HashTagId.ToString()))
                    {
                        ddlHashtags.Items[i].Selected = true;
                    }
                }
            });
        }

        private void BindDataProductImages(int productId)
        {
            var data = new List<ImageInfo>();
            var productImage = _productProvider.GET_TABLE_PRODUCT_IMAGE().Where(w => w.ID_Products == productId).ToList();
            if (productImage.Count > 0)
            {
                foreach (var item in productImage)
                {
                    var photo = new ImageInfo
                    {
                        Path = item.Path,
                        Note = item.Note
                    };
                    data.Add(photo);
                }   
            }                      
            imagesInput.SetData(data);
        }

        /// <summary>
        /// BIND DATA COMBOBOX CONTROL
        /// </summary>
        private void BindDataCombobox(string request = "")
        {
            ddl_CategoriesProducts.DataSource = null;
            //Combobox Status
            ddl_StatusProducts.DataSource = _productProvider.GetTableProductStatus();
            ddl_StatusProducts.DataBind();
            //Combobox Cateogry
            ddl_CategoriesProducts.DataSource = _productProvider.ListProductCategory();
            ddl_CategoriesProducts.DataBind();
            //List Type Of Product
            rptListProductType.DoBind(_productProvider.GET_TABLE_TYPES());
            var productId = 0;
            if (_isUpdate)
            {
                //List Size Of Product
                productId = Convert.ToInt32(request);
                rptListSizeOfProduct.DoBind(_productSizeService.Get_ProductSize_By_ProductId(productId));
                rptListProductColor.DoBind(_productColorService.GetProductColorByProductId(productId));
            }
            else
            {
                //List Size Of Product
                rptListSizeOfProduct.DoBind(_productSizeService.Get_ProductSize_By_ProductId(productId));
                rptListProductColor.DoBind(_productColorService.GetProductColorByProductId(productId));
            }         
            //Bind List Hashtags
            ddlHashtags.DataSource = _hashtagProvider.SelectAll();
            ddlHashtags.DataBind();
            chklProductNews.DataSource = _newsBlogService.GetTableNewsByIsActive();
            chklProductNews.DataBind();
        }

        protected void btn_Update_OnClick(object sender, EventArgs e)
        {
            if (txtName.Text.IsNullOrWhiteSpace()) _productProvider.ShowMessageBox("Vui lòng nhập tên sản phẩm");

            var productId = Convert.ToInt32(Request.QueryString["id"]);
            var productCode = txtCode.Text.Trim();
            var productName = txtName.Text.Trim();
            var productAlias = productName.UnicodeFormat();
            var productAvatar = InputFile_Avatar.Text.Trim();
            var productPrice = txtPrice.Text.IsNullOrWhiteSpace()
                ? 0
                : Convert.ToDecimal(txtPrice.Text.Replace(".", "").Trim());
            var productPriceOld = txtPriceOld.Text.Trim().IsNullOrWhiteSpace()
                ? 0
                : Convert.ToDecimal(txtPriceOld.Text.Replace(".", "").Trim());
            var productCategoryId = Convert.ToInt32(ddl_CategoriesProducts.SelectedValue);
            var productStatus = Convert.ToInt32(ddl_StatusProducts.SelectedValue);
            //var subDescription = Request.Form["editor_subdescription"];
            var summary = txtSummary.Text.StripHtml();
            var productContent = Request.Form["editor_content"];
            var linkYoutube = txtLinkY.Text.Trim();
            var isActive = rdb_Show.Checked;
            var isHot = rdb_IsHot.Checked;
            // Danh sách Image thêm vào db
            var productPhotoSelected = imagesInput.GetData<ImageInfo>();
            var hashtagSelected = ddlHashtags.Items.Cast<ListItem>().Where(x => x.Selected).Select(x => x.Value);
            var newsIdSelected = chklProductNews.Items.Cast<ListItem>().Where(x => x.Selected).Select(x => x.Value);

            if (_isUpdate)
            {
                if (productId <= 0) throw new Exception("ProductId must be number positive");

                _productProvider.UPDATE_VALUE_PRODUCTS(productId, productCode, productName, productAlias, productAvatar, summary, productContent,
                                productPrice, productPriceOld, productCategoryId, productStatus, linkYoutube, isActive, isHot);

                // [DELETE] - 2017/11/26 - NAM-NT - CLIENT NOT USE - START 
                ////---Xóa các Size của Product đang Edit
                //_productSize.DELETE_LIST_ITEM_PRODUCT_SIZE_WHERE_PRODUCTID(productId);
                //ADD_VALUE_TABLE_PRODUCT_SIZES(productId);

                ////--- Xóa hết Color của Product
                //_productColor.DeleteListRecordProductColorWhereProductId(productId);
                //ADD_VALUE_TABLE_PRODUCT_COLOR(productId);
                // [DELETE] - 2017/11/26 - NAM-NT - CLIENT NOT USE - END 

                UpdateValueProductNews(newsIdSelected, productId);

                _productProvider.DeleteRecordTableProductTypeByProductId(productId);
                _productProvider.DeleteProductImageByProductId(productId);
                _hashtagLinkProvider.DeleteByLinkId(productId);
            }
            else
            {
                productId = _productProvider.INSERT_INTO_TABLE_PRODUCTS(productCode, productName, productAlias, productAvatar,
                    summary, productContent, productPrice, productPriceOld, productCategoryId, productStatus, linkYoutube, isActive, isHot);

                // [DELETE] - 2017/11/26 - NAM-NT - CLIENT NOT USE - START
                ////Add ProductSize
                //ADD_VALUE_TABLE_PRODUCT_SIZES(maxProductId);
                ////Add ColorProduct
                //ADD_VALUE_TABLE_PRODUCT_COLOR(maxProductId);
                // [DELETE] - 2017/11/26 - NAM-NT - CLIENT NOT USE - END

                //Add ProductNews
                AddValueProductNews(newsIdSelected, productId);
            }

            //Add ProductType
            AddValueForTableProductType(productId);
            //Add ProductImage
            AddValueForTableProductImage(productPhotoSelected, productId);
            //Add HashtagLink
            AddValueForTableHashtagLink(hashtagSelected, productId);
            Response.Redirect(MyConstant.ListProductUrl);
        }

        private void UpdateValueProductNews(IEnumerable<string> newsIdSelected, int productId)
        {
            ProductNewsProvider.Inst.UpdateByProductIdAndNewsId(productId, newsIdSelected);
        }

        private void AddValueProductNews(IEnumerable<string> productNewsSelected, int productId)
        {
            foreach (var item in productNewsSelected)
            {
                var productNews = new PRODUCT_NEW
                {
                    ProductId = productId,
                    NewsId = Convert.ToInt32(item)
                };
                ProductNewsProvider.Inst.Insert(productNews);
            }
        }

        private void AddValueForTableProductImage(List<ImageInfo> listImages, int productId)
        {
            foreach (var item in listImages)
            {
                _productProvider.INSERT_VALUE_PRODUCT_IMAGE(item.Path, item.Note, productId);
            }
        }

        private void AddValueForTableHashtagLink(IEnumerable<string> listHashtags, int productId)
        {
            foreach (var item in listHashtags)
            {
                var hashTagLink = new HashTagLink
                {
                    LinkId = productId,
                    TypeId = (int) MyEnum.LinkType.Product,
                    HashTagId = Convert.ToInt32(item)
                };
                _hashtagLinkProvider.Insert(hashTagLink);
            }
        }

        /// <summary>
        /// Thêm thể loại cho sản phẩm
        /// </summary>
        /// <param name="productId"></param>
        public void AddValueForTableProductType(int productId)
        {
            foreach (RepeaterItem rptItem in rptListProductType.Items)
            {
                if (rptItem.FindControl("chk_Type") is CheckBox chk)
                {
                    if (chk.Checked)
                    {
                        _productProvider.INSERT_VALUE_TABLE_PRODUCT_TYPES(productId, Convert.ToInt32(chk.Attributes["typeid"]));
                    }                 
                }
            }
        }

        /// <summary>
        /// Thêm ProductSize cho sản phẩm
        /// </summary>
        /// <param name="productId"></param>
        public void ADD_VALUE_TABLE_PRODUCT_SIZES(int productId)
        {
            foreach (RepeaterItem rptItem in rptListSizeOfProduct.Items)
            {
                if (rptItem.FindControl("chk_Size") is CheckBox chk)
                {
                    if (!chk.Checked) continue;
                    var chkPrice = rptItem.FindControl("chk_Price") as TextBox;
                    _productSizeService.INSERT_INTO_TABLE_PRODUCT_SIZE(Convert.ToInt32(chk.Attributes["sizeId"]), productId,
                        chkPrice.IsNotNull() && chkPrice.Text.IsNullOrWhiteSpace()
                            ? Convert.ToDecimal(chkPrice.Text.Replace(".", "").Trim())
                            : 0);
                }
            }
        }

        public void ADD_VALUE_TABLE_PRODUCT_COLOR(int productId)
        {
            foreach (RepeaterItem rptItem in rptListProductColor.Items)
            {
                if (rptItem.FindControl("chk_ProductColor") is CheckBox chk)
                {
                    if (chk.Checked)
                    {
                        _productColorService.InsertRecordTableProductColor(Convert.ToInt32(chk.Attributes["colorId"]), productId);
                    }
                }

            }
        }

        //Lấy thể loại của Product
        public bool GetActiveProductType(int typeId)
        {
            var productId = Convert.ToInt32(Request.QueryString["id"]);
            var t = _productProvider.GET_TABLE_PRODUCT_TYPE().Where(w => w.ID_Product == productId && w.ID_Type == typeId).ToList();
            return t.Count > 0;
        }
    }    
}