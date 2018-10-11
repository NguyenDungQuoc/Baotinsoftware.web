using System.Collections.Generic;
using System.Linq;
using MyProfile.Settings;

namespace MyProfile.Class
{
    public class LinksWebsites
    {
        DatabaseToLinqEntityDataContext db = new DatabaseToLinqEntityDataContext();

        public List<LINK> GET_TABLE_LINKS_WEBSITES()
        {
            return db.LINKs.OrderByDescending(w => w.ID).ToList();
        }

        public void INSERT_INTO_TABLE_LINKS(string name, string href, string image)
        {
            LINK t = new LINK();
            t.Name = name;
            t.Href = href;
            t.Image = image;
            db.LINKs.InsertOnSubmit(t);
            db.SubmitChanges();
        }

        public void UPDATE_VALUE_TABLE_LINKS(int id, string name, string href, string image)
        {
            var t = db.LINKs.Where(w => w.ID == id).FirstOrDefault();
            t.Name = name;
            t.Href = href;
            t.Image = image;
            db.SubmitChanges();
        }

        public void DELETE_TABLE_LINKS(int id)
        {
            var t = db.LINKs.Where(w => w.ID == id).FirstOrDefault();
            db.LINKs.DeleteOnSubmit(t);
            db.SubmitChanges();
        }
    }
}