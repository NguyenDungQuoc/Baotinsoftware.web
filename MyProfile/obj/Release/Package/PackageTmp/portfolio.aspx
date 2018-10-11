<%@ Page Title="Thể loại" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="portfolio.aspx.cs" Inherits="MyProfile.portfolio" %>
<%@ Register Src="~/Modules/Products/ProductOfTypes.ascx" TagPrefix="uc1" TagName="ProductOfTypes" %>
<%@ Register Src="~/Modules/Products/GroupProducts.ascx" TagPrefix="uc1" TagName="GroupProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
	    <div class="container margin-bottom-50">
		    <div class="row">
                <uc1:GroupProducts runat="server" id="GroupProducts" />
			    <div class="col-sm-9">
				    <uc1:ProductOfTypes runat="server" id="ProductOfTypes" />
			    </div>
		    </div>
	    </div>
    </section>    
</asp:Content>
