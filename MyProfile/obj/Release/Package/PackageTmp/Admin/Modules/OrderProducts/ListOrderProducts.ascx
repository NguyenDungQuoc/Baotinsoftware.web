<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListOrderProducts.ascx.cs" Inherits="MyProfile.Admin.Modules.OrderProducts.ListOrderProducts" %>
<%@ Import Namespace="MyProfile.Class" %>

<div class='row'>
    <div class='col-md-12'>
        <div class='box box-info'>
            <div class='box-header no-padding-bottom'>
                <h3 class='box-title'>Danh sách Đơn đặt hàng</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">
                    <label class="lbl-alert"></label>                                                                                
                    <button id="btnDel" class="btn btn-danger btn-flat marginLeft-10" title="Xóa">
						<i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
						Delete
					</button>                                                            
                </div><!-- /. tools -->
            </div><!-- /.box-header -->
            <div class="box-body table-responsive" id="ntn-tb">
                <asp:GridView ID="GridView_ListData" runat="server" AutoGenerateColumns="False" Width="100%" HeaderStyle-Height="30px"
                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" EnableModelValidation="True" 
                    CssClass="table table-bordered table-hover dataTable" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="ID">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <%# Eval("Row") %>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="40px"/>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Tên khách hàng">
                            <ItemTemplate>
                                <a title="<%# Eval("CustomerName") %>" href="<%# Eval("ID","/Admin/orderdetails.aspx?id={0}") %>"><%# Eval("CustomerName") %></a>
                                <div style="font-size: 11px; color: #555; padding-top: 2px;">Số điện thoại : <%# Eval("Mobile") %></div>                                                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="200" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>                                                                                                
                        
                        <asp:TemplateField HeaderText="Ngày đặt hàng">
                            <ItemTemplate>
                                <%# Eval("Date","{0:dd/MM/yyyy}") %>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="120" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>                                                
                        
                        <asp:TemplateField HeaderText="Địa chỉ">
                            <ItemTemplate>
                                <%# Eval("Address") %>                           
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="190" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Ghi chú">
                            <ItemTemplate>
                                <%# Eval("CustomerNote") %>                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>                                                                                                                        

                        <asp:TemplateField HeaderText="Tình trạng đơn hàng">
                            <ItemTemplate>
                                <span style="<%# Eval("StatusID").ToString() == "6" ? "color:red" : Eval("StatusID").ToString() %>"><%# getStringOrderStatus(Convert.ToInt32(Eval("StatusID"))) %></span>                                                                                                                                                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="150" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>                                                                                                                        

                        <asp:TemplateField HeaderText="Chọn">
                            <ItemTemplate>
                                <input type="checkbox" id="chkdel" runat="server" pid='<%# Eval("ID") %>' />
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
                                <asp:ListItem Text="25" Value="25" />
                                <asp:ListItem Text="50" Value="50" />
                                <asp:ListItem Text="70" Value="70" />
                            </asp:DropDownList>
                        </div>                                                
                    </div>
                    <div class="col-xs-6">
                        <div class="paging_bootstrap">
                            <asp:Repeater ID="rpt_Pager" runat="server">
                                <HeaderTemplate><ul class="pagination"></HeaderTemplate>
                                <ItemTemplate>
                                    <li class="<%# Utility.GetClassActivePaging(PageIndex.ToString(),Eval("Value").ToString()) + " " + Utility.GetClassDisabledPaging(Convert.ToBoolean(Eval("Enabled"))) %>">
                                        <a href="/Admin/orderproducts.aspx?page=<%# Eval("Value") %>"><%#Eval("Text") %></a>                                        
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
<script type="text/javascript" src="/Theme/javascript/js_adminOrderProducts.js"></script>
