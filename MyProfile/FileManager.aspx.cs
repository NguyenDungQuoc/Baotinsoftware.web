using System;
using System.Web.UI;

namespace MyProfile
{
    public partial class FileManager : Page
    {
        protected string Type
        {
            get { return Request.QueryString["type"]; }
        }

        protected bool Multi
        {
            get { return string.IsNullOrEmpty(Request.QueryString["multi"]) ? false : Convert.ToBoolean(Request.QueryString["multi"]); }
        }
    }
}