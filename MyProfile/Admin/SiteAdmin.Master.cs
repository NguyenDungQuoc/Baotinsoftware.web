using System;
using System.Linq;
using MyProfile.Class;

namespace MyProfile.Admin
{
    public partial class SiteAdmin : System.Web.UI.MasterPage
    {
        UserAdmin n = new UserAdmin();
        SendContact sc = new SendContact();
        ProductProvider p = new ProductProvider();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!AccountSession<MyAccount>.Inst.IsLoging)
            {
                Response.Redirect(@"/Admin/login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    LoadData_InfoAdmin();
                }                   
            }
        }        

        private void LoadData_InfoAdmin()
        {
            var t = n.GetUsersByUsername(AccountSession<MyAccount>.Inst.AccountInfo.UserId).SingleOrDefault();
            var c = sc.GET_TABLE_CONTACTS();
            if (t != null)
            {
                lbl_Date.Text = t.Date.ToString();
                lbl_FullName.Text = lbl_FullNameUser.Text = lblFullName.InnerHtml = t.Fullname;
                Image_User.ImageUrl = Image_Avatar.ImageUrl = t.Image; Image_Avatar.AlternateText = Image_User.AlternateText = t.Fullname;
                if (t.ID != 2)
                {
                    hdf_Active.Value = "hide-row";
                }
                else
                {
                    hdf_Active.Value = "";
                }
            }
            lblCountUser.InnerHtml = n.GET_TABLE_USER().Count.ToString();
            countContacts.InnerHtml = c.Count.ToString();
            //Lấy MessContact chưa duyệt
            rpt_MessageCustomer.DataSource = c.Where(w => w.Status == 0).OrderByDescending(w => w.Date);
            rpt_MessageCustomer.DataBind();
            //Lấy đơn hàng mới
            rpt_ShoppingCart.DataSource = p.GET_TABLE_ORDER_PRODUCTS().Where(w => w.StatusID == 6).OrderByDescending(w => w.Date);
            rpt_ShoppingCart.DataBind();
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            AccountSession<MyAccount>.Inst.SignOut();
            Response.Redirect(@"/Admin/login.aspx");
        }
    }
}