
namespace MyProfile.Class
{
    public class Singleton<T> where T : new()
    {
        private static T t = new T();
        public static T Inst
        {
            get { return t; }
        }
    }
}
