using MyProfile.Class;
using System.Configuration;

namespace MyProfile.Services.Web.Images
{
    public class AppSettings : Singleton<AppSettings>
    {
        private string saveFolder = ConfigurationManager.AppSettings["SaveFolder"].WhenEmpty(() => "Thumb");
        /// <summary>
        /// 
        /// </summary>
        public string SaveFolder
        {
            get { return saveFolder; }
        }

        private bool isSaveThumb = ConfigurationManager.AppSettings["isSaveThumb"].WhenEmpty(() => "1") == "1";
        /// <summary>
        /// 
        /// </summary>
        public bool IsSaveThumb
        {
            get { return isSaveThumb; }
        }
    }
}
