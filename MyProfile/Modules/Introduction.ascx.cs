using System;
using MyProfile.Class;
using System.Linq;
using System.Web.UI;

namespace MyProfile.Modules
{
    public partial class Introduction : UserControl
    {
        private NewsBlogProvider _newsBlogProvider;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_NewsInitial();
            }
        }

        private void BindData_NewsInitial()
        {
            _newsBlogProvider = new NewsBlogProvider();
            int newsCategoryId = 1; //About Us
            rpt_Introduction.DataSource = _newsBlogProvider.GET_TABLE_NEWS().Where(w => w.ID_GroupNews == newsCategoryId).Take(1).ToList();
            rpt_Introduction.DataBind();
        }
    }
}