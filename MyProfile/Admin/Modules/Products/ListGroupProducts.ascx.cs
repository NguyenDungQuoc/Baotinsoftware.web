using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.Products
{
    public partial class ListGroupProducts : UserControl
    {
        private readonly ProductProvider _productProvider = new ProductProvider();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDataGroupProduct();
            }
        }

        private void BindDataGroupProduct()
        {
            var data = _productProvider.ListProductCategory();
            GridView_ListData.DoBind(data);
            rpt_ListCategories.DoBind(data);            
        }

        protected void GridView_ListData_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "IsActive":
                    var productId = Convert.ToInt32(e.CommandArgument);
                    _productProvider.UpdateIsActiveOrPositionForGroupProduct(true, productId);
                    break;
                case "IsShow":
                    var recordId = Convert.ToInt32(e.CommandArgument);
                    _productProvider.UPDATE_ISHOT_TABLE_GROUP_PRODUCTS(recordId);
                    break;
            }
            BindDataGroupProduct();
        }

        /// <summary>
        /// DELETE CALL AJAX
        /// </summary>
        public void DeleteRecord()
        {
            var recordId = HttpContext.Current.Request.Params["recordId"];
            _productProvider.DELETE_GROUP_PRODUCTS(recordId.IsNullOrWhiteSpace() ? 0 : Convert.ToInt32(recordId));
        }        

        /// <summary>
        /// Insert New Record
        /// </summary>
        public void InsertRecordGroupProducts()
        {
            var name = HttpContext.Current.Request.Params["name"];
            var position = HttpContext.Current.Request.Params["position"].IsNotNull()
                ? Convert.ToInt32(HttpContext.Current.Request.Params["position"])
                : 0;
            var categoryProductId = HttpContext.Current.Request.Params["parentID"].IsNotNull()
                ? Convert.ToInt32(HttpContext.Current.Request.Params["parentID"])
                : 0;
            var active = HttpContext.Current.Request.Params["active"].IsNotNull() &&
                         Convert.ToBoolean(HttpContext.Current.Request.Params["active"]);
            var description = HttpContext.Current.Request.Params["des"];
            const string img = "";

            if (name.IsNotNull())
            {
                if (Convert.ToInt32(categoryProductId) == 0)
                {
                    _productProvider.INSERT_VALUE_GROUP_PRODUCTS(name, description, categoryProductId, img, position, active);
                }
                else
                {
                    var productId = 0;
                    var flagParentId = _productProvider.GetGroupProductByPrimaryKey(categoryProductId)?.ParentID;
                    if (flagParentId == 0)
                    {
                        productId = categoryProductId;
                    }
                    _productProvider.INSERT_VALUE_GROUP_PRODUCTS(name, description, productId, img, position, active);
                }
            }
            else
            {
                _productProvider.ShowMessageBox("Vui lòng nhập tên cho danh mục");
            }
        }

        /// <summary>
        /// UPDATE RECORD
        /// </summary>
        public void UpdateRecordGroupProducts()
        {
            var recordId = HttpContext.Current.Request.Params["idItem"];
            var name = HttpContext.Current.Request.Params["name"];
            var position = HttpContext.Current.Request.Params["position"].IsNotNull()
                ? Convert.ToInt32(HttpContext.Current.Request.Params["position"])
                : 0;
            var description = HttpContext.Current.Request.Params["des"];
            var categoryProductId = HttpContext.Current.Request.Params["parentID"].IsNotNull()
                ? Convert.ToInt32(HttpContext.Current.Request.Params["parentID"])
                : 0;
            var active = HttpContext.Current.Request.Params["active"].IsNotNull() &&
                         Convert.ToBoolean(HttpContext.Current.Request.Params["active"]);

            if (!recordId.IsNotNull()) return;
            var parentId = 0;
            if (categoryProductId != 0)
            {
                var flagParentId = _productProvider.GET_TABLE_GROUP_PRODUCTS().FirstOrDefault(w => w.ID == categoryProductId)?.ParentID;
                if (flagParentId == 0)
                {
                    parentId = Convert.ToInt32(categoryProductId);
                }
            }
            _productProvider.UPDATE_VALUE_GROUP_PRODUCTS(Convert.ToInt32(recordId), name, description, parentId,
                string.Empty, active, position);
        }

        /// <summary>
        /// Bind Data Record
        /// </summary>
        public void BindRecordToEdit()
        {
            try
            {
                var recordId = Convert.ToInt32(HttpContext.Current.Request.Params["recordId"]);
                if (recordId <= 0) return;
                var g = _productProvider.GET_TABLE_GROUP_PRODUCTS().FirstOrDefault(w => w.ID == recordId);
                if (g.IsNotNull())
                {
                    ShContext.Current.Data["Response"] = new { g?.Name, g?.Position, g?.Description, g?.ParentID, g?.Active };
                }
            }
            catch (Exception ex)
            {
                ShContext.Current.Alert(ex.Message);
            }
        }

        //public void updateRecordPosition()
        //{
        //    var recordId = HttpContext.Current.Request.Params["idItem"];
        //    if (!recordId.IsNotNull()) return;
        //    var position = HttpContext.Current.Request.Params["position"].IsNotNull()
        //        ? Convert.ToInt32(HttpContext.Current.Request.Params["position"])
        //        : 0;
        //    _productProvider.UpdateIsActiveOrPositionForGroupProduct(false, Convert.ToInt32(recordId), position);
        //}

        protected void LkbSave_OnClick(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GridView_ListData.Rows)
            {
                if (row.RowType != DataControlRowType.DataRow) continue;
                if (!(row.FindControl("txtPosition") is TextBox position)) continue;
                if (!position.Text.IsNullOrWhiteSpace() && position.Text.IsInteger())
                {
                    var categoryId = GridView_ListData.DataKeys[row.RowIndex]?.Value;
                    if (categoryId.IsNotNull())
                    {
                        _productProvider.UpdateIsActiveOrPositionForGroupProduct(false, Convert.ToInt32(categoryId),
                            Convert.ToInt32(position.Text));
                    }
                }
            }
            BindDataGroupProduct();
        }
    }
}