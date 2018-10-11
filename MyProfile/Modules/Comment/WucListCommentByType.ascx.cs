using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Modules.Comment
{
    public partial class WucListCommentByType : UserControl
    {
        private readonly CommentProvider _commentProvider = new CommentProvider();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDataInitial(Request.QueryString["id"]);
            }
        }

        private void BindDataInitial(string request)
        {
            if (request.IsNotNullOrNotWhiteSpace() && request.IsInteger())
            {
                rptListComment.DoBind(_commentProvider.Fe_GetCommentIsParentByLinkId(Convert.ToInt32(request)));
            }
        }

        protected void rptListComment_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (!e.IsItem()) return;
            var rptListSubComment = e.Item.FindControl("rptListSubComment") as Repeater;
            var commentId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "CommentId"));
            rptListSubComment.DoBind(_commentProvider.Fe_GetCommentByParentId(commentId));
        }
    }
}