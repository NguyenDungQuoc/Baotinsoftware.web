<%@ Page Title="Sản phẩm" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="products.aspx.cs" Inherits="MyProfile.products" %>
<%@ Register Src="~/Modules/Products/GroupProducts.ascx" TagPrefix="uc1" TagName="GroupProducts" %>
<%@ Register Src="~/Modules/Products/ProductOfCategories.ascx" TagPrefix="uc1" TagName="ProductOfCategories" %>
<%@ Register Src="~/Modules/Products/Products.ascx" TagPrefix="uc1" TagName="Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
    <section>
	    <div class="container margin-bottom-50">
		    <div class="row">
			    <uc1:GroupProducts runat="server" ID="GroupProducts" />				
			    <div class="col-sm-9">
				    <%--<uc1:ProductOfCategories runat="server" ID="ProductOfCategories" />--%>
                    <uc1:Products runat="server" id="Products" />
			    </div>
		    </div>
	    </div>
    </section>
</asp:Content>
