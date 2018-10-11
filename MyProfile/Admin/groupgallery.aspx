<%@ Page Title="Danh mục Đối tác/khách hàng" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="groupgallery.aspx.cs" Inherits="MyProfile.Admin.groupgallery" %>

<%@ Register Src="~/Admin/Modules/Gallery/GroupGallery.ascx" TagPrefix="uc1" TagName="GroupGallery" %>

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
            <li><a href="/Admin/listgallery.aspx">List Strategic Partners</a></li>
            <li class="active">Strategic Partners Categories</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:GroupGallery runat="server" id="GroupGallery" />
    </section><!-- /.content -->
</asp:Content>
