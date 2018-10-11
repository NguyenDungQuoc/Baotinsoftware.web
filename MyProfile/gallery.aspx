<%@ Page Title="Gallery" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="gallery.aspx.cs" Inherits="MyProfile.gallery" %>

<%@ Register Src="~/Modules/Gallery.ascx" TagPrefix="uc1" TagName="Gallery" %>
<%@ Register Src="~/Modules/Galleries/GalleriesOfCategories.ascx" TagPrefix="uc1" TagName="GalleriesOfCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:Gallery runat="server" id="Gallery" />
    <%--<uc1:GalleriesOfCategories runat="server" ID="GalleriesOfCategories" />--%>
</asp:Content>
