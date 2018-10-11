using System;
using System.Collections.Generic;
using System.Linq;
using MyProfile.Settings;

namespace MyProfile.Class
{
    public class NewsBlogProvider
    {
        private readonly DatabaseToLinqEntityDataContext _dbContext;

        public NewsBlogProvider()
        {
            _dbContext = new DatabaseToLinqEntityDataContext();
        }

        #region NEWS

        public IEnumerable<Sp_GetNewsPagingResult> Sp_GetNewsPaging(int pageIndex = 1, int pageSize = 10, bool isActive = true, string prefixUrl = "tin-tuc")
        {
            return _dbContext.Sp_GetNewsPaging(pageIndex, pageSize, isActive, prefixUrl).ToList();
        }

        public int Sp_GetNewsPagingCount(bool isActive = true)
        {
            return _dbContext.Sp_GetNewsPagingCount(isActive).FirstOrDefault().Total ?? 0;
        }

        public List<NEW> GET_TABLE_NEWS()
        {
            return _dbContext.NEWs.OrderByDescending(w => w.ID).ToList();
        }

        public NEW GetTableNewsById(int newsId)
        {
            return _dbContext.NEWs.FirstOrDefault(x => x.ID == newsId);
        }

        public List<NEW> GetTableNewsByIsActive(bool isActive = true)
        {
            return _dbContext.NEWs.Where(x => x.Active == isActive).OrderByDescending(x => x.Date).ToList();
        }

        public List<NEW> GET_TABLE_NEWS_USERID_POST(int userId)
        {
            return _dbContext.NEWs.Where(w => w.ID_UserPost == userId).ToList();
        }
        
        public void INSERT_TABLE_NEWS_BLOGS(string title, string tag, string sub, string img, string content, int view,
            bool isHot, bool active, int categoryId, int userId)
        {
            var t = new NEW
            {
                Title = title,
                Tag = tag,
                News_Sapo = sub,
                Image = img,
                Content = content,
                TotalView = view,
                IsHot = isHot,
                Active = active,
                ID_GroupNews = categoryId,
                Date = DateTime.Now,
                ID_UserPost = userId
            };
            _dbContext.NEWs.InsertOnSubmit(t);
            _dbContext.SubmitChanges();
        }

        /// <summary>
        /// CẬP NHẬT TRẠNG THÁI BÀI VIẾT ACTIVE
        /// </summary>
        public void UPDATE_TABLE_NEWS_ACTIVE_ISPOST(int type,int id, bool k)
        {
            var t = _dbContext.NEWs.FirstOrDefault(w => w.ID == id);
            switch (type)
            {
                case 0:
                    t.Active = k;
                    break;
                case 1:
                    t.IsHot = k;
                    break;
            }
            _dbContext.SubmitChanges();
        }

        public void UPDATE_TABLE_NEWS(int id, string title, string tag, string sub, string img, string content,
            bool isHot, bool active, int categoryId)
        {
            var t = _dbContext.NEWs.FirstOrDefault(w => w.ID == id);
            t.Title = title;
            t.Tag = tag;
            t.News_Sapo = sub;
            t.Image = img;
            t.Content = content;
            t.IsHot = isHot;
            t.Active = active;
            t.ID_GroupNews = categoryId;
            _dbContext.SubmitChanges();
        }

        public void DELETE_RECORD_TABLE_NEWS(int id)
        {
            var t = _dbContext.NEWs.FirstOrDefault(w => w.ID == id);
            _dbContext.NEWs.DeleteOnSubmit(t);
            _dbContext.SubmitChanges();
        }

        /// <summary>
        /// CẬP NHẬT TIN THEO DANH MỤC TIN
        /// </summary>
        public void UPDATE_TABLE_NEWS_GROUPNEWS_ID(int id, int idGroupNews)
        {
            var t = _dbContext.NEWs.FirstOrDefault(w => w.ID == id);
            t.ID_GroupNews = idGroupNews;
            _dbContext.SubmitChanges();
        }

        public void UPDATE_TABLE_NEWS_TOTALVIEW(int id)
        {
            var t = _dbContext.NEWs.FirstOrDefault(w => w.ID == id);
            t.TotalView = t.TotalView + 1;
            _dbContext.SubmitChanges();
        }

        /// <summary>
        /// Phân trang ListNews
        /// </summary>             
        public List<GET_NEWS_PAGINGResult> NEWS_PAGING(int pIndex, int pSize)
        {
            return _dbContext.GET_NEWS_PAGING(pIndex, pSize).ToList();
        }

