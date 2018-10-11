namespace MyProfile.Enums
{
    public class MyEnum
    {
        public enum LinkType
        {
            Product = 0,
            News = 1,
            Services = 2
        }

        public enum UpdateType
        {
            IsActive,
            IsHot,
            Position,
            IsEnable,
            IsDisable
        }

        public enum HandleType
        {
            Update,
            Insert,
            Delete
        }

        public enum StatusHandle
        {
            Success,
            Fail,
            Reject
        }
    }
}