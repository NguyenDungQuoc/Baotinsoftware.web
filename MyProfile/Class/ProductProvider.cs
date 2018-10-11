using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MyProfile.Settings;

namespace MyProfile.Class
{    
    public class ProductProvider
    {
        private readonly DatabaseToLinqEntityDataContext _dbContext;

        public ProductProvider()
        {
            _dbContext = new DatabaseToLinqEntityDataContext();
        }

        #region PRODUCT        

        public Fe_GetProductByIdResult Fe_GetProductById(int? productId, string prefixUrl = MyConstant.ProductAlias)
        {
            return _dbContext.Fe_GetProductById(productId, prefixUrl).FirstOrDefault();
        }

        public List<Fe_GetProductByCategoryIdResult> Fe_GetProductByCategoryId(int? categoryId,
            string prefixUrl = MyConstant.ProductAlias)
        {
            return _dbContext.Fe_GetProductByCategoryId(categoryId, prefixUrl).ToList();
        }

        public List<PRODUCT> GetTableProduct()
        {
            return _dbContext.PRODUCTs.ToList();
        }

        public PRODUCT GetProductById(int productId)
        {
            return _dbContext.PRODUCTs.FirstOrDefault(x => x.ID == productId);
        }

        public List<GET_PRODUCT_TYPE_IDResult> GET_PRODUCT_TYPE_ID(int typeId)
        {
            return _dbContext.GET_PRODUCT_TYPE_ID(typeId).ToList();
        }

        public List<GetProductByKeywordResult> GetProductByKeyword(string keyword, string prefixUrl = MyConstant.ProductAlias)
        {
            return _dbContext.GetProductByKeyword(keyword, prefixUrl).ToList();
        }

        public int INSERT_INTO_TABLE_PRODUCTS(string code, string name, string tag, string img, string sapo,
            string content, decimal price, decimal priceOld, int categoryId, int statusId, string linkY, bool active = false, bool ishot = false)
        {
            var t = new PRODUCT
            {
                Code = code,
                Name = name,
                Tag = tag,
                Image = img,
                Sapo = sapo,
                Content = content,
                Price = price,
                PriceOld = priceOld,
                ID_GroupProduct = categoryId,
                DatePublish = DateTime.Now,
                CountView = 1,
                CountBuy = 0,
                StatusID = statusId,
                IsActive = active,
                IsHot = ishot,
                LinkY = linkY
            };
            _dbContext.PRODUCTs.InsertOnSubmit(t);
            _dbContext.SubmitChanges();
            return _dbContext.PRODUCTs.Max(w => w.ID);
        }

        public void UPDATE_VALUE_PRODUCTS(int recordId, string code, string name, string tag, string img, string sapo,
            string content, decimal price, decimal priceOld, int categoryId, int statusId, string linkY, bool active = false, bool ishot = false)
        {
            var t = _dbContext.PRODUCTs.FirstOrDefault(w => w.ID == recordId);
            if (t != null)
            {
                t.Code = code;
                t.Name = name;
                t.Tag = tag;
                t.Image = img;
                t.Sapo = sapo;
                t.Content = content;
                t.Price = price;
                t.PriceOld = priceOld;
                t.ID_GroupProduct = categoryId;
                t.StatusID = statusId;
                t.IsActive = active;
                t.IsHot = ishot;
                t.LinkY = linkY;
                _dbContext.SubmitChanges();
            }
        }

        public void DELETE_RECORD_TABLE_PRODUCTS(int recordId)
        {
            var t = _dbContext.PRODUCTs.FirstOrDefault(w => w.ID == recordId);
            _dbContext.PRODUCTs.DeleteOnSubmit(t ?? throw new InvalidOperationException());
            _dbContext.SubmitChanges();
        }

        public void UPDATE_ACTIVE_AND_ISHOT_PRODUCTS(bool type, int recordId, bool active, bool ishot)
        {
            var t = _dbContext.PRODUCTs.FirstOrDefault(w => w.ID == recordId);
            if (type) //UPDATE ACTIVE
            {
                if (t != null) t.IsActive = active;
            }
            else //UPDATE ISHOT
            {
                if (t != null) t.IsHot = ishot;
            }
            _dbContext.SubmitChanges();
        }

        public void UPDATE_PRICE_AND_STATUS_PRODUCTS(int recordId, decimal price, int statusId)
        {
            var t = _dbContext.PRODUCTs.FirstOrDefault(w => w.ID == recordId);
            if (t != null)
            {
                t.Price = price;
                t.StatusID = statusId;
            }
            _dbContext.SubmitChanges();
        }

