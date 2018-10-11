<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WucListCommentByType.ascx.cs" Inherits="MyProfile.Modules.Comment.WucListCommentByType" %>
<%@ Import Namespace="MyProfile.Class" %>
<div class="response-area">
    <h4 class="no-margin-top" style="<%= rptListComment.Items.Count == 0 ? "display:none" : "" %>">Phản hồi về sản phẩm</h4>
    <asp:Repeater runat="server" ID="rptListComment" OnItemDataBound="rptListComment_OnItemDataBound">
        <HeaderTemplate>
            <ul class="media-list">
        </HeaderTemplate>
        <ItemTemplate>
            <li class="media">
                <a class="pull-left" href="#" onclick="return false;">
                    <span style="<%# "background-image: url({0})".Frmat(Eval("Avatar")) %>"></span>
                </a>
                <div class="media-body">
                    <ul class="sinlge-post-meta">
                        <li><i class="fa fa-user"></i><%# Eval("Name") %></li>
                        <li><i class="fa fa-clock-o"></i><%# Eval("DateCreated","{0:HH:mm:ss}") %></li>
                        <li><i class="fa fa-calendar"></i><%# Eval("DateCreated","{0:dd/MM/yyyy}") %></li>
                    </ul>
                    <p>
                        <%# Eval("Content") %>
                    </p>
                    <%# ImageExtension.GetImageAttachComment(Eval("AttachFile")) %>
                    <%--<a class="btn btn-primary" href="#"><i class="fa fa-reply"></i>Replay</a>--%>
                </div>
            </li>
            <asp:Repeater runat="server" ID="rptListSubComment">
                <ItemTemplate>
                    <li class="media second-media">
                        <a class="pull-left" href="#" onclick="return false;">
                            <span style="<%# "background-image: url({0})".Frmat(Eval("Avatar")) %>"></span>
                        </a>
                        <div class="media-body">
                            <ul class="sinlge-post-meta">
                                <li><i class="fa fa-user"></i><%# Eval("Name") %></li>
                                <li><i class="fa fa-clock-o"></i><%# Eval("DateCreated","{0:HH:mm:ss}") %></li>
                                <li><i class="fa fa-calendar"></i><%# Eval("DateCreated","{0:dd/MM/yyyy}") %></li>
                            </ul>
                            <p>
                                <%# Eval("Content") %>
                            </p>
                            <%# ImageExtension.GetImageAttachComment(Eval("AttachFile")) %>
                            <%--<a class="btn btn-primary" href="#"><i class="fa fa-reply"></i>Replay</a>--%>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ItemTemplate>
        <FooterTemplate></ul></FooterTemplate>
    </asp:Repeater>
</div><!--/Response-area-->