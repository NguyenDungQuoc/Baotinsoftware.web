<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="About.ascx.cs" Inherits="MyProfile.Modules.About" %>
<%@ Import Namespace="MyProfile.Class" %>
<%@ Register Src="~/Modules/Products/GroupProducts.ascx" TagPrefix="uc1" TagName="GroupProducts" %>

<section>
		<div class="container margin-bottom-50">
			<div class="row">
                <uc1:GroupProducts runat="server" ID="GroupProducts" />
                <div class="col-sm-9">
					<div class="blog-post-area">
						<h2 class="title text-center">Giới thiệu</h2>
						<div class="single-blog-post">
                            <asp:Repeater ID="rpt_PostDetail" runat="server">
                                <ItemTemplate>
                                    <h3><%# Eval("Title") %></h3>
							        <div class="post-meta">
								        <ul>
                                            <li><i class="fa fa-folder-open"></i> <%# get_CategoryName(Convert.ToInt32(Eval("ID_GroupNews"))) %></li>
									        <li><i class="fa fa-user"></i> <%# Singleton<UserAdmin>.Inst.GET_TABLE_USER_PRIMARYKEY(Convert.ToInt32(Eval("ID_UserPost"))).Fullname %></li>									
									        <li><i class="fa fa-calendar"></i> <%# Eval("Date","{0:dd/MM/yyyy}") %></li>
                                            <li><i class="fa fa-eye"></i> <%# Eval("TotalView") %> Views</li>
                                            <li><i class="fa fa-print"></i> <a onclick="window.print();" target="_blank" style="color: #333;">Print Screen</a></li>
								        </ul>								
							        </div>
							        <article class="post-detail article-detail">					        
						                <%# Eval("Content") %>
					                </article>
                                </ItemTemplate>
                            </asp:Repeater>														
						</div>
					</div><!--/blog-post-area-->

					<div class="rating-area">
						<ul class="ratings">
							<li class="rate-this">Rate this item:</li>
							<li>
								<i class="fa fa-star color"></i>
								<i class="fa fa-star color"></i>
								<i class="fa fa-star color"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
							</li>
							<li class="color">(6 votes)</li>
						</ul>
						<ul class="tag">
							<li>TAG:</li>
							<li><a class="color" href="#">Pink <span>/</span></a></li>
							<li><a class="color" href="#">T-Shirt <span>/</span></a></li>
							<li><a class="color" href="#">Girls</a></li>
						</ul>
					</div><!--/rating-area-->

					<div class="socials-share">
						<!-- Go to www.addthis.com/dashboard to customize your tools -->
                        <div class="addthis_sharing_toolbox"></div>
					</div><!--/socials-share-->					
				</div>
			</div>
        </div>
</section>

