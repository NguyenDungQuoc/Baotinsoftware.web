using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using MyProfile.Class;

namespace MyProfile
{
    public partial class Site : MasterPage
    {
        private readonly PageSeo _pageSeo = new PageSeo();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData_PageSEO();
            }
        }

        protected override void OnPreRender(EventArgs e)
        {
            var arr =
                MetaContext.Select(
                    mt => "<meta " + mt.Value.Attr + "='" + mt.Value.Name + "' content='" + HttpUtility.HtmlEncode(mt.Value.Content) + "' />")
                    .ToArray();
            ltrMeta.Text = string.Join("", arr);
        }

        private void LoadData_PageSEO()
        {
            var t = _pageSeo.GET_TABLE_PAGE_IDPAGE(MyConstant.PageIdDefault).FirstOrDefault();

            if (t == null) return;
            MetaContext["Meta1"] = new Meta
            {
                Name = "keywords",
                Content = t.Keyword
            };
            MetaContext["Meta2"] = new Meta
            {
                Name = "description",
                Content = t.Description
            };
            MetaContext["Meta3"] = new Meta
            {
                Name = "Abstract",
                Content = t.Description
            };
            favicon.Href = t.Favicon;
        }

        public static Dictionary<string, Meta> MetaContext
        {
            get
            {
                if (!(HttpContext.Current.Items["MetaContext"] is Dictionary<string, Meta> metaContext))
                     HttpContext.Current.Items["MetaContext"] = metaContext = new Dictionary<string, Meta>();
                return metaContext;
            }
        }
    }

    public class Meta
    {
        public string Attr { set; get; } = "name";

        public string Name { set; get; }

        public string Content { set; get; }
    }
}