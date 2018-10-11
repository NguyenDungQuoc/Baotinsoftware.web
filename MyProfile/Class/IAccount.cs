
namespace MyProfile.Class
{
    /// <summary>
    /// IAccount
    /// </summary>
    public interface IAccount
    {
        /// <summary>
        /// Lấy thông tin theo key
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        bool GetAccount(object key);

        /// <summary>
        /// Lấy Key người dung
        /// </summary>
        /// <returns></returns>
        string GetKey();
    }
}
