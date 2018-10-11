using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.Contact
{
    public partial class ListContacts : System.Web.UI.UserControl
    {
        SendContact sc = new SendContact();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind_ListContact();
            }
        }

        private void Bind_ListContact()
        {
            GridView_ListData.DataSource = sc.GET_TABLE_CONTACTS().OrderByDescending(w => w.Date);
            GridView_ListData.DataBind();
        }

        public static string GET_ISACTIVE(int k)
        {
            string _lock = "<span class='glyphicon glyphicon-eye-close font-16' title='Chưa duyệt'></span>";
            string _unlock = "<span class='glyphicon glyphicon-eye-open font-16' title='Đã duyệt'></span>";
            if (k == 1)
                return _unlock;
            else
                return _lock;
        }

        public void DeleteRecordContact()
        {
            var id = HttpContext.Current.Request.Params["idRecord"];
            sc.DELETE_CONTACT((string.IsNullOrEmpty(id) ? 0 : Convert.ToInt32(id)));
        }

        protected void GridView_ListData_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case ("Status"):
                    int id = Convert.ToInt32(e.CommandArgument);
                    int k =
                        Convert.ToInt32(
                            sc.GET_TABLE_CONTACTS().Where(w => w.ID == id).FirstOrDefault().Status);
                    if (k == 1)                    
                        sc.UPDATE_CONTACT_ACTIVE(id, 0);
                    else                    
                        sc.UPDATE_CONTACT_ACTIVE(id, 1);                    
                    Bind_ListContact();
                    break;
            }
        }
    }
}