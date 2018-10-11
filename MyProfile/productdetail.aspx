<%@ Page Title="Sản phẩm chi tiết" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="productdetail.aspx.cs" Inherits="MyProfile.productdetail" %>
<%@ Register Src="~/Modules/Products/ProductDetail.ascx" TagPrefix="uc1" TagName="ProductDetail" %>
<%@ Register Src="~/Modules/Products/GroupProducts.ascx" TagPrefix="uc1" TagName="GroupProducts" %>
<%@ Register Src="~/Modules/Products/ProductInformation.ascx" TagPrefix="uc1" TagName="ProductInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
	    <div class="container margin-bottom-50">
		    <div class="row">
                <uc1:GroupProducts runat="server" ID="GroupProducts" />
			    <div class="col-sm-9">
				    <%--<uc1:ProductDetail runat="server" id="ProductDetail" />--%>
                    <uc1:ProductInformation runat="server" ID="ProductInformation" />
			    </div>
		    </div>
	    </div>
    </section>    
</asp:Content>
