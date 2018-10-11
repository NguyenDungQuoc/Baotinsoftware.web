<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileAdmin.ascx.cs" Inherits="MyProfile.Admin.Modules.User.ProfileAdmin" %>
<%@ Import Namespace="System.EnterpriseServices.Internal" %>
<%@ Register Src="~/Controls/FileInput.ascx" TagName="FileInput" TagPrefix="sh" %>

<div class='row'>
    <div class='col-md-12'>
        <div class='box box-info'>
            <div class='box-header' style="padding-bottom: 0px;">
                <i class="fa fa-user"></i>
                <h3 class='box-title'>Thông tin tài khoản</h3>
                <!-- tools box -->
                <%--<div class="pull-right box-tools">           
                    <button class="btn btn-info btn-sm" data-widget='collapse' data-toggle="tooltip" title="Collapse"><i class="fa fa-minus"></i></button>
                    <button class="btn btn-info btn-sm" data-widget='remove' data-toggle="tooltip" title="Remove"><i class="fa fa-times"></i></button>
                </div>--%><!-- /. tools -->
            </div><!-- /.box-header -->
            <div class="box-body">
                <div class="row">
                    <div class="col-md-3 col-sm-4">                        
                        <div style="margin-top: 0px;">
                            <ul class="nav nav-pills nav-stacked">
                                <li class="header center-block no-padding-top">
                                    <img src="<%= getAvatar %>" alt="<%= txtFullname.Text %>" class="avatar-profile" />
                                </li>                                
                                <li><label>Ngày tạo : <%= getDate %></label></li>    
                                <li>
                                    <div class="form-group">
                                        <asp:TextBox ID="txtFullname" runat="server" placeholder="Họ & tên" autocomplete="off" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </li>                            
                                <li>
                                    <div class="form-group">
                                        <asp:TextBox ID="txtPassOld" runat="server" placeholder="Mật khẩu cũ" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-group">
                                        <asp:TextBox ID="txtPassword" runat="server" placeholder="Mật khẩu mới" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                    </div>    
                                </li>
                                <li>
                                    <div class="form-group">
                                        <asp:TextBox ID="txtNote" runat="server" placeholder="Note ..." autocomplete="off" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-group">
                                        <asp:TextBox ID="txtEmail" placeholder="Email" TextMode="Email" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </li>
                                <li>
                                    <div class="form-group sh-Input">
                                        <div class="input-group col-sm-12 validPath">
                                            <sh:FileInput runat="server" ID="fileUploadImage" FileType="Images" CssClass="form-control" placeholder="Đường dẫn file"/>
                                        </div>                                        
                                    </div>
                                </li>                                
                                <li>
                                    <div class="form-group">
                                        <asp:Button ID="btnCapNhat" runat="server" Text="Cập nhật" CssClass="btn btn-primary btn-flat" Font-Size="13px" Font-Names="Arial" OnClick="btnCapNhat_Click" OnClientClick="return myfunction();" />
                                        <br/>
                                        <asp:Label ID="lblShow" style="display: block; padding-top: 10px;" runat="server"></asp:Label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div><!-- /.col (LEFT) -->
                    <div class="col-md-9 col-sm-8">
                        <div class="row pad" style="padding-top:0px;">
                            <div class="col-sm-6 no-padding-left">
                                <span class="glyphicon glyphicon-bookmark"></span>
                                <h3 class='box-title' style="margin:0px; font-size:20px; display:inline-block;">Bài viết đã đăng</h3>
                            </div>
                            <div class="col-sm-6 search-form">
                                <form action="#" class="text-right">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtSearch" CssClass="form-control input-sm" placeholder="Search" runat="server"></asp:TextBox>
                                        <div class="input-group-btn">
                                            <button type="submit" name="q" class="btn btn-sm btn-primary"><i class="fa fa-search"></i></button>
                                        </div>
                                    </div>                                                     
                                </form>
                            </div>
                        </div><!-- /.row -->

                        <div class="table-responsive" id="ntn-tb">
                            <!-- THE MESSAGES -->                            
                            <asp:GridView ID="GridView_ListData" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" 
                                BorderWidth="1px" CellPadding="3" EnableModelValidation="True" Width="100%" HeaderStyle-Height="30px" OnPageIndexChanging="GridView_ListData_OnPageIndexChanging"
                                CssClass="table table-bordered" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="ID" AllowPaging="True" PageSize="12">
                                <Columns>
                                    <asp:TemplateField HeaderText="STT">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="40px"/>
                                    </asp:TemplateField>                                                                        
                                    
                                    <asp:TemplateField HeaderText="Tiêu đề">
                                        <ItemTemplate>
                                            <a target="blank" href="<%# "/article/" + Eval("Tag") + Eval("ID","-{0}.html") %>" title="<%# Eval("Title") %>"><%# Eval("Title") %></a>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>                                                                        

                                    <asp:BoundField HeaderText="Ngày đăng" DataField="Date" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ControlStyle-Width="100%" 
                                    ControlStyle-Height="30" ControlStyle-ForeColor="Black" ItemStyle-Font-Size="13px" ItemStyle-Width="100"/>
                                    
                                    <asp:BoundField HeaderText="Lượt xem" DataField="TotalView" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ControlStyle-Width="100%" 
                                    ControlStyle-Height="30" ControlStyle-ForeColor="Black" ItemStyle-Font-Size="13px" ItemStyle-Width="100"/>                                    

                                    <asp:TemplateField HeaderText="Trạng thái">
                                        <ItemTemplate>
                                            <%# getActivePost(Convert.ToBoolean(Eval("Active"))) %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="90px" />
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

<script type="text/javascript">
    function myfunction() {
        var f = $("#<%= txtFullname.ClientID %>");
        var o = $("#<%= txtPassOld.ClientID %>");
        var p = $("#<%= txtPassword.ClientID %>");
        if (f.val() == "") {            
            f.focus(); return false;
        }
        else if (o.val() == "" && p.val() != "") {
            o.focus();
            return false;
        }
        else if (o.val() != "" && p.val() == "") {
            p.focus();
            return false;
        }
        else {
            return confirm('Bạn thực sự muốn cập nhật?');
        }
    }
</script>