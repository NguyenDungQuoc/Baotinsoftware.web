<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Gallery.ascx.cs" Inherits="MyProfile.Modules.Gallery" %>

<!-- Works container -->
<div class="container work">
    <h2>My Gallery</h2>
    <asp:Repeater ID="rpt_Gallery" runat="server">
        <HeaderTemplate><ul class="work-images"></HeaderTemplate>
        <ItemTemplate>
            <li>
                <div>
                    <a class="fancybox-thumb" rel="fancybox-thumb" href="<%# Eval("Href") %>" title="<%# Eval("Title") %>">
                        <img src="<%# GetTagFullImage(Eval("Href").ToString(),250,250) %>" alt="<%# Eval("Title") %>" />                        
                    </a>
                </div>
            </li>
        </ItemTemplate>
        <FooterTemplate></ul></FooterTemplate>
    </asp:Repeater>
</div>
<!--END: Work container-->

<!-- Add fancyBox main JS and CSS files -->
<%--<script type="text/javascript" src="/Theme/js/jquery.fancybox.js"></script>
<link href="/Theme/css/jquery.fancybox.css" rel="stylesheet" />
<script type="text/javascript" src="/Theme/javascript/js_call_fancybox.js"></script>--%>