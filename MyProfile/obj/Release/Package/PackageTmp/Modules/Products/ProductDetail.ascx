<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductDetail.ascx.cs" Inherits="MyProfile.Modules.Products.ProductDetail" %>
<%@ Import Namespace="MyProfile.Services.Web.Images" %>
<%@ Import Namespace="MyProfile.Class" %>

<h2 class="title text-center">
    Sản phẩm chi tiết	    
</h2>
<div class="product-details"><!--product-details-->
    <asp:Repeater ID="rpt_ProductDetail" runat="server" OnItemDataBound="rpt_ProductDetail_ItemDataBound">
        <ItemTemplate>
            <div class="col-sm-5">
		        <div class="view-product">
                    <a class="fancybox-thumb" rel="fancybox-thumb" href="<%# Eval("Avatar") %>" title="<%# Eval("ProductName") %>">
                        <img src="<%# Eval("Avatar") %>" alt="<%# Eval("ProductName") %>" title="<%# Eval("ProductName") %>" />
                    </a>			        
			        <h3>ZOOM</h3>
		        </div>
		        <div id="similar-product" class="carousel slide" data-ride="carousel">								
			        <!-- Wrapper for slides -->
			        <div class="carousel-inner <%= DataCountImage == 0 ? "hide-item" : "" %>">
                        <asp:Repeater runat="server" ID="rpData" OnItemDataBound="rpData_ItemDataBound">
                            <ItemTemplate>
                                <div class="item <%# Container.ItemIndex == 0 ? "active" : "" %>">
                                    <asp:Repeater runat="server" ID="rpItem">
                                        <ItemTemplate>
                                            <a class="fancybox-thumb" rel="fancybox-thumb" title="<%# Eval("Note") %>" href="<%# Eval("Path") %>" style="display:inline-block;">
                                                <%# PathImage.Inst.GetImageTag(Eval("Path"), 100, 100, Eval("Note")) %>
                                            </a>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>										
			        </div>

			        <!-- Controls -->
			        <a class="left item-control" href="#similar-product" data-slide="prev">
			        <i class="fa fa-angle-left"></i>
			        </a>
			        <a class="right item-control" href="#similar-product" data-slide="next">
				        <i class="fa fa-angle-right"></i>
			        </a>
		        </div>
	        </div>
	        <div class="col-sm-7">
		        <div class="product-information"><!--/product-information-->			
			        <h2><%# Eval("ProductName") %></h2>
			        <p><b>Mã sản phẩm :</b> <%# Eval("ProductCode") %></p>
			        <p class="hide-item">
				        <b>Giá bán :</b> 
                        <span class="price-tag" pricetag="<%# Eval("Price") %>" style="<%# Eval("PriceOld") != null && "0".Equals(Eval("PriceOld").ToString()) ? "" : "text-decoration: line-through;" %>">
                            <%# Eval("Price") != null && "0".Equals(Eval("Price").ToString()) ? "Liên hệ" : Eval("Price","{0: 0,0}đ") %>
                        </span>				        				        
			        </p>
                    <p <%# Eval("PriceOld") != null && "0".Equals(Eval("PriceOld").ToString()) ? "class='hide-item'" : "" %>>
                        <b>Giá ưu đãi :</b> 
                        <span class="price-discount" pricetag="<%# Eval("PriceOld") %>">
                            <%# Eval("PriceOld") != null && "0".Equals(Eval("PriceOld").ToString()) ? "Liên hệ" : Eval("PriceOld","{0: 0,0}đ") %>
                        </span>
                    </p>
			        <p><b>Thể loại :</b> <a href="<%# Eval("CategoryUrl") %>"><%# Eval("ProductCategoryName") %></a></p>			        
                    <p><b>Lượt xem :</b> <%# Eval("CountView") %> Đã xem</p>
                    <p class="hidden"><b>Lượt mua :</b> <%# Eval("CountBuy") %> Người đã mua sản phẩm</p>
			        <p><b>Trạng thái :</b> <%# Eval("Status") %></p>
                    <p class="chk-color <%= DataCountColor == 0 ? "hide-item" : "" %>">
                        <b>Màu sắc :</b>
                        <asp:Repeater ID="rpt_ListColorOfProduct" runat="server">
                            <ItemTemplate>
                               <span title="<%# Eval("Note") %>" pricetag="<%# Eval("Price") == null ? "0" : Eval("Price") %>" style="background-color:<%# Eval("Hex") %>"></span>
                            </ItemTemplate>
                        </asp:Repeater>
                    </p>
                    <p class="chk-size <%= DataCountSize == 0 ? "hide-item" : "" %>"><b>Size :</b>
                        <asp:Repeater ID="rpt_ListSizeOfProduct" runat="server">
                            <ItemTemplate>                                                                
                                <label><input type="radio" name="Size" value="<%# Eval("SizeId") %>" title="<%# Eval("Note") %>" pricetag="<%# Eval("Price") %>" /><%# Eval("Name") %></label>
                            </ItemTemplate>
                        </asp:Repeater>
                    </p>
                    <p class="hide-item">
                        <b>Số lượng</b>
				        <%--<asp:TextBox ID="txt_Quantity" CssClass="input-quantity" runat="server" MaxLength="2" TextMode="Number" Text="1"></asp:TextBox>--%>
                        <input type="number" id="txtQuantity" class="input-quantity product-quantity" name="quantity" min="1" max="9" value="1" maxlength="1" oninput="maxLengthCheck(this)" />                                                
                        <button type="button" class="btn btn-fefault cart">
							<i class="fa fa-shopping-cart"></i>
							Đặt mua
						</button>                        
                    </p>
                    <p>
                        <a href="<%= MyConstant.ContactUrl %>" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Liên hệ đặt hàng</a>
                    </p>                         
                    <!-- Go to www.addthis.com/dashboard to customize your tools -->                    
                    <div class="addthis_sharing_toolbox"></div>			        
		        </div><!--/product-information-->
	        </div>
        </ItemTemplate>
    </asp:Repeater>	
