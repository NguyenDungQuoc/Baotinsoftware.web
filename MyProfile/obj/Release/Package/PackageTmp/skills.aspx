<%@ Page Title="Our Services" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="skills.aspx.cs" Inherits="MyProfile.skills" %>

<%@ Register Src="~/Modules/Services/ServicesDetail.ascx" TagPrefix="uc1" TagName="ServicesDetail" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ServicesDetail runat="server" id="ServicesDetail" />
</asp:Content>
