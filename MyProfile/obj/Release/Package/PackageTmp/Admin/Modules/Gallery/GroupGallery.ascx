<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GroupGallery.ascx.cs" Inherits="MyProfile.Admin.Modules.Gallery.GroupGallery" %>
<%@ Import Namespace="MyProfile.Class" %>

<div class='row'>
    <div class='col-md-12'>
        <div class='box box-info'>
            <div class='box-header' style="padding-bottom: 0px;">
                <i class="fa fa-user"></i>
                <h3 class='box-title'>Strategic Partners Category</h3>                
            </div><!-- /.box-header -->
            <div class="box-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-sm-12 no-padding-left no-padding-right">
                            <span class="glyphicon glyphicon-bookmark"></span>
                            <h3 class='box-title' style="margin:0px; font-size:20px; display:inline-block;">Thêm mới danh mục</h3>
                        </div>                                
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group row-horizontal no-margin-bottom validName">                   
                                    <label class="control-label col-sm-12 no-padding-left">Tên danh mục</label>                                
                                    <asp:TextBox ID="txtName" CssClass="form-control" autocomplete="off" runat="server" placeholder="Tên danh mục"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group row-horizontal no-margin-bottom">                  
                                    <label class="control-label col-sm-12 no-padding-left">Mô tả</label>                              
                                    <asp:TextBox ID="txtDes" CssClass="form-control" runat="server" placeholder="Mô tả"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group row-horizontal no-margin-bottom">                    
                                    <label class="control-label col-sm-12 no-padding-left">Vị trí</label>                                                                
                                    <asp:TextBox ID="txtPos" CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>                                    
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group row-horizontal no-margin-bottom">                    
                                    <label class="control-label col-sm-12 no-padding-left">Trạng thái</label>                                
                                    <asp:RadioButton ID="rdb_Show" CssClass="radio" Text="Hiện" GroupName="Status" runat="server" style="display: inline-block" />
                                    <asp:RadioButton ID="rdb_Hide" CssClass="radio custom-radio" Text="Ẩn" GroupName="Status" runat="server" />                                                           
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group row-horizontal no-margin-bottom">
                                    <label class="control-label col-sm-12 no-padding-left">Thêm mới</label>
                                    <asp:Button ID="btnInsert" runat="server" Text="Thêm mới" CssClass="btn btn-primary btn-flat" OnClick="btnInsert_OnClick" OnClientClick="return validInsertRecord(0);" />
                                </div>
                            </div>                                                                                                                                                                                                    
                        </div>
                    </div><!-- /.col (LEFT) -->
                    <div class="col-md-12 m-t10-m-b10"></div>
                    <div class="col-md-12">
                        <div class="col-sm-6 no-padding-left">
                            <span class="glyphicon glyphicon-bookmark"></span>
                            <h3 class='box-title' style="margin:0px; font-size:20px; display:inline-block;">Danh sách danh mục</h3>
                        </div>
                        <div class="col-sm-6 search-form no-padding-right">
                            <form action="#" class="text-right">
                                <div class="input-group">
                                    <asp:TextBox ID="txtSearch" CssClass="form-control" placeholder="Search" runat="server"></asp:TextBox>
                                    <div class="input-group-btn">
                                        <button type="submit" name="q" class="btn btn-primary"><i class="fa fa-search"></i></button>
                                    </div>
                                </div>                                                     
                            </form>
                        </div>
                        <div class="col-md-12 m-t10-m-b10"></div>
                        <div class="table-responsive" id="ntn-tb">
                            <!-- THE MESSAGES -->                            
                            <asp:GridView ID="GridView_ListData" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" 
                                BorderWidth="1px" CellPadding="3" EnableModelValidation="True" Width="100%" HeaderStyle-Height="30px" OnRowCommand="GridView_ListData_OnRowCommand" 
                                CssClass="table table-bordered" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="ID" OnRowEditing="GridView_ListData_OnRowEditing">
                                <Columns>
                                    <asp:TemplateField HeaderText="STT">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="40px"/>
                                    </asp:TemplateField>                                                                        
                                    
                                    <asp:BoundField HeaderText="Tên danh mục" DataField="Name" ItemStyle-CssClass="validName" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" ControlStyle-Width="100%" 
                                    ControlStyle-Height="30" ControlStyle-ForeColor="Black" ItemStyle-Font-Size="13px" ItemStyle-Width="250" ItemStyle-ForeColor="#3c8dbc" />                                                                      

                                    <asp:BoundField HeaderText="Mô tả" DataField="Description" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" ControlStyle-Width="100%" 
                                    ControlStyle-Height="30" ControlStyle-ForeColor="Black" ItemStyle-Font-Size="13px" ItemStyle-Width="230"/>                                                                                                            
                                    
                                    <asp:TemplateField HeaderText="Vị trí">
                                        <ItemTemplate>
                                            <%# Eval("Position") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtPosition" CssClass="form-control" runat="server" Text='<%# Eval("Position") %>' Height="30px" TextMode="Number"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" CssClass="validPosition" Width="65" />
                                        <HeaderStyle HorizontalAlign="Center" />                                                                                
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Trạng thái">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButtonStatus" CommandArgument='<%# Eval("ID") %>' CommandName="IsActive" runat="server">
                                                <%# Utility.GetLabelIsActive(Convert.ToBoolean(Eval("Active")),"Ẩn","Hiện") %>
                                            </asp:LinkButton>                                            
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="80" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Sửa">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButtonEdit" CommandName="Edit" ToolTip="Chỉnh sửa" runat="server"><i class="fa fa-pencil font-16"></i></asp:LinkButton>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="Update" OnClick="Update_OnClick" OnClientClick="return validInsertRecord(1);" CommandArgument='<%# Eval("ID") %>' ToolTip="Cập nhật" runat="server"><span class="glyphicon glyphicon-refresh font-16"></span></asp:LinkButton>
                                            <asp:LinkButton ID="Cancel" OnClick="Cancel_OnClick" ToolTip="Hủy bỏ" runat="server"><span class="glyphicon glyphicon-remove font-16 red"></span></asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="60px" />
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
                    </div><!-- /.col (RIGHT) -->
                </div><!-- /.row -->
            </div><!-- /.box-body -->
        </div><!-- /.box -->                
    </div><!-- /.col-->
</div><!-- ./row -->
<script type="text/javascript" src="/Theme/javascript/js_adminGroupGallery.js"></script>
<script type="text/javascript" src="/Theme/javascript/js_validate.js"></script>