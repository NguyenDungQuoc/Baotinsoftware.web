using MyProfile.Settings;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyProfile.Class
{
    public class ProductSize
    {
        public DatabaseToLinqEntityDataContext db = new DatabaseToLinqEntityDataContext();

        /// <summary>
        /// TABLE SIZE
        /// </summary>
        /// <returns></returns>
        public List<SIZE> GET_TABLE_SIZE()
        {

            return db.SIZEs.ToList();
        }

        public List<Get_ProductSize_By_ProductIdResult> Get_ProductSize_By_ProductId(int productId)
        {
            return db.Get_ProductSize_By_ProductId(productId).ToList();
        }

        public void INSERT_INTO_TABLE_SIZE(string name, string note, bool active)
        {
            SIZE t = new SIZE();
            t.Name = name;
            t.Note = note;
            t.IsActive = active;
            db.SIZEs.InsertOnSubmit(t);
            db.SubmitChanges();
        }

        public void UPDATE_VALUE_TABLE_SIZE(int sizeId, string name, string note, bool active)
        {
            var t = db.SIZEs.FirstOrDefault(w => w.SizeId == sizeId);
            t.Name = name;
            t.Note = note;
            t.IsActive = active;
            db.SubmitChanges();
        }

        public void DELETE_ITEM_TABLE_SIZE(int sizeId)
        {
            var t = db.SIZEs.FirstOrDefault(w => w.SizeId == sizeId);
            db.SIZEs.DeleteOnSubmit(t);
            db.SubmitChanges();
        }

        /// <summary>
        /// TABLE PRODUCT_SIZE
        /// </summary>
        /// <returns></returns>
        public List<PRODUCT_SIZE> GET_TABLE_PRODUCT_SIZE()
        {
            return db.PRODUCT_SIZEs.ToList();
        }

        /// <summary>
        /// THÊM RECORD TABLE PRODUCT_SIZE
        /// </summary>
        /// <param name="sizeId"></param>
        /// <param name="productId"></param>
        public void INSERT_INTO_TABLE_PRODUCT_SIZE(int sizeId, int productId, decimal price = 0)
        {
            PRODUCT_SIZE t = new PRODUCT_SIZE();
            t.SizeId = sizeId;
            t.ProductId = productId;
            t.Price = price;
            db.PRODUCT_SIZEs.InsertOnSubmit(t);
            db.SubmitChanges();
        }

        public void DELETE_ITEM_TABLE_PRODUCT_SIZE(int productSizeId)
        {
            var t = db.PRODUCT_SIZEs.FirstOrDefault(w => w.ProductSizeId == productSizeId);
            db.PRODUCT_SIZEs.DeleteOnSubmit(t);
            db.SubmitChanges();
        }

        /// <summary>
        /// Xóa tất cả Record khi ta Where được 1 List<ProductSzie> 
        /// </summary>
        /// <param name="productId"></param>
        public void DELETE_LIST_ITEM_PRODUCT_SIZE_WHERE_PRODUCTID(int productId)
        {                        
            var t = db.PRODUCT_SIZEs.Where(w => w.ProductId == productId).ToList();
            if (t.Count > 0)
            {
                foreach (var item in t)
                {
                    DELETE_ITEM_TABLE_PRODUCT_SIZE(item.ProductSizeId);
                }
            }
        }
    }
}