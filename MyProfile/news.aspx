<%@ Page Title="Tin tức" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="news.aspx.cs" Inherits="MyProfile.news" %>
<%@ Register Src="~/Modules/News.ascx" TagPrefix="uc1" TagName="News" %>
<%@ Register Src="~/Modules/Products/GroupProducts.ascx" TagPrefix="uc1" TagName="GroupProducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
    <section>
	    <div class="container margin-bottom-50">
		    <div class="row">
                <uc1:GroupProducts runat="server" ID="GroupProducts" />
			    <div class="col-sm-9">
				    <uc1:News runat="server" ID="News" />
			    </div>
		    </div>
	    </div>
    </section>
</asp:Content>
