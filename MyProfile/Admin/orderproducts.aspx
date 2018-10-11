<%@ Page Title="Đơn hàng khách đặt" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="orderproducts.aspx.cs" Inherits="MyProfile.Admin.orderproducts" %>

<%@ Register Src="~/Admin/Modules/OrderProducts/ListOrderProducts.ascx" TagPrefix="uc1" TagName="ListOrderProducts" %>

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
            <li class="active">Product Orders</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:ListOrderProducts runat="server" id="ListOrderProducts" />
    </section><!-- /.content -->
</asp:Content>
