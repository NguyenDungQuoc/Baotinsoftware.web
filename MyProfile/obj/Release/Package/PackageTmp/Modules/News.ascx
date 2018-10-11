<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="News.ascx.cs" Inherits="MyProfile.Modules.News" %>
<%@ Import Namespace="MyProfile.Class" %>

<div class="blog-post-area">
	<h2 class="title text-center"><asp:Literal ID="ltr_Title" runat="server"></asp:Literal></h2>
    <asp:Repeater ID="rpt_ListNewsEventOfCategory" runat="server">
        <ItemTemplate>
            <div class="single-blog-post">
                <a href="<%# "/" + GetCategoryName(Convert.ToInt32(Eval("ID_GroupNews")), false) + Eval("Tag","/{0}") + Eval("ID","-{0}.html") %>">
		            <h3><%# Eval("Title") %></h3>
                </a>
		        <div class="post-meta">
			        <ul>
				        <li><i class="fa fa-folder-open"></i> <%# GetCategoryName(Convert.ToInt32(Eval("ID_GroupNews")), true) %></li>
						<li><i class="fa fa-user"></i> <%# Singleton<UserAdmin>.Inst.GET_TABLE_USER_PRIMARYKEY(Convert.ToInt32(Eval("ID_UserPost"))).Fullname %></li>									
						<li><i class="fa fa-calendar"></i> <%# Eval("Date","{0:dd/MM/yyyy}") %></li>
                        <li><i class="fa fa-eye"></i> <%# Eval("TotalView") %> Views</li>                        
			        </ul>			        
		        </div>
                <div class="row">
                    <div class="col-sm-4">
                        <a href="<%# "/" + GetCategoryName(Convert.ToInt32(Eval("ID_GroupNews")), false) + Eval("Tag","/{0}") + Eval("ID","-{0}.html") %>" title="<%# Eval("Title") %>">
			                <img src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>">
		                </a>
                    </div>
		            <div class="col-sm-8">
                        <div class="sub-sapo">
                            <%# Eval("News_Sapo") %>
                        </div>
		                <a class="btn btn-primary" href="<%# "/" + GetCategoryName(Convert.ToInt32(Eval("ID_GroupNews")), false) + Eval("Tag","/{0}") + Eval("ID","-{0}.html") %>">Read more<i style="padding-left: 5px;" class="fa fa-chevron-right fa-1x"></i></a>
		            </div>
                </div>		
	        </div>
        </ItemTemplate>
    </asp:Repeater>
    		
	<%--<div class="pagination-area">
		<ul class="pagination">
			<li><a href="" class="active">1</a></li>
			<li><a href="">2</a></li>
			<li><a href="">3</a></li>
			<li><a href=""><i class="fa fa-angle-double-right"></i></a></li>
		</ul>
	</div>--%>
</div>


