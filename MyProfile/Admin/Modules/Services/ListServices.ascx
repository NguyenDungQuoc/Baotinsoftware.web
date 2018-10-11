<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListServices.ascx.cs" Inherits="MyProfile.Admin.Modules.Services.ListServices" %>
<%@ Import Namespace="MyProfile.Class" %>

<div class='row'>
    <div class='col-md-12'>
        <div class='box box-info'>
            <div class='box-header no-padding-bottom'>
                <h3 class='box-title'>Danh sách dịch vụ</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">
                    <label class="lbl-alert"></label>
                    <a href="/Admin/editservices.aspx" class="btn btn-success btn-flat marginLeft-10" title="Thêm mới">
                        <i class="ace-icon fa fa-edit bigger-120 orange"></i>
                        Add +
                    </a>                    
                    <button id="btnSaves" class="btn btn-primary btn-flat marginLeft-10">
                        <i class="ace-icon fa fa-save bigger-120 orange"></i>
                        Saves
                    </button>                    
                    <button id="btnDel" class="btn btn-danger btn-flat marginLeft-10">
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
                                <img style="width: 100%;" src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="60" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Tiêu đề">
                            <ItemTemplate>
                                <a target="blank" title="<%# Eval("Title") %>" href="<%# Eval("ID","/Admin/editservices.aspx?id={0}") %>"><%# Eval("Title") %></a>                                                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>                                                                                                
                        
                        <asp:TemplateField HeaderText="Thể loại">
                            <ItemTemplate>                                    
                                 <asp:DropDownList ID="ddl_GroupServices" Font-Size="13px" DataTextField="Name" DataValueField="ID" CssClass="form-control" runat="server">                                                                
                                </asp:DropDownList>
                                <asp:HiddenField ID="hdf_GroupServices" runat="server" Value='<%# Eval("ID_GroupServices") %>'/>                           
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="180" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>                        
                        
                        <asp:TemplateField HeaderText="Người đăng">
                            <ItemTemplate>
                                <%# Singleton<UserAdmin>.Inst.GET_TABLE_USER_PRIMARYKEY(Convert.ToInt32(Eval("ID_UserPost"))).Fullname %>                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="120" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>
                        
                        <%--<asp:TemplateField HeaderText="Lượt xem">
                            <ItemTemplate>
                                <%# Eval("TotalView") %>                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="80" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>--%>                                                

                        <asp:TemplateField HeaderText="Ngày đăng">
                            <ItemTemplate>
                                <%# Eval("Date","{0:dd/MM/yyyy}") %>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="85" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Nổi bật">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButtonIsHot" CommandArgument='<%# Eval("ID") %>' CommandName="isHot" runat="server">
                                    <%# Utility.GetLabelIsHot(Convert.ToBoolean(Eval("IsHot")),"Tin nổi bật","Tin thường") %>
                                </asp:LinkButton>                                                           
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="65" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Trạng thái">
                            <ItemTemplate>                                
                                <asp:LinkButton ID="LinkButtonStatus" CommandArgument='<%# Eval("ID") %>' CommandName="isActive" runat="server">
                                    <%# Utility.GetLabelIsActive(Convert.ToBoolean(Eval("Active")),"Chưa duyệt","Đã duyệt") %>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="80" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>                        

                        <asp:TemplateField HeaderText="Chọn">
                            <ItemTemplate>
                                <input type="checkbox" id="chkdel" runat="server" pid='<%# Eval("ID") %>' />
                                <asp:HiddenField ID="hdf_ID" runat="server" Value='<%# Eval("ID") %>'/>
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

<script type="text/javascript" src="/Theme/javascript/js_adminServices.js"></script>