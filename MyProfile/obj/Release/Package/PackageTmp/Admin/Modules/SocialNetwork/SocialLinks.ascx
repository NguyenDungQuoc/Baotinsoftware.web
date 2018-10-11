 <%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SocialLinks.ascx.cs" Inherits="MyProfile.Admin.Modules.SocialNetwork.SocialLinks" %> <%@ Import Namespace="MyProfile.Class" %>

<div class='row'>
    <div class='col-md-12'>
        <div class='box box-info'>
            <div class='box-header no-padding-bottom'>
                <h3 class='box-title'>Quản lý đường dẫn mạng xã hội - Fanpage</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">                    
                    <%--<button id="btnDel" class="btn btn-danger btn-flat">
						<i class="ace-icon fa fa-trash-o bigger-120 orange"></i>
						Delete
					</button>--%>                                        
                </div><!-- /. tools -->
            </div><!-- /.box-header -->

            <div class="box-body table-responsive" id="ntn-tb">
                <!-- THE MESSAGES -->                            
                <asp:GridView ID="GridView_ListData" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" 
                    BorderWidth="1px" CellPadding="3" EnableModelValidation="True" Width="100%" HeaderStyle-Height="30px" OnRowCommand="GridView_ListData_OnRowCommand" 
                    CssClass="table table-bordered table-hover dataTable" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="ID" OnRowEditing="GridView_ListData_OnRowEditing">
                    <Columns>
                        <asp:TemplateField HeaderText="STT">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="40px"/>
                        </asp:TemplateField>                                                                                                                                    
                        
                        <asp:TemplateField HeaderText="Tên mạng xã hội">
                            <ItemTemplate>
                                <%# Eval("Name") %>                                
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" Width="280" ForeColor="#3C8DBC" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField> 
                        
                        <asp:TemplateField HeaderText="Icon">
                            <ItemTemplate>
                                <i class="<%# Eval("Description") %>"></i>                                                                
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtIcon" runat="server" Text='<%# Eval("Description") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="60" Font-Size="15px" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>                                                                        
                                                  
                        <asp:BoundField HeaderText="Đường dẫn - Fanpage" DataField="Href" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center" ControlStyle-Width="100%" 
                        ControlStyle-Height="30" ControlStyle-ForeColor="Black" ItemStyle-Font-Size="13px"/>                                                                     

                        <asp:TemplateField HeaderText="Trạng thái">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButtonStatus" CommandArgument='<%# Eval("ID") %>' CommandName="IsActive" runat="server">
                                    <%# Utility.GetLabelIsActive(Convert.ToBoolean(Eval("Active")),"Ẩn","Hiện") %>
                                </asp:LinkButton>                                            
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="80" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>                                                                                                                                                
                                    
                        <asp:TemplateField HeaderText="Sửa">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButtonEdit" CommandName="Edit" ToolTip="Chỉnh sửa" runat="server"><i class="fa fa-pencil font-16"></i></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="Update" OnClick="Update_OnClick" OnClientClick="return validInsertRecord(1);" CommandArgument='<%# Eval("ID") %>' ToolTip="Cập nhật" runat="server"><span class="glyphicon glyphicon-refresh font-16"></span></asp:LinkButton>
                                <asp:LinkButton ID="Cancel" OnClick="Cancel_OnClick" ToolTip="Hủy bỏ" runat="server"><span class="glyphicon glyphicon-remove font-16 red"></span></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="65px" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                                    
                        <asp:TemplateField HeaderText="Xóa">
                            <ItemTemplate>                                            
                                <a id="delRecord" class="delRecord" href="<%# Eval("ID") %>">
                                    <span class="glyphicon glyphicon-remove-circle red font-16" title="Xóa"></span>
                                </a>                                            
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="55px" />
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
        </div><!-- /.box -->                
    </div><!-- /.col-->
</div><!-- ./row -->
<script type="text/javascript" src="/Theme/javascript/js_adminSocialNetworks.js"></script>
<script type="text/javascript" src="/Theme/javascript/js_validate.js"></script>