using System.Collections.Generic;

namespace MyProfile.Class.Interface
{
    public interface IBehavior<T> where T : class
    {
        IEnumerable<T> SelectAll();
        void Update(T t);
        int Insert(T t);
        void Delete(int id);
        T SelectByPrimaryKey(int primaryKey);
        void SaveChanges();
    }
}