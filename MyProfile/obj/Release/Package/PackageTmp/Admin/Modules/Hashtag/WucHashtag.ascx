<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WucHashtag.ascx.cs" Inherits="MyProfile.Admin.Modules.Hashtag.WucHashtag" %>
<%@ Import Namespace="MyProfile.Class" %>
<%--<%@ Register TagPrefix="sh" TagName="FileInput" Src="~/Controls/FileInput.ascx" %>--%>

<div class="row">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header no-padding-bottom">
                <h3 class="box-title"><i class="fa fa-tags"></i> Quản lý Hashtag</h3>
                <!-- tools box -->
                <%--<div class="pull-right box-tools">                    
                    <button id="btnClick" type="button" data-toggle="modal" data-target="#compose-modal" class="btn btn-primary btn-flat">Thêm mới</button>                                        
                </div><!-- /. tools -->--%>
            </div><!-- /.box-header -->
            <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                <ProgressTemplate>
                    <img src="/Theme/photo/social-icon-google-2x.png"/>
                </ProgressTemplate>
            </asp:UpdateProgress>--%>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">
                                <span class="glyphicon glyphicon-bookmark"></span>
                                <h3 class="box-title" style="margin:0; font-size:20px; display:inline-block;">Thêm mới Hashtag</h3>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group row-horizontal validName no-margin-bottom">                   
                                    <label class="control-label col-sm-12 no-padding-left">Tên hashtag *</label>                                
                                    <asp:TextBox ID="txtHashtag" CssClass="form-control" autocomplete="off" runat="server" placeholder="Tên #hashtag" MaxLength="100"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group row-horizontal no-margin-bottom">                    
                                    <label class="control-label col-sm-12 no-padding-left">Nổi bật</label>                                
                                    <asp:RadioButton ID="rdbYes" CssClass="radio" Text="Có" GroupName="IsHot" runat="server" style="display: inline-block" />
                                    <asp:RadioButton ID="rdbNo" CssClass="radio custom-radio" Text="Không" GroupName="IsHot" runat="server" Checked="True" />                                                           
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group row-horizontal no-margin-bottom">                    
                                    <label class="control-label col-sm-12 no-padding-left">Trạng thái</label>                                
                                    <asp:RadioButton ID="rdbShow" CssClass="radio" Text="Hiện" GroupName="IsActive" runat="server" style="display: inline-block" />
                                    <asp:RadioButton ID="rdbHide" CssClass="radio custom-radio" Text="Ẩn" GroupName="IsActive" runat="server" Checked="True" />                                                           
                                </div>
                            </div>
                            <div class="col-md-2 hide">
                                <div class="form-group row-horizontal no-margin-bottom">                    
                                    <label class="control-label col-sm-12 no-padding-left">Show/Off</label>                                
                                    <asp:RadioButton ID="rdbEnableT" CssClass="radio" Text="Bật" GroupName="IsEnable" runat="server" style="display: inline-block" />
                                    <asp:RadioButton ID="rdbEnableF" CssClass="radio custom-radio" Text="Tắt" GroupName="IsEnable" runat="server" Checked="True" />                                                           
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group row-horizontal no-margin-bottom">
                                    <label class="control-label col-sm-12 no-padding-left">Thêm mới</label>
                                    <asp:Button ID="BtnInsert" runat="server" Text="Thêm mới" CssClass="btn btn-primary btn-flat" OnClick="BtnInsert_OnClick" OnClientClick="return validInsertRecord(0);" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label runat="server" ID="lblError" style="color: red;"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-12 m-t10-m-b10"></div>
                                <span class="glyphicon glyphicon-bookmark"></span>
                                <h3 class="box-title" style="margin:0; font-size:20px; display:inline-block;">Danh sách Hashtag</h3>
                            </div>
                            <div class="col-md-12 m-t10-m-b10"></div>
                            <div class="col-md-12 table-responsive">
                                <!-- THE MESSAGES -->                            
                                <asp:GridView ID="GvListData" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" 
                                    BorderWidth="1px" CellPadding="3" EnableModelValidation="True" Width="100%" HeaderStyle-Height="30px" OnRowCommand="GvListData_OnRowCommand" 
                                    CssClass="table table-bordered table-hover dataTable" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="HashTagId" OnRowEditing="GvListData_OnRowEditing">
                                    <Columns>
                                        <asp:TemplateField HeaderText="STT">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="40px"/>
                                        </asp:TemplateField>                                                                                                                                    
                        
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                # <%# Eval("Name") %>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtHashtagName" CssClass="form-control" autocomplete="off" runat="server" placeholder="Tên #hashtag" 
                                                    MaxLength="100" Text='<%# Eval("Name") %>'>
                                                </asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" ForeColor="#3C8DBC" />
                                            <HeaderStyle HorizontalAlign="Center" />           
                                        </asp:TemplateField> 
                        
                                        <asp:TemplateField HeaderText="Link Seo">
                                            <ItemTemplate>
                                                <%# Eval("Alias") %>                                                                                                                               
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="300" />
                                            <HeaderStyle HorizontalAlign="Center" />           
                                        </asp:TemplateField>   
                        
                                        <asp:TemplateField HeaderText="Nổi bật">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lnkIsHot" CommandArgument='<%# Eval("HashTagId") %>' CommandName="IsHot">
                                                    <%# Utility.GetLabelIsHot(Convert.ToBoolean(Eval("isHot")))  %>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="80" />
                                            <HeaderStyle HorizontalAlign="Center" />           
                                        </asp:TemplateField>                                                                                                                                                                                                                   

                                        <asp:TemplateField HeaderText="Trạng thái">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkStatus" CommandArgument='<%# Eval("HashTagId") %>' CommandName="IsActive" runat="server">
                                                    <%# Utility.GetLabelIsActive(Convert.ToBoolean(Eval("IsActive")), "Ẩn", "Hiện") %>
                                                </asp:LinkButton>                                            
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="80" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>                                                                                                                                                                                                            
                                        
                                        <asp:TemplateField HeaderText="Chỉnh sửa">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkEdit" CommandName="Edit" CommandArgument='<%# Eval("HashTagId") %>' ToolTip="Chỉnh sửa" runat="server"><i class="fa fa-pencil font-16"></i></asp:LinkButton>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:LinkButton ID="lnkUpdate" OnClick="lnkUpdate_OnClick" OnClientClick="return updateRecordUploadFile();" CommandArgument='<%# Eval("HashTagId") %>' ToolTip="Cập nhật" runat="server">
                                                    <span class="glyphicon glyphicon-refresh font-16"></span>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="lnkCancel" OnClick="lnkCancel_OnClick" ToolTip="Hủy bỏ" runat="server">
                                                    <span class="glyphicon glyphicon-remove font-16 red"></span>
                                                </asp:LinkButton>
                                            </EditItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="85px" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Xóa">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lnkDelete" CommandArgument='<%# Eval("HashTagId") %>' CommandName="Delete" OnClientClick="return confirm('Bạn có thực sự muốn xóa?');">
                                                    <span class="glyphicon glyphicon-remove-circle red font-16" title="Xóa"></span>
                                                </asp:LinkButton>
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
                        </div>
                    </div><!-- /.box-body -->
                </ContentTemplate>
            </asp:UpdatePanel>          
        </div><!-- /.box -->                
    </div><!-- /.col-->
</div><!-- ./row -->

<%--<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 style="font-family:Segoe UI,Arial,sans-serif;" class="modal-title"><i class="fa fa-wrench"></i> Thông tin chỉnh sửa</h4>
        </div>
        <form action="#" method="post">
            <div class="modal-body">
                <div class="form-group row-horizontal">                    
                    <label class="col-sm-3 control-label">Tên hashtag</label>
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
</div><!-- /.modal -->--%>
<script src="/Theme/javascript/js_validate.js" type="text/javascript"></script>