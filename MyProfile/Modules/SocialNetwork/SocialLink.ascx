<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SocialLink.ascx.cs" Inherits="MyProfile.Modules.SocialNetwork.SocialLink" %>

<asp:Repeater ID="rpt_SocialNetworks" runat="server">
    <HeaderTemplate><ul class="nav navbar-nav"></HeaderTemplate>
    <ItemTemplate>
        <li>
            <a target="blank" title="<%# Eval("Name") %>" href="<%# Eval("Href") %>">
                <i class="<%# Eval("Description") %>"></i>
            </a>
        </li>
    </ItemTemplate>
    <FooterTemplate></ul></FooterTemplate>
</asp:Repeater>