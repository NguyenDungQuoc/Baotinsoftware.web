<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductInformation.ascx.cs" Inherits="MyProfile.Modules.Products.ProductInformation" %>
<%@ Import Namespace="MyProfile.Class" %>
<%@ Register Src="~/Controls/FileUploader.ascx" TagPrefix="uc1" TagName="FileUploader" %>
<%@ Register Src="~/Modules/Comment/WucListCommentByType.ascx" TagPrefix="uc1" TagName="WucListCommentByType" %>

<div class="product-details row"><!--product-details-->
    <div class="col-md-12">
        <h2 class="title text-center">Sản phẩm chi tiết</h2>
    </div>
    <asp:Repeater ID="rptProductInformation" runat="server" OnItemDataBound="rptProductInformation_ItemDataBound">
        <ItemTemplate>
            <div class="col-sm-8 border-right-ddd">                                   
                <div class="product-content nopadding article-detail">
                    <input id="hdfProductId" type="hidden" value="<%# Eval("ProductId") %>"/>
                    <h2 class="detail-caption"><%# Eval("ProductName") %></h2>                    
                    <%# Eval("Content") %>                    
		        </div>             		        
	        </div>
	        <div class="col-sm-4">
                <p>
                    <a class="fancybox-thumb" rel="fancybox-thumb" title="<%# Eval("ProductName") %>" href="<%# Eval("Avatar") %>" style="display:block; font-size:0;">                                
                        <img src="<%# Eval("Avatar") %>" alt="<%# Eval("ProductName") %>" class="img-responsive" />
                    </a>
                    <strong class="tip-img"><%# Eval("ProductName") %></strong>
                </p>
                <asp:Repeater runat="server" ID="rptListImages">                    
                    <ItemTemplate>
                        <p class="text-center">
                            <a class="fancybox-thumb" rel="fancybox-thumb" title="<%# Eval("Note") %>" href="<%# Eval("Path") %>" style="display:block; font-size:0;">                                
                                <img src="<%# Eval("Path") %>" alt="<%# Eval("Note") %>" class="img-responsive" style="display: inline-block;" />
                            </a>
                            <strong class="tip-img"><%# Eval("Note") %></strong>
                        </p>                        
                    </ItemTemplate>                    
                </asp:Repeater>		        
	        </div>
        </ItemTemplate>
    </asp:Repeater>	
</div><!--/product-details-->
<div class="row">
    <div class="col-md-12">
        <h2 class="detail-caption padding-bottom-10 <%= rptListRelatedNews.Items.Count > 0 ? "" : "hide-item" %>">
            Tin tức liên quan cho sản phẩm
        </h2>
        <asp:Repeater ID="rptListRelatedNews" runat="server">
            <HeaderTemplate><ul class="list-related-news"></HeaderTemplate>
            <ItemTemplate>
                <li>
                    <a href="<%# Eval("UrlFormat") %>"><%# Eval("Title") %></a>
                </li>
            </ItemTemplate>
            <FooterTemplate></ul></FooterTemplate>
        </asp:Repeater>
    </div>
