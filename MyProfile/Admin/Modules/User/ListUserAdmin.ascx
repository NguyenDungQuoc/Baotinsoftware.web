<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListUserAdmin.ascx.cs" Inherits="MyProfile.Admin.Modules.User.ListUserAdmin" %>
<%@ Import Namespace="MyProfile.Class" %>
<%@ Register Src="~/Controls/FileInput.ascx" TagName="FileInput" TagPrefix="sh" %>
<script src="/Scripts/ShAjax.js"></script>
<div class='row'>
    <div class='col-md-12'>
        <div class='box box-info'>
            <div class='box-header no-padding-bottom'>
                <h3 class='box-title'>Danh sách quản trị viên</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">                    
                    <button id="btnDel" class="btn btn-danger btn-flat">
						<i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
						Delete
					</button>                                        
                </div><!-- /. tools -->
            </div><!-- /.box-header -->
            <div class="box-body table-responsive" id="ntn-tb">
                <asp:GridView ID="GridView_ListData" runat="server" AutoGenerateColumns="False" 
                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" OnRowEditing="GridView_ListData_RowEditing" OnRowCommand="GridView_ListData_RowCommand" OnRowDataBound="GridView_ListData_RowDataBound" 
                    CellPadding="3" EnableModelValidation="True" Width="100%" HeaderStyle-Height="30px" CssClass="table table-bordered table-hover dataTable" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="ID">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <%# Eval("Row") %>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="40px"/>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Tên truy cập">
                            <ItemTemplate>
                                <asp:Image ID="Image_User" ImageUrl='<%# Eval("Image") %>' AlternateText='<%# Eval("Fullname") %>' runat="server" style="width:80px; height:80px; border:4px solid #ddd; border-radius:50%;" />
                                <div style="padding-top: 3px;">    
                                    <a href="#" style="color:#00C0EF; font-weight:bold;"><%# Eval("Username") %></a>
                                </div>                                                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="160" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Họ và tên" DataField="Fullname" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ControlStyle-Width="100%" ControlStyle-Height="32" />
                        
                        <%--<asp:BoundField HeaderText="Email" DataField="Email" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ControlStyle-Width="100%" ControlStyle-Height="30" />--%>
                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <%# Eval("Email") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEmail" TextMode="Email" placeholder="Email" autocomplete="off" style="padding: 0 2px; height: 32px;" runat="server" Text='<%# Eval("Email") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <HeaderStyle HorizontalAlign="Center" />                            
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Ghi chú" DataField="Note" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ControlStyle-Width="100%" ControlStyle-Height="32" />                                                                        

                        <asp:TemplateField HeaderText="Khởi tạo">
                            <ItemTemplate>
                                <%# Eval("Date","{0:dd/MM/yyyy}") %>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="80" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Active">
                            <ItemTemplate>                                
                                <asp:LinkButton ID="LinkButtonStatus" CommandArgument='<%# Eval("Username") %>' CommandName="IsActive" runat="server">
                                    <%# Utility.GetLabelIsActive(Convert.ToBoolean(Eval("Active")),"Khóa","Mở Khóa") %>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="60" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Sửa">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButtonEdit" CommandName="Edit" ToolTip="Chỉnh sửa" runat="server"><i class="fa fa-pencil font-16"></i></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="Update" OnClick="Update_Click" CommandArgument='<%# Eval("Username") %>' ToolTip="Cập nhật" runat="server"><span class="glyphicon glyphicon-refresh font-16"></span></asp:LinkButton>
                                <asp:LinkButton ID="Cancel" OnClick="Cancel_Click" ToolTip="Hủy bỏ" runat="server"><span class="glyphicon glyphicon-remove font-16 red"></span></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="60" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Chọn">
                            <ItemTemplate>
                                <input type="checkbox" id="chkdel" runat="server" pid='<%# Eval("ID") %>' />
                                <asp:HiddenField ID="hdf_ID" runat="server" Value='<%# Eval("ID") %>'/>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="40px" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle BackColor="#f5f5f5" VerticalAlign="Middle" HorizontalAlign="Center" Font-Bold="True" ForeColor="#d60c0c" />
                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Center" />
                    <RowStyle ForeColor="#000066" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                </asp:GridView>   
                <div class="row">
                    <div class="col-xs-6">
                        <div class="col-sm-2 no-padding-left marginTop-10">
                            <asp:DropDownList ID="ddl_PageSize" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddl_PageSize_OnSelectedIndexChanged" runat="server">                                
                                <asp:ListItem Text="15" Value="15" />
                                <asp:ListItem Text="25" Value="25" />
                                <asp:ListItem Text="50" Value="50" />
                            </asp:DropDownList>
                        </div>                                                
                    </div>
                    <div class="col-xs-6">
                        <div class="paging_bootstrap">
                            <asp:Repeater ID="rpt_Pager" runat="server">
                                <HeaderTemplate><ul class="pagination"></HeaderTemplate>
                                <ItemTemplate>
                                    <li class="<%# Utility.GetClassActivePaging(PageIndex.ToString(),Eval("Value").ToString()) + " " + Utility.GetClassDisabledPaging(Convert.ToBoolean(Eval("Enabled"))) %>">
                                        <a href="/Admin/listuser.aspx?page=<%# Eval("Value") %>"><%#Eval("Text") %></a>                                        
                                    </li>
                                </ItemTemplate>
                                <FooterTemplate></ul></FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>             
            </div>
        </div><!-- /.box -->                
    </div><!-- /.col-->
</div><!-- ./row -->
<script type="text/javascript">    
    function UserBusiness()
    {
        $.extend(this, new ShAjax());
        this.assembly = "MyProfile";
        this.typeAction = "Admin.Modules.User.ListUserAdmin";        
        this.dodel = function (id,callback)
        {
            this.get("DeleteAdmin", { idUser: id }, callback);
        }
    }
    var userBusiness = new UserBusiness();

    $(document).ready(function () {
        $("#btnDel").click(function (e) {
            var selectedRows = $('#<%= GridView_ListData.ClientID %> tr').filter(':has(:checkbox:checked)').length;
            if (selectedRows < 1) {
                alert("Vui lòng chọn Items muốn xóa!");
            }
            else {
                if (confirm("Bạn thực sự muốn xóa Items này?")) {
                    $('#<%= GridView_ListData.ClientID %> tr').filter(':has(:checkbox:checked)').each(function () {                        
                        var id = $(this).find("[id*=hdf_ID]").val();                        
                        var $this = this;                        
                        userBusiness.dodel(id, function () {                            
                            $($this).remove();
                        });
                    });
                } else {
                    return false;
                }                                               
            }
            e.preventDefault();
        });
    });
</script>