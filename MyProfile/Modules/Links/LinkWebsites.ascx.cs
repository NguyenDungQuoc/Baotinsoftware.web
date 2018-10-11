using System;
using MyProfile.Class;

namespace MyProfile.Modules.Links
{
    public partial class LinkWebsites : System.Web.UI.UserControl
    {
        LinksWebsites  l = new LinksWebsites();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind_DataLinksWebsite();
            }
        }

        private void Bind_DataLinksWebsite()
        {
            rpt_ListLinkWebsite.DataSource = l.GET_TABLE_LINKS_WEBSITES();
            rpt_ListLinkWebsite.DataBind();
        }
    }
}