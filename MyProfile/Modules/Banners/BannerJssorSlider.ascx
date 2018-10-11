<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BannerJssorSlider.ascx.cs" Inherits="MyProfile.Modules.Banners.BannerJssorSlider" %>

<section id="home" class="text-center">
    <div id="slider1_container">
    <!-- Loading Screen -->
    <div u="loading" class="slider-loading">
        <div class="loading1">
        </div>
        <div class="loading2">
        </div>
    </div>
    <!-- Slides Container -->
    <asp:Repeater runat="server" ID="rpt_SlideJssor">
        <HeaderTemplate><div u="slides" class="slides-container"></HeaderTemplate>
        <ItemTemplate>            
            <div class="slides-items">
                <img u="image" src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>" />                
                <div class="header-caption">
                    <%# Eval("Title") %>
                </div>
                <div class="text-caption">
                    <%# Eval("Href") %>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate></div></FooterTemplate>
    </asp:Repeater>
                                
    <!-- bullet navigator container -->
    <div u="navigator" class="jssorb21" style="top: 460px; right: 6px;">            
        <div u="prototype"></div>
    </div>                
    <!-- Arrow Left -->
    <span u="arrowleft" class="jssora21l" style="top: 123px; left: 8px;">
    </span>
    <!-- Arrow Right -->
    <span u="arrowright" class="jssora21r" style="top: 123px; right: 8px;">
    </span>
    <!--#endregion Arrow Navigator Skin End -->
</div>
<!-- Jssor Slider End -->
</section>

<!-- CSS -->
<link href="/Theme/js/jssorSlider/jssor-style.css" rel="stylesheet" />
<!-- JS -->
<script src="/Theme/js/jssorSlider/jssor.js" type="text/javascript"></script>
<script src="/Theme/js/jssorSlider/jssor.slider.js" type="text/javascript"></script>
<script src="/Theme/js/jssorSlider/calljssor.js" type="text/javascript"></script>
