<%@ Page Title="Quản lý liên kết website" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="linkwebsites.aspx.cs" Inherits="MyProfile.Admin.linkwebsites" %>

<%@ Register Src="~/Admin/Modules/Links/LinkWebsites.ascx" TagPrefix="uc1" TagName="LinkWebsites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Administration
            <small>Control panel</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="/Admin/home.aspx"><i class="fa fa-dashboard"></i> Dashboard</a></li>            
            <li class="active">List Links</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:LinkWebsites runat="server" id="LinkWebsites" />
    </section><!-- /.content -->
</asp:Content>
