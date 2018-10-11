<%@ Page Title="Thông tin bài viết" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="editservices.aspx.cs" Inherits="MyProfile.Admin.editservices" %>

<%@ Register Src="~/Admin/Modules/Services/EditServices.ascx" TagPrefix="uc1" TagName="EditServices" %>

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
            <li><a href="/Admin/listservices.aspx">Services</a></li>
            <li class="active">Edit Service</li>
        </ol>
    </section>
    <!-- Main content -->
    <section class="content">    
         <uc1:EditServices runat="server" ID="EditServices" />
    </section><!-- /.content -->
</asp:Content>
