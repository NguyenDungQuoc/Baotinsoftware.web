<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GroupProducts.ascx.cs" Inherits="MyProfile.Modules.Products.GroupProducts" %>
<%@ Import Namespace="MyProfile.Class" %>
<%@ Register Src="~/Modules/News_Blogs/ListNewsjCarouselLite.ascx" TagPrefix="uc1" TagName="ListNewsjCarouselLite" %>

<div class="col-sm-3">
	<div class="left-sidebar">
		<h2>Danh mục</h2>
		<div class="panel-group category-products" id="accordian"><!--category-products-->            
            <asp:Repeater ID="rpt_Categories" runat="server" OnItemDataBound="rpt_Categories_OnItemDataBound">
                <HeaderTemplate><ul class="list-cat"></HeaderTemplate>
                <ItemTemplate>
                    <li class="<%# Get_Plus_Right(Convert.ToInt32(Eval("ID"))) %>">
				        <i class="fa fa-angle-right"></i><a href="<%# Eval("Tag","/san-pham/{0}") + Eval("ID","-{0}.html") %>"><%# Eval("Name") %></a>
                        <asp:Repeater ID="rpt_ChildCategories" runat="server">
                            <HeaderTemplate><ul class="child-list-cat"></HeaderTemplate>
                            <ItemTemplate>
                                <li>
                                    <a href="<%# Eval("Tag","/san-pham/{0}") + Eval("ID","-{0}.html") %>">→ <%# Eval("Name") %></a>
                                </li>
                            </ItemTemplate>
                            <FooterTemplate></ul></FooterTemplate>                                                            
                        </asp:Repeater>
                        <%--<asp:Repeater ID="rptChildProductByCategory" runat="server">
                            <HeaderTemplate><ul class="child-list-cat"></HeaderTemplate>
                            <ItemTemplate>
                                <li>
                                    <a href="<%# "/san-pham/" + p.Get_Url_Category(Convert.ToInt32(Eval("ID_GroupProduct"))) + Eval("Tag","/{0}") + Eval("ID","-{0}.html") %>">
                                        <i class="fa fa-angle-double-right"></i> <%# Eval("Name") %>
                                    </a>
                                </li>
                            </ItemTemplate>
                            <FooterTemplate></ul></FooterTemplate>
                        </asp:Repeater>--%>                        				        
			        </li>                                        				    					                    				                                            
                </ItemTemplate>
                <FooterTemplate></ul></FooterTemplate>
            </asp:Repeater>										                                        			
		</div><!--/category-products-->					
		<%--<div class="brands_products hide-item"><!--brands_products-->
			<h2>Loại hàng</h2>
			<div class="brands-name">
			    <asp:Repeater runat="server" ID="rpt_ListProductOfTypes">
			        <HeaderTemplate><ul class="nav nav-pills nav-stacked"></HeaderTemplate>
                    <ItemTemplate>
                        <li>
                            <a href="<%# Eval("Tag","/the-loai/{0}") + Eval("ID_Type","-{0}.html") %>">
                                <span class="pull-right"><%# Get_Count_Product_TypeID(Convert.ToInt32(Eval("ID_Type"))) %></span><%# Eval("Name") %>
                            </a>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate></ul></FooterTemplate>
			    </asp:Repeater>				
			</div>
		</div><!--/brands_products-->--%>                
        <uc1:ListNewsjCarouselLite runat="server" id="ListNewsjCarouselLite" />
        <%--<div class="brands_products margin-bottom-30"><!--brands_products-->
			<h2>Thống kê lượt xem</h2>
			<div class="brands-name">
                <!-- Histats.com  (div with counter) --><div id="histats_counter" class="text-center"></div>
                <!-- Histats.com  START  (aync)-->
                <script type="text/javascript">var _Hasync= _Hasync|| [];
                _Hasync.push(['Histats.start', '1,3566057,4,438,112,75,00011111']);
                _Hasync.push(['Histats.fasi', '1']);
                _Hasync.push(['Histats.track_hits', '']);
                (function() {
                var hs = document.createElement('script'); hs.type = 'text/javascript'; hs.async = true;
                hs.src = ('//s10.histats.com/js15_as.js');
                (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(hs);
                })();</script>
                <noscript><a href="/" target="_blank"><img  src="//sstatic1.histats.com/0.gif?3566057&101" alt="" border="0"></a></noscript>
                <!-- Histats.com  END  -->
			</div>
        </div>--%>
	    <div class="brands_products margin-bottom-30"><!--brands_products-->
	        <h2 style="margin-bottom: 15px;">Từ khóa</h2>
	        <asp:Repeater runat="server" ID="rptListHashtag">
	            <HeaderTemplate><ul class="list-hashtag"></HeaderTemplate>
	            <ItemTemplate>
	                <li>
	                    <a href="<%# Eval("UrlFormat") %>" title="<%# Eval("HashtagName") %>">
	                        <span>×</span><%# Eval("HashtagName") %>
	                    </a>
	                </li>
	            </ItemTemplate>
	            <FooterTemplate></ul></FooterTemplate>
	        </asp:Repeater>
	    </div>
		<%--<div class="shipping text-center"><!--shipping-->
            <a href="#">
                <img src="/Upload/images/Products/shipping.jpg" alt="" />
            </a>			
		</div><!--/shipping-->        
        <div class="shipping text-center"><!--shipping-->
            <a href="#">
                <img src="/Upload/images/Products/shipping.jpg" alt="" />
            </a>			
		</div><!--/shipping-->--%>					
	</div>
</div>
<script type="text/javascript">
    (function ($) {
        $('.lv2 > a').click(function(e) {
            e.preventDefault();
            el = $(this);
            if (!el.hasClass('on')) {
                $('.on').removeClass('on').next().stop(false, true).slideUp(400);
                el.addClass('on').next().stop(false, true).slideDown(400);
            } else {
                $('.on').removeClass('on').next().stop(false, true).slideUp(400);
            }
        });
    })(jQuery);
</script>