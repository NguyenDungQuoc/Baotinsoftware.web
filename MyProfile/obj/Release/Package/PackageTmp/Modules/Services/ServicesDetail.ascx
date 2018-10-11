<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServicesDetail.ascx.cs" Inherits="MyProfile.Modules.Services.ServicesDetail" %>
<%@ Import Namespace="MyProfile.Class" %>

<section id="news_events">
    <div class="title-box">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2><asp:Literal runat="server" ID="ltrTitle"></asp:Literal></h2>						
                </div>                    
            </div>                
        </div>
    </div>
    <div class="box-info">
        <div class="container">
            <div class="row">
                <asp:Repeater runat="server" ID="rpt_TabLeft_ListCategories" OnItemDataBound="rpt_TabLeft_ListCategories_OnItemDataBound">
                    <HeaderTemplate><div class="col-xs-12 col-md-4 col-lg-4 col-sm-4"></HeaderTemplate>
                    <ItemTemplate>
                        <div class="box-widget">
						    <div class="widget_title">
							    <h4><span><%# Eval("Name") %></span></h4>
						    </div>
                            <asp:Repeater runat="server" ID="rpt_ChildList">
                                <HeaderTemplate><ul class="arrows-list-category"></HeaderTemplate>
                                <ItemTemplate>
                                    <li class="<%# Eval("ID").ToString() == Request.Params["id"].Trim() ? "active" : ""  %>">
                                        <a title="<%# Eval("Title") %>" href="<%# "/our-services/" + GetTagGroupServices(Convert.ToInt32(Eval("ID_GroupServices"))) + "/" + Eval("Tag") + Eval("ID","-{0}.html") %>"> <%# Eval("Title") %></a>
                                    </li>
                                </ItemTemplate>
                                <FooterTemplate></ul></FooterTemplate>
                            </asp:Repeater>						    
					    </div>
                        <asp:HiddenField runat="server" ID="hdfID" Value='<%# Eval("ID") %>' />
                    </ItemTemplate>
                    <FooterTemplate></div></FooterTemplate>
                </asp:Repeater>  
                              
                <asp:Repeater runat="server" ID="rpt_TabRight_ServicesDetail" OnItemDataBound="rpt_TabRight_ServicesDetail_OnItemDataBound">
                    <HeaderTemplate><div class="col-xs-12 col-sm-8 col-md-8 col-lg-8"></HeaderTemplate>
                    <ItemTemplate>
                        <div class="post-meta">
						    <h2><%# Eval("Title") %></h2>
						    <div class="list-metaInfo">
							    <span><i class="fa fa-calendar"></i> <a><%# Eval("Date","{0:dd/MM/yyyy}") %></a></span>
							    <span><i class="fa fa-user"></i> By <a><%# Singleton<UserAdmin>.Inst.GET_TABLE_USER_PRIMARYKEY(Convert.ToInt32(Eval("ID_UserPost"))).Fullname %></a></span>
							    <span><i class="fa fa-folder-open"></i> <a href="<%# "/our-services/" + GetTagGroupServices(Convert.ToInt32(Eval("ID_GroupServices"))) + Eval("ID_GroupServices","-{0}.html") %>"><%= ltrTitle.Text %></a></span>
							    <span><i class="fa fa-eye"></i> <a><%# Eval("TotalView") %> Views</a></span>
							    <span><i class="fa fa-print"></i> <a onclick="window.print();" target="_blank">Print Screen</a></span>
						    </div>
					    </div>

					    <article class="post-detail article-detail">					        					        
						    <%# Eval("Content") %>
					    </article>						
						
					    <h4 class="other-title">Related stories</h4>
					    <asp:Repeater runat="server" ID="rpt_ListRelated">
                            <HeaderTemplate><ul class="arrows-list-category other-listnews"></HeaderTemplate>
                            <ItemTemplate>
                                <li>
                                    <a title="<%# Eval("Title") %>" href="<%# "/our-services/" + GetTagGroupServices(Convert.ToInt32(Eval("ID_GroupServices"))) + "/" + Eval("Tag") + Eval("ID","-{0}.html") %>"> <%# Eval("Title") %></a>
                                </li>
                            </ItemTemplate>
                            <FooterTemplate></ul></FooterTemplate>                            
                        </asp:Repeater>
                        <asp:HiddenField runat="server" ID="hdfID" Value='<%# Eval("ID_GroupServices") %>' />
                    </ItemTemplate>
                    <FooterTemplate></div></FooterTemplate>
                </asp:Repeater>									
            </div>
        </div>
    </div>
</section>