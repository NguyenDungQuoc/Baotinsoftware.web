<%@ Page Title="Quản lý giao diện" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="MyProfile.Admin.home" %>
<%@ Register Src="~/Admin/Modules/Seo/SeoPage.ascx" TagPrefix="uc1" TagName="SeoPage" %>

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
            <li><a href="/Admin/home.aspx"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">Dashboard</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <uc1:SeoPage runat="server" id="SeoPage" />
    </section><!-- /.content -->    
</asp:Content>
