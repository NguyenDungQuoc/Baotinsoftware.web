using System.Linq;
using MyProfile.Settings;

namespace MyProfile.Class
{
    public class MyAccount : IAccount
    {
        public string UserId { set; get; }
        public string FullName { set; get; }

        private readonly DatabaseToLinqEntityDataContext _dbContext = new DatabaseToLinqEntityDataContext();
        
        public bool GetAccount(object key)
        {            
            var t = _dbContext.USERs.FirstOrDefault(w => w.Username == key.ToString());
            if (t == null) {return false;}            
            UserId = key.ToString();
            FullName = t.Fullname;
            return true;            
        }

        public string GetKey()
        {
            return UserId;
        }

        public bool Login(string username, string password)
        {
            var t = new UserAdmin();
            if (t.CHECK_LOGIN_ADMIN(username, password) == false) {
                return false;
            }
            var user = t.GetUsersByUsername(username).First();
            var myuser = new MyAccount
            {
                UserId = username,
                FullName = user.Fullname
            };
            AccountSession<MyAccount>.Inst.Authen(myuser);
            return true;

        }
    }
}