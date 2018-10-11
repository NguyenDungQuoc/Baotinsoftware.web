using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MyProfile.Settings;
using System.Web.Security;

namespace MyProfile.Class
{
    public class UserAdmin
    {
        private readonly DatabaseToLinqEntityDataContext _dbContext = new DatabaseToLinqEntityDataContext();   

        public List<USER> GET_TABLE_USER()
        {
            return _dbContext.USERs.ToList();
        }

        public List<USER> GetUsersByUsername(string username)
        {
            return _dbContext.USERs.Where(w => w.Username == username).ToList();
        }

        public USER GET_TABLE_USER_PRIMARYKEY(int userId)
        {            
            return _dbContext.USERs.FirstOrDefault(w => w.ID == userId);
        }

        public USER GetUserByEmail(string email)
        {
            return _dbContext.USERs.FirstOrDefault(w => w.Email == email);
        }

        public void UPDATE_TABLE_USER_USERNAME(int k, string username, string fullname, string img, string note, bool active, string email)
        {
            var t = _dbContext.USERs.SingleOrDefault(w => w.Username == username.Trim().ToString());
            if (t != null)
            {
                if (k == 0) //Thay đổi Active
                {
                    t.Active = active;
                }
                else //Thay đổi tt cá nhân
                {
                    t.Fullname = fullname;
                    t.Image = img;
                    t.Note = note;
                    t.Email = email;
                }
                _dbContext.SubmitChanges();
            }
        }

        public void INSERT_TABLE_USERS_NEWMEMBERSHIP(string username, string password, string fullname, string img,
            DateTime date, bool active, string email)
        {
            var t = new USER
            {
                Username = username,
                Password = Encode_PassWord(password),
                Fullname = fullname,
                Image = img,
                Date = date,
                Active = active,
                Email = email
            };
            _dbContext.USERs.InsertOnSubmit(t);
            _dbContext.SubmitChanges();
        }

        public bool CHECK_ISACTIVE_USER(string username)
        {
            var t = _dbContext.USERs.FirstOrDefault(w => w.Username == username);
            return t?.Active != null && t.Active != false;
        }

        public bool CHECK_LOGIN_ADMIN(string us, string pwd)
        {
            var pass = Encode_PassWord(pwd);
            var t = _dbContext.USERs.SingleOrDefault(w => w.Username == us.Trim().ToString());
            if (t == null) return false;
            return t.Password == pass;
        }

        /// <summary>
        /// Kiểm tra Username và Email khi người dùng đăng ký xem có trùng không
        /// </summary>
        /// <param name="type"></param>
        /// <param name="username"></param>
        /// <param name="email"></param>
        /// <returns></returns>
        public bool VALIDATION_REGISTER_MEMBERSHIP(bool type, string username, string email)
        {
            if (type) //kiem tra Username
            {
                var t = _dbContext.USERs.FirstOrDefault(w => w.Username == username);
                return t == null;
            }
            else //Kiem tra Email
            {
                var t = _dbContext.USERs.FirstOrDefault(w => w.Email == email);
                return t == null;
            }
        }

        /// <summary>
        /// Kiểm tra Email trước khi Update xem Email có trùng không?
        /// </summary>
        /// <param name="username"></param>
        /// <param name="email"></param>
        /// <returns></returns>
        public bool CHECK_EMAIL_USER_WHEN_UPDATE(string username, string email)
        {
            var t = _dbContext.USERs.SingleOrDefault(w => w.Username != username && w.Email == email);
            return t == null;
        }

        public bool CHANGE_PASSWORD_USER(string username, string pwdOld, string pwd)
        {
            var t = _dbContext.USERs.FirstOrDefault(w => w.Username == username);
            if (t != null)
            if (t.Password == Encode_PassWord(pwdOld.Trim()))
            {
                var newPassword = Encode_PassWord(pwd);
                t.Password = newPassword;
                _dbContext.SubmitChanges();
                return true;
            }                
            return false;            
        }

        public void CHANGE_PASSWORD(string us, string pwd)
        {
            var t = _dbContext.USERs.FirstOrDefault(w => w.Username == us);
            if (t != null)
            {
                var newPassword = Encode_PassWord(pwd);
                t.Password = newPassword;
                _dbContext.SubmitChanges();
            }
        }

        public void DELETE_USER_ADMIN(int idUser)
        {
            var t = _dbContext.USERs.FirstOrDefault(w => w.ID == idUser);
            _dbContext.USERs.DeleteOnSubmit(t ?? throw new InvalidOperationException());
            _dbContext.SubmitChanges();
        }

        public List<GET_USERS_PAGINGResult> USERS_PAGING(int pIndex, int pSize)
        {
            return _dbContext.GET_USERS_PAGING(pIndex, pSize).ToList();
        }

        public int USERS_PAGING_COUNT()
        {
            var t = _dbContext.GET_USERS_PAGING_COUNT().FirstOrDefault();
            return t != null ? Convert.ToInt32(t.Total) : 0;
        }
        
        public void ShowMessageBox(string s)
        {
            //Show một message
            var result = $"<script type='text/javascript'>alert('{s}');</script>";
            HttpContext.Current.Response.Write(result);
        }

        public string Encode_PassWord(string pwd)
        {
            //Mã hóa password
            return FormsAuthentication.HashPasswordForStoringInConfigFile(pwd.Trim(), "SHA1");           
        }
    }
}