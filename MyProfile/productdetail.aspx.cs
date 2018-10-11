using System;
using System.Linq;
using System.Text;
using System.Web.Services;
using System.Web.UI;
using MyProfile.Class;
using MyProfile.Class.Messages;
using MyProfile.Enums;
using MyProfile.Settings;

namespace MyProfile
{
    public partial class productdetail : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// TypeId = 0 : Product, 1: News
        /// </summary>
        /// <param name="avatar"></param>
        /// <param name="fullname"></param>
        /// <param name="message"></param>
        /// <param name="email"></param>
        /// <param name="provinceId"></param>
        /// <param name="images"></param>
        /// <param name="productId"></param>
        /// <param name="typeId"></param>
        /// <returns></returns>
        [WebMethod]
        public static object HandleSendComment(string avatar, string fullname, string message, string email,
            string provinceId, string images, string productId, int typeId = 0)
        {
            var responseMessage = new AjaxResponseMessage
            {
                StatusCode = MyEnum.StatusHandle.Fail.ToString(),
                Description = MyConstant.ErrorProcess
            };

            if (!productId.IsInteger() || !fullname.IsNotNullOrNotWhiteSpace() || !message.IsNotNullOrNotWhiteSpace() || email.IsNullOrWhiteSpace())
                return responseMessage;

            try
            {
                var comment = new Comment
                {
                    LinkId = Convert.ToInt32(productId),
                    Name = fullname.StripHtml(),
                    Content = message.StripHtml(),
                    Email = email.StripHtml(),
                    AttachFile = images,
                    Avatar = avatar.Base64ToImage(MyConstant.PathUploadComment),
                    ParentId = 0,
                    Position = 1,
                    IsActive = true,
                    IsDisable = false,
                    TypeId = typeId,
                    DateCreated = DateTime.Now
                };
                var commentProvider = new CommentProvider();
                var adminUser = Singleton<UserAdmin>.Inst.GetUsersByUsername(MyConstant.Systems).FirstOrDefault();
                var product = Singleton<ProductProvider>.Inst.Fe_GetProductById(comment.LinkId);
                if (commentProvider.Insert(comment) <= 0 || adminUser == null || product == null) return responseMessage;
                if (SendEmailForAdmin(adminUser, product))
                {
                    // Response Success
                    return new
                    {
                        StatusCode = MyEnum.StatusHandle.Success.ToString(),
                        Description = "Thêm thành công",
                        comment.Name,
                        comment.Content,
                        comment.Avatar,
                        comment.AttachFile,
                        Date = "{0:dd-MM-yyyy}".Frmat(comment.DateCreated),
                        Time = "{0:HH:mm:ss}".Frmat(comment.DateCreated)
                    };
                }
                return responseMessage;
            }
            catch (Exception ex)
            {
                responseMessage.Description = ex.Message;
                return responseMessage;
            }
        }

        /// <summary>
        /// SEND EMAIL FOR ADMIN
        /// </summary>
        /// <param name="adminUser"></param>
        /// <param name="product"></param>
        /// <returns></returns>
        private static bool SendEmailForAdmin(USER adminUser, Fe_GetProductByIdResult product)
        {
            var subject = "SYSTEMS {0} - NOTIFICATION".Frmat(MyConstant.DomainBaotinSoftware.ToUpper());
            var bodyStringBuilder = new StringBuilder();
            bodyStringBuilder.Append("Xin chào {0}".Frmat(adminUser.Fullname));
            bodyStringBuilder.Append("<br/><br/><b>{0}</b> thông báo, có một bình luận (comment) từ khách hàng, bạn vui lòng kiểm tra và xác nhận thông tin này từ đường dẫn sau.".Frmat(MyConstant.BaotinSoftware.ToUpper()));
            bodyStringBuilder.Append("<br/><br/>Link: <a target='blank' href='{0}{1}'>{2}</a>".Frmat(MyConstant.LinkBaotinSoftware, product.UrlFormat, product.ProductName));
            bodyStringBuilder.Append("<br/><br/>--- <b>LƯU Ý</b> ---");
            bodyStringBuilder.Append("<br/><br/>Please do not respond to this message as it is automatically generated and is for information purposes only.");
            bodyStringBuilder.Append("<br/>(Vui lòng không trả lời email này, đây là email tự động tạo ra với mục đích thông tin)");
            var emailHandle = new EmailHandle();
            emailHandle.Mail.To.Add(adminUser.Email);
            emailHandle.Mail.Subject = subject;
            emailHandle.Mail.Body = bodyStringBuilder.ToString();
            return emailHandle.Send();
        }

        /// <summary>
        /// Xử lý upload hình là base64
        /// </summary>
        /// <param name="base64"></param>
        /// <returns></returns>
        [WebMethod]
        public static string UploadHandler(string base64)
        {
            var myImage = new MyImage {Path = base64.Base64ToImage(MyConstant.PathUploadComment)};
            return myImage.Path;
        }
    }
}