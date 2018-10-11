using System.Collections.Generic;
using System.Linq;
using MyProfile.Settings;

namespace MyProfile.Class
{
    public class SocialNetWork
    {
        public static DatabaseToLinqEntityDataContext db = new DatabaseToLinqEntityDataContext();

        public List<SOCIAL_NETWORK> GET_TABLE_SOCIAL_NETWORK()
        {
            return db.SOCIAL_NETWORKs.ToList();
        }

        public void UPDATE_SOCIAL_NETWORK(bool type, int id, string des, string href, bool active)
        {
            var l = db.SOCIAL_NETWORKs.Where(w => w.ID == id).FirstOrDefault();
            if (l != null)
            {
                if (type) //UPDATE HREF & DESCRIPTION
                {
                    l.Description = des;
                    l.Href = href;
                }
                else //UPDATE ACTIVE
                {
                    l.Active = active;
                }
                db.SubmitChanges();
            }
        }

        public void DELETE_SOCIAL_NETWORK(int id)
        {
            var l = db.SOCIAL_NETWORKs.Where(w => w.ID == id).FirstOrDefault();
            if (l != null)
            {
                db.SOCIAL_NETWORKs.DeleteOnSubmit(l);
                db.SubmitChanges();
            }
        }
    }
}