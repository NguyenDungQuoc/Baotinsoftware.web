<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListGallerys.ascx.cs" Inherits="MyProfile.Admin.Modules.Gallery.WebUserControl1" %>
<%@ Import Namespace="MyProfile.Class" %>
<%@ Register Src="~/Controls/FileInput.ascx" TagName="FileInput" TagPrefix="sh" %>

<div class="row">
    <div class="col-xs-12 col-md-12">
        <div class='box box-info'>
            <div class='box-header' style="padding-bottom: 0px;">
                <i class="fa fa-picture-o"></i>
                <h3 class='box-title'>Our Strategic Partners</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">           
                    <button id="btnClick" type="button" data-toggle="modal" data-target="#compose-modal" class="btn btn-primary btn-flat">Thêm mới</button>
                </div><!-- /. tools -->                
            </div><!-- /.box-header -->
            <div class="box-body">
                <div class="wrapper-gallery">                
                    <asp:Repeater runat="server" ID="rptListGallery" OnItemCommand="rptListGallery_OnItemCommand">
                        <HeaderTemplate><div class="row list-gallery"></HeaderTemplate>
                        <ItemTemplate>
                            <div class="col-md-3 li">
								<a href="<%# Eval("Href") %>" class="fancybox-thumb thumbnail" rel="fancybox-thumb" title="<%# Eval("Title") %>">
									<img alt="<%# Eval("Title") %>" src="<%# Eval("Href") %>">
									<%--<div class="title-gallery">
										<div class="inner"><%# Eval("Title") %></div>
									</div>--%>
								</a>
							    <div class="tools tools-bottom">
							        <asp:LinkButton ID="lnk_Active" runat="server" CommandName="IsActive" CommandArgument='<%# Eval("ID") %>'>
							            <%# Utility.GetLabelIsActive((bool)Eval("Active"),"Ẩn","Hiện") %>
							        </asp:LinkButton>							        						        
								    <a href="<%# Eval("Href") %>" class="fancybox-thumb" rel="fancybox-thumb" title="Zoom">
									    <i class="ace-icon fa fa-search-plus font-16"></i>
								    </a>
								    <a href="#" class="callmodal" pib="<%# Eval("ID") %>" title="Chỉnh sửa">
									    <i class="ace-icon fa fa-pencil font-16"></i>
								    </a>
								    <a href="#" class="delItems" title="Xóa">
									    <i class="ace-icon fa fa-times red font-16"></i>
                                        <asp:HiddenField ID="hdf_ID" runat="server" Value='<%# Eval("ID") %>' />
								    </a>
							    </div>
							</div>
                        </ItemTemplate>
                        <FooterTemplate></div></FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>            
    </div>
</div>

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
                        <input type="text" id="txtName" class="form-control" autocomplete="off" />
                    </div>
                </div>                
                <div class="form-group row-horizontal">
                    <label class="col-sm-3 control-label">Liên kết/Link</label>
                    <div class="col-sm-9">
                        <input type="text" id="txtContent" class="form-control" autocomplete="off" />                        
                    </div>
                </div>
                <div class="form-group row-horizontal">
                    <label class="col-sm-3 control-label">Danh mục</label>
                    <div class="col-sm-6">                        
                        <select id="cmb_GroupGallery" class="form-control" data-placeholder="--Chọn danh mục--">
                            <option value="0">-- Chọn danh mục --</option>
                            <asp:Repeater ID="rptGroupGallery" runat="server">
                                <ItemTemplate>
                                    <option value="<%# Eval("ID") %>"><%# Eval("Name") %></option>
                                </ItemTemplate>
                            </asp:Repeater>
                        </select>
                    </div>
                </div>                
                <div class="form-group row-horizontal">
                    <label class="col-sm-3 control-label">Trạng thái</label>
                    <div class="col-sm-3">                        
                        <select id="cmb_Active" class="form-control" data-placeholder="--Chọn--">
                            <option value="">-- Chọn --</option>
                            <option value="False">Ẩn</option>
                            <option value="True">Hiện</option>
                        </select>
                    </div>
                </div>
                <div class="form-group row-horizontal">
                    <label class="col-sm-3 control-label">Hình ảnh (225x100px)</label>
                    <div class="col-sm-9">
                        <div class="input-group validPath sh-Input">
                            <sh:FileInput runat="server" ID="fileUploadImage" FileType="Images" Width="" CssClass="form-control" placeholder="Đường dẫn file"/> 
                        </div>                                                                       
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

<script type="text/javascript" src="/Theme/js/jquery.fancybox.js"></script>
<link href="/Theme/css/jquery.fancybox.css" rel="stylesheet" />
<script type="text/javascript" src="/Theme/javascript/js_adminGallery.js"></script>