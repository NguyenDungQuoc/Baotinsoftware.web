<%@ Page Title="Thông tin tài khoản" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="profiles.aspx.cs" Inherits="MyProfile.Admin.profiles" %>

<%@ Register Src="~/Admin/Modules/User/ProfileAdmin.ascx" TagPrefix="uc1" TagName="ProfileAdmin" %>

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
            <li class="active">User Profile</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <uc1:ProfileAdmin runat="server" id="ProfileAdmin" />
    </section><!-- /.content -->
</asp:Content>
