<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LinkWebsites.ascx.cs" Inherits="MyProfile.Modules.Links.LinkWebsites" %>

<div class="single-widget">
	<h2>Liên kết</h2>
    <asp:Repeater runat="server" ID="rpt_ListLinkWebsite">
        <HeaderTemplate><ul class="nav nav-pills nav-stacked"></HeaderTemplate>
        <ItemTemplate>
            <li><a target="blank" href="<%# Eval("Href") %>"><%# Eval("Name") %></a></li>
        </ItemTemplate>
        <FooterTemplate></ul></FooterTemplate>
    </asp:Repeater>
</div><!--end link websites-->