<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BannersSliders.ascx.cs" Inherits="MyProfile.Admin.Modules.Banners.BannersSliders" %>
<%@ Import Namespace="MyProfile.Class" %>
<%@ Register TagPrefix="sh" TagName="FileInput" Src="~/Controls/FileInput.ascx" %>

<div class="row">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header no-padding-bottom">
                <h3 class="box-title">Quản lý Banner - Slide</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">                    
                    <button id="btnClick" type="button" data-toggle="modal" data-target="#compose-modal" class="btn btn-primary btn-flat">Thêm mới</button>                                        
                </div><!-- /. tools -->
            </div><!-- /.box-header -->
            <div class="box-body table-responsive" id="ntn-tb">
                <!-- THE MESSAGES -->                            
                <asp:GridView ID="GridView_ListData" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" 
                    BorderWidth="1px" CellPadding="3" EnableModelValidation="True" Width="100%" HeaderStyle-Height="30px" OnRowCommand="GridView_ListData_OnRowCommand" 
                    CssClass="table table-bordered table-hover dataTable" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="ID">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="40px"/>
                        </asp:TemplateField>                                                                                                                                    
                        
                        <asp:TemplateField HeaderText="Tiêu đề">
                            <ItemTemplate>
                                <a href="#<%# Eval("ID") %>" class="callmodal" pib="<%# Eval("ID") %>" title="<%# Eval("Title") %>">
                                    <%# Eval("Title") %>
                                </a>                                                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" ForeColor="#3C8DBC" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField> 
                        
                        <asp:TemplateField HeaderText="Hình ảnh">
                            <ItemTemplate>
                                <img src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>" style="width: 100%; height: auto;" />                                                                                                                               
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="280" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField> 
                        
                        <asp:TemplateField HeaderText="Link">
                            <ItemTemplate>
                                <%# Eval("Href") %>                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="180" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>   
                        
                        <asp:TemplateField HeaderText="Vị trí">
                            <ItemTemplate>
                                <%# Eval("Position") %>                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="50" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>                                                                                                                                                                                                                   

                        <asp:TemplateField HeaderText="Trạng thái">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButtonStatus" CommandArgument='<%# Eval("ID") %>' CommandName="IsActive" runat="server">
                                    <%# Utility.GetLabelIsActive(Convert.ToBoolean(Eval("Active")), "Ẩn", "Hiện") %>
                                </asp:LinkButton>                                            
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="80" />
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
            <h4 style="font-family:Segoe UI,Arial,sans-serif;" class="modal-title"><i class="fa fa-wrench"></i> Thông tin chỉnh sửa</h4>
        </div>
        <form action="#" method="post">
            <div class="modal-body">
                <div class="form-group row-horizontal">                    
                    <label class="col-sm-3 control-label">Tiêu đề</label>
                    <div class="col-sm-9">
                        <input type="text" id="txtTitle" class="form-control" autocomplete="off" />
                    </div>
                </div>                
                <div class="form-group row-horizontal">
                    <label class="col-sm-3 control-label">Link</label>
                    <div class="col-sm-9">
                        <input type="text" id="txtLink" class="form-control" autocomplete="off" />                        
                    </div>
                </div>                                
                <div class="form-group row-horizontal">
                    <label class="col-sm-3 control-label">Ảnh <i style="font-size: 12px; color: red;">(1140px - 440px)</i></label>
                    <div class="col-sm-9 sh-Input">
                        <div class="input-group col-sm-12 validPath">
                            <sh:FileInput runat="server" ID="fileUploadImage" FileType="Images" CssClass="form-control" placeholder="Đường dẫn file"/>
                        </div>                                                                        
                    </div>
                </div>
                <div class="form-group row-horizontal">
                    <label class="col-sm-3 control-label">Vị trí</label>
                    <div class="col-sm-3">                        
                        <input type="number" id="txtPosition" class="form-control" autocomplete="off" />
                    </div>
                </div>
                <div class="form-group row-horizontal">
                    <label class="col-sm-3 control-label">Trạng thái</label>
                    <div class="col-sm-3">                        
                        <select id="cmb_Active" class="form-control" data-placeholder="--Chọn--">
                            <option value="">--Chọn--</option>
                            <option value="False">Ẩn</option>
                            <option value="True">Hiện</option>
                        </select>
                    </div>
                </div>                
            </div>
            <div class="modal-footer clearfix">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
                <button id="btn_Accept" type="button" class="btn btn-primary pull-left"><i class="fa fa-floppy-o"></i> Xác nhận</button>
                <button id="btn_Update" type="button" class="btn btn-primary pull-left"><i class="fa fa-floppy-o"></i> Cập nhật</button>                
                <asp:HiddenField ID="hdfCurrent" runat="server" />
            </div>
        </form>
    </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script type="text/javascript" src="/Theme/javascript/js_adminBanners.js"></script>
