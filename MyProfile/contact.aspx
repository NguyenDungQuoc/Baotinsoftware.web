<%@ Page Title="Liên hệ với chúng tôi" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="MyProfile.contact" %>

<%@ Register Src="~/Modules/Contact.ascx" TagPrefix="uc1" TagName="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:Contact runat="server" ID="Contact" />
</asp:Content>
