<%@ Page Title="Trang chủ | Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="MyProfile.home" %>
<%@ Register Src="~/Modules/Banners/BannerCarousel.ascx" TagPrefix="uc1" TagName="BannerCarousel" %>
<%@ Register Src="~/Modules/Products/GroupProducts.ascx" TagPrefix="uc1" TagName="GroupProducts" %>
<%@ Register Src="~/Modules/Products/ProductFeatureds.ascx" TagPrefix="uc1" TagName="ProductFeatureds" %>
<%@ Register Src="~/Modules/Products/TabProducts.ascx" TagPrefix="uc1" TagName="TabProducts" %>
<%@ Register Src="~/Modules/Banners/BannerWowSlider.ascx" TagPrefix="uc1" TagName="BannerWowSlider" %>
<%@ Register Src="~/Modules/Introduction.ascx" TagPrefix="uc1" TagName="Introduction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
    <%--<uc1:BannerCarousel runat="server" id="BannerCarousel" />--%>
    <%--<uc1:BannerWowSlider runat="server" ID="BannerWowSlider" />--%>
    <section>
		<div class="container">
			<div class="row">
				<uc1:GroupProducts runat="server" ID="GroupProducts" />
                <div class="col-sm-9">
                    <uc1:Introduction runat="server" ID="Introduction" />
                </div>				
				<div class="col-sm-9">                    
					<uc1:ProductFeatureds runat="server" ID="ProductFeatureds" />
                    <%--<uc1:TabProducts runat="server" id="TabProducts" />--%>										
				</div>
			</div>
		</div>
	</section>            
</asp:Content>
