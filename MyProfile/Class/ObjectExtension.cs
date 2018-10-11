using System;
using System.Linq;

namespace MyProfile.Class
{
    public static class ObjectExtension    
    {
        /// <summary>
        /// Cast object to T
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static T As<T>(this object obj)
        {
            return obj.IsNull() ? default(T) : (T)obj;
        }

        /// <summary>
        /// Kiểm tra xem một đối tượng có Null hay không
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static bool IsNull(this object obj)
        {
            return obj == null;
        }

        public static bool IsNotNull(this object obj)
        {
            return obj != null;
        }

        /// <summary>
        /// Merge two Object then return object original
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="original">The object original</param>
        /// <param name="destination">The object destination</param>
        /// <returns></returns>
        public static T MergeInto<T>(this T original, T destination)
        {
            if(original.IsNull()) throw new Exception("The object original should not null");
            if (destination.IsNull()) return original;

            var type = typeof(T);
            var properties = type.GetProperties().Where(prop => prop.CanRead && prop.CanWrite);
            foreach (var prop in properties)
            {
                var value = prop.GetValue(destination, null);
                if (value != null)
                    prop.SetValue(original, value, null);
            }
            return original;
        }

        public static bool IsInteger(this object obj)
        {
            if (obj.IsNull()) return false;
            return int.TryParse(obj.ToString(), out var value);
        }
    }
}