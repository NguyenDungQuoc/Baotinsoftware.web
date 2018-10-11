<%@ Page Title="Chi tiết đơn đặt hàng" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="orderdetails.aspx.cs" Inherits="MyProfile.Admin.orderdetails" %>

<%@ Register Src="~/Admin/Modules/OrderProducts/OrderDetails.ascx" TagPrefix="uc1" TagName="OrderDetails" %>

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
            <%--<li><a href="/Admin/listproducts.aspx">Product Management</a></li>--%>
            <li><a href="/Admin/orderproducts.aspx">Product Orders</a></li>
            <li class="active">Order Detail</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:OrderDetails runat="server" id="OrderDetails" />
    </section><!-- /.content -->
</asp:Content>
