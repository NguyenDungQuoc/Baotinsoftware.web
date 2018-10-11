<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListDownload.ascx.cs" Inherits="MyProfile.Admin.Modules.Download.ListDownload" %>
<%@ Import Namespace="MyProfile.Class" %>
<%@ Register Src="~/Controls/FileInput.ascx" TagName="FileInput" TagPrefix="sh" %>
<div class="row">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header" style="padding-bottom: 0px;">
                <i class="fa fa-cloud-download"></i>
                <h3 class="box-title">File Download</h3>                
            </div><!-- /.box-header -->
            <div class="box-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-sm-12 no-padding-left no-padding-right">
                            <span class="glyphicon glyphicon-bookmark"></span>
                            <h3 class="box-title" style="margin:0; font-size:20px; display:inline-block;">Thêm mới File</h3>
                        </div>                                
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group row-horizontal no-margin-bottom validName">                   
                                    <label class="control-label col-sm-12 no-padding-left">Tên file *</label>                                
                                    <asp:TextBox ID="txtName" CssClass="form-control" autocomplete="off" runat="server" placeholder="Tên file"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group row-horizontal no-margin-bottom">                  
                                    <label class="control-label col-sm-12 no-padding-left">Đường dẫn file *</label>
                                    <div class="input-group col-sm-12 validPath">
                                        <sh:FileInput runat="server" ID="txtPath" FileType="Images" Width="" CssClass="form-control" placeholder="Đường dẫn file"/>
                                    </div>                                                                  
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group row-horizontal no-margin-bottom">                  
                                    <label class="control-label col-sm-12 no-padding-left">Mô tả</label>                              
                                    <asp:TextBox ID="txtDes" CssClass="form-control" runat="server" placeholder="Mô tả"></asp:TextBox>
                                </div>
                            </div>                                                                                                                                                                                                                                
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group row-horizontal no-margin-bottom">                    
                                    <label class="control-label col-sm-12 no-padding-left">Kích thước (KB)</label>                                                                
                                    <asp:TextBox ID="txtSize" CssClass="form-control" runat="server" placeholder="Kích thước (KB)"></asp:TextBox>                                    
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
                                    <asp:Button ID="btnInsert" runat="server" Text="Thêm mới" CssClass="btn btn-primary btn-flat" OnClick="btnInsert_Click" OnClientClick="return validInsertRecord(1);" />
                                </div>
                            </div>
                        </div>
                    </div><!-- /.col (LEFT) -->
                    <div class="col-md-12 m-t10-m-b10"></div>
                    <div class="col-md-12">
                        <div class="col-sm-6 no-padding-left">
                            <span class="glyphicon glyphicon-bookmark"></span>
                            <h3 class="box-title" style="margin:0; font-size:20px; display:inline-block;">Danh sách File</h3>
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
                                BorderWidth="1px" CellPadding="3" EnableModelValidation="True" Width="100%" HeaderStyle-Height="30px" OnRowCommand="GridView_ListData_RowCommand" 
                                CssClass="table table-bordered" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="DownloadId" OnRowEditing="GridView_ListData_RowEditing">
                                <Columns>
                                    <asp:TemplateField HeaderText="STT">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="30px"/>
                                    </asp:TemplateField>                                                                        
                                    
                                    <asp:BoundField HeaderText="Tên File" DataField="Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" 
                                    ControlStyle-ForeColor="Black" ItemStyle-Font-Size="13px" ItemStyle-ForeColor="#3c8dbc" ControlStyle-CssClass="form-control f-Name" />                                                                      
                                                                                                                                                                                    
                                    <asp:TemplateField HeaderText="Đường dẫn">
                                        <ItemTemplate>
                                            <%# Eval("Path").ToString().Length > 100 ? Eval("Path").ToString().Substring(0, 100) + " ..." : Eval("Path") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <div class="input-group col-sm-12">
                                                <sh:FileInput runat="server" ID="txtFilePath" FileType="Images" Text='<%# Eval("Path") %>' CssClass="form-control f-Path" placeholder="Đường dẫn file"/>
                                            </div>                                                                                        
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="280px" />
                                        <HeaderStyle HorizontalAlign="Center" />                                                                                
                                    </asp:TemplateField>

                                    <asp:BoundField HeaderText="Mô tả" DataField="Description" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" 
                                    ControlStyle-ForeColor="Black" ItemStyle-Font-Size="13px" ItemStyle-Width="180" ControlStyle-CssClass="form-control"/>

                                    <asp:TemplateField HeaderText="Size">
                                        <ItemTemplate>
                                            <%# Eval("Size") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtSize" CssClass="form-control" runat="server" Text='<%# Eval("Size") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" CssClass="validPosition" Width="80" />
                                        <HeaderStyle HorizontalAlign="Center" />                                                                                
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Trạng thái">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButtonStatus" CommandArgument='<%# Eval("DownloadId") %>' CommandName="IsActive" runat="server">
                                                <%# Utility.GetLabelIsActive(Convert.ToBoolean(Eval("IsActive")), "Ẩn", "Hiện") %>
                                            </asp:LinkButton>                                            
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="80px" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Sửa">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButtonEdit" CommandName="Edit" ToolTip="Chỉnh sửa" runat="server"><i class="fa fa-pencil font-16"></i></asp:LinkButton>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="Update" OnClick="Update_Click" OnClientClick="return updateRecordUploadFile();" CommandArgument='<%# Eval("DownloadId") %>' ToolTip="Cập nhật" runat="server">
                                                <span class="glyphicon glyphicon-refresh font-16"></span>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="Cancel" OnClick="Cancel_Click" ToolTip="Hủy bỏ" runat="server">
                                                <span class="glyphicon glyphicon-remove font-16 red"></span>
                                            </asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="75px" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Xóa">
                                        <ItemTemplate>                                                                                             
                                            <asp:LinkButton ID="lnkDelRecord" runat="server" CommandArgument='<%# Eval("DownloadId") %>' CommandName="DelRecord" OnClientClick="return confirm('Bạn có thật sự muốn xóa?')">
                                                <span class="glyphicon glyphicon-remove-circle red font-16" title="Xóa"></span>
                                            </asp:LinkButton>                                       
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
                        </div><!-- /.table-responsive -->
                    </div><!-- /.col (RIGHT) -->
                </div><!-- /.row -->
            </div><!-- /.box-body -->
        </div><!-- /.box -->                
    </div><!-- /.col-->
</div><!-- ./row -->
<script src="/Theme/javascript/js_validate.js" type="text/javascript"></script>
