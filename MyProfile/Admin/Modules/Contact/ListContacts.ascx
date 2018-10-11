<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListContacts.ascx.cs" Inherits="MyProfile.Admin.Modules.Contact.ListContacts" %>

<div class="row">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header no-padding-bottom">
                <h3 class="box-title">Quản lý hộp thư từ khách hàng</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">                    
                    <button id="btnDel" class="btn btn-danger btn-flat">
						<i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
						Delete
					</button>                                        
                </div><!-- /. tools -->
            </div><!-- /.box-header -->
            <div class="box-body table-responsive" id="ntn-tb">
                <asp:GridView ID="GridView_ListData" runat="server" AutoGenerateColumns="False" Width="100%" HeaderStyle-Height="30px" OnRowCommand="GridView_ListData_OnRowCommand"
                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" EnableModelValidation="True" 
                    CssClass="table table-bordered table-hover dataTable" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="ID">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="40px"/>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Người gửi">
                            <ItemTemplate>
                                <%# Eval("Name") %>                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="150" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>                                                

                        <asp:BoundField HeaderText="Nội dung" DataField="Content" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" ControlStyle-Width="100%" ControlStyle-Height="30" />                        
                        
                        <asp:TemplateField HeaderText="Điện thoại">
                            <ItemTemplate>
                                <%# Eval("Phone") %>                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="120" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <%# Eval("Email") %>                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="140" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Ngày gửi">
                            <ItemTemplate>
                                <%# Eval("Date","{0:dd/MM/yyyy}") %>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="90" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Trạng thái">
                            <ItemTemplate>                                
                                <asp:LinkButton ID="LinkButtonStatus" CommandArgument='<%# Eval("ID") %>' CommandName="Status" runat="server">
                                    <%# GET_ISACTIVE(Convert.ToInt32(Eval("Status"))) %>
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
            </div>
        </div><!-- /.box -->                
    </div><!-- /.col-->
</div><!-- ./row -->
<script src="/Theme/javascript/js_adminContact.js" type="text/javascript"></script>
