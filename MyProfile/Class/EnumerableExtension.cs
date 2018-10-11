using System;
using System.Linq;
using System.Collections.Generic;
namespace MyProfile.Class
{
    public static class EnumerableExtension
    {
        /// <summary>
        /// Tìm kiếm những bản tin mới từ danh sách mói so với danh sách cũ
        /// </summary>
        /// <typeparam name="T1"></typeparam>
        /// <typeparam name="T2"></typeparam>
        /// <typeparam name="T"></typeparam>
        /// <param name="listNews"></param>
        /// <param name="listOlds"></param>
        /// <param name="ex1"></param>
        /// <param name="ex2"></param>
        /// <returns></returns>
        public static IEnumerable<T1> FindNewItems<T1, T2, T>(this IEnumerable<T1> listNews, IEnumerable<T2> listOlds, Func<T1, T> ex1, Func<T2, T> ex2)
        {
            return (from vi_new in listNews
                    join vi_old in listOlds on ex1(vi_new) equals ex2(vi_old) into vi_old_
                    from vi_old_item in vi_old_.DefaultIfEmpty()
                    select new { vi_new, vi_old_item }).Where(o => o.vi_old_item == null).Select(o => o.vi_new);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="data"></param>
        /// <param name="action"></param>
        public static void ForEach<T>(this IEnumerable<T> data, Action<T> action)
        {
            foreach (var t in data) action(t);
        }

        /// <summary>
        /// Join một trường lại thành chuỗi cách nhau bởi sep
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <typeparam name="T1"></typeparam>
        /// <param name="list"></param>
        /// <param name="action"></param>
        /// <param name="sep"></param>
        /// <returns></returns>
        public static string JoinString<T, T1>(this IEnumerable<T> list, Func<T, T1> action, string sep = ",")
        { 
            return string.Join(sep, list.Select(action).ToArray());
        }

        public static void SJoin<T1, T2, TValue>(this IEnumerable<T1> d1, IEnumerable<T2> d2, Func<T1,TValue> t1, Func<T2,TValue> t2, Action<T1,T2> action)
        {
            var count = d1.Join(d2, d11 => t1(d11), d21 => t2(d21), (d11, d21) =>
            {
                action(d11, d21);
                return false;
            }).Count();
        }
    }
}
