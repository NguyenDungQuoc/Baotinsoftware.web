using MyProfile.Settings;
using System.Collections.Generic;
using System.Linq;

namespace MyProfile.Class
{
    public class BannerSlides
    {
        private readonly DatabaseToLinqEntityDataContext _dbContext = new DatabaseToLinqEntityDataContext();

        public List<BANNER> GET_TABLE_BANNER()
        {
            return _dbContext.BANNERs.ToList();
        }

        public void INSERT_BANNER(string title, string content, string img, string href, int p, bool active)
        {
            var t = new BANNER
            {
                Title = title,
                Content = content,
                Image = img,
                Href = href,
                Position = p,
                Active = active
            };
            _dbContext.BANNERs.InsertOnSubmit(t);
            _dbContext.SubmitChanges();
        }

        public void UPDATE_BANNERS(int id, string title, string content, string img, string href, int p, bool active)
        {
            var t = _dbContext.BANNERs.FirstOrDefault(w => w.ID == id);
            if (t != null)
            {
                t.Title = title;
                t.Content = content;
                t.Image = img;
                t.Href = href;
                t.Position = p;
                t.Active = active;
                _dbContext.SubmitChanges();
            }
        }

        public void UPDATE_BANNER_ACTIVE(int id, bool active)
        {
            var t = _dbContext.BANNERs.FirstOrDefault(w => w.ID == id);
            if (t != null)
            {
                t.Active = active;
                _dbContext.SubmitChanges();
            }
        }

        public void DELETE_BANNERS(int id)
        {
            var t = _dbContext.BANNERs.FirstOrDefault(w => w.ID == id);
            _dbContext.BANNERs.DeleteOnSubmit(t);
            _dbContext.SubmitChanges();
        }
    }
}