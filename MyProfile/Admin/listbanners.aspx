<%@ Page Title="Quản lý banner slide" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="listbanners.aspx.cs" Inherits="MyProfile.Admin.listbanners" %>

<%@ Register Src="~/Admin/Modules/Banners/BannersSliders.ascx" TagPrefix="uc1" TagName="BannersSliders" %>

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
            <li class="active">List Banners</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:BannersSliders runat="server" id="BannersSliders" />
    </section><!-- /.content -->
</asp:Content>
