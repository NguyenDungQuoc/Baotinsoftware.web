<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StrategicPartner.ascx.cs" Inherits="MyProfile.Modules.StrategicPartners.StrategicPartner" %>

<div class="container">
	<div class="row">				
		<div id="owl-boxTopPartners" class="col-sm-12">
            <asp:Repeater ID="rpt_StrategicPartners" runat="server">
                <ItemTemplate>
                    <%--<div class="col-sm-2">--%>
				        <div class="text-center paddingLR15">
					        <a href="<%# Eval("Content") %>" target="_blank" title="<%# Eval("Title") %>">						        
							    <img src="<%# Eval("Href") %>" alt="<%# Eval("Title") %>" class="img-responsive" />                                						        						        
					        </a>
					        <p class="nomargin"><%# Eval("Title") %></p>
				        </div>
			        <%--</div>--%>
                </ItemTemplate>
            </asp:Repeater>												                    
            <%--<div class="col-sm-2">
				<div class="video-gallery text-center">
					<a href="#">
						<div class="iframe-img">
							<img src="/Upload/images/Products/iframe2.png" alt="" />
						</div>
						<div class="overlay-icon">
							<i class="fa fa-play-circle-o"></i>
						</div>
					</a>
					<p>Circle of Hands</p>
					<h2>24 DEC 2014</h2>
				</div>
			</div>--%>
		</div>
	</div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#owl-boxTopPartners").owlCarousel({
            autoPlay: 3000, //Set AutoPlay to 3 seconds
            navigation: false,
            pagination: false,
            items: 6,
            itemsDesktop: [1199, 6],
            itemsDesktopSmall: [991, 6],
            itemsTablet: [767, 3],
            itemsMobile: [479, 3]
        });
    });
</script>