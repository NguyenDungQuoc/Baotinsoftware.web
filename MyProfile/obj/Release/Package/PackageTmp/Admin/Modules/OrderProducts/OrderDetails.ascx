<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrderDetails.ascx.cs" Inherits="MyProfile.Admin.Modules.OrderProducts.OrderDetails" %>

<div class='row'>
    <div class='col-md-12'>
        <div class='box box-info'>
            <div class='box-header no-padding-bottom'>
                <h3 class='box-title'>Thông tin chi tiết đơn hàng</h3>               
            </div><!-- /.box-header -->
            <div class="box-body">
                <div class="row">
                    <div class="col-sm-12" role="form">
                        <asp:Repeater ID="rpt_ListInfoCustomers" runat="server">
                            <ItemTemplate>
                                <div class="form-group row-horizontal">
                                    <label class="control-label col-sm-3 right-block">Tên khách hàng</label>
                                    <div class="col-sm-6">                                                                        
                                        <input type="text" class="form-control" disabled="disabled" value="<%# Eval("CustomerName") %>"/>                                                                
                                    </div>                            
                                </div>
                                <div class="form-group row-horizontal">
                                    <label class="control-label col-sm-3 right-block">Điện thoại</label>
                                    <div class="col-sm-6">                                                                        
                                        <input type="text" class="form-control" disabled="disabled" value="<%# Eval("Mobile") %>"/>                                                                
                                    </div>                            
                                </div>
                                <div class="form-group row-horizontal">
                                    <label class="control-label col-sm-3 right-block">Email</label>
                                    <div class="col-sm-6">                                                                        
                                        <input type="text" class="form-control" disabled="disabled" value="<%# Eval("Email") %>"/>                                                                
                                    </div>                            
                                </div>
                                <div class="form-group row-horizontal">
                                    <label class="control-label col-sm-3 right-block">Địa chỉ</label>
                                    <div class="col-sm-6">      
                                        <input type="text" class="form-control" disabled="disabled" value="<%# Eval("Address") %>"/>                                                                                                        
                                    </div>                            
                                </div>
                                <div class="form-group row-horizontal">
                                    <label class="control-label col-sm-3 right-block">Hình thức thanh toán</label>
                                    <div class="col-sm-3">                                
                                        <input type="text" class="form-control" disabled="disabled" value="<%# Eval("TypePayment") %>"/>                                                                                                                                                
                                    </div>
                                    <label class="control-label col-sm-2 right-block">Ngày đặt hàng</label>
                                    <div class="col-sm-2">                                                                        
                                        <input type="text" class="form-control" disabled="disabled" value="<%# Eval("Date","{0:dd/MM/yyyy}") %>"/>                                                                
                                    </div>                            
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Trạng thái đơn hàng</label>
                            <div class="col-sm-3">                                
                                <asp:DropDownList ID="ddl_StatusOrderProducts" DataTextField="Name" DataValueField="ID" CssClass="form-control" runat="server">                                                                                                                                                
                                </asp:DropDownList>                                                                                                
                            </div>                            
                        </div>
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block">Ghi chú</label>
                            <div class="col-sm-7">                                
                                <asp:TextBox ID="txtNote" CssClass="form-control" autocomplete="off" Height="100" TextMode="MultiLine" runat="server" style="max-height: 100px;"></asp:TextBox>                                                                
                            </div>                            
                        </div>                                                                                                                                                
                        <div class="box-body table-responsive" id="ntn-tb">
                            <asp:GridView ID="GridView_ListData" runat="server" AutoGenerateColumns="False" Width="100%" HeaderStyle-Height="30px"
                                BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" EnableModelValidation="True" 
                                CssClass="table table-bordered table-hover dataTable" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="ID" OnRowDataBound="GridView_ListData_OnRowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="STT">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="40px"/>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Hình ảnh">
                                        <ItemTemplate>
                                            <img src="<%# Eval("Image") %>" alt="<%# Eval("Name") %>" style="width: 100%; height: auto;" />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="80px"/>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Tên sản phẩm">
                                        <ItemTemplate>
                                            <a target="blank" title="<%# Eval("Name") %>" href="<%# Eval("ID") %>"><%# Eval("Name") %></a>                                                                                                            
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" />           
                                    </asp:TemplateField>                                                                                                
                        
                                    <asp:TemplateField HeaderText="Số lượng">
                                        <ItemTemplate>
                                            <%# Eval("Quantity") %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="120" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>                                                
                        
                                    <asp:TemplateField HeaderText="Giá bán (VNĐ)">
                                        <ItemTemplate>
                                            <%# Eval("Price","{0: 0,0}") %>                           
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="190" />
                                        <HeaderStyle HorizontalAlign="Center" />           
                                    </asp:TemplateField>
                        
                                    <asp:TemplateField HeaderText="Thành tiền (VNĐ)">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotal" CssClass="auto" data-a-sep="." data-a-dec="," aPad="false" runat="server"></asp:Label>                                
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="180" />
                                        <HeaderStyle HorizontalAlign="Center" />           
                                    </asp:TemplateField>                                                                                                                                                            
                                </Columns>
                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                <HeaderStyle BackColor="#f5f5f5" VerticalAlign="Middle" HorizontalAlign="Center" Font-Bold="True" ForeColor="#d60c0c" />
                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Center" />
                                <RowStyle ForeColor="#000066" />
                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                            </asp:GridView>     
                        </div><!-- /.box -->
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-10 right-block">Tổng thành tiền (VNĐ)</label>
                            <div class="col-sm-2 right-block">                                
                                <asp:Label ID="lblSumTotal" style="font-size: 20px; color: red;" CssClass="auto" data-a-sep="." data-a-dec="," aPad="false" runat="server"></asp:Label> vnđ                                                                
                            </div>                            
                        </div>                                                                   
                        <!-- tools box -->
                        <div class="form-group row-horizontal">
                            <label class="control-label col-sm-3 right-block"></label>
                            <div class="col-sm-9">                                                                
                                <asp:Button ID="btn_Update" CssClass="btn btn-primary btn-flat" runat="server" Text="Xác nhận" OnClick="btn_Update_OnClick" />
                                <a href="/Admin/orderproducts.aspx" class="btn btn-danger btn-flat" title="Quay lại">Quay lại</a>
                            </div>                                                                                                            
                        </div><!-- /. tools -->
                    </div>            
                </div>                                                
            </div>
        </div><!-- /.box -->                
    </div><!-- /.col-->
</div><!-- ./row -->
<script type="text/javascript" src="/Admin/Theme/js/autoNumeric/autoNumeric.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        // Call AutoNumeric Currency
        $('.auto').autoNumeric('init', { aPad: false });
    });
</script>