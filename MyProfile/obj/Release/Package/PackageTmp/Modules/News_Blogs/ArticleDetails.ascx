<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ArticleDetails.ascx.cs" Inherits="MyProfile.Modules.News_Blogs.ArticleDetails" %>
<%@ Import Namespace="MyProfile.Class" %>

<div class="main-wrapper">
    <div class="news-holder details-holder">        
        <div class="float-8">
            <div class="news-details">
                <div class="news-title">
                    <h2>
                        <%= GetTitleNews %>
                    </h2>                    
                    <asp:Repeater ID="rpt_MetaNewsDetails" runat="server">
                        <HeaderTemplate><ul class="details-meta"></HeaderTemplate>
                        <ItemTemplate>
                            <li>
                                <i class="fa fa-folder-open"></i>
                                <span><%# Singleton<NewsBlog>.Inst.GetGroupNewByPrimaryKey(Convert.ToInt32(Eval("ID_GroupNews"))).Name %></span>
                            </li>
                            <li>
                                <i class="fa fa-calendar-o"></i>
                                <span><%# Eval("Date","{0:dd/MM/yyyy}") %></span>
                            </li>
                            <li>
                                <i class="fa fa-user"></i>by
                                <span><%# Singleton<UserAdmin>.Inst.GET_TABLE_USER_PRIMARYKEY(Convert.ToInt32(Eval("ID_UserPost"))).Fullname %></span>
                            </li>
                            <li>
                                <i class="fa fa-eye"></i>
                                <span><%# Eval("TotalView") %></span>
                            </li>
                        </ItemTemplate>
                        <FooterTemplate></ul></FooterTemplate>
                    </asp:Repeater>                    
                </div>
                <div class="news-sapo">
                    <asp:Literal runat="server" ID="ltrSapo"></asp:Literal>
                </div>
                <div class="news-content article-detail">
                    <asp:Literal runat="server" ID="ltrDetails"></asp:Literal>                                        
                </div>
            </div>
        </div>
        <div class="float-4">
            <div class="news-details">
                <div class="nav-tabs-custom">                    
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-1" data-toggle="tab">MỚI NHẤT</a></li>
                        <li class=""><a href="#tab-2" data-toggle="tab">NỔI BẬT</a></li>
                        <li class=""><a href="#tab-3" data-toggle="tab">XEM NHIỀU</a></li>                                                                
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-1">
                            <asp:Repeater ID="rpt_ListNewsPost" runat="server">
                                <ItemTemplate>
                                    <div class="items-news">
                                        <div class="thub-left">
                                            <a href="<%# "/article/" + Eval("Tag") + Eval("ID","-{0}.html") %>" title="<%# Eval("Title") %>">
                                                <img src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>"/>
                                            </a>                                    
                                        </div>
                                        <div class="thub-right">
                                            <h4><a href="<%# "/article/" + Eval("Tag") + Eval("ID","-{0}.html") %>" title="<%# Eval("Title") %>"><%# Eval("Title") %></a></h4>
                                            <p><i class="fa fa-calendar-o"></i><span><%# Eval("Date","{0:dd/MM/yyyy}") %></span></p>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>                                                                                   
                        </div>
                        <div class="tab-pane" id="tab-2">
                            <asp:Repeater ID="rpt_ListNewsHot" runat="server">
                                <ItemTemplate>
                                    <div class="items-news">
                                        <div class="thub-left">
                                            <a href="<%# "/article/" + Eval("Tag") + Eval("ID","-{0}.html") %>" title="<%# Eval("Title") %>">
                                                <img src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>"/>
                                            </a>                                    
                                        </div>
                                        <div class="thub-right">
                                            <h4><a href="<%# "/article/" + Eval("Tag") + Eval("ID","-{0}.html") %>" title="<%# Eval("Title") %>"><%# Eval("Title") %></a></h4>
                                            <p><i class="fa fa-calendar-o"></i><span><%# Eval("Date","{0:dd/MM/yyyy}") %></span></p>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>                  
                        </div>
                        <div class="tab-pane" id="tab-3">
                            <asp:Repeater ID="rpt_ListNewsView" runat="server">
                                <ItemTemplate>
                                    <div class="items-news">
                                        <div class="thub-left">
                                            <a href="<%# "/article/" + Eval("Tag") + Eval("ID","-{0}.html") %>" title="<%# Eval("Title") %>">
                                                <img src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>"/>
                                            </a>                                    
                                        </div>
                                        <div class="thub-right">
                                            <h4><a href="<%# "/article/" + Eval("Tag") + Eval("ID","-{0}.html") %>" title="<%# Eval("Title") %>"><%# Eval("Title") %></a></h4>
                                            <p><i class="fa fa-calendar-o"></i><span><%# Eval("Date","{0:dd/MM/yyyy}") %></span></p>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>                                                        
                        </div>
                    </div>
                </div>
            </div>            
        </div>
    </div>
</div>