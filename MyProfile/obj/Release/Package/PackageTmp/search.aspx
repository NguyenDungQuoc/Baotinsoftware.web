<%@ Page Title="Kết quả tìm kiếm" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="MyProfile.search" %>
<%@ Register Src="~/Modules/Products/GroupProducts.ascx" TagPrefix="uc1" TagName="GroupProducts" %>
<%@ Register Src="~/Modules/Products/FindProduct.ascx" TagPrefix="uc1" TagName="FindProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
	    <div class="container margin-bottom-50">
		    <div class="row">
                <uc1:GroupProducts runat="server" ID="GroupProducts" />
                <div class="col-sm-9">
                    <uc1:FindProduct runat="server" id="FindProduct" />
                </div>
		    </div>
            </div>
    </section>
</asp:Content>
