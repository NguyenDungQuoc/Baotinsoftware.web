using System.Collections.Generic;
using System.Linq;
using MyProfile.Class.Interface;
using MyProfile.DTO;
using MyProfile.Settings;

namespace MyProfile.Class
{
    public class HashtagProvider : IBehavior<HashTag>
    {
        private readonly DatabaseToLinqEntityDataContext _dbContext;

        public HashtagProvider()
        {
            _dbContext = new DatabaseToLinqEntityDataContext();
        }

        public IEnumerable<HashTag> SelectAll()
        {
            return _dbContext.HashTags.OrderByDescending(x => x.HashTagId);
        }

        public IEnumerable<HashtagDto> GetHashtagByIsHotAndActive(bool isActive = true, bool isHot = true)
        {
            return _dbContext.HashTags.Where(x => x.IsActive == isActive && x.IsHot == isHot)
                .OrderByDescending(x => x.HashTagId)
                .Select(x => new HashtagDto
                {
                    HashtagId = x.HashTagId,
                    Alias = x.Alias,
                    HashtagName = x.Name,
                    UrlFormat = $"/{MyConstant.HashtagAliasVn}/{x.Alias}-{x.HashTagId}.html"
                }).ToList();
        }

        public void Update(HashTag t)
        {
            SelectByPrimaryKey(t.HashTagId).MergeInto(t);
            SaveChanges();
        }

        public int Insert(HashTag hashTag)
        {
            _dbContext.HashTags.InsertOnSubmit(hashTag);
            SaveChanges();
            return _dbContext.HashTags.Max(x => x.HashTagId);
        }

        public void Delete(int id)
        {
            var hashTag = SelectByPrimaryKey(id);
            _dbContext.HashTags.DeleteOnSubmit(hashTag);
            SaveChanges();
        }

        public HashTag SelectByPrimaryKey(int key)
        {
            return _dbContext.HashTags.FirstOrDefault(x => x.HashTagId == key);
        }

        public void SaveChanges()
        {
            _dbContext.SubmitChanges();
        }

        public List<HashTag> SelectByName(string hashTagName)
        {
            return _dbContext.HashTags.Where(x => x.Name.Equals(hashTagName)).ToList();
        }

        public List<Fe_GetProduct_Paging_By_HashtagIdResult> Fe_GetProduct_Paging_By_HashtagId(int? hashtagId,
            int pageIndex = 1, int pageSize = 10, string prefixUrl = MyConstant.ProductAlias)
        {
            return _dbContext.Fe_GetProduct_Paging_By_HashtagId(hashtagId, pageIndex, pageSize, prefixUrl).ToList();
        }
    }
}