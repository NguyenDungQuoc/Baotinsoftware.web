using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyProfile.Class
{
    public class ShoppingCart
    {
        readonly ProductProvider _productEntity = new ProductProvider();
        readonly ProductSize _productSize = new ProductSize();

        private static ShoppingCart inst = new ShoppingCart();
        /// Một instance để sử dụng
        public static ShoppingCart Inst
        {
            get { return inst; }
        }

        // Các sản phẩm trong giỏ hàng
        public List<ProductItem> Items
        {
            get
            { 
                // Lấy id product từ session
                //Nếu chưa có items nào thì khởi tạo session lưu trữ
                if (!(HttpContext.Current.Session["ProductItems"] is List<ProductItem> productItem))
                {
                    HttpContext.Current.Session["ProductItems"] = productItem = new List<ProductItem>();
                }
                return productItem;
            }
        }

        // Clear Khi khách hàng muốn làm mới lại giỏ hàng.
        public void ClearCart()
        {
            HttpContext.Current.Session["ProductItems"] = null;
        }

        //Thêm sản phẩm vào giỏ hàng.
        public void AddProduct(int productId, int quantity, int styleId = 0, int sizeId = 0)
        {
            // Loading 2s
            //Thread.Sleep(2000);

            var productItem = this.Items.FirstOrDefault(p => p.ProductID == productId && p.IdStyle == styleId && p.SizeId == sizeId);

            //Nếu sản phẩm chưa có lần nào trong giỏ hàng thì thêm mới
            if (productItem == null)
            {
                productItem = new ProductItem { ProductID = productId, Quantity = quantity, IdStyle = styleId, SizeId = sizeId };
                this.Items.Add(productItem);
            }
            else
            {
                productItem.Quantity += quantity;
            }

            // Ví dụ trường hợp
            // mình bỏ sản phẩm A với số lượng là n vào giỏ hàng, nếu chưa có lần nào thì trong giỏ là n
            // lần tiếp theo cũng bỏ sản phẩm A vào với số lượng là m thì tổng số sản phẩm A trong giỏ là m + n
        }

        //Xóa một sản phẩm khỏi giỏ hàng.
        public void RemoveProduct(int productId, int styleId, int sizeId)
        {
            //Thread.Sleep(2000);

            var productItem = this.Items.FirstOrDefault(p => p.ProductID == productId && p.IdStyle == styleId && p.SizeId == sizeId);
            if (productItem != null)
            {
                this.Items.Remove(productItem);
            }
        }

        //Cập nhật số lượng sảm phẩm có trong giỏ hàng
        public void UpdateItems(int productId, int quantity, int styleId, int sizeId)
        {
            //Thread.Sleep(2000);

            var productItem = this.Items.FirstOrDefault(p => p.ProductID == productId && p.IdStyle == styleId && p.SizeId == sizeId);
            // Nếu sản phẩm chưa có lần nào trong giỏ hàng thì thêm mới
            if (productItem != null) productItem.Quantity = quantity;
        }

        /// <summary>
        /// Lấy cái hàm này điền lên grid ở trang giỏ hàng
        /// </summary>
        /// <returns></returns>
        public List<NewProduct> Get()
        {
            //Lấy danh sách Product sau khi ta đã có đc list Id mà khách hàng đã chọn
            var listProduct = _productEntity.GetProductByListProductId(Items.Select(i => i.ProductID).ToList());

            return Items.Select(item => 
            {
                var newProduct = new NewProduct
                {
                    ProductId = item.ProductID,
                    IdStyle = item.IdStyle,
                    Quantity = item.Quantity,
                    SizeId = item.SizeId
                };
                var p = listProduct.FirstOrDefault(pi => pi.ID == newProduct.ProductId);
                if (p != null)
                {
                    newProduct.Name = p.Name;

                    var styleData = _productEntity.GET_TABLE_PRODUCT_IMAGE()
                        .FirstOrDefault(w => w.ID == item.IdStyle && w.ID_Products == item.ProductID);
                    var sizeData = _productSize.GET_TABLE_PRODUCT_SIZE()
                        .FirstOrDefault(w => w.SizeId == item.SizeId && w.ProductId == item.ProductID);

                    decimal costStyle = 0, costSize = 0, costProduct = 0;
                    //Kiểm tra xem Kiểu/Style của Product
                    if (styleData != null)
                    {
                        costStyle = Convert.ToDecimal(styleData.Note);
                        newProduct.Image = styleData.Path;
                    }
                    else
                    {
                        newProduct.Image = p.Image;
                    }
                    //Kiểm tra Size của Product                                
                    if (sizeData != null)
                    {
                        costSize = Convert.ToDecimal(sizeData.Price);
                    }
                    //Kiểm tra nếu giá ưu đãi/giá cũ = null hoặc = 0 hay ko?
                    //Nếu có thì lấy giá bán làm giá thanh toán
                    if (p.PriceOld == null || p.PriceOld == 0)
                    {
                        costProduct = Convert.ToDecimal(p.Price);
                    }
                    else
                    {
                        costProduct = Convert.ToDecimal(p.PriceOld);
                    }
                    //Giá của sản phẩm sau cùng:
                    newProduct.Price = costProduct + costSize + costStyle;
                }
                return newProduct;
            }).ToList();            
        }
    }

    public class NewProduct
    {
        //Mã sản phẩm
        public int ProductId { set; get; }
        //Kiểu sản phẩm
        public int IdStyle { set; get; }
        //Giá bán
        public decimal Price { set; get; }
        //Tên sản phẩm
        public string Name { set; get; }
        //Ảnh sản phẩm
        public string Image { set; get; }
        //Số lượng
        public int Quantity { set; get; }  
        //Size
        public int SizeId { set; get; } 
    }

    public class ShoppingCartAjax
    {
        public void ChangeCart()
        {
            var product = ShoppingCart.Inst.Get();
            var cart = ShoppingCart.Inst.Items;

            var data = product.Join(cart, 
                p => p.ProductId + "_" + p.IdStyle + "_" + p.SizeId, 
                c => c.ProductID + "_" + c.IdStyle + "_" + c.SizeId, 
                (p, c) => new { p.Price, c.Quantity, ProductID = p.ProductId, c.SizeId }).ToList();

            var totalMoney = data.Sum(item => item.Price * item.Quantity);
            ShContext.Current.Data["Cart"] = new { TotalMoney = totalMoney, TotalProduct = ShoppingCart.Inst.Items.Sum(item => item.Quantity) };
            ShContext.Current.Data["Items"] = data;
        }

        /// <summary>
        /// Đẩy sản phẩm khách chọn vào Giỏ hàng
        /// </summary>
        public void Push()
        {
            var productId = HttpContext.Current.Request.Params["pId"];
            if (productId.IsNotNull())
            {
                var quantity = HttpContext.Current.Request.Params["qId"];
                var styleId = HttpContext.Current.Request.Params["style"];
                var sizeId = HttpContext.Current.Request.Params["size"];
                ShoppingCart.Inst.AddProduct(Convert.ToInt32(productId), 
                    CheckDataInput(quantity.Trim(), "quantity"), 
                    CheckDataInput(styleId.Trim(), "style"), 
                    CheckDataInput(sizeId.Trim(), "size"));
                ChangeCart();                
            }            
        }

        /// <summary>
        /// Kiểm tra chuỗi đưa vào có phải là số không? Nếu ko thì return ra kiểu số hợp lệ.
        /// </summary>
        /// <param name="sInput"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        private int CheckDataInput(string sInput, string type)
        {
            try
            {
                var resInt = Convert.ToInt32(sInput);
                if (type != "quantity") return resInt;
                if (resInt < 10)
                {
                    return resInt;
                }
                resInt = 1;
                return resInt;
            }
            catch (Exception)
            {
                return type == "quantity" ? 1 : 0;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        public void Remove()
        {
            var productId = Convert.ToInt32(HttpContext.Current.Request.Params["pId"]);
            var styleId = Convert.ToInt32(HttpContext.Current.Request.Params["style"]);
            var sizeId = Convert.ToInt32(HttpContext.Current.Request.Params["size"]);
            ShoppingCart.Inst.RemoveProduct(productId, styleId, sizeId);
            ChangeCart();
        }

        /// <summary>
        /// Cập nhật giỏ hàng
        /// </summary>
        public void Update()
        {
            var data = HttpContext.Current.Request.Params["data"].Split('@').ToList();

            data.ForEach(item => 
            {
                var iv = item.Split(':');
                if (iv.Length != 3 || string.IsNullOrEmpty(iv[0]) || string.IsNullOrEmpty(iv[1]) || string.IsNullOrEmpty(iv[2]) || string.IsNullOrEmpty(iv[3])) return;

                // Cho nay can validate nhe, neu no nhap ko phai kieu so em phai alert hoac gi do nhe
                // ko no nhap linh tinh convert loi ngay
                // check ko duoc nhap so am nua
                // iv[1] = so luong, iv[0] = id san pham
                ShoppingCart.Inst.UpdateItems(Convert.ToInt32(iv[0]), Convert.ToInt32(iv[1]), Convert.ToInt32(iv[2]), Convert.ToInt32(iv[3]));
            });

            ChangeCart();
        }
    }
}