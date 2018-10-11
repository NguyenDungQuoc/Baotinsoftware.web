<%@ Page Title="Danh sách sản phẩm" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="listproducts.aspx.cs" Inherits="MyProfile.Admin.listproducts" %>

<%@ Register Src="~/Admin/Modules/Products/ListProducts.ascx" TagPrefix="uc1" TagName="ListProducts" %>

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
            <li><a href="/Admin/groupproducts.aspx">Group Products</a></li>
            <li class="active">List Products</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:ListProducts runat="server" id="ListProducts" />
    </section><!-- /.content -->
</asp:Content>
