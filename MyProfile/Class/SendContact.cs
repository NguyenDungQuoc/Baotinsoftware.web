using MyProfile.Settings;
using System;
using System.Collections.Generic;
using System.Linq;

namespace MyProfile.Class
{
    public class SendContact
    {
        private readonly DatabaseToLinqEntityDataContext _dbContext = new DatabaseToLinqEntityDataContext();

        public void INSERT_CONTACT(string name, string title, string email, string phone, string content, int active, DateTime dateSend)
        {
            var t = new CONTACT
            {
                Name = name,
                Title = title,
                Email = email,
                Phone = phone,
                Content = content,
                Status = active,
                Date = dateSend
            };
            _dbContext.CONTACTs.InsertOnSubmit(t);
            _dbContext.SubmitChanges();
        }

        public List<CONTACT> GET_TABLE_CONTACTS()
        {
            return _dbContext.CONTACTs.ToList();
        }

        public void DELETE_CONTACT(int id)
        {
            var t = _dbContext.CONTACTs.FirstOrDefault(w => w.ID == id);
            _dbContext.CONTACTs.DeleteOnSubmit(t ?? throw new InvalidOperationException());
            _dbContext.SubmitChanges();
        }

        public void UPDATE_CONTACT_ACTIVE(int id, int k)
        {
            var t = _dbContext.CONTACTs.FirstOrDefault(w => w.ID == id);
            if (t != null) t.Status = k;
            _dbContext.SubmitChanges();
        }

        internal void SendEmail(string mailTo, string subject, string body)
        {
            try
            {
                var mail = new EmailHandle();
                mail.Mail.To.Add(mailTo);
                mail.Mail.Body = body;
                mail.Mail.Subject = subject;
                mail.Send();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}