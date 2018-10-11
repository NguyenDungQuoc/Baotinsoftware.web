<%@ Page Title="Thông tin cập nhật sản phẩm" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="editproducts.aspx.cs" Inherits="MyProfile.Admin.editproducts" %>

<%@ Register Src="~/Admin/Modules/Products/EditProducts.ascx" TagPrefix="uc1" TagName="EditProducts" %>

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
            <li><a href="/Admin/listproducts.aspx">Product Management</a></li>
            <li class="active">Edit Product</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <uc1:EditProducts runat="server" ID="EditProducts" />
    </section><!-- /.content -->
</asp:Content>
