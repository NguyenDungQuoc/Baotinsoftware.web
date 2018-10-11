using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace MyProfile.Class
{
    public class Utility
    {
        public static string GetLabelIsActive(bool k, string mesLock, string mesUnlock)
        {
            var _lock = $"<i class='fa fa-eye-slash font-18' title='{mesLock}'></i>";
            var unlock = $"<i class='fa fa-eye font-18' title='{mesUnlock}'></i>";
            return k ? unlock : _lock;
        }

        public static string GetLabelIsHot(object k, string strTrue = "Nổi bật", string strFalse = "Không nổi bật")
        {
            if (!k.IsNotNull()) return string.Empty;
            var _true = $"<span class='glyphicon glyphicon-ok-circle font-16' title='{strTrue}'></span>";
            var _false = $"<span class='glyphicon glyphicon-minus font-16' title='{strFalse}'></span>";
            return Convert.ToBoolean(k) ? _true : _false;
        }

        public static string GetLabelOnOff(object obj, string strTrue = "Show", string strFalse = "Off")
        {
            if (!obj.IsNull())
            {
                return Convert.ToBoolean(obj)
                    ? $"<i class='fa fa-dot-circle-o font-16' title='{strTrue}' style='color:#000'></i>"
                    : $"<i class='fa fa-circle-o font-16' title='{strFalse}'></i>";
            }
            return string.Empty;
        }

        public List<ListItem> PagerListItems_Paginations(int indexPage, int pageSize, int recordCount)
        {
            var dblPageCount = (double)(recordCount / decimal.Parse(pageSize.ToString()));
            var pageCount = (int) Math.Ceiling(dblPageCount);
            var pages = new List<ListItem>();
            if (pageCount > 0)
            {
                pages.Add(new ListItem("First", "1", indexPage > 1));
                for (var i = 1; i <= pageCount; i++)
                {
                    pages.Add(new ListItem(i.ToString(), i.ToString(), i != indexPage));
                }
                pages.Add(new ListItem("Last", pageCount.ToString(), indexPage < pageCount));
            }
            return pages.ToList();
        }

        public static string GetClassDisabledPaging(bool k)
        {
            return k ? string.Empty : "disabled";
        }

        public static string GetClassActivePaging(string a, string b)
        {
            return a == b ? "active" : "";
        }

        /// <summary>
        /// Show một message
        /// </summary>
        /// <param name="s"></param>
        public static void ShowMessageBox(string s)
        {
            HttpContext.Current.Response.Write($"<script type='text/javascript'>alert('{s}');</script>");
        }
    }
}