using System;
using System.Linq;
using MyProfile.Class;

namespace MyProfile.Modules.SocialNetwork
{
    public partial class SocialLink : System.Web.UI.UserControl
    {
        SocialNetWork l = new SocialNetWork();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind_DataSocialNetWork();
            }
        }

        private void Bind_DataSocialNetWork()
        {
            rpt_SocialNetworks.DataSource = l.GET_TABLE_SOCIAL_NETWORK().Where(w => w.Active == true).ToList();
            rpt_SocialNetworks.DataBind();
        }
    }
}