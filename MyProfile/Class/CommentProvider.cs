using System;
using System.Collections.Generic;
using System.Linq;
using MyProfile.Class.Interface;
using MyProfile.Enums;
using MyProfile.Settings;

namespace MyProfile.Class
{
    public class CommentProvider : IBehavior<Comment>
    {
        private readonly DatabaseToLinqEntityDataContext _dbContext;

        public CommentProvider()
        {
            _dbContext = new DatabaseToLinqEntityDataContext();
        }

        public IEnumerable<Comment> SelectAll()
        {
            return _dbContext.Comments.OrderByDescending(x => x.DateCreated).ToList();
        }

        public void Update(Comment t)
        {
            SelectByPrimaryKey(t.CommentId).MergeInto(t);
            SaveChanges();
        }

        public int Insert(Comment t)
        {
            _dbContext.Comments.InsertOnSubmit(t);
            SaveChanges();
            return _dbContext.Comments.Max(x => x.CommentId);
        }

        /// <summary>
        /// Delete comment record
        /// Check id is parentId? If is parentId to delete all child
        /// </summary>
        /// <param name="id"></param>
        public void Delete(int id)
        {
            var t = SelectByPrimaryKey(id);
            if (t.IsNull()) throw new ArgumentNullException(nameof(id));
            _dbContext.Comments.DeleteOnSubmit(t);
            if (t.ParentId == 0)
            {
                SelectAll().Where(x => x.ParentId == id).ForEach(x =>
                {
                    _dbContext.Comments.DeleteOnSubmit(x);
                });
            }
            SaveChanges();
        }

        public Comment SelectByPrimaryKey(int key)
        {
            return _dbContext.Comments.FirstOrDefault(x => x.CommentId == key);
        }

        public void SaveChanges()
        {
            _dbContext.SubmitChanges();
        }

        public void UpdateBoolean(MyEnum.UpdateType updateType, int commentId)
        {
            var t = SelectByPrimaryKey(commentId);
            switch (updateType)
            {
                case MyEnum.UpdateType.IsActive:
                    t.IsActive = t.IsActive != true;
                    break;
                case MyEnum.UpdateType.IsDisable:
                    t.IsDisable = t.IsDisable != true;
                    break;
            }
            SaveChanges();
        }

        /// <summary>
        /// Type = 0 : Product, 1 : News
        /// </summary>
        /// <param name="linkId"></param>
        /// <param name="typeId"></param>
        /// <returns></returns>
        public List<Comment> Fe_GetCommentIsParentByLinkId(int linkId, int typeId = 0)
        {
            return _dbContext.Comments.Where(x =>
                x.ParentId == 0 &&
                x.LinkId == linkId &&
                x.TypeId == typeId &&
                x.IsActive == true &&
                x.IsDisable != true).OrderBy(x => x.DateCreated).ToList();
        }

        public List<Comment> Fe_GetCommentByParentId(int parentId, int typeId = 0)
        {
            return _dbContext.Comments.Where(x => x.ParentId == parentId &&
                                                  x.TypeId == typeId &&
                                                  x.IsActive == true &&
                                                  x.IsDisable != true).OrderBy(x => x.DateCreated).ToList();
        }

        public List<GetCommentByTypeIdResult> GetCommentByTypeId(int? typeId = 0, string prefixUrl = "san-pham")
        {
            return _dbContext.GetCommentByTypeId(typeId, prefixUrl).ToList();
        }

        public List<GetCommentByTypeIdResult> GetCommentArrangeSequence(int? typeId = 0, string prefixUrl = "san-pham")
        {
            var listComment = GetCommentByTypeId(typeId, prefixUrl);
            var result = new List<GetCommentByTypeIdResult>();
            listComment.Where(c => c.ParentId == 0).ForEach(c =>
            {
                result.Add(c);
                result.AddRange(listComment.Where(x => x.ParentId == c.CommentId));
            });
            return result;
        }
    }
}