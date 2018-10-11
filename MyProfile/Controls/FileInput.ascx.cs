using System;
using System.Web.UI.WebControls;

namespace MyProfile.Controls
{
    public partial class FileInput : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!Page.IsPostBack)
            ltr.Text = "<a class='btn btn-primary input-group-btn b-radius-topleft' href='javascript:void(0)' onclick=\"ShCore.showFiles('" + FileType + "',false,function(folder,files){ $('#" + txtInput.ClientID + "').val(folder+files[0]); })\"><i class='fa fa-cloud-upload'></i></a>";
        }

        private string fileType = "Images";

        public string FileType
        {
            get { return fileType; }
            set { fileType = value; }
        }

        /// <summary>
        /// 
        /// </summary>
        public Unit Width
        {
            set { txtInput.Width = value; }
            get { return txtInput.Width; }
        }

        public string Text
        {
            set { txtInput.Text = value; }
            get { return txtInput.Text; }
        }

        public string CssClass
        {
            set { txtInput.CssClass = value; }
            get { return txtInput.CssClass; }
        }
    }
}