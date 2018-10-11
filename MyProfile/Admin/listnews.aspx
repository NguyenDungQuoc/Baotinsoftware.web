<%@ Page Title="Quản lý tin tức" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="listnews.aspx.cs" Inherits="MyProfile.Admin.listnews" %>

<%@ Register Src="~/Admin/Modules/News/ListNewsBlogs.ascx" TagPrefix="uc1" TagName="ListNewsBlogs" %>

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
            <li class="active">List News & Events</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:ListNewsBlogs runat="server" ID="ListNewsBlogs" />
    </section><!-- /.content -->
</asp:Content>
