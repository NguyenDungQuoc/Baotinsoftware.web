<%@ Page Title="Download" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="download.aspx.cs" Inherits="MyProfile.download" %>
<%@ Register Src="~/Modules/Download/ListDownload.ascx" TagPrefix="uc1" TagName="ListDownload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ListDownload runat="server" id="ListDownload" />
</asp:Content>