</div><!--/product-details-->

<div class="category-tab shop-details-tab"><!--category-tab-->
    <div class="col-sm-12">
	    <ul class="nav nav-tabs">
		    <li class="active"><a href="#details" data-toggle="tab">Thông tin chi tiết</a></li>
		    <li><a href="#companyprofile" data-toggle="tab">Sản phẩm cùng loại</a></li>		    
		    <li><a href="#reviews" data-toggle="tab">Bình luận</a></li>
	    </ul>
    </div>
    <div class="tab-content">
	    <div class="tab-pane fade active in" id="details" >
		    <div class="product-content article-detail">
                <asp:Literal ID="ltr_Content" runat="server"></asp:Literal>
		    </div>			    
	    </div>
							
	    <div class="tab-pane fade" id="companyprofile" >
            <asp:Repeater ID="rpt_ListProductSimilar" runat="server">
                <ItemTemplate>
                    <div class="col-sm-3">
			            <div class="product-image-wrapper">
				            <div class="single-products">
					            <div class="productinfo text-center">
                                    <a href="<%# Eval("UrlFormat") %>" title="<%# Eval("ProductName") %>">
						                <img src="<%# Eval("Avatar") %>" alt="<%# Eval("ProductName") %>" />
                                    </a>
						            <h2 class="hide-item">
						                <%# Eval("Price") != null && "0".Equals(Eval("Price").ToString()) ? "Liên hệ" : Eval("Price","{0: 0,0} đ") %>
						            </h2>
						            <p class="p-price">
                                        <a href="<%# Eval("UrlFormat") %>" title="<%# Eval("ProductName") %>">
                                            <%# Eval("ProductName") %>
                                        </a>
                                    </p>
						            <button type="button" class="btn btn-default add-to-cart hide-item"><i class="fa fa-shopping-cart"></i>Liên hệ đặt hàng</button>
                                    <a href="<%= MyConstant.ContactUrl %>" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Liên hệ đặt hàng</a>
					            </div>
				            </div>
			            </div>
		            </div>
                </ItemTemplate>
            </asp:Repeater>		    
	    </div>								    
							
	    <div class="tab-pane fade" id="reviews" >
		    <div class="col-sm-12">
			    <%--<ul>
				    <li><a href=""><i class="fa fa-user"></i>EUGEN</a></li>
				    <li><a href=""><i class="fa fa-clock-o"></i>12:41 PM</a></li>
				    <li><a href=""><i class="fa fa-calendar-o"></i>31 DEC 2014</a></li>
			    </ul>
			    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
			    <p><b>Write Your Review</b></p>
									
			    <div class="form-reviews">
				    <span>
					    <input type="text" placeholder="Your Name"/>
					    <input type="email" placeholder="Email Address"/>
				    </span>
				    <textarea name="" ></textarea>				    
				    <button type="button" class="btn btn-default pull-right">
					    Submit
				    </button>
			    </div>--%>
                <div class="fb-comments" data-href="https://www.facebook.com/Web247-Web-Design-and-Graphics-Design-500792100055672/?ref=hl" data-width="100%" data-numposts="10"></div>
		    </div>
	    </div>							
    </div>
</div><!--/category-tab-->

<%--<script type="text/javascript" src="/Theme/js/jquery.fancybox.js"></script>
<link href="/Theme/css/jquery.fancybox.css" rel="stylesheet" />--%>
<script type="text/javascript" src="/Theme/js/cart/shoppingcart.js"></script>
<div id="fb-root"></div>
<script type="text/javascript">(function (d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.5";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));    
</script>
