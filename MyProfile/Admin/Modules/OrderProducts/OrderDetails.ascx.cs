using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;

namespace MyProfile.Admin.Modules.OrderProducts
{
    public partial class OrderDetails : System.Web.UI.UserControl
    {
        ProductProvider p = new ProductProvider();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData_OrderDetails();
            }
        }

        private void BindData_OrderDetails()
        {
            if (!string.IsNullOrEmpty(Request.Params["id"]))
            {
                try
                {
                    //Bind OrderStatus
                    ddl_StatusOrderProducts.DataSource = p.GET_TABLE_ORDER_STATUS();
                    ddl_StatusOrderProducts.DataBind();
                    //Bind Info OrderDetail
                    int id = Convert.ToInt32(Request.Params["id"]);
                    var t = p.GET_TABLE_ORDER_PRODUCTS().Where(w => w.ID == id);
                    rpt_ListInfoCustomers.DataSource = t.ToList();
                    rpt_ListInfoCustomers.DataBind();
                    txtNote.Text = t.FirstOrDefault().CustomerNote;
                    ddl_StatusOrderProducts.SelectedValue = t.FirstOrDefault().StatusID.ToString();
                    //Bind Products
                    GridView_ListData.DataSource = p.GET_TABLE_ORDER_DETAILS(id);
                    GridView_ListData.DataBind();
                    lblSumTotal.Text = Sumtotal.ToString();
                }
                catch (Exception)
                {
                    Response.Redirect(@"/Admin/orderproducts.aspx");
                }                
            }
            else
            {
                Response.Redirect(@"/Admin/orderproducts.aspx");
            }            
        }

        protected void btn_Update_OnClick(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.Params["id"]))
            {
                p.UPDATE_STATUS_AND_NOTE_ORDER_PRODUCT(Convert.ToInt32(Request.Params["id"]), txtNote.Text.Trim(),
                    Convert.ToInt32(ddl_StatusOrderProducts.SelectedValue));
                BindData_OrderDetails();
                p.ShowMessageBox("Cập nhật thành công!");
            }
            else
            {
                Response.Redirect(@"/Admin/orderproducts.aspx");
            } 
        }

        private decimal Sumtotal = 0;
        protected void GridView_ListData_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                decimal rowPrice = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Price"));
                int rowQuantity = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Quantity"));
                decimal rowTotal = rowPrice*rowQuantity;
                var lblTotal = e.Row.FindControl("lblTotal") as Label;
                lblTotal.Text = rowTotal.ToString();
                Sumtotal = Sumtotal + rowTotal;
            }            
        }
    }
}