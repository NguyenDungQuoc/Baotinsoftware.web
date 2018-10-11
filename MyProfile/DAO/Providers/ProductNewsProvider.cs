using System;
using System.Collections.Generic;
using System.Linq;
using MyProfile.Class;
using MyProfile.Class.Interface;
using MyProfile.Settings;

namespace MyProfile.DAO.Providers
{
    public class ProductNewsProvider : Singleton<ProductNewsProvider>,  IBehavior<PRODUCT_NEW>
    {
        private readonly DatabaseToLinqEntityDataContext _dbContext;

        public ProductNewsProvider()
        {
            _dbContext = new DatabaseToLinqEntityDataContext();
        }

        public void Delete(int id)
        {
            var item = SelectByPrimaryKey(id);
            _dbContext.PRODUCT_NEWs.DeleteOnSubmit(item);
            SaveChanges();
        }

        public int Insert(PRODUCT_NEW t)
        {
            _dbContext.PRODUCT_NEWs.InsertOnSubmit(t);
            SaveChanges();
            return GetMaxProductNewsId();
        }

        public void SaveChanges()
        {
            _dbContext.SubmitChanges();
        }

        public IEnumerable<PRODUCT_NEW> SelectAll()
        {
            return _dbContext.PRODUCT_NEWs.OrderByDescending(x => x.ProductNewsId).ToList();
        }

        public PRODUCT_NEW SelectByPrimaryKey(int productNewsId)
        {
            return _dbContext.PRODUCT_NEWs.FirstOrDefault(x => x.ProductNewsId == productNewsId);
        }

        public IEnumerable<PRODUCT_NEW> GetProductNewsByProductId(int productId)
        {
            return _dbContext.PRODUCT_NEWs.Where(x => x.ProductId == productId).ToList();
        }

        public void Update(PRODUCT_NEW t)
        {
            var productNews = SelectByPrimaryKey(t.ProductNewsId);
            productNews.ProductId = t.ProductId;
            productNews.NewsId = t.NewsId;
            productNews.DisplayOrder = t.DisplayOrder;
            SaveChanges();
        }

        public void UpdateByProductIdAndNewsId(int productId, IEnumerable<string> newsIdSelected)
        {
            var productNewsByProductId = GetProductNewsByProductId(productId);
            _dbContext.PRODUCT_NEWs.DeleteAllOnSubmit(productNewsByProductId);
            newsIdSelected.ForEach(item =>
            {
                Insert(new PRODUCT_NEW { NewsId = Convert.ToInt32(item), ProductId = productId });
            });
        }

        public int GetMaxProductNewsId()
        {
            return _dbContext.PRODUCT_NEWs.Max(x => x.ProductNewsId);
        }

        public IEnumerable<Sp_GetNewsPagingResult> GetNewsByProductId(int productId)
        {
            var newsBlogProvider = new NewsBlogProvider();
            var newsIds = GetProductNewsByProductId(productId).Select(x => x.NewsId).ToList();
            var newsResult = newsBlogProvider.Sp_GetNewsPaging(1, MyConstant.PageSizeMedium).Where(i => newsIds.Contains(i.NewsId)).ToList();
            return newsResult;
        }
    }
}