        public void UPDATE_VIEW_OR_BUY_TABLE_PRODUCT(bool type, int recordId)
        {
            var t = _dbContext.PRODUCTs.FirstOrDefault(w => w.ID == recordId);
            if (type)
            {
                if (t != null) t.CountView = t.CountView + 1;
            }
            else
            {
                if (t != null) t.CountBuy = t.CountBuy + 1;
            }            
            _dbContext.SubmitChanges();
        }

        /// <summary>
        /// Phân trang theo cờ bool (flagId) đưa vào.
        /// Ví dụ: flagId = true OR false thì lấy theo đk
        /// Còn không sẽ lấy theo mặc định là không có điều kiện gì.
        /// </summary>
        /// <param name="flagId"></param>
        /// <param name="pIndex"></param>
        /// <param name="pSize"></param>
        /// <returns></returns>
        public List<GET_PRODUCT_PAGINGResult> GetProductPaging(int flagId, int pIndex, int pSize)
        {
            return _dbContext.GET_PRODUCT_PAGING(flagId, pIndex, pSize).ToList();
        }

        /// <summary>
        /// Đếm tổng số sản phẩm
        /// </summary>
        /// <param name="flagId"></param>
        /// <returns></returns>
        public int TotalProductPagingCount(int flagId)
        {
            var t = _dbContext.GET_PRODUCT_PAGING_COUNT(flagId).FirstOrDefault();
            return t != null ? Convert.ToInt32(t.Total) : 0;
        }

        /// <summary>
        /// Lấy sản phẩm và phân trang theo danh mục. Nếu là danh mục cha sẽ lấy cả sản phẩm thuộc cả danh mục con
        /// </summary>
        /// <param name="categoryId"></param>
        /// <param name="pIndex"></param>
        /// <param name="pSize"></param>
        /// <param name="prefixUrl"></param>
        /// <returns></returns>
        public List<GetProductPagingByCategoryIdResult> GetProductPagingByCategoryId(int categoryId, int pIndex = 1, int pSize = 10, string prefixUrl = MyConstant.ProductAlias)
        {
            return _dbContext.GetProductPagingByCategoryId(categoryId, pIndex, pSize, prefixUrl).ToList();
        }

        /// <summary>
        /// Đếm tổng số sản phẩm theo danh mục
        /// </summary>
        /// <param name="categoryId"></param>
        /// <returns></returns>
        public int TotalProductPagingByCategoryIdCount(int categoryId)
        {
            var t = _dbContext.GetProductPagingByCategoryIdCount(categoryId).FirstOrDefault();
            return t != null ? Convert.ToInt32(t.Total) : 0;
        }

        public List<PRODUCT_STATUS> GetTableProductStatus()
        {
            return _dbContext.PRODUCT_STATUS.ToList();
        }

        public List<PRODUCT> GetProductByListProductId(List<int> productId)
        {
            return _dbContext.PRODUCTs.Where(w => productId.Contains(w.ID)).ToList();
        }
        #endregion

        /// <summary>
        /// GROUP_PRODUCTS
        /// </summary>
        /// <returns></returns>
        #region == GROUP_PRODUCTS ===
        public string Get_Url_Category(int categoryId)
        {
            if (categoryId == 0) return "all-0";
            var category = GetGroupProductByPrimaryKey(categoryId);
            return "{0}-{1}".Frmat(category.Tag, categoryId);
        }

        public GROUP_PRODUCT GetGroupProductByPrimaryKey(int categoryId)
        {
            return _dbContext.GROUP_PRODUCTs.FirstOrDefault(w => w.ID == categoryId);
        }

        public List<GROUP_PRODUCT> GET_TABLE_GROUP_PRODUCTS()
        {
            return _dbContext.GROUP_PRODUCTs.ToList();
        }

        public List<GROUP_PRODUCT> GetCategoryProductByParentId(int parentId = 0, bool isActive = true, bool isHot = true)
        {
            return GET_TABLE_GROUP_PRODUCTS()
                .Where(w => w.ParentID == parentId && w.Active == isActive && w.IsHot == isHot)
                .OrderBy(w => w.Position)
                .ToList();
        }

        public void INSERT_VALUE_GROUP_PRODUCTS(string name, string des, int parentId, string img, int position = 0, bool active = false, bool isHot = false)
        {
            var t = new GROUP_PRODUCT
            {
                Name = name,
                Tag = name.UnicodeFormat(),
                Position = position,
                Description = des,
                ParentID = parentId,
                Image = img,
                Active = active,
                IsHot = isHot
            };
            _dbContext.GROUP_PRODUCTs.InsertOnSubmit(t);
            _dbContext.SubmitChanges();
        }

