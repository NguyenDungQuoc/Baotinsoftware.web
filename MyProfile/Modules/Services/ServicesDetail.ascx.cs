using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Modules.Services
{
    public partial class ServicesDetail : UserControl
    {
        ServicesClass s = new ServicesClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_Detail();
            }
        }

        private void BindData_Detail()
        {
            try
            {
                //---Tab Left---//
                const int catId = 1; //Our Services
                rpt_TabLeft_ListCategories.DataSource =
                    s.GET_TABLE_GROUP_SERVICES()
                        .Where(w => w.ParentID == catId && w.Active == true)
                        .OrderBy(w => w.Position)
                        .ToList();
                rpt_TabLeft_ListCategories.DataBind();

                //---Tab Detail---///
                if (!string.IsNullOrEmpty(Request.Params["id"]))
                {
                    var id = Convert.ToInt32(Request.Params["id"]);
                    s.UPDATE_TABLE_SERVICES_TOTALVIEW(id);
                    var t = s.GET_TABLE_SERVICES().Where(w => w.ID == id).ToList();
                    rpt_TabRight_ServicesDetail.DataSource = t;
                    rpt_TabRight_ServicesDetail.DataBind();
                    Page.Title = t.FirstOrDefault().Title;
                    ltrTitle.Text = s.GET_TABLE_GROUP_SERVICES().FirstOrDefault(w => w.ID == Convert.ToInt32(t.FirstOrDefault().ID_GroupServices)).Name;

                    var domain = Request.Url.Authority;

                    MyProfile.Site.MetaContext["Meta1"] = new Meta
                    {
                        Attr = "itemprop",
                        Name = "datePublished",
                        Content = t.FirstOrDefault().Date.ToString().Substring(0, 10)
                    };
                    MyProfile.Site.MetaContext["Meta2"] = new Meta
                    {
                        Attr = "itemprop",
                        Name = "image",
                        Content = domain + t.FirstOrDefault().Image
                    };
                    MyProfile.Site.MetaContext["Meta3"] = new Meta
                    {
                        Attr = "itemprop",
                        Name = "headline",
                        Content = Page.Title
                    };
                    MyProfile.Site.MetaContext["Meta4"] = new Meta
                    {
                        Attr = "itemprop",
                        Name = "genre",
                        Content = ltrTitle.Text
                    };
                    MyProfile.Site.MetaContext["Meta5"] = new Meta
                    {
                        Attr = "itemprop",
                        Name = "url",
                        Content = domain + Request.RawUrl.Trim()
                    };

                    MyProfile.Site.MetaContext["Meta6"] = new Meta
                    {
                        Attr = "property",
                        Name = "og:url",
                        Content = domain + Request.RawUrl.Trim()
                    };
                    MyProfile.Site.MetaContext["Meta7"] = new Meta
                    {
                        Attr = "property",
                        Name = "og:type",
                        Content = ltrTitle.Text
                    };
                    MyProfile.Site.MetaContext["Meta8"] = new Meta
                    {
                        Attr = "property",
                        Name = "og:image",
                        Content = domain + t.FirstOrDefault().Image
                    };
                    MyProfile.Site.MetaContext["Meta9"] = new Meta
                    {
                        Attr = "property",
                        Name = "og:title",
                        Content = Page.Title
                    };
                    MyProfile.Site.MetaContext["Meta10"] = new Meta
                    {
                        Attr = "property",
                        Name = "og:description",
                        Content = Server.HtmlDecode(t.FirstOrDefault().Sub)
                    };
                    MyProfile.Site.MetaContext["Meta11"] = new Meta
                    {
                        Attr = "property",
                        Name = "article:published_time",
                        Content = t.FirstOrDefault().Date.ToString().Substring(0, 10)
                    };
                }
                else
                {
                    Response.Redirect(MyConstant.PageNotFoundUrl);
                }
            }
            catch (Exception)
            {
                Response.Redirect(MyConstant.PageNotFoundUrl);
            }
        }

        protected void rpt_TabLeft_ListCategories_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var childRepeater = (Repeater)e.Item.FindControl("rpt_ChildList");
                var hdfId = (HiddenField)e.Item.FindControl("hdfID");
                childRepeater.DataSource = s.GET_TABLE_SERVICES().Where(w => w.ID_GroupServices == Convert.ToInt32(hdfId.Value) && w.Active == true).ToList();
                childRepeater.DataBind();
            }
        }

        public string GetTagGroupServices(int idGroupServices)
        {
            return s.GET_TABLE_GROUP_SERVICES().FirstOrDefault(w => w.ID == idGroupServices).Tag;
        }

        protected void rpt_TabRight_ServicesDetail_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            var id = Convert.ToInt32(Request.Params["id"]);
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var childRepeater = (Repeater)e.Item.FindControl("rpt_ListRelated");
                var hdfId = (HiddenField)e.Item.FindControl("hdfID");
                childRepeater.DataSource = s.GET_TABLE_SERVICES().Where(w => w.ID_GroupServices == Convert.ToInt32(hdfId.Value) && w.Active == true && w.ID != id).ToList();
                childRepeater.DataBind();
            }
        }
    }
}