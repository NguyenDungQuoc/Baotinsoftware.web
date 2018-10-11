using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;
using MyProfile.Settings;

namespace MyProfile.Admin.Modules.Products
{
    public partial class ListProducts : UserControl
    {
        private readonly ProductProvider _productEntity = new ProductProvider();
        private readonly Utility _utility = new Utility();
        private List<GROUP_PRODUCT> _ddlGroupProduct;

        private List<GROUP_PRODUCT> ComboboxGroupProducts => _ddlGroupProduct ?? (_ddlGroupProduct = _productEntity.ListProductCategory());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddl_FilterOfCategory.DataSource = ComboboxGroupProducts;
                ddl_FilterOfCategory.DataBind();
                Bind_DataListProducs();
            }
        }        

        private void Bind_DataListProducs(int pageIndex = 1)
        {
            var categoryId = Convert.ToInt32(ddl_FilterOfCategory.SelectedValue);
            var pageSize = Convert.ToInt32(ddl_PageSize.SelectedValue);
            int recordCount;
            var flagId = 2;
            if (categoryId == 0)
            {   
                GridView_ListData.DoBind(_productEntity.GetProductPaging(flagId, pageIndex, pageSize));
                recordCount = _productEntity.TotalProductPagingCount(flagId);                
            }
            else
            {   
                // Lọc theo danh mục đc chọn                
                GridView_ListData.DoBind(_productEntity.GetProductPagingByCategoryId(categoryId, pageIndex, pageSize));
                recordCount = _productEntity.TotalProductPagingByCategoryIdCount(categoryId);                
            }
            rpt_Pager.DoBind(_utility.PagerListItems_Paginations(pageIndex, pageSize, recordCount));
        }

        protected void GridView_ListData_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            var recordId = Convert.ToInt32(e.CommandArgument);
            var product = _productEntity.GetProductById(recordId);
            switch (e.CommandName)
            {
                case "IsActive":
                    var k = Convert.ToBoolean(product.IsActive);
                    if (k)
                    {
                        _productEntity.UPDATE_ACTIVE_AND_ISHOT_PRODUCTS(true, recordId, false, true);
                        ((LinkButton) e.CommandSource).Text = Utility.GetLabelIsActive(false, "Chưa duyệt","Đã duyệt");
                    }
                    else
                    {
                        _productEntity.UPDATE_ACTIVE_AND_ISHOT_PRODUCTS(true, recordId, true, true);
                        ((LinkButton) e.CommandSource).Text = Utility.GetLabelIsActive(true, "Chưa duyệt", "Đã duyệt");
                    }
                    break;

                case "IsHot":
                    var l = Convert.ToBoolean(product.IsHot);
                    if (l)
                    {
                        _productEntity.UPDATE_ACTIVE_AND_ISHOT_PRODUCTS(false, recordId, true, false);
                        ((LinkButton) e.CommandSource).Text = Utility.GetLabelIsHot(false, "Có", "Không");
                    }
                    else
                    {
                        _productEntity.UPDATE_ACTIVE_AND_ISHOT_PRODUCTS(false, recordId, true, true);
                        ((LinkButton) e.CommandSource).Text = Utility.GetLabelIsHot(true, "Có", "Không");
                    }
                    break;
            }
        }

        protected void GridView_ListData_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.FindControl("ddl_GroupProducts") is DropDownList ddlGroupProducts)
                {
                    ddlGroupProducts.DataSource = ComboboxGroupProducts;
                    ddlGroupProducts.DataBind();
                    if (e.Row.FindControl("hdf_GroupProducts") is HiddenField id) ddlGroupProducts.SelectedValue = id.Value;
                }

                if (e.Row.FindControl("ddlStatus") is DropDownList ddlStatus)
                {
                    ddlStatus.DataSource = _productEntity.GetTableProductStatus();
                    ddlStatus.DataBind();
                    if (e.Row.FindControl("hdf_IDStatus") is HiddenField sId) ddlStatus.SelectedValue = sId.Value;
                }
            }
        }

        protected void ddl_PageSize_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_DataListProducs();
        }               

        /// <summary>
        /// AJAX
        /// </summary>
        public void DeleteRecord()
        {
            var recordId = HttpContext.Current.Request.Params["idRecord"];
            _productEntity.DELETE_RECORD_TABLE_PRODUCTS(Convert.ToInt32(recordId));
        }

        public void updateRecordProducts()
        {
            var recordId = HttpContext.Current.Request.Params["idItem"];            
            var price = HttpContext.Current.Request.Params["valuePrice"];
            var statusId = HttpContext.Current.Request.Params["valueStatus"];
            _productEntity.UPDATE_PRICE_AND_STATUS_PRODUCTS(Convert.ToInt32(recordId),
                string.IsNullOrEmpty(price) ? 0 : Convert.ToDecimal(price), Convert.ToInt32(statusId));
        }

        protected void ddl_FilterOfCategory_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            Bind_DataListProducs();
        }

        protected void lnkPage_OnClick(object sender, EventArgs e)
        {
            pageCurrent = Convert.ToInt32((sender as LinkButton).CommandArgument);
            Bind_DataListProducs(pageCurrent);            
        }

        public int pageCurrent = 1;
    }
}