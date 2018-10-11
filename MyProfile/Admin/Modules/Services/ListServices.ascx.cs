using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;
using MyProfile.Settings;

namespace MyProfile.Admin.Modules.Services
{
    public partial class ListServices : System.Web.UI.UserControl
    {
        ServicesClass s = new ServicesClass();
        Utility linq = new Utility();
        private List<GROUP_SERVICE> ddlGroupServices = null;
        UserAdmin u = new UserAdmin();

        public int pageCurrent = 1;

        public List<GROUP_SERVICE> ComboboxGroupServices
        {
            get
            {
                if (ddlGroupServices == null)
                {
                    ddlGroupServices = s.LIST_SERVICE_CATEGORIES();
                }
                return ddlGroupServices;
            }
        } 

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddl_FilterOfCategory.DataSource = ComboboxGroupServices;
                ddl_FilterOfCategory.DataBind();
                BindData_ListServices();
            }
        }

        private void BindData_ListServices(int pageIndex = 1)
        {
            int idCatSelected = Convert.ToInt32(ddl_FilterOfCategory.SelectedValue);
            int pageSize = Convert.ToInt32(ddl_PageSize.SelectedValue);

            int recordCount;
            if (idCatSelected == 0)
            {
                GridView_ListData.DataSource = s.SERVICES_PAGING(pageIndex, pageSize);
                GridView_ListData.DataBind();

                recordCount = s.SERVICES_PAGING_COUNT();                
            }
            else
            {
                GridView_ListData.DataSource = s.SERVICES_PAGING_GROUP_SERVICES(idCatSelected, pageIndex, pageSize);
                GridView_ListData.DataBind();

                recordCount = s.GROUP_SERVICES_PAGING_COUNT(idCatSelected);
            }
            rpt_Pager.DataSource = linq.PagerListItems_Paginations(pageIndex, pageSize, recordCount);
            rpt_Pager.DataBind();
        }

        protected void GridView_ListData_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            var t = s.GET_TABLE_SERVICES().Where(w => w.ID == id).FirstOrDefault();
            switch (e.CommandName)
            {
                case ("isActive"):
                    bool k = Convert.ToBoolean(t.Active);
                    if (k)
                    {
                        s.UPDATE_TABLE_SERVICES_ACTIVE_ISHOT(0, id, false);
                        (e.CommandSource as LinkButton).Text = Utility.GetLabelIsActive(false, "Chưa duyệt", "Đã duyệt");
                    }
                    else
                    {
                        s.UPDATE_TABLE_SERVICES_ACTIVE_ISHOT(0, id, true);
                        (e.CommandSource as LinkButton).Text = Utility.GetLabelIsActive(true, "Chưa duyệt", "Đã duyệt");
                    }
                    break;
                case ("isHot"):
                    bool l = Convert.ToBoolean(t.IsHot);
                    if (l)
                    {
                        s.UPDATE_TABLE_SERVICES_ACTIVE_ISHOT(1, id, false);
                        (e.CommandSource as LinkButton).Text = Utility.GetLabelIsHot(false, "Tin nổi bật", "Tin thường");
                    }
                    else
                    {
                        s.UPDATE_TABLE_SERVICES_ACTIVE_ISHOT(1, id, true);
                        (e.CommandSource as LinkButton).Text = Utility.GetLabelIsHot(true, "Tin nổi bật", "Tin thường");
                    }
                    break;
            }
        }        

        protected void GridView_ListData_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            string user_ID = u.GetUsersByUsername(AccountSession<MyAccount>.Inst.AccountInfo.UserId.Trim()).FirstOrDefault().ID.ToString();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList rptGroupServices = e.Row.FindControl("ddl_GroupServices") as DropDownList;
                rptGroupServices.DataSource = ComboboxGroupServices;
                rptGroupServices.DataBind();
                HiddenField id = e.Row.FindControl("hdf_GroupServices") as HiddenField;
                rptGroupServices.SelectedValue = id.Value;

                if (DataBinder.Eval(e.Row.DataItem, "ID_UserPost").ToString() != user_ID)
                {//Nếu mẫu tin nào của User tạo mà User khác login thì ko đc xóa và thay đổi
                    var chkdel = e.Row.FindControl("chkdel") as System.Web.UI.HtmlControls.HtmlInputCheckBox;
                    chkdel.Visible = false;
                    rptGroupServices.Attributes.Add("disabled", "true");
                }
            }
        }

        protected void ddl_PageSize_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            BindData_ListServices();
        }

        protected void ddl_FilterOfCategory_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            BindData_ListServices();
        }
        
        protected void lnkPage_OnClick(object sender, EventArgs e)
        {
            pageCurrent = Convert.ToInt32((sender as LinkButton).CommandArgument);
            BindData_ListServices(pageCurrent);
        }

        /// <summary>
        /// AJAX
        /// </summary>
        public void DeleteRecordServices()
        {
            var id = HttpContext.Current.Request.Params["idRecord"];
            s.DELETE_RECORD_TABLE_SERVICES((string.IsNullOrEmpty(id) ? 0 : Convert.ToInt32(id)));
        }

        public void updateRecordServiceCategory()
        {
            var id = HttpContext.Current.Request.Params["idItem"];
            var idGroupServices = HttpContext.Current.Request.Params["idGroupNews"];
            s.UPDATE_TABLE_SERVICES_GROUP_SERVICE_ID(Convert.ToInt32(id), Convert.ToInt32(idGroupServices));
        }
        
    }
}