        public int NEWS_PAGING_COUNT()
        {
            return Convert.ToInt32(_dbContext.GET_NEWS_PAGING_COUNT().FirstOrDefault().Total);
        }        

        public List<GET_NEWS_FEATURED_CATIDResult> GET_NEWS_FEATURED_IDGROUPNEWS(int groupNewsId)
        {
            return _dbContext.GET_NEWS_FEATURED_CATID(groupNewsId).ToList();
        }

        public List<GET_NEWS_PAGING_GROUP_NEWSResult> NEWS_PAGING_GROUP_NEWS(int groupNewsId, int pIndex, int pSize)
        {
            // Lấy news và phân trang theo danh mục. Nếu là danh mục cha sẽ lấy cả sản phẩm thuộc cả danh mục con
            return _dbContext.GET_NEWS_PAGING_GROUP_NEWS(groupNewsId, pIndex, pSize).ToList();
        }

        public int NEWS_PAGING_COUNT_GROUP_NEWS(int groupNewsId)
        {
            // Đếm tổng số items theo danh mục
            return Convert.ToInt32(_dbContext.GET_NEWS_PAGING_COUNT_GROUP_NEWS(groupNewsId).FirstOrDefault().Total);
        }

        #endregion

        /// <summary>
        /// GROUP_NEWS
        /// </summary>
        /// <returns></returns>

        #region GROUP_NEWS
        public List<GROUP_NEW> GET_TABLE_GROUP_NEWS()
        {
            return _dbContext.GROUP_NEWs.ToList();
        }

        public GROUP_NEW GetNewsCategoryById(int newsCategoryId)
        {
            return _dbContext.GROUP_NEWs.FirstOrDefault(x => x.ID == newsCategoryId);
        }

        public List<GROUP_NEW> LIST_CATEGORIES_NEWS()
        {            
            var resultCategory = new List<GROUP_NEW>();
            var lstCategory = GET_TABLE_GROUP_NEWS().OrderBy(w => w.Position).ToList();
            foreach (var item in lstCategory.Where(w => w.ParentID == 0).ToList())
            {
                resultCategory.Add(item);
                var childCategory = lstCategory.Where(w => w.ParentID == item.ID).OrderBy(w => w.Position).ToList();
                foreach (var record in childCategory)
                {
                    record.Name = $"→ {record.Name}";
                }
                resultCategory.AddRange(childCategory);
            }
            return resultCategory.ToList();            
        }

        public void INSERT_TABLE_GROUP_NEWS(string name, string tag, int p, string des, int parentId, bool active)
        {
            var t = new GROUP_NEW
            {
                Name = name,
                Tag = tag,
                Position = p,
                Description = des,
                ParentID = parentId,
                Active = active
            };
            _dbContext.GROUP_NEWs.InsertOnSubmit(t);
            _dbContext.SubmitChanges();
        }

        public void UPDATE_TABLE_GROUP_NEWS(int id, string name, string tag, int position, string description, int parentId, bool active)
        {
            var groupNews = GetNewsCategoryById(id);
            if (groupNews != null)
            {
                groupNews.Name = name;
                groupNews.Tag = tag;
                groupNews.Description = description;
                groupNews.Position = position;
                groupNews.ParentID = parentId;
                groupNews.Active = active;
            }
            _dbContext.SubmitChanges();
        }

        public void UPDATE_IS_ACTIVE_TABLE_GROUP_NEWS(int id, bool isActive)
        {
            var groupNews = GetNewsCategoryById(id);
            groupNews.Active = isActive;
            _dbContext.SubmitChanges();
        }

        public void UPDATE_POSITION_TABLE_GROUP_NEWS(int id, int position)
        {
            var groupNews = GetNewsCategoryById(id);
            groupNews.Position = position;
            _dbContext.SubmitChanges();
        }

        public void DELETE_RECORD_TABLE_GROUP_NEWS(int id)
        {
            var groupNews = GetNewsCategoryById(id);
            var groupNewsByParentId = _dbContext.GROUP_NEWs.Where(w => w.ParentID == id).ToList();
            if (Convert.ToInt32(groupNews.ParentID) != 0 || groupNewsByParentId.Count == 0)
            {
                _dbContext.GROUP_NEWs.DeleteOnSubmit(groupNews);
            }
            else
            {
                _dbContext.GROUP_NEWs.DeleteOnSubmit(groupNews);
                for (var i = 0; i < groupNewsByParentId.Count; i++)
                {
                    _dbContext.GROUP_NEWs.FirstOrDefault(w => w.ID == groupNewsByParentId[i].ID).ParentID = 0;
                }

            }
            _dbContext.SubmitChanges();
        }        

        #endregion
    }
}