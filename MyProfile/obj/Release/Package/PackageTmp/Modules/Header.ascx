<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="MyProfile.Modules.Header" %>
<%@ Import Namespace="MyProfile.Class" %>
<%@ Register Src="~/Modules/SocialNetwork/SocialLink.ascx" TagPrefix="uc1" TagName="SocialLink" %>
<header id="header"><!--header-->
	<div class="header_top"><!--header_top-->
		<div class="container">
			<div class="row">
				<div class="col-sm-8">
					<asp:Repeater ID="rptPageInfo" runat="server">
                        <HeaderTemplate><ul class="contact-company nav nav-pills"></HeaderTemplate>
                        <ItemTemplate>
                            <li><a href="tel:<%# Eval("Slogan") %>"><i class="fa fa-phone"></i> <%# Eval("Slogan") %></a></li>
						    <li><a href="mailto:<%# Eval("Fanpage") %>"><i class="fa fa-envelope"></i> <%# Eval("Fanpage") %></a></li>
                            <li><a href="Skype:baotinsoftware?chat"><i class="fa fa-skype"></i> baotinsoftware</a></li>
                        </ItemTemplate>
                        <FooterTemplate></ul></FooterTemplate>
                    </asp:Repeater>
				</div>
				<div class="col-sm-4">
					<%--<div class="social-icons pull-right">
						<uc1:SocialLink runat="server" ID="SocialLink" />
					</div>--%>
                    <div class="search_box text-right">
                        <input type="text" id="txt-search" placeholder="Enter search keywords..." autocomplete="off" onkeypress="return fncSearchKeyword(event)" />                        
					</div>
				</div>
			</div>
		</div>
	</div><!--/header_top-->		
	<div class="header-middle"><!--header-middle-->
		<div class="container">
			<div class="row">
				<div class="col-sm-3">
					<a class="logo" href="/trang-chu.html">						                                
                        <asp:Image ID="imgLogo" runat="server" />
					</a>
				</div>
				<div class="col-sm-9">
                    <div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
					</div>
					<div class="mainmenu pull-right">
						<ul class="nav navbar-nav collapse navbar-collapse nopadding">
							<li><a href="<%= MyConstant.HomeUrl %>" class="<%= mHome %>">Trang chủ</a></li>                            
                            <li><a href="<%= MyConstant.ProductUrl %>" class="<%= mProducts %>">Sản phẩm</a></li>      
                            <asp:Repeater ID="rpt_Data" runat="server">
                                <ItemTemplate>
                                    <li><a href="<%# Eval("Tag","/{0}") + Eval("ID","-{0}.html") %>"><%# Eval("Name") %></a></li>
                                </ItemTemplate>
                            </asp:Repeater>            
                            <li><a href="<%= MyConstant.DownloadUrl %>" class="<%= mDownload %>">Download</a></li>                							
							<li><a href="<%= MyConstant.ContactUrl %>" class="<%= mContacts %>">Liên hệ</a></li>
						</ul>
					</div>                                                            					
				</div>
			</div>
		</div>
	</div><!--/header-middle-->		
</header><!--/header-->