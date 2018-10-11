<%@ Page Title="Quản lý danh mục sản phẩm" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="groupproducts.aspx.cs" Inherits="MyProfile.Admin.groupproducts" %>

<%@ Register Src="~/Admin/Modules/Products/ListGroupProducts.ascx" TagPrefix="uc1" TagName="ListGroupProducts" %>

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
            <li class="active">Group Products</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:ListGroupProducts runat="server" id="ListGroupProducts" />
    </section><!-- /.content -->
</asp:Content>
