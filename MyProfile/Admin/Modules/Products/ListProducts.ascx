<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListProducts.ascx.cs" Inherits="MyProfile.Admin.Modules.Products.ListProducts" %>
<%@ Import Namespace="MyProfile.Class" %>

<div class="row">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header no-padding-bottom">
                <h3 class="box-title">Danh sách sản phẩm</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">
                    <label class="lbl-alert"></label>
                    <a href="/Admin/editproducts.aspx" class="btn btn-success btn-flat marginLeft-10" title="Thêm mới">
                        <i class="ace-icon fa fa-edit bigger-120 orange"></i>
                        Add +
                    </a>                    
                    <button id="btnSaves" class="btn btn-primary btn-flat marginLeft-10 hide-row" title="Lưu thông tin ở chế độ sửa nhanh">
                        <i class="ace-icon fa fa-save bigger-120 orange"></i>
                        Saves
                    </button>                    
                    <button id="btnDel" class="btn btn-danger btn-flat marginLeft-10" title="Xóa">
						<i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
						Delete
					</button>                                                            
                </div><!-- /. tools -->
            </div><!-- /.box-header -->
            <div class="box-body table-responsive" id="ntn-tb">
                <asp:GridView ID="GridView_ListData" runat="server" AutoGenerateColumns="False" Width="100%" HeaderStyle-Height="30px" OnRowCommand="GridView_ListData_OnRowCommand"
                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" EnableModelValidation="True" 
                    CssClass="table table-bordered table-hover dataTable" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="ID" OnRowDataBound="GridView_ListData_OnRowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <%# Eval("Row") %>                                
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="40px"/>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Ảnh">
                            <ItemTemplate>                                
                                <img style="width: 100%;" src="<%# Eval("Image") %>" alt="<%# Eval("Name") %>" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="60" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Tên sản phẩm">
                            <ItemTemplate>
                                <a target="blank" title="<%# Eval("Name") %>" href="<%# Eval("ID","/Admin/editproducts.aspx?id={0}") %>"><%# Eval("Name") %></a>                                                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>                                                                                                
                        
                        <asp:TemplateField HeaderText="Thể loại">
                            <ItemTemplate>         
                                <asp:DropDownList ID="ddl_GroupProducts" Font-Size="13px" DataTextField="Name" DataValueField="ID" CssClass="form-control" runat="server" Enabled="false">                                                                                                                                        
                                </asp:DropDownList>                                       
                                <asp:HiddenField ID="hdf_GroupProducts" runat="server" Value='<%# Eval("ID_GroupProduct") %>'/>                           
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="270" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>                        
                        
                        <%--<asp:TemplateField HeaderText="Giá bán (VNĐ)">
                            <ItemTemplate>                                
                                <asp:TextBox ID="txtPrice" CssClass="form-control auto" data-a-sep="." data-a-dec="," aPad="false" Text='<%# Eval("Price")%>' placeholder="VNĐ" runat="server"></asp:TextBox>                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="120" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>--%>
                        
                        <%--<asp:TemplateField HeaderText="Xem">
                            <ItemTemplate>
                                <%# Eval("CountView") %>                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="65" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>--%>                                                

                        <asp:TemplateField HeaderText="Ngày đăng">
                            <ItemTemplate>
                                <%# Eval("DatePublish","{0:dd/MM/yyyy}") %>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="85" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Tình trạng">
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlStatus" DataTextField="Name" DataValueField="ID" CssClass="form-control ddlStatus" runat="server"></asp:DropDownList>
                                <asp:HiddenField ID="hdf_IDStatus" runat="server" Value='<%# Eval("StatusID") %>' />                                                                                                                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="120" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Nổi bật">
                            <ItemTemplate>                                
                                <asp:LinkButton ID="LinkButtonIsHot" CommandArgument='<%# Eval("ID") %>' CommandName="IsHot" runat="server">
                                    <%# Utility.GetLabelIsHot(Convert.ToBoolean(Eval("IsHot")),"Có","Không") %>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="70" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Active">
                            <ItemTemplate>                                
                                <asp:LinkButton ID="LinkButtonStatus" CommandArgument='<%# Eval("ID") %>' CommandName="IsActive" runat="server">
                                    <%# Utility.GetLabelIsActive(Convert.ToBoolean(Eval("IsActive")),"Chưa duyệt","Đã duyệt") %>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="60" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>                                                                        

                        <asp:TemplateField HeaderText="Chọn">
                            <ItemTemplate>
                                <input type="checkbox" id="chkdel" runat="server" pid='<%# Eval("ID") %>' />
                                <%--<asp:HiddenField ID="hdf_ID" runat="server" Value='<%# Eval("ID") %>'/>--%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="45px" />
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
                        <div class="col-sm-6 no-padding-left marginTop-10">
                            <asp:DropDownList ID="ddl_FilterOfCategory" CssClass="form-control" AutoPostBack="True" runat="server" DataTextField="Name" DataValueField="ID" AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_FilterOfCategory_OnSelectedIndexChanged">                                
                                <asp:ListItem Text="--Lọc theo danh mục--" Value="0" />
                            </asp:DropDownList>
                        </div>                                                
                    </div>
                    <div class="col-xs-6">
                        <div class="paging_bootstrap">
                            <asp:Repeater ID="rpt_Pager" runat="server">
                                <HeaderTemplate><ul class="pagination"></HeaderTemplate>
                                <ItemTemplate>
                                    <li class="<%# Eval("Value").ToString() == pageCurrent.ToString() ? "active" : "" %>">
                                        <asp:LinkButton OnClick="lnkPage_OnClick" runat="server" ID="lnkPage" CommandArgument='<%# Eval("Value") %>'><%#Eval("Text") %></asp:LinkButton>                                                                          
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
<script type="text/javascript" src="/Admin/Theme/js/autoNumeric/autoNumeric.js"></script>
<script type="text/javascript" src="/Theme/javascript/js_adminProducts.js"></script>
