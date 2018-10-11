﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditNews.ascx.cs" Inherits="MyProfile.Admin.Modules.News.EditNews" %>

<%@ Register Src="~/Controls/FileInput.ascx" TagName="FileInput" TagPrefix="sh" %>

<div class="row">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header no-padding-bottom">
                <h3 class="box-title">Thông tin bài viết</h3>               
            </div><!-- /.box-header -->
            <div class="box-body">
                <div class="row">
                    <div class="col-sm-12" role="form">
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Tiêu đề *</label>
                            <div class="col-sm-6 title-Input">                                
                                <asp:TextBox ID="txtTitle" CssClass="form-control" autocomplete="off" runat="server"></asp:TextBox>                                                                
                            </div>                            
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Hình ảnh đại diện (600x380 pixed) *</label>
                            <div class="col-sm-6 sh-Input">    
                                <div class="input-group col-sm-12 validPath">
                                    <sh:FileInput runat="server" ID="InputFile_Avatar" Width="" CssClass="form-control" FileType="Images" placeholder="Đường dẫn file"/>
                                </div>                                                                                                                            
                            </div>                            
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Mô tả ngắn (250 ký tự)</label>
                            <div class="col-sm-9">                                                                
                                <textarea id="editor_subdescription" name="editor_subdescription" class="form-control">
                                    <%= subDetail %>
                                </textarea>                                                                
                            </div>                            
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Nội dung chi tiết</label>
                            <div class="col-sm-9">                                
                                <textarea id="editor_content" name="editor_content" class="form-control">
                                    <%= detailContent %>
                                </textarea>                                                                
                            </div>                            
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Thể loại tin</label>
                            <div class="col-sm-4">                                
                                <asp:DropDownList ID="ddl_GroupNews" DataTextField="Name" DataValueField="ID" CssClass="form-control" runat="server">                                                                                                            
                                </asp:DropDownList>                                                                
                            </div>                            
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Tin nổi bật</label>
                            <div class="col-sm-2">                                
                                <asp:DropDownList ID="ddl_IsHot" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="False">Tin thường</asp:ListItem>                                    
                                    <asp:ListItem Value="True">Tin nổi bật</asp:ListItem>                                                                                                            
                                </asp:DropDownList>                                                                                                
                            </div>                            
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Trạng thái</label>
                            <div class="col-sm-6">                                
                                <asp:RadioButton ID="rdb_Show" CssClass="radio" Text="Đã duyệt" GroupName="Status" runat="server" style="display: inline-block" />
                                <asp:RadioButton ID="rdb_Hide" CssClass="radio custom-radio" Text="Chưa duyệt" GroupName="Status" runat="server" />                                                                
                            </div>                            
                        </div>
                        <!-- tools box -->
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block"></label>
                            <div class="col-sm-9">                                                                
                                <asp:Button ID="btn_Update" CssClass="btn btn-primary btn-flat" OnClientClick="return beforeSubmit()" runat="server" Text="Xác nhận" OnClick="btn_Update_OnClick" />
                                <a href="/Admin/listnews.aspx" class="btn btn-danger btn-flat" title="Quay lại">Quay lại</a>
                            </div>                                                                                                            
                        </div><!-- /. tools -->
                    </div>
                </div>                                                
            </div>
        </div><!-- /.box -->                
    </div><!-- /.col-->
</div><!-- ./row -->
<script type="text/javascript" src="/Theme/javascript/js_adminNews.js"></script>