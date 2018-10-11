using System;
using System.Linq;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile.Modules.Services
{
    public partial class ServicesOfCategories : UserControl
    {
        ServicesClass s = new ServicesClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_ServiceOfCategories();
            }
        }

        private void BindData_ServiceOfCategories()
        {
            try
            {
                if (!string.IsNullOrEmpty(Request.Params["id"]))
                {
                    int catId = Convert.ToInt32(Request.Params["id"].Trim());
                    Page.Title = ltrTitle.Text = s.GET_TABLE_GROUP_SERVICES().FirstOrDefault(w => w.ID == catId).Name;
                    rpt_ServiceOfCategories.DataSource = s.GET_TABLE_SERVICES().Where(w => w.ID_GroupServices == catId).ToList();
                    rpt_ServiceOfCategories.DataBind();
                }
                else
                {
                    Response.Redirect(MyConstant.PageNotFoundUrl);
                }
            }
            catch (Exception ex)
            {
                Response.Redirect(ex.Message);
            }
            
        }

        public string GetTagGroupServices(int idGroupServices)
        {
            return s.GET_TABLE_GROUP_SERVICES().FirstOrDefault(w => w.ID == idGroupServices).Tag;
        }
    }
}