</div>
<div class="row">
    <div class="category-tab shop-details-tab"><!--category-tab-->
        <div class="col-sm-12">
	        <ul class="nav nav-tabs">
		        <li class="active"><a href="#details" data-toggle="tab">Sản phẩm cùng loại</a></li>
		        <%--<li><a href="#companyprofile" data-toggle="tab">Video - Clip</a></li>--%>		    
		        <%--<div id="recommended-item-carousel" class="carousel slide" data-ride="carousel">--%>
                <li><a href="#comment" data-toggle="tab">Bình luận</a></li>
	        </ul>
        </div>
        <div class="tab-content">
	        <div class="tab-pane fade active in" id="details" >
		        <div class="product-content">                    
                    <asp:Repeater ID="rpt_ListProductSimilar" runat="server">
                        <HeaderTemplate><div class="owl-carousel owl-theme"></HeaderTemplate>
                        <ItemTemplate>
                            <div class="product-image-wrapper" style="margin-left:10px; margin-right:10px;">
				                <div class="single-products">
					                <div class="productinfo text-center">
                                        <a href="<%# Eval("UrlFormat") %>" title="<%# Eval("ProductName") %>">
						                    <img src="<%# Eval("Avatar") %>" alt="<%# Eval("ProductName") %>" class="img-responsive" />
                                        </a>
						                <h2 class="hide-item"><%# Eval("Price") != null && "0".Equals(Eval("Price").ToString()) ? "Liên hệ" : Eval("Price","{0: 0,0} đ") %></h2>
						                <p class="p-price">
                                            <a href="<%# Eval("UrlFormat") %>" title="<%# Eval("ProductName") %>"><%# Eval("ProductName") %></a>
                                        </p>
						                <button type="button" class="btn btn-default add-to-cart hide-item"><i class="fa fa-shopping-cart"></i>Liên hệ đặt hàng</button>
                                        <a href="<%= MyConstant.ContactUrl %>" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Liên hệ đặt hàng</a>
					                </div>
				                </div>
			                </div>
                        </ItemTemplate>
                        <FooterTemplate></div></FooterTemplate>
                    </asp:Repeater>                
		        </div>			    
	        </div>							
	        <div class="tab-pane fade" id="companyprofile" >
                <div class="product-content">
                    <div class="col-sm-12">
                        <div class="embed-responsive embed-responsive-16by9">
                            <iframe class="embed-responsive-item" src="<%= GetLinkYoutube %>"></iframe>
                        </div>
                    </div>
                </div>                                    		    
	        </div>								    							
	        <div class="tab-pane fade" id="comment">
		        <div class="col-md-12">
                    <uc1:WucListCommentByType runat="server" ID="WucListCommentByType" />
		            <h4>Bình luận về sản phẩm</h4>
		            <div class="replay-box">
		                <div class="row">
		                    <div class="col-sm-2">
		                        <div class="blank-arrow">
		                            <label>Ảnh đại diện</label>
		                        </div>
                                <div class="cmt-cover">
                                    <img src="/Theme/photo/avatar-anonymous.png" alt="Ảnh đại diện" title="Ảnh đại diện" class="img-responsive" 
                                        style="filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);" />
                                </div>
		                        <div class="command-upload-avatar">
		                            <a title="Upload ảnh đại diện">
                                        <asp:FileUpload ID="FileUploadAvatar" CssClass="fileUploadAvatar" runat="server" 
                                            style="filter: alpha(opacity=0);-ms-filter:'progid:DXImageTransform.Microsoft.Alpha(Opacity=0)';" ToolTip="Đính kèm ảnh"  />
		                                <img src="/Theme/img/camera-photo_24x24.png" alt="Upload ảnh đại diện" title="Đính kèm ảnh" />
		                            </a>
		                        </div>
		                    </div>
		                    <div class="col-sm-4">
		                        <div class="form-reviews">
		                            <div class="blank-arrow">
		                                <label>Họ & tên</label>
		                            </div>
		                            <span>*</span>
		                            <input type="text" name="fullname" placeholder="Họ & tên *" maxlength="50" />
		                            <div class="blank-arrow">
		                                <label>Email</label>
		                            </div>
		                            <span>*</span>
		                            <input type="email" name="email" placeholder="Email *" maxlength="100" />
		                            <div class="blank-arrow">
		                                <label>Mã bảo vệ</label>
		                            </div>
                                    <div class="clear">
                                        <strong class="captcha-code">
                                            <asp:HiddenField ID="hdfResultStopSpam" runat="server" />
                                            <asp:Literal runat="server" ID="ltrStopSpam"></asp:Literal>
                                        </strong>
                                        <input name="captcha" type="number" style="width: 50%" placeholder="Nhập mã bảo vệ *" maxlength="2" />
                                    </div>
		                        </div>
		                    </div>
		                    <div class="col-sm-6">
		                        <div class="text-area no-margin-top">
		                            <div class="blank-arrow">
		                                <label>Nội dung</label>
		                            </div>
		                            <span>*</span>
		                            <textarea name="message" rows="6" placeholder="Nội dung ..." maxlength="300"></textarea>
		                        </div>
                                <div class="box-file-uploader">
                                    <uc1:FileUploader runat="server" ID="FileUploader" />
                                </div>
		                        <a id="btn_SendComment" class="btn btn-primary" href="#" style="padding: 10px 20px;">Gửi bình luận</a>
		                    </div>
		                </div>
		            </div><!--/Repaly Box-->				
		        </div>
	        </div>							
        </div>
    </div><!--/category-tab-->
</div>
<script src="/Theme/plugins/uploadFile/scripts/handlecomment.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.owl-carousel').owlCarousel({
            autoPlay: 3000, //Set AutoPlay to 3 seconds
            navigation: false,
            pagination: false,
            items: 4,
            itemsDesktop: [1199, 4],
            itemsDesktopSmall: [991, 4],
            itemsTablet: [767, 3],
            itemsMobile: [479, 2]
        });
    });
</script>

