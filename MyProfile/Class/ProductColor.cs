using MyProfile.Settings;
using System.Collections.Generic;
using System.Linq;

namespace MyProfile.Class
{
    public class ProductColor
    {
        public DatabaseToLinqEntityDataContext db = new DatabaseToLinqEntityDataContext();        
        
        /// <summary>
        /// TABLE COLOR
        /// </summary>
        /// <returns></returns>
        public List<COLOR> GetAllTableColor()
        {            
            return db.COLORs.OrderByDescending(w => w.ColorId).ToList();
        }

        public List<COLOR> GetColorByColorId(int colorId)
        {            
            return db.COLORs.Where(w => w.ColorId == colorId).ToList();
        }

        /// <summary>
        /// TABLE PRODUCT_COLOR
        /// </summary>
        /// <returns></returns>
        public List<PRODUCT_COLOR> GetAllTableProductColor()
        {
            return db.PRODUCT_COLORs.ToList();
        }

        public void InsertRecordTableProductColor(int colorId, int productId, decimal price = 0)
        {
            PRODUCT_COLOR t = new PRODUCT_COLOR();
            t.ColorId = colorId;
            t.ProductId = productId;
            t.Price = price;
            db.PRODUCT_COLORs.InsertOnSubmit(t);
            db.SubmitChanges();
        }

        public void DeleteRecordTableProductColor(int recordId)
        {
            var t = db.PRODUCT_COLORs.FirstOrDefault(w => w.ProductColorId == recordId);
            db.PRODUCT_COLORs.DeleteOnSubmit(t);
            db.SubmitChanges();
        }

        /// <summary>
        /// Xóa tất cả Record mà có ProductId = productId
        /// </summary>
        /// <param name="productId"></param>
        public void DeleteListRecordProductColorWhereProductId(int productId)
        {
            var t = db.PRODUCT_COLORs.Where(w => w.ProductId == productId).ToList();
            if (t.Count > 0)
            {
                foreach (var item in t)
                {
                    DeleteRecordTableProductColor(item.ProductColorId);
                }
            }
        }

        public List<Get_ProductColor_By_ProductIdResult> GetProductColorByProductId(int productId)
        {
            return db.Get_ProductColor_By_ProductId(productId).ToList();
        }
    }
}