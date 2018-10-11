using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Controls
{
    public partial class ImagesInput : UserControl
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ltrChoose.Text = "<a href=\"javascript:void(0)\" onclick=\"ShCore.showFiles('Images',true,function(folder,files) { MultipleImagesCallback('" + hdPath.ClientID + "','" + lnk.UniqueID + "',folder,files); })\"><h2 class=\"tile-text\">Chọn ảnh</h2></a>";
            }
        }

        /// <summary>
        /// Điền dữ liệu
        /// </summary>
        /// <param name="data"></param>
        public void SetData(object data)
        {
            rpData.DoBind(data);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnk_Click(object sender, EventArgs e)
        {
            var olds = rpData.Items.Cast<Control>().Select(c => new { Path = c.FindControl("hdPathItem").As<HiddenField>().Value, Note = c.FindControl("txtTitle").As<TextBox>().Text }).ToList();
            var news = hdPath.Value.Split('@').Where(c => c.Trim().IsNotNull()).Select(c => new { Path = c, Note = "" });

            olds.Union(news.FindNewItems(olds, n => n.Path, o => o.Path)).ToList().BindTo(rpData);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public List<T> GetData<T>() where T : IImageInfo, new()
        {
            return rpData.Items.Cast<Control>().Select(c => new T { Path = c.FindControl("hdPathItem").As<HiddenField>().Value, Note = c.FindControl("txtTitle").As<TextBox>().Text }).ToList();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnDel_Click(object sender, EventArgs e)
        {
            var path = sender.As<Button>().NamingContainer.FindControl("hdPathItem").As<HiddenField>().Value;
            rpData.Items.Cast<Control>()
                .Select(c => new { Path = c.FindControl("hdPathItem").As<HiddenField>().Value, Note = c.FindControl("txtTitle").As<TextBox>().Text })
                .Where(c => c.Path != path).ToList().BindTo(rpData);
        }
    }
}