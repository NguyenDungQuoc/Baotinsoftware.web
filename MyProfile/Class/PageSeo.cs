using System;
using System.Collections.Generic;
using System.Linq;
using MyProfile.Settings;

namespace MyProfile.Class
{
    public class PageSeo
    {
        private readonly DatabaseToLinqEntityDataContext _dbContext;
        public PageSeo()
        {
            _dbContext = new DatabaseToLinqEntityDataContext();
        }

        public List<PAGE> GET_TABLE_PAGE()
        {
            return _dbContext.PAGEs.ToList();
        }

        public PAGE GetPageById(int pageId)
        {
            return _dbContext.PAGEs.FirstOrDefault(p => p.ID == pageId);
        }

        public List<PAGE> GET_TABLE_PAGE_IDPAGE(int id)
        {
            return _dbContext.PAGEs.Where(w => w.ID == id).ToList();
        }

        public void UPDATE_TABLE_PAGE(int id, string title, string logo, string slogan, string description, string keyword,
            string img, string favicon, string analytics, string maps, string fanpage)
        {
            var t = _dbContext.PAGEs.FirstOrDefault(w => w.ID == id);
            if (t != null)
            {
                t.Title = title;
                //t.Content = content;
                t.Logo = logo;
                t.Slogan = slogan;
                t.Description = description;
                t.Keyword = keyword;
                t.Image = img;
                t.Favicon = favicon;
                t.GoogleAnalytics = analytics;
                t.MapCode = maps;
                t.Fanpage = fanpage;
                //t.Copyright = copyright;
                //t.Contact = contact;
                _dbContext.SubmitChanges();
            }
        }

        public void UPDATE_CONTENT_ABOUT_PAGE_ID(int id, string content)
        {
            var t = _dbContext.PAGEs.FirstOrDefault(w => w.ID == id);
            if (t != null)
            {
                t.Content = content;
                _dbContext.SubmitChanges();
            }
        }

        public void UPDATE_COPYRIGHT_CONTACT_PAGE_ID(int id , string copyright, string contact)
        {
            var t = _dbContext.PAGEs.FirstOrDefault(w => w.ID == id);
            if (t != null)
            { 
                t.Copyright = copyright;
                t.Contact = contact;
                _dbContext.SubmitChanges();
            }
        }

        public void DELETE_TABLE_PAGE_ID(int pageId)
        {
            var t = _dbContext.PAGEs.FirstOrDefault(w => w.ID == pageId);
            _dbContext.PAGEs.DeleteOnSubmit(t ?? throw new InvalidOperationException());
            _dbContext.SubmitChanges();
        }
    }
}