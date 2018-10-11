<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BannerCarousel.ascx.cs" Inherits="MyProfile.Modules.Banners.BannerCarousel" %>

<section id="slider"><!--slider-->
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div id="slider-carousel" class="carousel slide" data-ride="carousel">
                    <asp:Repeater runat="server" ID="rpt_ListPagers">
                        <HeaderTemplate><ol class="carousel-indicators"></HeaderTemplate>
                        <ItemTemplate>
                            <li data-target="#slider-carousel" data-slide-to="<%# Eval("Position") %>" class="<%# Eval("Position").ToString() == "0" ? "active" : "" %>"></li>
                        </ItemTemplate>
                        <FooterTemplate></ol></FooterTemplate>
                    </asp:Repeater>											                    

                    <asp:Repeater runat="server" ID="rpt_ListBanners">
                        <HeaderTemplate><div class="carousel-inner"></HeaderTemplate>
                        <ItemTemplate>
                            <div class="item <%# Eval("Position").ToString() == "0" ? "active" : "" %>">
							    <div class="col-sm-6">
								    <h1><span>E</span>-SHOPPER</h1>
								    <h2><%# Eval("Title") %></h2>
								    <p><%# Eval("Content") %></p>
								    <a href="<%# Eval("Href") %>" class="btn btn-default get">Xem chi tiết</a>
							    </div>
							    <div class="col-sm-6">
								    <img src="<%# Eval("Image") %>" class="girl img-responsive" alt="<%# Eval("Title") %>" />								    
							    </div>
						    </div>
                        </ItemTemplate>
                        <FooterTemplate></div></FooterTemplate>
                    </asp:Repeater>					
						
					<a href="#slider-carousel" class="left control-carousel hidden-xs" data-slide="prev">
						<i class="fa fa-angle-left"></i>
					</a>
					<a href="#slider-carousel" class="right control-carousel hidden-xs" data-slide="next">
						<i class="fa fa-angle-right"></i>
					</a>
				</div>
					
			</div>
		</div>
	</div>
</section><!--/slider-->