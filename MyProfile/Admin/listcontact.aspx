<%@ Page Title="Quản lý thư liên hệ" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="listcontact.aspx.cs" Inherits="MyProfile.Admin.listcontact" %>

<%@ Register Src="~/Admin/Modules/Contact/ListContacts.ascx" TagPrefix="uc1" TagName="ListContacts" %>

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
            <li class="active">List Contacts</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:ListContacts runat="server" id="ListContacts" />
    </section><!-- /.content -->
</asp:Content>
