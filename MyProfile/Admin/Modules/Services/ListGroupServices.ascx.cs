using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.Services
{
    public partial class ListGroupServices : UserControl
    {
        ServicesClass servicesEntity = new ServicesClass();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_GroupServices();
            }
        }

        private void BindData_GroupServices()
        {
            GridView_ListData.DataSource = rpt_ListCategories.DataSource = servicesEntity.LIST_SERVICE_CATEGORIES();
            GridView_ListData.DataBind();
            rpt_ListCategories.DataBind();
        }

        protected void GridView_ListData_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "IsActive":
                    var id = Convert.ToInt32(e.CommandArgument);
                    var k = Convert.ToBoolean(servicesEntity.GET_TABLE_GROUP_SERVICES().Where(w => w.ID == id).FirstOrDefault().Active);
                    if (k)
                    {
                        servicesEntity.UPDATE_IS_ACTIVE_AND_POSITION_TABLE_GROUP_SERVICES(0, id, false, 123);
                        (e.CommandSource as LinkButton).Text = Utility.GetLabelIsActive(false, "Ẩn", "Hiện");
                    }
                    else
                    {
                        servicesEntity.UPDATE_IS_ACTIVE_AND_POSITION_TABLE_GROUP_SERVICES(0, id, true, 123);
                        (e.CommandSource as LinkButton).Text = Utility.GetLabelIsActive(true, "Ẩn", "Hiện");
                    }
                    break;
            }
        }

        /// <summary>
        /// DELETE CALL AJAX
        /// </summary>
        public void DeleteRecord()
        {
            var id = HttpContext.Current.Request.Params["idRecord"];
            servicesEntity.DELETE_RECORD_TABLE_GROUP_SERVICES((string.IsNullOrEmpty(id) ? 0 : Convert.ToInt32(id)));
        }

        /// <summary>
        /// Bind Data Record
        /// </summary>
        public void bindRecordToEdit()
        {
            try
            {
                var idRecord = HttpContext.Current.Request.Params["idRecord"];
                if (idRecord != null)
                {
                    var g = servicesEntity.GET_TABLE_GROUP_SERVICES().FirstOrDefault(w => w.ID == (string.IsNullOrEmpty(idRecord) ? 0 : Convert.ToInt32(idRecord)));
                    ShContext.Current.Data["Entity"] = new { g.Name, g.Position, g.Description, g.ParentID, g.Active };
                }
            }
            catch (Exception)
            {
                ShContext.Current.Alert("Thất bại ! Vui lòng kiểm tra lại.");
            }
        }

        /// <summary>
        /// Insert New Record
        /// </summary>
        public void insertRecordGroupProducts()
        {
            var name = HttpContext.Current.Request.Params["name"];
            var po = HttpContext.Current.Request.Params["position"];
            var des = HttpContext.Current.Request.Params["des"];
            var idGroupProduct = HttpContext.Current.Request.Params["parentID"];
            var active = HttpContext.Current.Request.Params["active"];
            if (Convert.ToInt32(idGroupProduct) == 0)
            {
                servicesEntity.INSERT_TABLE_GROUP_SERVICES(name, name.UnicodeFormat(), string.IsNullOrEmpty(po) ? 0 : Convert.ToInt32(po), des.Trim(),
                    Convert.ToInt32(idGroupProduct), !string.IsNullOrEmpty(active) && bool.Parse(active));
            }
            else
            {
                int parentId;
                if (Convert.ToInt32(
                    servicesEntity.GET_TABLE_GROUP_SERVICES()
                        .Where(w => w.ID == Convert.ToInt32(idGroupProduct))
                        .FirstOrDefault()
                        .ParentID) == 0)
                {
                    parentId = Convert.ToInt32(idGroupProduct);
                }
                else
                {
                    parentId = 0;
                }
                servicesEntity.INSERT_TABLE_GROUP_SERVICES(name, name.UnicodeFormat(),
                    string.IsNullOrEmpty(po) ? 0 : Convert.ToInt32(po), des.Trim(),
                    parentId, !string.IsNullOrEmpty(active) && bool.Parse(active));
            }
        }

        /// <summary>
        /// UPDATE RECORD
        /// </summary>
        public void updateRecordGroupProducts()
        {
            var id = HttpContext.Current.Request.Params["idItem"];
            var name = HttpContext.Current.Request.Params["name"];
            var po = HttpContext.Current.Request.Params["position"];
            var des = HttpContext.Current.Request.Params["des"];
            var idGroupProduct = HttpContext.Current.Request.Params["parentID"];
            var active = HttpContext.Current.Request.Params["active"];
            if (id != null)
            {
                int parentId;
                if (Convert.ToInt32(idGroupProduct) == 0)
                {
                    parentId = 0;
                }
                else
                {
                    if (Convert.ToInt32(
                        servicesEntity.GET_TABLE_GROUP_SERVICES()
                            .Where(w => w.ID == Convert.ToInt32(idGroupProduct))
                            .FirstOrDefault()
                            .ParentID) == 0)
                    {
                        parentId = Convert.ToInt32(idGroupProduct);
                    }
                    else
                    {
                        parentId = 0;
                    }
                }
                servicesEntity.UPDATE_TABLE_GROUP_SERVICES(Convert.ToInt32(id), name.Trim(), name.UnicodeFormat(),
                    string.IsNullOrEmpty(po) ? 0 : Convert.ToInt32(po), des.Trim(), parentId,
                    !string.IsNullOrEmpty(active) && bool.Parse(active));
            }
        }

        /// <summary>
        /// UPDATE POSITION
        /// </summary>
        public void updateRecordPosition()
        {
            var id = HttpContext.Current.Request.Params["idItem"];
            var p = HttpContext.Current.Request.Params["position"];
            servicesEntity.UPDATE_IS_ACTIVE_AND_POSITION_TABLE_GROUP_SERVICES(1, Convert.ToInt32(id), true, string.IsNullOrEmpty(p) ? 0 : Convert.ToInt32(p));            
        }
    }
}