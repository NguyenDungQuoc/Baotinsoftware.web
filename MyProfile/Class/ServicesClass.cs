using System;
using System.Collections.Generic;
using System.Linq;
using MyProfile.Settings;

namespace MyProfile.Class
{
    public class ServicesClass
    {
        private readonly DatabaseToLinqEntityDataContext _dbcContext = new DatabaseToLinqEntityDataContext();

        #region SERVICES

        public List<SERVICE> GET_TABLE_SERVICES()
        {
            return _dbcContext.SERVICEs.ToList();
        }

        public void INSERT_RECORD_TABLE_SERVICES(string title, string tag, string sub, string img, string content, int view,
            bool isHot, bool active, int idGroup, DateTime date, int idUserPost)
        {
            SERVICE t = new SERVICE
            {
                Title = title,
                Tag = tag,
                Sub = sub,
                Image = img,
                Content = content,
                TotalView = view,
                IsHot = isHot,
                Active = active,
                ID_GroupServices = idGroup,
                Date = date,
                ID_UserPost = idUserPost
            };
            _dbcContext.SERVICEs.InsertOnSubmit(t);
            _dbcContext.SubmitChanges();
        }

        public void DELETE_RECORD_TABLE_SERVICES(int id)
        {
            var t = _dbcContext.SERVICEs.SingleOrDefault(w => w.ID == id);
            _dbcContext.SERVICEs.DeleteOnSubmit(t);
            _dbcContext.SubmitChanges();
        }

        public void UPDATE_VALUE_TABLE_SERVICES(int id, string title, string tag, string sub, string img, string content,
            bool isHot, bool active, int idGroup)
        {
            var t = _dbcContext.SERVICEs.SingleOrDefault(w => w.ID == id);
            t.Title = title;
            t.Tag = tag;
            t.Sub = sub;
            t.Image = img;
            t.Content = content;
            t.IsHot = isHot;
            t.Active = active;
            t.ID_GroupServices = idGroup;
            _dbcContext.SubmitChanges();
        }        

        public void UPDATE_TABLE_SERVICES_TOTALVIEW(int id)
        {
            var t = _dbcContext.SERVICEs.SingleOrDefault(w => w.ID == id);
            if (t != null) t.TotalView = t.TotalView + 1;
            _dbcContext.SubmitChanges();
        }

        public void UPDATE_TABLE_SERVICES_ACTIVE_ISHOT(int type, int id, bool k)
        {
            var t = _dbcContext.SERVICEs.SingleOrDefault(w => w.ID == id);
            switch (type)
            {
                case 0:
                    t.Active = k;
                    break;
                case 1:
                    t.IsHot = k;
                    break;
            }
            _dbcContext.SubmitChanges();
        }

        public void UPDATE_TABLE_SERVICES_GROUP_SERVICE_ID(int id, int idCat)
        {
            var t = _dbcContext.SERVICEs.SingleOrDefault(w => w.ID == id);
            t.ID_GroupServices = idCat;
            _dbcContext.SubmitChanges();
        }

        public List<GET_SERVICES_PAGINGResult> SERVICES_PAGING(int pIndex, int pSize)
        {
            return _dbcContext.GET_SERVICES_PAGING(pIndex, pSize).ToList();
        }

        public int SERVICES_PAGING_COUNT()
        {
            return Convert.ToInt32(_dbcContext.GET_SERVICES_PAGING_COUNT().FirstOrDefault().Total);
        }

        public List<GET_SERVICES_PAGING_GROUP_SERVICESResult> SERVICES_PAGING_GROUP_SERVICES(int idCat, int pIndex, int pSize)
        {
            return _dbcContext.GET_SERVICES_PAGING_GROUP_SERVICES(idCat, pIndex, pSize).ToList();
        }

        public int GROUP_SERVICES_PAGING_COUNT(int idCat)
        {
            return Convert.ToInt32(_dbcContext.GET_SERVICES_PAGING_COUNT_GROUP_SERVICES(idCat).FirstOrDefault().Total);
        }

        #endregion

        /// <summary>
        /// GROUP SERVICES
        /// </summary>
        /// <returns></returns>
        #region GROUP_SERVICES

        public List<GROUP_SERVICE> GET_TABLE_GROUP_SERVICES()
        {
            return _dbcContext.GROUP_SERVICEs.ToList();
        }

        public List<GROUP_SERVICE> LIST_SERVICE_CATEGORIES()
        {            
            var resultCategory = new List<GROUP_SERVICE>();
            var lstCategory = GET_TABLE_GROUP_SERVICES().OrderBy(w => w.Position).ToList();
            foreach (var item in lstCategory.Where(w => w.ParentID == 0).ToList())
            {
                resultCategory.Add(item);
                var listChildCategory = lstCategory.Where(w => w.ParentID == item.ID).OrderBy(w => w.Position).ToList();
                foreach (var record in listChildCategory)
                {
                    record.Name = "→ " + record.Name;
                }
                resultCategory.AddRange(listChildCategory);
            }            
            return resultCategory.ToList();
        }

        public void DELETE_RECORD_TABLE_GROUP_SERVICES(int id)
        {
            var t = _dbcContext.GROUP_SERVICEs.FirstOrDefault(w => w.ID == id);
            var l = _dbcContext.GROUP_SERVICEs.Where(w => w.ParentID == id).ToList();
            if (Convert.ToInt32(t.ParentID) != 0 || l.Count == 0)
            {
                _dbcContext.GROUP_SERVICEs.DeleteOnSubmit(t);
            }
            else
            {
                _dbcContext.GROUP_SERVICEs.DeleteOnSubmit(t);
                for (var i = 0; i < l.Count; i++)
                {
                    _dbcContext.GROUP_SERVICEs.FirstOrDefault(w => w.ID == l[i].ID).ParentID = 0;
                }
            }
            _dbcContext.SubmitChanges();
        }

        public void INSERT_TABLE_GROUP_SERVICES(string name, string tag, int p, string des, int parentId, bool active)
        {
            var t = new GROUP_SERVICE
            {
                Name = name,
                Tag = tag,
                Position = p,
                Description = des,
                ParentID = parentId,
                Active = active
            };
            _dbcContext.GROUP_SERVICEs.InsertOnSubmit(t);
            _dbcContext.SubmitChanges();
        }

        public void UPDATE_TABLE_GROUP_SERVICES(int recordId, string name, string tag, int p, string des, int parentId, bool active)
        {
            var t = _dbcContext.GROUP_SERVICEs.FirstOrDefault(w => w.ID == recordId);
            t.Name = name;
            t.Tag = tag;
            t.Description = des;
            t.Position = p;
            t.ParentID = parentId;
            t.Active = active;
            _dbcContext.SubmitChanges();
        }

        public void UPDATE_IS_ACTIVE_AND_POSITION_TABLE_GROUP_SERVICES(int type, int id, bool k, int p)
        {
            var t = _dbcContext.GROUP_SERVICEs.FirstOrDefault(w => w.ID == id);
            if (type == 0)
            {
                t.Active = k;
            }
            else
            {
                t.Position = p;
            }
            _dbcContext.SubmitChanges();
        }
        #endregion
    }
}