<%@ Page Title="Strategic Partners" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="partners.aspx.cs" Inherits="MyProfile.partners" %>
<%@ Register Src="~/Modules/Galleries/GalleriesOfCategories.ascx" TagPrefix="uc1" TagName="GalleriesOfCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:GalleriesOfCategories runat="server" ID="GalleriesOfCategories" />
</asp:Content>
