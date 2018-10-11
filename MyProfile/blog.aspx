<%@ Page Title="Our Services" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="blog.aspx.cs" Inherits="MyProfile.blog" %>
<%@ Register Src="~/Modules/Services/ServicesOfCategories.ascx" TagPrefix="uc1" TagName="ServicesOfCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ServicesOfCategories runat="server" id="ServicesOfCategories" />
</asp:Content>
