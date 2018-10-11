<%@ Page Title="Câu hỏi thường gặp" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="faqs.aspx.cs" Inherits="MyProfile.faqs" %>

<%@ Register Src="~/Modules/Faqs.ascx" TagPrefix="uc1" TagName="Faqs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:Faqs runat="server" ID="Faqs" />
</asp:Content>
