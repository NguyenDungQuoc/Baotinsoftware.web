<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WucCommentManagement.ascx.cs" Inherits="MyProfile.Admin.Modules.Comment.WucCommentManagement" %>
<%@ Register Src="~/Controls/ImagesInput.ascx" TagPrefix="sh" TagName="ImagesInput" %>

<%@ Import Namespace="MyProfile.Class" %>
<style type="text/css">
    #ntn-tb table tbody tr td.td-content{ vertical-align: top !important;}
    /*---Comment---*/
    .cmt-avt > strong{
        display: block; color: #000;
    }
    .cmt-avt > a {
        width: 65px;
        height: 65px;
        background-size: cover;
        display: inline-block;
        font-size: 0;
        background-position: center center;
        background-repeat: no-repeat;
    }
    .cmt-avt > p{
        font-style: italic;
        margin-bottom: 0;
    }
    .cmt-content {
        overflow: hidden;
        padding-bottom: 5px;
        border-bottom: 1px solid #ddd;
    }
    .cmt-meta {
        font-size: 12px;
        margin: 0; padding: 5px 0 0 0;
        list-style: none;
        width: 100%;
    }
    .cmt-meta > li {
        padding-right: 10px;
        display: inline-block;
        float: left;
    }
    .cmt-meta > li:last-child {
        padding-right: 0;
        float: right;
    }
    .cmt-meta > li > span {
        color: #7f7f7f;
    }
    .list-img-comment {
        width: 100%;
        overflow: hidden;
        padding-top: 10px;
    }
    .list-img-comment > a{
        width: 40px; 
        height: 40px; 
        background-size: cover; 
        display: inline-block; 
        margin-right: 5px;
        overflow: hidden;
        background-color: #cecece;
        font-size: 0;
    }
    .cmt-reply { color: #ff0074;}
</style>
<div class="row">
    <div class="col-md-12">
        <div class="box box-info">
            <div class="box-header no-padding-bottom">
                <h3 class="box-title">Quản lý Bình Luận</h3>
                <!-- tools box -->
                <div class="pull-right box-tools">                    
                    <button id="btnClick" type="button" data-toggle="modal" data-target="#compose-modal" class="btn btn-primary btn-flat">Thêm mới</button>                                        
                </div><!-- /. tools -->
            </div><!-- /.box-header -->
            <div class="box-body table-responsive" id="ntn-tb">
                <!-- THE MESSAGES -->                            
                <asp:GridView ID="GridViewListData" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" 
                    BorderWidth="1px" CellPadding="3" EnableModelValidation="True" Width="100%" HeaderStyle-Height="30px" OnRowCommand="GridViewListData_OnRowCommand" 
                    CssClass="table table-bordered table-hover dataTable" Font-Names="Arial" Font-Size="13px" ForeColor="#000" DataKeyNames="CommentId">
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
                                <div class="cmt-avt <%# "0".Equals(Eval("ParentId").ToString()) ? "" : "hide-row" %>" >
                                    <a href="#<%# Eval("CommentId") %>" style="<%# "background-image: url({0})".Frmat(Eval("Avatar")) %>"></a>
                                    <strong><%# Eval("Name") %></strong>
                                    <p><%# Eval("Email") %></p>
                                </div>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="180" ForeColor="#3C8DBC" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField> 
                        
                        <asp:TemplateField HeaderText="Nội dung">
                            <ItemTemplate>
                                <div class="cmt-content">
                                    <span class="<%# "0".Equals(Eval("ParentId").ToString()) ? "hide-row" : "" %>" style="font-style: italic; color: red;">@Bảo Tín Software :</span>
                                    <%# Eval("Content") %>
                                    <%# ImageExtension.GetImageAttachComment(Eval("AttachFile")) %>
                                </div>
                                <ul class="cmt-meta">
                                    <li>
                                        <span><i class="fa fa-clock-o"></i> <%# Eval("DateCreated","{0:dd/MM/yyyy HH:mm:ss}") %></span>
                                    </li>
                                    <li>
                                        <a target="_blank" href="<%# Eval("ProductUrl") %>"><i class="fa fa-link"></i> <%# Eval("ProductName") %></a>
                                    </li>
                                    <li class="<%# "0".Equals(Eval("ParentId").ToString()) ? "" : "hide-row" %>">
                                        <a href="<%# "{0}-{1}".Frmat(Eval("CommentId"),Eval("ProductId")) %>" id="btnReply" class="cmt-reply" title="Trả lời">Reply</a>
                                    </li>
                                </ul>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" CssClass="td-content" />
                            <HeaderStyle HorizontalAlign="Center" />           
                        </asp:TemplateField>                                                                                                                                                                                                                   

                        <asp:TemplateField HeaderText="Trạng thái">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkBtnStatus" CommandArgument='<%# Eval("CommentId") %>' CommandName="IsActive" runat="server">
                                    <%# Utility.GetLabelIsActive(Convert.ToBoolean(Eval("IsActive")), "Ẩn", "Hiện") %>
                                </asp:LinkButton>                                            
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="80" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>                                                                                                                                                                                                            
                                    
                        <asp:TemplateField HeaderText="Xóa">
                            <ItemTemplate>                                            
                                <asp:LinkButton runat="server" ID="lnkBtnDelete" CommandArgument='<%# Eval("CommentId") %>' CommandName="IsDelete" 
                                    OnClientClick="return confirm('Are you sure you want delete this record?')">
                                    <span class="glyphicon glyphicon-remove-circle red font-16" title="Xóa"></span>
                                </asp:LinkButton>
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
<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 style="font-family:Segoe UI,Arial,sans-serif;" class="modal-title"><i class="fa fa-wrench"></i> Thông tin Hồi đáp</h4>
        </div>
        <form action="#" method="post">
            <div class="modal-body">
                <div class="form-group row-horizontal">                    
                    <label class="col-sm-3 control-label">Nội dung *</label>
                    <div class="col-sm-9">
                        <asp:TextBox runat="server" ID="TxtReplyContent" CssClass="form-control" TextMode="MultiLine" Rows="6" 
                            MaxLength="255" autocomplete="off" style="overflow-x: hidden; max-width: 100%;"></asp:TextBox>
                    </div>
                </div>                                
                <div class="form-group row-horizontal no-margin-bottom">
                    <label class="col-sm-3 control-label">Ảnh <i style="font-size: 12px; color: red;">(Tối đa 3 ảnh)</i></label>
                    <div class="col-sm-9 sh-Input">
                        <div class="input-group col-sm-12">
                            <sh:ImagesInput runat="server" ID="ImagesInputFile" />
                        </div>                                                                        
                    </div>
                </div>                
            </div>
            <div class="modal-footer clearfix no-margin-top">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
                <button id="btnAccept" type="button" class="btn btn-primary pull-left" title="Xác nhận" name="btnAccept"><i class="fa fa-floppy-o"></i> Xác nhận</button>
            </div>
        </form>
    </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script src="/Theme/javascript/js_adminComment.js" type="text/javascript"></script>