        public void UPDATE_VALUE_GROUP_PRODUCTS(int productId, string name, string des, int parentId, string img = "", bool active = false, int position = 0)
        {
            var t = _dbContext.GROUP_PRODUCTs.FirstOrDefault(w => w.ID == productId);
            if (t != null)
            {
                t.Name = name;
                t.Tag = name.UnicodeFormat();
                t.Position = position;
                t.Description = des;
                t.ParentID = parentId;
                t.Image = img;
                t.Active = active;
            }
            _dbContext.SubmitChanges();
        }

        public void UpdateIsActiveOrPositionForGroupProduct(bool type, int recordId, int position = 0)
        {
            var t = _dbContext.GROUP_PRODUCTs.FirstOrDefault(w => w.ID == recordId);
            if (type) //UPDATE ACTIVE
            {
                if (t != null) t.Active = t.Active != true;
            }
            else //UPDATE POSITION
            {
                if (t != null) t.Position = position;
            }
            _dbContext.SubmitChanges();
        }

        public void UPDATE_ISHOT_TABLE_GROUP_PRODUCTS(int recordId)
        {
            var t = _dbContext.GROUP_PRODUCTs.FirstOrDefault(w => w.ID == recordId);
            if (t != null) t.IsHot = t.IsHot != true;
            _dbContext.SubmitChanges();
        }

        public void DELETE_GROUP_PRODUCTS(int recordId)
        {
            var t = _dbContext.GROUP_PRODUCTs.FirstOrDefault(w => w.ID == recordId);
            _dbContext.GROUP_PRODUCTs.DeleteOnSubmit(t ?? throw new InvalidOperationException());
            _dbContext.SubmitChanges();
        }
        
        public List<GROUP_PRODUCT> ListProductCategory()
        {
            var resultCategory = new List<GROUP_PRODUCT>();
            var listCategory = GET_TABLE_GROUP_PRODUCTS().OrderBy(w => w.Position).ToList();
            foreach (var item in listCategory.Where(w => w.ParentID == 0).ToList())
            {                
                resultCategory.Add(item);
                var listChildCategory = listCategory.Where(w => w.ParentID == item.ID).OrderBy(w => w.Position).ToList();
                foreach (var record in listChildCategory)
                {
                    record.Name = "→ " + record.Name;
                }
                resultCategory.AddRange(listChildCategory);
            }            
            return resultCategory.ToList();                        
        }

        #endregion        


        #region ORDER_PRODUCTS

        public List<GET_ORDER_PRODUCT_PAGINGResult> ORDER_PRODUCT_PAGING(int pIndex, int pSize)
        {
            return _dbContext.GET_ORDER_PRODUCT_PAGING(pIndex, pSize).ToList();
        }

        public int ORDER_PRODUCT_PAGING_COUNT()
        {
            var result = _dbContext.GET_ORDER_PRODUCT_PAGING_COUNT().FirstOrDefault();
            return result != null ? Convert.ToInt32(result.Total) : 0;
        }

        public List<ORDER_PRODUCT> GET_TABLE_ORDER_PRODUCTS()
        {
            return _dbContext.ORDER_PRODUCTs.ToList();
        }

        public List<ORDER_STATUSE> GET_TABLE_ORDER_STATUS()
        {
            return _dbContext.ORDER_STATUSEs.ToList();
        }

        public List<ORDER_DETAIL> GET_TABLE_ORDER_DETAILS()
        {
            return _dbContext.ORDER_DETAILs.ToList();
        }
        /// <summary>
        /// Lấy danh sách sản phẩm mà khách hàng đã đặt ở hóa đơn
        /// </summary>
        /// <param name="orderId"></param>
        /// <returns></returns>
        public List<GET_ORDER_DETAILSResult> GET_TABLE_ORDER_DETAILS(int orderId)
        {
            return _dbContext.GET_ORDER_DETAILS(orderId).ToList();
        }

        public void UPDATE_STATUS_AND_NOTE_ORDER_PRODUCT(int orderId, string note, int statusId)
        {
            var t = _dbContext.ORDER_PRODUCTs.FirstOrDefault(w => w.ID == orderId);
            if (t == null) return;
            t.CustomerNote = note;
            t.StatusID = statusId;
            _dbContext.SubmitChanges();
        }

        public void DELETE_ORDER_PRODUCTS(int orderId)
        {
            var t = _dbContext.ORDER_PRODUCTs.FirstOrDefault(w => w.ID == orderId);
            _dbContext.ORDER_PRODUCTs.DeleteOnSubmit(t ?? throw new InvalidOperationException());
            _dbContext.SubmitChanges();
        }

        #endregion

        #region PRODUCT_IMAGES

        public List<PRODUCT_IMAGE> GET_TABLE_PRODUCT_IMAGE()
        {
            return _dbContext.PRODUCT_IMAGEs.ToList();
        }

