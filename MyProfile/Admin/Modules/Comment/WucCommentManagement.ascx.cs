using System;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;
using MyProfile.Enums;
using MyProfile.Settings;
using CommentInfo = MyProfile.Settings.Comment;

namespace MyProfile.Admin.Modules.Comment
{
    public partial class WucCommentManagement : UserControl
    {
        private readonly CommentProvider _commentProvider = new CommentProvider();
        private readonly UserAdmin _userAdmin = new UserAdmin();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDataInitial();
            }
        }

        private void BindDataInitial()
        {
            GridViewListData.DoBind(_commentProvider.GetCommentArrangeSequence());
        }

        protected void GridViewListData_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            var commentId = Convert.ToInt32(e.CommandArgument);
            switch (e.CommandName)
            {
                case "IsActive":
                    _commentProvider.UpdateBoolean(MyEnum.UpdateType.IsActive, commentId);
                    break;
                case "IsDisable":
                    _commentProvider.UpdateBoolean(MyEnum.UpdateType.IsDisable, commentId);
                    break;
                case "IsDelete":
                    _commentProvider.Delete(commentId);
                    break;
            }
            BindDataInitial();
        }

        /// <summary>
        /// Ajax Insert Comment
        /// </summary>
        public void InsertComment()
        {
            try
            {
                var content = HttpContext.Current.Request.Params["content"];
                var request = HttpContext.Current.Request.Params["request"];
                var images = HttpContext.Current.Request.Params["images"];
                var adminUser = _userAdmin.GetUsersByUsername(MyConstant.Systems).FirstOrDefault();
                if (content.IsNotNullOrNotWhiteSpace() && request.IsNotNullOrNotWhiteSpace() && adminUser.IsNotNull())
                {
                    var comment = new CommentInfo
                    {
                        Name = adminUser.Fullname,
                        Email = adminUser.Email,
                        Content = content.StripHtml(),
                        IsActive = true,
                        IsDisable = false,
                        TypeId = (int)MyEnum.LinkType.Product,
                        ProvinceId = 0,
                        Position = 0,
                        ParentId = Convert.ToInt32(request.Split('-')[0]),
                        DateCreated = DateTime.Now,
                        Avatar = adminUser.Image,
                        LinkId = Convert.ToInt32(request.Split('-')[1]),
                        AttachFile = images.Replace("[", "").Replace("]", "").Replace("\"", "")
                    };

                    if (_commentProvider.Insert(comment) > 0)
                    {
                        var product = Singleton<ProductProvider>.Inst.Fe_GetProductById(comment.LinkId);
                        SendEmailForAdmin(product, comment);
                        ShContext.Current.Data["Response"] = new
                        {
                            Status = MyEnum.StatusHandle.Success.ToString(),
                            Description = "Thêm thành công"
                        };
                    }
                }
                else
                {
                    ShContext.Current.Data["Response"] = new
                    {
                        Status = MyEnum.StatusHandle.Fail.ToString(),
                        Description = "Đã có lỗi xẩy ra, vui lòng kiểm tra lại"
                    };
                }
            }
            catch (Exception ex)
            {
                ShContext.Current.Data["Response"] = new
                {
                    Status = MyEnum.StatusHandle.Fail.ToString(),
                    Description = ex.Message
                };
            }
        }

        /// <summary>
        /// SEND EMAIL FOR ADMIN
        /// </summary>
        /// <param name="product"></param>
        /// <param name="commentInfo"></param>
        /// <returns></returns>
        private static bool SendEmailForAdmin(Fe_GetProductByIdResult product, CommentInfo commentInfo)
        {
            var commentId = commentInfo.ParentId ?? 0;
            var commentParent = Singleton<CommentProvider>.Inst.SelectByPrimaryKey(commentId);
            if (commentParent.IsNotNull() && commentParent.Email.IsNotNull())
            {
                var bodyStringBuilder = new StringBuilder();
                bodyStringBuilder.Append("Xin chào {0}".Frmat(commentParent.Name));
                bodyStringBuilder.Append("<br/><br/>Admin wesbite <a href='{0}' target='_blank'>{1}</a> vừa trả lời bình luận (comment) của bạn".Frmat(MyConstant.LinkBaotinSoftware, MyConstant.DomainBaotinSoftware));
                bodyStringBuilder.Append("<br/><br/><i>{0}</i>".Frmat(commentInfo.Content));
                bodyStringBuilder.Append("<br/><br/>Bạn có thể xem nội dung bình luận (comment) ở link sau: <a target='blank' href='{0}{1}'>{2}</a>".Frmat(MyConstant.LinkBaotinSoftware, product.UrlFormat, product.ProductName));
                bodyStringBuilder.Append("<br/><br/>--- <b>LƯU Ý</b> ---");
                bodyStringBuilder.Append("<br/><br/>Please do not respond to this message as it is automatically generated and is for information purposes only.");
                bodyStringBuilder.Append("<br/>(Vui lòng không trả lời email này, đây là email tự động tạo ra với mục đích thông tin)");
                var emailHandle = new EmailHandle();
                emailHandle.Mail.To.Add(commentParent.Email);
                emailHandle.Mail.Subject = "PHẢN HỒI COMMENT - BÌNH LUẬN BÀI VIẾT";
                emailHandle.Mail.Body = bodyStringBuilder.ToString();
                return emailHandle.Send();
            }
            return false;
        }
    }
}