<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BannerWowSlider.ascx.cs" Inherits="MyProfile.Modules.Banners.BannerWowSlider" %>
<%@ Import Namespace="MyProfile.Services.Web.Images" %>
<section id="slider" class="margin-bottom-30"><!--slider-->
    <div id="wowslider-container1">
	    <div class="ws_images">            
            <asp:Repeater ID="rptBannerSlider" runat="server">
                <HeaderTemplate><ul></HeaderTemplate>
                <ItemTemplate>
                    <li>
                        <img src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>" title="<%# Eval("Title") %>" id="wows1_<%# Eval("ID") %>"/>
                    </li>
                </ItemTemplate>
                <FooterTemplate></ul></FooterTemplate>
            </asp:Repeater>	        
	    </div>
	    <div class="ws_bullets">
            <asp:Repeater ID="rptBannerNavigation" runat="server">
                <HeaderTemplate><div></HeaderTemplate>
                <ItemTemplate>
                    <a href="#" title="<%# Eval("Title") %>">
                        <span>
                            <%# PathImage.Inst.GetImageTag(Eval("Image"), 124, 48, Eval("Title"), "") %><%# Eval("Position") %>
                        </span>
                    </a>
                </ItemTemplate>
                <FooterTemplate></div></FooterTemplate>
            </asp:Repeater>            
	    </div>
        <%--<div class="ws_script" style="position:absolute;left:-99%">
            <a href="http://wowslider.com">slider bootstrap</a> by WOWSlider.com v7.6
        </div>--%>
	    <div class="ws_shadow"></div>
    </div>
</section>
<link href="/Theme/js/wowslider/wow-css.css" rel="stylesheet" />
<script src="/Theme/js/wowslider/wowslider.js" type="text/javascript"></script>
<script src="/Theme/js/wowslider/wow-script.js" type="text/javascript"></script>