        public void INSERT_VALUE_PRODUCT_IMAGE(string path, string alt, int productId)
        {
            var t = new PRODUCT_IMAGE
            {
                Path = path,
                Note = alt,
                ID_Products = productId
            };
            _dbContext.PRODUCT_IMAGEs.InsertOnSubmit(t);
            _dbContext.SubmitChanges();
        }

        public void DeleteProductImage(int recordId)
        {
            var t = _dbContext.PRODUCT_IMAGEs.FirstOrDefault(w => w.ID == recordId);
            _dbContext.PRODUCT_IMAGEs.DeleteOnSubmit(t ?? throw new InvalidOperationException());
            _dbContext.SubmitChanges();
        }

        public void DeleteProductImageByProductId(int productId)
        {
            var productImages = _dbContext.PRODUCT_IMAGEs.Where(w => w.ID_Products == productId).ToList();
            productImages.ForEach(item => {
                DeleteProductImage(item.ID);
            });
        }
        #endregion

        #region PRODUCT_TYPES

        public List<TYPE> GET_TABLE_TYPES()
        {
            return _dbContext.TYPEs.Where(w => w.IsActive == true).ToList();
        }

        public void INSERT_VALUE_TABLE_TYPES(string name, string tag)
        {
            var t = new TYPE
            {
                Name = name,
                Tag = tag
            };
            _dbContext.TYPEs.InsertOnSubmit(t);
            _dbContext.SubmitChanges();
        }

        public void UPDATE_RECORD_TABLE_TYPES(int id, string name, string tag)
        {
            var t = _dbContext.TYPEs.FirstOrDefault(w => w.ID_Type == id);
            if (t != null)
            {
                t.Name = name;
                t.Tag = tag;
            }
            _dbContext.SubmitChanges();
        }

        public void DELETE_RECORD_TABLE_TYPES(int id)
        {
            var t = _dbContext.TYPEs.FirstOrDefault(w => w.ID_Type == id);
            _dbContext.TYPEs.DeleteOnSubmit(t ?? throw new InvalidOperationException());
            _dbContext.SubmitChanges();
        }

        /// <summary>
        /// PRODUCT_TYPE
        /// </summary>
        /// <returns></returns>
        public List<PRODUCT_TYPE> GET_TABLE_PRODUCT_TYPE()
        {
            return _dbContext.PRODUCT_TYPEs.ToList();
        }

        public void INSERT_VALUE_TABLE_PRODUCT_TYPES(int productId, int idType)
        {
            var t = new PRODUCT_TYPE
            {
                ID_Product = productId,
                ID_Type = idType
            };
            _dbContext.PRODUCT_TYPEs.InsertOnSubmit(t);
            _dbContext.SubmitChanges();
        }

        public void UPDATE_RECORD_TABLE_PRODUCT_TYPES(int productTypeId, int productId, int idType)
        {
            var t = _dbContext.PRODUCT_TYPEs.FirstOrDefault(w => w.ID == productTypeId);
            if (t != null)
            {
                t.ID_Product = productId;
                t.ID_Type = idType;
            }
            _dbContext.SubmitChanges();
        }

        public void DELETE_RECORD_TABLE_PRODUCT_TYPES(int productTypeId)
        {
            var t = _dbContext.PRODUCT_TYPEs.FirstOrDefault(w => w.ID == productTypeId);
            _dbContext.PRODUCT_TYPEs.DeleteOnSubmit(t ?? throw new InvalidOperationException());
            _dbContext.SubmitChanges();
        }

        public void DeleteRecordTableProductTypeByProductId(int productId)
        {
            var t = _dbContext.PRODUCT_TYPEs.Where(w => w.ID_Product == productId).ToList();
            if (t.Count > 0)
            {
                foreach (var item in t)
                {
                    DELETE_RECORD_TABLE_PRODUCT_TYPES(item.ID);
                }
            }
        }

        public string Get_Product_Of_Type(int productId)
        {
            var productTypes = _dbContext.PRODUCT_TYPEs.Where(w => w.ID_Product == productId).ToList();
            foreach (var item in productTypes)
            {
                switch (item.ID_Type)
                {
                    case 1:
                        return "<img src='/Theme/photo/new.png' class='new' alt='Sản phẩm mới' />";
                    case 2:
                        return "<img src='/Theme/photo/sale.png' class='new' alt='Sản phẩm khuyến mãi' />";
                }
            }
            return string.Empty;
        }

        #endregion

        /// <summary>
        /// Show một message
        /// </summary>
        /// <param name="s"></param>
        public void ShowMessageBox(string s)
        {
            HttpContext.Current.Response.Write($"<script type='text/javascript'>alert('{s}');</script>");
        }
    }    
}