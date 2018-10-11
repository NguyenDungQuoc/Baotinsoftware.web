<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SeoPage.ascx.cs" Inherits="MyProfile.Admin.Modules.Seo.SeoPage" %>
<%@ Register Src="~/Controls/FileInput.ascx" TagName="FileInput" TagPrefix="sh" %>

<div class="row">
    <div class="col-lg-3 col-xs-6">
        <!-- small box -->
        <div class="small-box bg-aqua">
            <div class="inner">
                <h3>
                    <asp:Literal runat="server" ID="txtCountNews"></asp:Literal>
                </h3>
                <p>
                    News & Events
                </p>
            </div>
            <div class="icon">
                <i class="ion ion-android-note"></i>
            </div>
            <a href="/Admin/listnews.aspx" class="small-box-footer">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div><!-- ./col -->
    <div class="col-lg-3 col-xs-6">
        <!-- small box -->
        <div class="small-box bg-yellow">
            <div class="inner">
                <h3>
                    <asp:Literal runat="server" ID="txtCountService"></asp:Literal>
                </h3>
                <p>
                    Strategic Partners
                </p>
            </div>
            <div class="icon">
                <i class="ion ion-gear-b"></i>
            </div>
            <a href="/Admin/listgallery.aspx" class="small-box-footer">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div><!-- ./col -->
    <div class="col-lg-3 col-xs-6">
        <!-- small box -->
        <div class="small-box bg-green">
            <div class="inner">
                <h3>
                    <asp:Literal runat="server" ID="txtCountMember"></asp:Literal>
                </h3>
                <p>
                    Products
                </p>
            </div>
            <div class="icon">
                <i class="ion ion-bag"></i>
            </div>
            <a href="/Admin/listproducts.aspx" class="small-box-footer">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div><!-- ./col -->    
    <div class="col-lg-3 col-xs-6">
        <!-- small box -->
        <div class="small-box bg-red">
            <div class="inner">
                <h3>
                    <asp:Literal runat="server" ID="txtCountContact"></asp:Literal>
                </h3>
                <p>
                    Contact Us
                </p>
            </div>
            <div class="icon">
                <i class="ion ion-email"></i>
            </div>
            <a href="/Admin/listcontact.aspx" class="small-box-footer">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div><!-- ./col -->

    <div class="col-md-12 hide-row">
        <div class="box box-info">
            <div class="box-header">
                <h3 class="box-title">Giới thiệu - Profile</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">
                    <asp:Button ID="btnCapNhat" runat="server" Text="Cập nhật" CssClass="btn btn-primary btn-flat" Font-Size="13px" Font-Names="Arial" OnClick="btnCapNhat_Click"/>                                        
                </div><!-- /. tools -->
            </div><!-- /.box-header -->
            <div class="box-body pad">
                <textarea id="editor_content" name="editor_content" rows="10" cols="80">
                    <%= DetailContent %>
                </textarea>
            </div>
        </div><!-- /.box -->                
    </div><!-- /.col-->

    <!-- left column -->
    <div class="col-md-6">
        <!-- general form elements -->
        <div class="box box-primary">
            <div class="box-header no-padding-bottom">
                <h3 class="box-title">Thông tin về SEO, keyword, description, favicons...</h3>
            </div><!-- /.box-header -->
            <!-- form start -->
            <div role="form">
                <div class="box-body">
                    <div class="form-group">
                        <label class="control-label col-sm-12 no-padding-left">Tiêu đề trang - Title page</label>
                        <asp:TextBox ID="txtTitle" runat="server" placeholder="Tiêu đề" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-12 no-padding-left">Mobile Contact</label>
                        <asp:TextBox ID="txtSlogan" runat="server" placeholder="Slogan" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-12 no-padding-left">Description - Mô tả</label>
                        <asp:TextBox ID="txtDes" runat="server" TextMode="MultiLine" placeholder="Description" CssClass="form-control" Rows="3"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Keyword - Từ khóa</label>
                        <asp:TextBox ID="txtKeyword" runat="server" TextMode="MultiLine" placeholder="Keyword" CssClass="form-control" Rows="3"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-12 no-padding-left">Email Contact</label>
                        <asp:TextBox ID="txtFanpage" runat="server" placeholder="Mã nhúng Fanpage Facebook" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-12 no-padding-left">Google Maps</label>
                        <asp:TextBox ID="txtMaps" runat="server" placeholder="Mã Google Maps" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-12 no-padding-left">Google Analytics</label>
                        <asp:TextBox ID="txtAnalytics" runat="server" placeholder="Analytics" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>
                    <div class="form-group sh-Input">                        
                        <label class="control-label col-sm-12 no-padding-left">Logo</label>
                        <div class="input-group col-sm-12 validPath">
                            <sh:FileInput runat="server" ID="FileInputLogo" CssClass="form-control" FileType="Images" Width="" placeholder="Đường dẫn file"/>
                        </div>                        
                    </div>
                    <div class="form-group sh-Input">
                        <label class="control-label col-sm-12 no-padding-left">Favicon</label>
                        <div class="input-group col-sm-12 validPath">
                            <sh:FileInput runat="server" ID="FileInputFavicon" FileType="Images" CssClass="form-control" placeholder="Đường dẫn file"/>
                        </div>                        
                    </div>
                    <div class="form-group sh-Input">
                        <label class="control-label col-sm-12 no-padding-left">Ảnh đại diện</label>
                        <div class="input-group col-sm-12 validPath">
                            <sh:FileInput runat="server" ID="fileUploadAvatar" FileType="Images" CssClass="form-control" placeholder="Đường dẫn file"/>
                        </div>                        
                    </div>
                </div><!-- /.box-body -->
                <div class="box-footer">
                    <asp:Button ID="btnSaves" runat="server" Text="Cập nhật" CssClass="btn btn-primary btn-flat" Font-Size="13px" Font-Names="Arial" OnClick="btnSaves_Click" />
                </div>
            </div>
        </div><!-- /.box -->      
    </div><!--/.col (left) -->
    <!-- right column -->
    <div class="col-md-6">
        <!-- general form elements disabled -->
        <div class="box box-primary">
            <div class="box-header no-padding-bottom">
                <h3 class="box-title">Thông tin Footer - Copyright</h3>
            </div><!-- /.box-header -->            
            <div role="form">
                <div class="box-body">
                    <!-- text input -->
                    <div class="form-group">
                        <label class="control-label no-padding-left">Copyright</label>
                        <textarea id="editor_copyright" name="editor_copyright" class="form-control" rows="4" placeholder="Enter ...">
                            <%= DetailCopyright %>
                        </textarea>                        
                    </div>
                    
                    <div class="form-group">
                        <label class="control-label no-padding-left">Contact - Thông tin liên hệ</label>                        
                        <textarea id="editor_contact" name="editor_contact" class="form-control" rows="4" placeholder="Enter ...">
                            <%= DetailContact %>
                        </textarea>                                                
                    </div>                                                            
                </div><!-- /.box-body -->
                <div class="box-footer">
                    <asp:Button ID="btnUpdate" runat="server" Text="Cập nhật" CssClass="btn btn-primary btn-flat" Font-Size="13px" Font-Names="Arial" OnClick="btnUpdate_Click" />
                </div>
            </div>
        </div><!-- /.box -->
    </div><!--/.col (right) -->
</div><!-- ./row -->
<script type="text/javascript">
    var fck_content = $("#editor_content").ckeditor();
    var fck_copyright = $("#editor_copyright").ckeditor();
    var fck_contact = $("#editor_contact").ckeditor();
</script>