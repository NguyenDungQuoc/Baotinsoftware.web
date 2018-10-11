using System;
using System.Text.RegularExpressions;

namespace MyProfile.Class
{
    public static class StringExtension
    {
        /// <summary>
        /// Format một String
        /// </summary>
        /// <param name="str"></param>
        /// <param name="params"></param>
        /// <returns></returns>
        public static string Frmat(this string str, params object[] @params)
        {
            return string.Format(str, @params);
        }

        /// <summary>
        /// Kiểm tra xem string có Null hay không
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static bool IsNull(this string str)
        {
            return string.IsNullOrEmpty(str);
        }

        public static bool IsNullOrWhiteSpace(this string value)
        {
            return string.IsNullOrWhiteSpace(value);
        }

        public static bool IsNotNullOrNotWhiteSpace(this string value)
        {
            return !value.IsNullOrWhiteSpace();
        }

        /// <summary>
        /// Kiểm tra string nó null hay ko
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static bool IsNotNull(this string str)
        {
            return !string.IsNullOrEmpty(str);
        }

        /// <summary>
        /// swith giá trị khi mà str là Empty
        /// </summary>
        /// <param name="str"></param>
        /// <param name="action"></param>
        /// <returns></returns>
        public static string WhenEmpty(this string str, Func<string> action)
        {
            return str.IsNull() ? action() : str;
        }

        /// <summary>
        /// Regex lấy Id video của youtube
        /// </summary>
        public static Regex Regex = new Regex("(embed|v)(/|=)([^&?]+)");

        /// <summary>
        /// Lấy Youtube Id
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static string GetYoutubeId(this string url)
        {
            // Match
            var match = Regex.Match(url);

            // trả về Id
            return !match.Success ? null : match.Groups[3].Value;
        }

        private const string VietChars = "àáảãạâầấẩẫậăằắẳẵặèéẻẽẹêềếểễệđìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵÀÁẢÃẠÂẦẤẨẪẬĂẰẮẲẴẶÈÉẺẼẸÊỀẾỂỄỆĐÌÍỈĨỊÒÓỎÕỌÔỒỐỔỖỘƠỜỚỞỠỢÙÚỦŨỤƯỪỨỬỮỰỲÝỶỸỴÂĂĐÔƠƯ";
        private const string EngChars = "aaaaaaaaaaaaaaaaaeeeeeeeeeeediiiiiooooooooooooooooouuuuuuuuuuuyyyyyAAAAAAAAAAAAAAAAAEEEEEEEEEEEDIIIOOOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYYAADOOU";
        public static string UnicodeFormat(this string value)
        {
            var result = string.Empty;
            int position;
            foreach (var t in value)
            {
                position = VietChars.IndexOf(t.ToString(), StringComparison.Ordinal);
                if (position >= 0)
                    result += EngChars[position];
                else
                    result += t;
            }
            var temp = result;
            foreach (var t in result)
            {
                position = Convert.ToInt32(t);
                if (!((position >= 97 && position <= 122) || (position >= 65 && position <= 90) || (position >= 48 && position <= 57) || position == 32))
                    temp = temp.Replace(t.ToString(), "");
            }
            temp = temp.Replace(" ", "-");
            while (temp.EndsWith("-"))
                temp = temp.Substring(0, temp.Length - 1);

            while (temp.IndexOf("--", StringComparison.Ordinal) >= 0)
                temp = temp.Replace("--", "-");

            result = temp;
            result = result.Replace("\"", string.Empty);
            result = result.Replace("'", string.Empty);
            return result.ToLower();
        }

        public static string StripHtml(this string input)
        {
            return Regex.Replace(input.Trim(), "<.*?>", string.Empty);
        }

        public static bool IsEmail(this string email)
        {
            return email.IsNotNullOrNotWhiteSpace() && Regex.IsMatch(email.Trim(), @"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
        }
    }
}