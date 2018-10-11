using MyProfile.Settings;
using System.Collections.Generic;
using System.Linq;
using System;

namespace MyProfile.Class
{
    public class DownloadFile
    {
        private readonly DatabaseToLinqEntityDataContext _dbContext = new DatabaseToLinqEntityDataContext();
        public List<DOWNLOAD> GetListDataDownloadFile()
        {
            return _dbContext.DOWNLOADs.OrderByDescending(w => w.Date).ToList();
        }

        public List<DOWNLOAD> GetDataDownloadById(int downloadId)
        {
            return _dbContext.DOWNLOADs.Where(w => w.DownloadId == downloadId).ToList();
        }

        public void InsertRecordToTableDownload(string name, string path, string des, string size = "NA", bool active = false)
        {
            var t = new DOWNLOAD
            {
                Name = name,
                Path = path,
                Description = des,
                Size = size,
                Date = DateTime.Now,
                IsActive = active
            };
            _dbContext.DOWNLOADs.InsertOnSubmit(t);
            _dbContext.SubmitChanges();
        }

        public void UpdateRecordToTableDownload(int downloadId, string name, string path, string des, string size)
        {
            var t = _dbContext.DOWNLOADs.FirstOrDefault(w => w.DownloadId == downloadId);
            if (t != null)
            {
                t.Name = name;
                t.Path = path;
                t.Description = des;
                t.Size = size;
            }
            _dbContext.SubmitChanges();
        }

        public void UpdateIsActiveToTableDownload(int downloadId)
        {
            var t = _dbContext.DOWNLOADs.FirstOrDefault(w => w.DownloadId == downloadId);
            if (t != null) t.IsActive = t.IsActive != true;
            _dbContext.SubmitChanges();
        }

        public void DeleteRecordToTableDownload(int downloadId)
        {
            var t = _dbContext.DOWNLOADs.FirstOrDefault(w => w.DownloadId == downloadId);
            _dbContext.DOWNLOADs.DeleteOnSubmit(t ?? throw new InvalidOperationException());
            _dbContext.SubmitChanges();
        }
    }
}