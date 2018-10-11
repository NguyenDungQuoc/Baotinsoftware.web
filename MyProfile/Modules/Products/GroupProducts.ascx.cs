using System;
using System.Linq;
using System.Web.UI.WebControls;
using MyProfile.Class;
using System.Web.UI;

namespace MyProfile.Modules.Products
{
    public partial class GroupProducts : UserControl
    {
        private readonly ProductProvider _productProvider;
        private readonly HashtagProvider _hashtagProvider;

        public GroupProducts()
        {
            _productProvider = new ProductProvider();
            _hashtagProvider = new HashtagProvider();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDataCategories();
            }
        }

        private void BindDataCategories()
        {
            var categories = _productProvider.GET_TABLE_GROUP_PRODUCTS().Where(w => w.Active == true && w.ParentID == 0).OrderBy(w => w.Position).ToList();
            var hashtags = _hashtagProvider.GetHashtagByIsHotAndActive();
            rpt_Categories.DoBind(categories);
            rptListHashtag.DoBind(hashtags);
            //rpt_ListProductOfTypes.DoBind(_productProvider.GET_TABLE_TYPES());
        }

        protected void rpt_Categories_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (!e.IsItem()) return;

            var childRepeater = e.Item.FindControl("rpt_ChildCategories") as Repeater;
            if (childRepeater == null) return;

            var productCategoryId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "ID"));
            if (productCategoryId <= 0) return;
            
            childRepeater.DataSource = _productProvider.GET_TABLE_GROUP_PRODUCTS()
                .Where(w => w.ParentID == productCategoryId && w.Active == true)
                .OrderBy(w => w.Position)
                .ToList();
            //childRepeater.DataSource = p.PRODUCT_PAGING_GROUP_PRODUCT_IDCAT(productCategoryId, 1, 20).Where(w => w.IsActive == true).ToList();
            childRepeater.DataBind();
        }

        public string Get_Plus_Right(int categoryId)
        {
            if (categoryId <= 0) return string.Empty;
            var c = _productProvider.GET_TABLE_GROUP_PRODUCTS().Where(w => w.ParentID == categoryId).ToList().Count;
            return c > 0 ? "lv2" : string.Empty;
        }

        public int Get_Count_Product_TypeID(int idType)
        {
            return _productProvider.GET_TABLE_PRODUCT_TYPE().Where(w => w.ID_Type == idType).ToList().Count;
        }
    }
}