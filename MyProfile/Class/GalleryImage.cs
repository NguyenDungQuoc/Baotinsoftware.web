using System;
using System.Collections.Generic;
using System.Linq;
using MyProfile.Settings;

namespace MyProfile.Class
{
    public class GalleryImage
    {
        public static DatabaseToLinqEntityDataContext db = new DatabaseToLinqEntityDataContext();

        #region GALLERY
        public List<GALLERY> GET_TABLE_GALLERY()
        {
            return db.GALLERies.ToList();
        }

        public void INSERT_GALLERY(string title, string href, string content, DateTime date, int idGroup, bool atv)
        {
            GALLERY t = new GALLERY();
            t.Title = title;
            t.Href = href;
            t.Content = content;
            t.Date = date;
            t.ID_GroupGallery = idGroup;
            t.Active = atv;
            db.GALLERies.InsertOnSubmit(t);
            db.SubmitChanges();
        }

        public void UPDATE_GALLERY(int id, string title, string href, string content, int idGroup, bool atv)
        {
            var t = db.GALLERies.Where(w => w.ID == id).SingleOrDefault();
            t.Title = title;
            t.Href = href;
            t.Content = content;
            t.ID_GroupGallery = idGroup;
            t.Active = atv;
            db.SubmitChanges();
        }

        public void UPDATE_ACTIVE_GALLERY(int id, bool active)
        {
            var t = db.GALLERies.Where(w => w.ID == id).SingleOrDefault();
            t.Active = active;
            db.SubmitChanges();
        }

        public void DELETE_GALLERY_ID(int id)
        {
            var t = db.GALLERies.Where(w => w.ID == id).SingleOrDefault();
            db.GALLERies.DeleteOnSubmit(t);
            db.SubmitChanges();
        }
        #endregion

        #region GROUP GALLERY
        public List<GROUP_GALLERY> GET_TABLE_GROUP_GALLERY()
        {
            return db.GROUP_GALLERies.ToList();
        }

        public void INSERT_GROUP_GALLERY(string name,string tag, string des, int p, bool atv)
        {
            GROUP_GALLERY t = new GROUP_GALLERY();
            t.Name = name;
            t.Tag = tag;
            t.Description = des;
            t.Position = p;
            t.Active = atv;
            db.GROUP_GALLERies.InsertOnSubmit(t);
            db.SubmitChanges();
        }

        public void UPDATE_GROUP_GALLERY(bool k,int idGroup,string name, string tag, string des, int p, bool atv)
        {
            var t = db.GROUP_GALLERies.Where(w => w.ID == idGroup).SingleOrDefault();            
            if (k == true)
            {
                t.Name = name;
                t.Tag = tag;
                t.Description = des;
                t.Position = p;                
            }
            else
            {
                t.Active = atv;
            }
            db.SubmitChanges();
        }

        public void DELETE_GROUP_GALLERY(int idGroup)
        {
            var t = db.GROUP_GALLERies.Where(w => w.ID == idGroup).SingleOrDefault();
            db.GROUP_GALLERies.DeleteOnSubmit(t);
            db.SubmitChanges();
        }
        #endregion
    }
}