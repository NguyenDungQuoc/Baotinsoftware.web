<%@ Page Title="Article" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="article.aspx.cs" Inherits="MyProfile.article" %>
<%@ Register Src="~/Modules/News_Blogs/NewsDetail.ascx" TagPrefix="uc1" TagName="NewsDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">               
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
    <uc1:NewsDetail runat="server" ID="NewsDetail" />
</asp:Content>
