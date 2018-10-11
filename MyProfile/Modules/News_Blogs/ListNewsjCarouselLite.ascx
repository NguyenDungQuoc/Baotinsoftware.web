<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListNewsjCarouselLite.ascx.cs" Inherits="MyProfile.Modules.News_Blogs.ListNewsjCarouselLite" %>

<div class="brands_products"><!--brands_news-->
    <h2>Tin tức & Sự kiện</h2>
    <div class="jCarouselLite">
        <asp:Repeater ID="rptListNews" runat="server">
            <HeaderTemplate><ul class="owl-carousel owl-theme"></HeaderTemplate>
            <ItemTemplate>
                <li class="item" style="padding-left:0;">                            
                    <a href="<%# Eval("UrlFormat") %>">
                        <img src="<%# Eval("Avatar") %>" alt="<%# Eval("Title") %>">
                    </a>
                    <h4><a href="<%# Eval("UrlFormat") %>"><%# Eval("Title") %></a></h4>
                </li>
            </ItemTemplate>
            <FooterTemplate></ul></FooterTemplate>
        </asp:Repeater>        
    </div>
</div><!--/brands_news-->
<%--<script src="/Theme/js/jcarousellite/jquery.jcarousellite.min.js" type="text/javascript"></script>
<script type="text/javascript">    
    $(".jCarouselLite").jCarouselLite({        
        vertical: true, // chạy theo chiều dọc
        hoverPause: true,// Hover vào nó sẽ dừng lại
        visible: 7, // Số bài viết cần hiện
        auto: 500,  // Tự động scroll
        mouseWheel: true,
        speed: 2000
    });
</script>--%>