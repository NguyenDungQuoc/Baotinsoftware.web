<%@ Page Title="List Services" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="listservices.aspx.cs" Inherits="MyProfile.Admin.listservices" %>

<%@ Register Src="~/Admin/Modules/Services/ListServices.ascx" TagPrefix="uc1" TagName="ListServices" %>

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
            <li class="active">List Services</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:ListServices runat="server" ID="ListServices" />
    </section><!-- /.content -->
</asp:Content>
