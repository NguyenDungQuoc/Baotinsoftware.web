<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewsDetail.ascx.cs" Inherits="MyProfile.Modules.News_Blogs.NewsDetail" %>
<%@ Import Namespace="MyProfile.Class" %>
<%@ Register Src="~/Modules/Products/GroupProducts.ascx" TagPrefix="uc1" TagName="GroupProducts" %>
<section>
		<div class="container margin-bottom-50">
			<div class="row">
                <uc1:GroupProducts runat="server" ID="GroupProducts" />
                <div class="col-sm-9">
					<div class="blog-post-area">
						<h2 class="title text-center"><asp:Literal ID="ltrCategoryName" runat="server"></asp:Literal></h2>
						<div class="single-blog-post">
                            <asp:Repeater ID="rpt_PostDetail" runat="server">
                                <ItemTemplate>
                                    <h3><%# Eval("Title") %></h3>
							        <div class="post-meta">
								        <ul>
                                            <li><i class="fa fa-folder-open"></i> <%# GetCategoryName(Convert.ToInt32(Eval("ID_GroupNews"))) %></li>
									        <li><i class="fa fa-user"></i> <%# Singleton<UserAdmin>.Inst.GET_TABLE_USER_PRIMARYKEY(Convert.ToInt32(Eval("ID_UserPost"))).Fullname %></li>									
									        <li><i class="fa fa-calendar"></i> <%# Eval("Date","{0:dd/MM/yyyy}") %></li>
                                            <li><i class="fa fa-eye"></i> <%# Eval("TotalView") %> Views</li>
                                            <li><i class="fa fa-print"></i> <a onclick="window.print();" target="_blank" style="color: #333; cursor: pointer;">Print Screen</a></li>
								        </ul>								
							        </div>
							        <article class="post-detail article-detail">					        
						                <%# Eval("Content") %>
					                </article>
                                </ItemTemplate>
                            </asp:Repeater>														
						</div>
					</div><!--/blog-post-area-->

					<div class="other-listnews">
                        <div class="other-title">
                            <i class="fa fa-folder-open"></i>
                            <h4>Tin tức cùng loại</h4>
                        </div>
                        <asp:Repeater runat="server" ID="rpt_ListNewsOther">
                            <HeaderTemplate><ul></HeaderTemplate>
                            <ItemTemplate>
                                <li>
                                    <i class="fa fa-caret-right"></i>
                                    <a href="<%# "/" + GetCategoryName(Convert.ToInt32(Eval("ID_GroupNews")), "T") + Eval("Tag","/{0}") + Eval("ID","-{0}.html") %>"><%# Eval("Title") %></a>
                                </li>
                            </ItemTemplate>
                            <FooterTemplate></ul></FooterTemplate>
                        </asp:Repeater>
                    </div>                    

					<div class="socials-share">
						<!-- Go to www.addthis.com/dashboard to customize your tools -->
                        <div class="addthis_sharing_toolbox"></div>
					</div><!--/socials-share-->					
				</div>
			</div>
        </div>
</section>
