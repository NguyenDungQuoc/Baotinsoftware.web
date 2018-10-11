using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.SocialNetwork
{
    public partial class SocialLinks : System.Web.UI.UserControl
    {
        SocialNetWork l = new SocialNetWork();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind_DataLinkSocialNetWork();
            }
        }

        private void Bind_DataLinkSocialNetWork()
        {
            GridView_ListData.DataSource = l.GET_TABLE_SOCIAL_NETWORK();
            GridView_ListData.DataBind();
        }        

        protected void GridView_ListData_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case ("IsActive"):
                    var id = e.CommandArgument;
                    bool k =
                        Convert.ToBoolean(
                            l.GET_TABLE_SOCIAL_NETWORK().Where(w => w.ID == Convert.ToInt32(id)).FirstOrDefault().Active);
                    if (k)
                    {
                        l.UPDATE_SOCIAL_NETWORK(false, Convert.ToInt32(id), "", "", false);
                    }
                    else
                    {
                        l.UPDATE_SOCIAL_NETWORK(false, Convert.ToInt32(id), "", "", true);
                    }
                    Bind_DataLinkSocialNetWork();
                    break;
            }
        }

        protected void GridView_ListData_OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView_ListData.EditIndex = e.NewEditIndex;
            Bind_DataLinkSocialNetWork();
        }

        protected void Update_OnClick(object sender, EventArgs e)
        {
            GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;
            string txtIcon = (row.Cells[2].Controls[0].FindControl("txtIcon") as TextBox).Text;
            string txtHref = (row.Cells[3].Controls[0] as TextBox).Text;

            LinkButton lnkUpdate = (sender as LinkButton);
            var key = lnkUpdate.CommandArgument;
            l.UPDATE_SOCIAL_NETWORK(true, Convert.ToInt32(key), txtIcon, txtHref, true);
            GridView_ListData.EditIndex = -1;
            Bind_DataLinkSocialNetWork();
        }

        protected void Cancel_OnClick(object sender, EventArgs e)
        {
            GridView_ListData.EditIndex = -1;
            Bind_DataLinkSocialNetWork();
        }

        /// <summary>
        /// DELETE CALL AJAX
        /// </summary>
        public void DeleteRecord()
        {
            var id = HttpContext.Current.Request.Params["idRecord"];
            l.DELETE_SOCIAL_NETWORK((string.IsNullOrEmpty(id) ? 0 : Convert.ToInt32(id)));
        }
    }
}