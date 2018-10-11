using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.Gallery
{
    public partial class GroupGallery : System.Web.UI.UserControl
    {
        GalleryImage g = new GalleryImage();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind_DataGroupGallery();
            }
        }

        private void Bind_DataGroupGallery()
        {
            GridView_ListData.DataSource = g.GET_TABLE_GROUP_GALLERY().OrderByDescending(w => w.ID);
            GridView_ListData.DataBind();
        }        

        protected void Update_OnClick(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;
                string name = (row.Cells[1].Controls[0] as TextBox).Text;
                string des = (row.Cells[2].Controls[0] as TextBox).Text;
                TextBox pos = (row.Cells[3].Controls[0].FindControl("txtPosition") as TextBox);
                LinkButton lnkUpdate = (sender as LinkButton);
                var key = lnkUpdate.CommandArgument;
                string tag = name.UnicodeFormat();
                g.UPDATE_GROUP_GALLERY(true, Convert.ToInt32(key), name.Trim(), tag, des, (string.IsNullOrEmpty(pos.Text) ? 0 : Convert.ToInt32(pos.Text)), false);
                GridView_ListData.EditIndex = -1;
                Bind_DataGroupGallery();
            }
            catch (Exception)
            {
                ShContext.Current.Alert("Thất bại ! Vui lòng kiểm tra lại.");
            }                 
        }

        protected void Cancel_OnClick(object sender, EventArgs e)
        {
            GridView_ListData.EditIndex = -1;
            this.Bind_DataGroupGallery();
        }

        protected void GridView_ListData_OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView_ListData.EditIndex = e.NewEditIndex;
            this.Bind_DataGroupGallery();
        }

        /// <summary>
        /// Update Active
        /// Delte Item
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GridView_ListData_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case ("IsActive"):
                    var id = e.CommandArgument;
                    bool k =
                        Convert.ToBoolean(
                            g.GET_TABLE_GROUP_GALLERY().Where(w => w.ID == Convert.ToInt32(id)).FirstOrDefault().Active);
                    if (k == true)                    
                    { g.UPDATE_GROUP_GALLERY(false, Convert.ToInt32(id), "", "", "", 0, false);}                    
                    else
                    {g.UPDATE_GROUP_GALLERY(false, Convert.ToInt32(id), "", "", "", 0, true);}
                    Bind_DataGroupGallery();                  
                    break;                
            }            
        }

        public void DeleteRecord()
        {
            var id = HttpContext.Current.Request.Params["idRecord"];
            g.DELETE_GROUP_GALLERY((string.IsNullOrEmpty(id) ? 0 : Convert.ToInt32(id)));
        }

        /// <summary>
        /// Insert Item
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnInsert_OnClick(object sender, EventArgs e)
        {
            string tag = txtName.Text.UnicodeFormat();
            bool k = false;
            if (rdb_Show.Checked)
            {k = true;}
            g.INSERT_GROUP_GALLERY(txtName.Text.Trim(), tag, txtDes.Text,
                (string.IsNullOrEmpty(txtPos.Text) ? 0 : Convert.ToInt32(txtPos.Text)), k);
            Bind_DataGroupGallery();
            txtPos.Text = txtName.Text = txtDes.Text = "";
        }
    }
}