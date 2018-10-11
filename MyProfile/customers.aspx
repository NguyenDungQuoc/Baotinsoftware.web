<%@ Page Title="Customer Focus Commitment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="customers.aspx.cs" Inherits="MyProfile.customers" %>
<%@ Register Src="~/Modules/Customers/Customer.ascx" TagPrefix="uc1" TagName="Customer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:Customer runat="server" ID="Customer" />
</asp:Content>
