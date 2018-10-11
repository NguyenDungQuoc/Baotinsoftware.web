<%@ Page Title="Service Category" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="groupservices.aspx.cs" Inherits="MyProfile.Admin.groupservices" %>

<%@ Register Src="~/Admin/Modules/Services/ListGroupServices.ascx" TagPrefix="uc1" TagName="ListGroupServices" %>

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
            <li><a href="/Admin/listservices.aspx">List Services</a></li>
            <li class="active">Service Category</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">
        <uc1:ListGroupServices runat="server" ID="ListGroupServices" />
    </section><!-- /.content -->
</asp:Content>
