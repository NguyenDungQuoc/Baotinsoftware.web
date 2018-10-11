<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LinkWebsites.ascx.cs" Inherits="MyProfile.Admin.Modules.Links.LinkWebsites" %>

<div class='row'>
    <div class='col-md-12'>
        <div class='box box-info'>
            <div class='box-header no-padding-bottom'>
                <h3 class='box-title'>Quản lý Liên kết website</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">                    
                    <button id="btnAdd" data-toggle="modal" data-target="#compose-modal" class="btn btn-primary btn-flat">
						<i class="ace-icon fa  fa-pencil bigger-120 orange"></i>
						Thêm mới
					</button>                                        
                </div><!-- /. tools -->
            </div><!-- /.box-header -->                        

            <div class="box-body table-responsive" id="ntn-tb">
                <!-- THE MESSAGES -->                            
                <asp:GridView ID="GridView_ListData" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" 
                    BorderWidth="1px" CellPadding="3" EnableModelValidation="True" Width="100%" HeaderStyle-Height="30px" OnRowEditing="GridView_ListData_OnRowEditing"
                    CssClass="table table-bordered table-hover dataTable" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="ID">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="40px"/>
                        </asp:TemplateField>                                                                                                                                                                                     
                        
                        <asp:BoundField HeaderText="Tiêu đề" DataField="Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" ControlStyle-Width="100%" 
                        ControlStyle-Height="30" ControlStyle-ForeColor="Black" ItemStyle-Font-Size="13px" ItemStyle-Width="300px" ItemStyle-ForeColor="#3C8DBC" />
                                                                          
                        <asp:BoundField HeaderText="Đường dẫn" DataField="Href" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" ControlStyle-Width="100%" 
                        ControlStyle-Height="30" ControlStyle-ForeColor="Black" ItemStyle-Font-Size="13px"/>                                                                                                                                                                                                                                             
                                    
                        <asp:TemplateField HeaderText="Sửa">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButtonEdit" CommandName="Edit" ToolTip="Chỉnh sửa" runat="server"><i class="fa fa-pencil font-16"></i></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="Update" OnClick="Update_OnClick" OnClientClick="return validInsertRecord(1);" CommandArgument='<%# Eval("ID") %>' ToolTip="Cập nhật" runat="server"><span class="glyphicon glyphicon-refresh font-16"></span></asp:LinkButton>
                                <asp:LinkButton ID="Cancel" OnClick="Cancel_OnClick" ToolTip="Hủy bỏ" runat="server"><span class="glyphicon glyphicon-remove font-16 red"></span></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="65px" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                                    
                        <asp:TemplateField HeaderText="Xóa">
                            <ItemTemplate>                                            
                                <a id="delRecord" class="delRecord" href="<%# Eval("ID") %>">
                                    <span class="glyphicon glyphicon-remove-circle red font-16" title="Xóa"></span>
                                </a>                                            
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="55px" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle BackColor="#f5f5f5" VerticalAlign="Middle" HorizontalAlign="Center" Font-Bold="True" ForeColor="#d60c0c" />
                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Center" />
                    <RowStyle ForeColor="#000066" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                </asp:GridView>                            
            </div><!-- /.table-responsive -->                    
        </div><!-- /.box -->                
    </div><!-- /.col-->
</div><!-- ./row -->

<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 style="font-family:Segoe UI,Arial,sans-serif;" class="modal-title"><i class="fa fa-wrench"></i> Thông tin cập nhật</h4>
        </div>
        <form action="#" method="post">
            <div class="modal-body">
                <div class="form-group row-horizontal">                    
                    <label class="col-sm-3 control-label">Tiêu đề</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtName" CssClass="form-control" autocomplete="off" runat="server"></asp:TextBox>
                    </div>
                </div>                
                <div class="form-group row-horizontal">
                    <label class="col-sm-3 control-label">Đường dẫn</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtHref" CssClass="form-control" autocomplete="off" TextMode="Url" runat="server"></asp:TextBox>                        
                    </div>
                </div>                                
                <%--<div class="form-group row-horizontal">
                    <label class="col-sm-3 control-label">Ảnh <i style="font-size: 12px; color: red;">(980px - 400px)</i></label>
                    <div class="col-sm-9 sh-Input">                        
                        <sh:FileInput runat="server" ID="fileUploadImage" FileType="Images" Width="249" placeholder="Đường dẫn file"/>                        
                    </div>
                </div>--%>                                
            </div>
            <div class="modal-footer clearfix">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
                <asp:Button ID="btnInsert" runat="server" Text="Xác nhận" class="btn btn-primary pull-left" OnClientClick="return valid_Insert();" OnClick="btnInsert_OnClick" />                
            </div>
        </form>
    </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script type="text/javascript" src="/Theme/javascript/js_adminLinkWebsite.js"></script>
<script type="text/javascript">
    function valid_Insert() {
        var title = $("#<%= txtName.ClientID %>");
        var href = $("#<%= txtHref.ClientID %>");
        if (title.val() != "" && href.val() != "") {
            return true;
        } else {
            alert("Tiêu đề và đường dẫn không được bỏ trống");
            title.focus();
            return false;
        }
    }
</script>