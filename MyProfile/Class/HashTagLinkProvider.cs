using System.Collections.Generic;
using System.Linq;
using MyProfile.Class.Interface;
using MyProfile.Settings;

namespace MyProfile.Class
{
    public class HashTagLinkProvider : IBehavior<HashTagLink>
    {
        private readonly DatabaseToLinqEntityDataContext _dbContext;

        public HashTagLinkProvider()
        {
            _dbContext = new DatabaseToLinqEntityDataContext();
        }

        public IEnumerable<HashTagLink> SelectAll()
        {
            return _dbContext.HashTagLinks.OrderByDescending(x => x.HashTagLinkId);
        }

        public void Update(HashTagLink t)
        {
            SelectByPrimaryKey(t.HashTagLinkId).MergeInto(t);
            SaveChanges();
        }

        public int Insert(HashTagLink t)
        {
            _dbContext.HashTagLinks.InsertOnSubmit(t);
            SaveChanges();
            return _dbContext.HashTagLinks.Max(x => x.HashTagLinkId);
        }

        public void Delete(int id)
        {
            var t = SelectByPrimaryKey(id);
            _dbContext.HashTagLinks.DeleteOnSubmit(t);
            SaveChanges();
        }

        public HashTagLink SelectByPrimaryKey(int key)
        {
            return _dbContext.HashTagLinks.FirstOrDefault(x => x.HashTagLinkId == key);
        }

        public void SaveChanges()
        {
            _dbContext.SubmitChanges();
        }

        /// <summary>
        /// Xóa theo loại sản phẩm or tin tức
        /// </summary>
        /// <param name="linkId"></param>
        public void DeleteByLinkId(int linkId)
        {
            var t = _dbContext.HashTagLinks.Where(x => x.LinkId == linkId).ToList();
            t.ForEach(i =>
            {
                Delete(i.HashTagLinkId);
            });
        }

        public List<HashTagLink> GetHashTagLinkByLinkId(int linkId)
        {
            return _dbContext.HashTagLinks.Where(x => x.LinkId == linkId).ToList();
        }
    }
}