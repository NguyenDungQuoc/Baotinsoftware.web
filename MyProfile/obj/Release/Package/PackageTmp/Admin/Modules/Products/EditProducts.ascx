<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditProducts.ascx.cs" Inherits="MyProfile.Admin.Modules.Products.EditProducts" %>
<%@ Register Src="~/Controls/FileInput.ascx" TagName="FileInput" TagPrefix="sh" %>
<%@ Register Src="~/Controls/ImagesInput.ascx" TagPrefix="sh" TagName="ImagesInput" %>

<div class="row">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header no-padding-bottom">
                <h3 class="box-title">Thông tin sản phẩm</h3>               
            </div><!-- /.box-header -->
            <div class="box-body">
                <div class="row">
                    <div class="col-sm-12" role="form">
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Tên sản phẩm *</label>
                            <div class="col-sm-9 title-Input">                                
                                <asp:TextBox ID="txtName" CssClass="form-control" autocomplete="off" runat="server" MaxLength="300"></asp:TextBox>                                                                
                            </div>                            
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Mã sản phẩm</label>
                            <div class="col-sm-2">                                
                                <asp:TextBox ID="txtCode" CssClass="form-control" autocomplete="off" runat="server" MaxLength="40"></asp:TextBox>                                                                
                            </div>
                            <label class="control-label col-sm-2 right-block">Ảnh đại diện (600x380 px) *</label>
                            <div class="col-sm-5 sh-Input">
                                <div class="input-group col-sm-12 validPath">
                                    <sh:FileInput runat="server" ID="InputFile_Avatar" Width="" CssClass="form-control" FileType="Images" placeholder="Đường dẫn file"/>
                                </div>                                                                                                                                
                            </div>
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Tình trạng</label>
                            <div class="col-sm-2">                           
                                <asp:DropDownList ID="ddl_StatusProducts" DataTextField="Name" DataValueField="ID" CssClass="form-control" runat="server">
                                    <asp:ListItem Text='<%= Eval("Name") %>' Value='<%= Eval("ID") %>'/>                                                                                                                                                
                                </asp:DropDownList>
                            </div>
                            <label class="control-label col-sm-2 right-block">Danh mục sản phẩm</label>
                            <div class="col-sm-5">                                
                                <asp:DropDownList ID="ddl_CategoriesProducts" DataTextField="Name" DataValueField="ID" CssClass="form-control" runat="server">                                                                                                                                                                                                                       
                                </asp:DropDownList>                                                                
                            </div>                        
                        </div>
                        <div class="form-group row-horizontal hide-row">                                                        
                            <label class="control-label col-sm-3 right-block">Giá bán (VNĐ)</label>
                            <div class="col-sm-2">
                                <asp:TextBox ID="txtPrice" CssClass="form-control auto" data-a-sep="." data-a-dec="," aPad="false" placeholder="VNĐ" runat="server" MaxLength="12"></asp:TextBox>
                            </div>
                            <div class="col-alert">
                                <span class="glyphicon glyphicon-question-sign col-alert" style="color: #F56954; font-size: 20px; margin-top: 5px;"></span>
                                <span class="tooltip-sign">
                                    Lưu ý : Nhập giá bán bằng 0 nếu muốn giá bán của bạn "Liên hệ"
                                </span>
                            </div>                                                                                                                                                                                                        
                        </div>
                        <div class="form-group row-horizontal hide-row">                            
                            <label class="control-label col-sm-3 right-block">Giá ưu đãi (Giá khuyến mãi)</label>
                            <div class="col-sm-2">                                
                                <asp:TextBox ID="txtPriceOld" CssClass="form-control auto" data-a-sep="." data-a-dec="," aPad="false" placeholder="VNĐ" runat="server" MaxLength="12"></asp:TextBox>                                                                                                                                
                            </div>                                
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Mô tả ngắn (300 ký tự)</label>                            
                            <div class="col-sm-9">                                                                
                                <%--<textarea id="editor_subdescription" name="editor_subdescription" class="form-control">
                                    <%= SubDetail %>
                                </textarea>--%>
                                <asp:TextBox runat="server" ID="txtSummary" TextMode="MultiLine" CssClass="form-control" Rows="6" MaxLength="300"></asp:TextBox>
                            </div>                            
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Mô tả chi tiết</label>
                            <div class="col-sm-9">                                
                                <textarea id="editor_content" name="editor_content" class="form-control">
                                    <%= DetailContent %>
                                </textarea>                                                                
                            </div>                            
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Link Youtube</label>
                            <div class="col-sm-9">                                
                                <asp:TextBox ID="txtLinkY" CssClass="form-control" autocomplete="off" runat="server" placeholder="Đường dẫn Video Youtube" MaxLength="400"></asp:TextBox>                                                                
                            </div>                            
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Hashtag (từ khóa)</label>
                            <div class="col-sm-9">
                                <asp:ListBox runat="server" ID="ddlHashtags" CssClass="form-control js-example-basic-multiple js-states" SelectionMode="Multiple" DataTextField="Name" DataValueField="HashtagId"/>
                            </div>
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block no-padding-top marginTop-10">Trạng thái</label>
                            <div class="col-sm-3">                                
                                <asp:RadioButton ID="rdb_Show" CssClass="radio" Text="Đã duyệt" GroupName="Status" runat="server" style="display: inline-block" />
                                <asp:RadioButton ID="rdb_Hide" CssClass="radio custom-radio" Text="Chưa duyệt" GroupName="Status" runat="server" />                                                                
                            </div>
                            <div class="col-sm-6">
                                <label class="control-label col-sm-3 right-block no-padding-top marginTop-10">Nổi bật</label>
                                <div class="col-sm-9">                                
                                    <asp:RadioButton ID="rdb_IsHot" CssClass="radio" Text="Có" GroupName="isHot" runat="server" style="display: inline-block" />
                                    <asp:RadioButton ID="rdb_NotIsHot" CssClass="radio custom-radio" Text="Không" GroupName="isHot" runat="server" />                                                                
                                </div>
                            </div>                            
                        </div>
                        <div class="form-group row-horizontal">                            
                            <label class="control-label col-sm-3 right-block">Loại sản phẩm</label>
                            <div class="col-sm-9 type-checkbox">
                                <asp:Repeater runat="server" ID="rptListProductType">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chk_Type" runat="server" Text='<%# Eval("Name") %>' Checked='<%# GetActiveProductType(Convert.ToInt32(Eval("ID_Type"))) %>' typeid='<%# Eval("ID_Type") %>' />                                        
                                    </ItemTemplate>
                                </asp:Repeater>                                
                            </div>
                        </div>
                        <div class="form-group row-horizontal hide-row">
                            <label class="control-label col-sm-3 right-block">Chọn Size</label>
                            <div class="col-sm-9 type-checkbox">
                                <asp:Repeater runat="server" ID="rptListSizeOfProduct">
                                    <HeaderTemplate><div class="row"></HeaderTemplate>
                                    <ItemTemplate>                                                                    
                                        <div class="col-sm-3 chk-enable">                                                                                     
                                            <asp:CheckBox ID="chk_Size" runat="server" Text='<%# Eval("Name") + Eval("Note"," ({0})") %>' sizeId='<%# Eval("SizeId") %>' Checked='<%# Eval("SelectedId") != null ? true : false %>' />                                            
                                            <asp:TextBox ID="chk_Price" runat="server" CssClass="form-control auto marginTop-5" data-a-sep="." data-a-dec="," aPad="false" placeholder="Nhập giá" Text='<%# Eval("Price") %>' MaxLength="12" autocomplete="off" Enabled='<%# Eval("Price") != null ? true : false %>'></asp:TextBox>
                                        </div>                                                                               
                                    </ItemTemplate>
                                    <FooterTemplate></div></FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <div class="form-group row-horizontal hide-row">
                            <label class="control-label col-sm-3 right-block">Màu sắc</label>
                            <div class="col-sm-9 type-checkbox">
                                <asp:Repeater runat="server" ID="rptListProductColor">                                    
                                    <ItemTemplate>
                                        <span class="color-item">
                                            <asp:CheckBox ID="chk_ProductColor" runat="server" Text='<%# Eval("Note") %>' ToolTip='<%# Eval("Note") %>' colorId='<%# Eval("ColorId") %>' Checked='<%# Eval("SelectedId") != null ? true : false %>' />
                                            <strong style="<%# "background:" + Eval("Hex") %>" class="color-icon"><%# Eval("Hex") %></strong>  
                                        </span>                                      
                                    </ItemTemplate>                                    
                                </asp:Repeater>
                            </div>
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Chọn ảnh/Chọn kiểu</label>
                            <div class="col-sm-9">
                                <sh:ImagesInput runat="server" ID="imagesInput" />
                            </div>
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Tin tức liên quan</label>
                            <div class="col-sm-9">
                                <div class="product-news-checkbox">
                                    <asp:CheckBoxList ID="chklProductNews" runat="server" DataTextField="Title" DataValueField="ID"></asp:CheckBoxList>
                                </div>
                            </div>
                        </div>
                        <!-- tools box -->
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block"></label>
                            <div class="col-sm-9">                                                                
                                <asp:Button ID="btn_Update" CssClass="btn btn-primary btn-flat" OnClientClick="return beforeSubmit()" runat="server" Text="Xác nhận" OnClick="btn_Update_OnClick" />
                                <a href="/Admin/listproducts.aspx" class="btn btn-danger btn-flat" title="Quay lại">Quay lại</a>
                            </div>                                                                                                            
                        </div><!-- /. tools -->
                    </div>            
                </div>                                                
            </div>
        </div><!-- /.box -->                
    </div><!-- /.col-->
</div><!-- ./row -->
<link href="/Theme/js/select2-4.0.5/select2.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/Theme/js/select2-4.0.5/select2.min.js"></script>
<script type="text/javascript" src="/Admin/Theme/js/autoNumeric/autoNumeric.js"></script>
<script type="text/javascript" src="/Theme/javascript/js_adminProducts.js"></script>

