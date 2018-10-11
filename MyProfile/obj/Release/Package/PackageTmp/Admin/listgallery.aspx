<%@ Page Title="Danh sách Đối tác/Khách hàng" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="listgallery.aspx.cs" Inherits="MyProfile.Admin.listgallery" %>

<%@ Register Src="~/Admin/Modules/Gallery/ListGallerys.ascx" TagPrefix="uc1" TagName="ListGallerys" %>

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
            <li class="active">List Strategic Partners</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:ListGallerys runat="server" id="ListGallerys" />
    </section><!-- /.content -->
</asp:Content>
