using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using MyProfile.Class;
using MyProfile.Settings;

namespace MyProfile.Admin.Modules.Hashtag
{
    public partial class WucHashtag : UserControl
    {
        private readonly HashtagProvider _hashtagProvider = new HashtagProvider();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDataInitial();
            }
        }

        private void LoadDataInitial()
        {
            GvListData.DoBind(_hashtagProvider.SelectAll());
        }

        protected void GvListData_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            var hashtag = new HashTag {HashTagId = Convert.ToInt32(e.CommandArgument)};
            var ht = _hashtagProvider.SelectByPrimaryKey(hashtag.HashTagId);
            switch (e.CommandName)
            {
                case "IsHot":
                    hashtag.IsHot = ht.IsHot != true;
                    _hashtagProvider.Update(hashtag);
                    break;
                case "IsActive":
                    hashtag.IsActive = ht.IsActive != true;
                    _hashtagProvider.Update(hashtag);
                    break;
                case "IsEnable":
                    hashtag.IsEnable = ht.IsEnable != true;
                    _hashtagProvider.Update(hashtag);
                    break;
                case "Delete":
                    _hashtagProvider.Delete(hashtag.HashTagId);
                    Response.Redirect("/Admin/hashtag.aspx");
                    return;
            }
            LoadDataInitial();
        }

        protected void BtnInsert_OnClick(object sender, EventArgs e)
        {
            var message = string.Empty;
            if (txtHashtag.Text.IsNull())
            {
                message = "Vui lòng nhập tên Hashtag";
            }
            else if (_hashtagProvider.SelectByName(txtHashtag.Text.Trim()).Count > 0)
            {
                message = "Hashtag này đã tồn tại, vui lòng chọn 1 tên khác";
            }
            else
            {
                var hashTag = new HashTag
                {
                    Name = txtHashtag.Text.Trim(),
                    Alias = txtHashtag.Text.Trim().UnicodeFormat(),
                    IsHot = rdbYes.Checked,
                    IsActive = rdbShow.Checked
                };
                _hashtagProvider.Insert(hashTag);
                Response.Redirect("/Admin/hashtag.aspx");
            }
            lblError.Text = message;
            txtHashtag.Focus();
        }

        protected void lnkUpdate_OnClick(object sender, EventArgs e)
        {
            if (!(sender is LinkButton btnUpdate) || !(((LinkButton) sender).NamingContainer is GridViewRow gvRow)) return;
            if (gvRow.FindControl("txtHashtagName") is TextBox hashtagName)
            {
                var hashtag = new HashTag
                {
                    HashTagId = Convert.ToInt32(btnUpdate.CommandArgument),
                    Name = hashtagName.Text.Trim(),
                    Alias = hashtagName.Text.Trim().UnicodeFormat()
                };
                //Check hashtag existing?
                var selectByName = _hashtagProvider.SelectAll().Where(x => x.Alias.Equals(hashtag.Alias)).ToList();
                if (selectByName.Count == 0)
                {
                    _hashtagProvider.Update(hashtag);
                }
                else
                {
                    lblError.Text = "Hashtag này đã tồn tại, vui lòng chọn 1 tên khác";
                    hashtagName.Focus();
                }
            }
            GvListData.EditIndex = -1;
            LoadDataInitial();
        }

        protected void lnkCancel_OnClick(object sender, EventArgs e)
        {
            GvListData.EditIndex = -1;
            LoadDataInitial();
            
        }

        protected void GvListData_OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            GvListData.EditIndex = e.NewEditIndex;
            LoadDataInitial();
        }
    }
}