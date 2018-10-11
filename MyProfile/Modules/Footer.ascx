<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Footer.ascx.cs" Inherits="MyProfile.Modules.Footer" %>
<%@ Import Namespace="MyProfile.Class" %>
<%@ Register Src="~/Modules/Links/LinkWebsites.ascx" TagPrefix="uc1" TagName="LinkWebsites" %>
<%@ Register Src="~/Modules/StrategicPartners/StrategicPartner.ascx" TagPrefix="uc1" TagName="StrategicPartner" %>

<footer id="footer"><!--Footer-->
    <div class="hoz-title">
        <div class="container">
	        <div class="row">
                <div class="col-md-12">
                    <h2>Đối tác khách hàng tiêu biểu</h2>
                </div>
	        </div>
        </div>
    </div>
	<div class="footer-top">
		<uc1:StrategicPartner runat="server" id="StrategicPartner" />
	</div>		
	<div class="footer-widget">
		<div class="container">
			<div class="row">
				<div class="col-sm-2">
					<div class="single-widget">
						<h2><i class="fa fa-map-signs" aria-hidden="true"></i> SITE MAP</h2>
						<ul class="nav nav-pills nav-stacked">
							<li><a href="<%= MyConstant.HomeUrl %>">Trang chủ</a></li>
							<li><a href="/gioi-thieu-1.html">Giới thiệu</a></li>
							<li><a href="<%= MyConstant.ProductUrl %>">Sản phẩm</a></li>
							<li><a href="/dich-vu-7.html">Dịch vụ</a></li>
							<li><a href="/tin-tuc-2.html">Tin tức & Sự kiện</a></li>
                            <li><a href="<%= MyConstant.DownloadUrl %>">Download</a></li>
                            <li><a href="<%= MyConstant.ContactUrl %>">Liên hệ chúng tôi</a></li>
						</ul>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="single-widget">
						<h2><i class="fa fa-newspaper-o" aria-hidden="true"></i> Tin tức</h2>						
                        <asp:Repeater runat="server" ID="rpt_LinkNews">
                            <HeaderTemplate><ul class="nav nav-pills nav-stacked"></HeaderTemplate>
                            <ItemTemplate>
                                <li><a href="<%# "/" + get_CategoryName(Convert.ToInt32(Eval("ID_GroupNews")), false) + Eval("Tag","/{0}") + Eval("ID","-{0}.html") %>"><%# Eval("Title") %></a></li>
                            </ItemTemplate>
                            <FooterTemplate></ul></FooterTemplate>
                        </asp:Repeater>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="single-widget">
						<h2><i class="fa fa-server" aria-hidden="true"></i> Dịch vụ</h2>
						<asp:Repeater runat="server" ID="rpt_LinkServices">
                            <HeaderTemplate><ul class="nav nav-pills nav-stacked"></HeaderTemplate>
                            <ItemTemplate>
                                <li><a href="<%# "/" + get_CategoryName(Convert.ToInt32(Eval("ID_GroupNews")), false) + Eval("Tag","/{0}") + Eval("ID","-{0}.html") %>"><%# Eval("Title") %></a></li>
                            </ItemTemplate>
                            <FooterTemplate></ul></FooterTemplate>
                        </asp:Repeater>
					</div>
				</div>
				<%--<div class="col-sm-2">
					<uc1:LinkWebsites runat="server" ID="LinkWebsites" />
				</div>--%>
				<div class="col-sm-3">
					<div class="single-widget">
						<h2><i class="fa fa-calendar"></i> Giờ làm việc</h2>
                        <div class="working-hours">
                            <p><i class="fa fa-clock-o"></i> Thứ 2 (7:30 am - 5:00 pm)</p>
                            <p><i class="fa fa-clock-o"></i> Thứ 3 (7:30 am - 5:00 pm)</p>
                            <p><i class="fa fa-clock-o"></i> Thứ 4 (7:30 am - 5:00 pm)</p>
                            <p><i class="fa fa-clock-o"></i> Thứ 5 (7:30 am - 5:00 pm)</p>
                            <p><i class="fa fa-clock-o"></i> Thứ 6 (7:30 am - 5:00 pm)</p>
                            <p><i class="fa fa-clock-o"></i> Thứ 7 (7:30 am - 11:30 am)</p>
                            <p><i class="fa fa-clock-o"></i> Chủ nhật (Liên hệ)</p>
                        </div>
						<%--<div class="searchform">
							<input type="text" placeholder="Giữ liên lạc với chúng tôi qua email" />
							<button type="submit" class="btn btn-default"><i class="fa fa-arrow-circle-o-right"></i></button>
							<p>Giữ liên lạc với chúng tôi qua Email để được hỗ trợ, ưu đãi tốt nhất.</p>
						</div>--%>
					</div>
				</div>					
			</div>
		</div>
	</div>		
	<div class="footer-bottom">
		<div class="container">
			<div class="row">
				<div class="col-md-9"><p>Copyright © 2018 BAO TIN SOFTWARE LTD. All rights reserved.</p></div>
				<div class="col-md-3"><p>Thiết kế & phát triển <span><a target="_blank" href="http://www.baotinsoftware.com">baotinsoftware.com</a></span></p></div>
			</div>
		</div>
	</div>		
</footer><!--/Footer-->