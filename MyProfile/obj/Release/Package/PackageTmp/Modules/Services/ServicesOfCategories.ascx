<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServicesOfCategories.ascx.cs" Inherits="MyProfile.Modules.Services.ServicesOfCategories" %>
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
            <div class="row service-box">
                <asp:Repeater runat="server" ID="rpt_ServiceOfCategories">                    
                    <ItemTemplate>
                        <div class="col-sm-4 col-md-4 col-lg-4">						
					        <div class="items-thumb">
						        <a title="<%# Eval("Title") %>" href="<%# "/our-services/" + GetTagGroupServices(Convert.ToInt32(Eval("ID_GroupServices"))) + "/" + Eval("Tag") + Eval("ID","-{0}.html") %>">
							        <img src="<%# Eval("Image") %>" alt="<%# Eval("Title") %>" />
							        <span></span>
						        </a>
					        </div>
					        <div class="items-sub">
						        <div class="subTitle">
							        <a title="<%# Eval("Title") %>" href="<%# "/our-services/" + GetTagGroupServices(Convert.ToInt32(Eval("ID_GroupServices"))) + "/" + Eval("Tag") + Eval("ID","-{0}.html") %>">
								        <h2><%# Eval("Title") %></h2>									
							        </a>
						        </div>							
						        <div class="subSapo">
							        <%# Server.HtmlDecode(Eval("Sub").ToString()) %>
						        </div>
						        <div class="list-metaInfo">
							        <span><i class="fa fa-calendar"></i> <a><%# Eval("Date","{0:dd/MM/yyyy}") %></a></span>
							        <span><i class="fa fa-user"></i> By <a><%# Singleton<UserAdmin>.Inst.GET_TABLE_USER_PRIMARYKEY(Convert.ToInt32(Eval("ID_UserPost"))).Fullname %></a></span>
							        <span><i class="fa fa-eye"></i> <a><%# Eval("TotalView") %> Views</a></span>
						        </div>							
					        </div>						
				        </div>
                    </ItemTemplate>                    
                </asp:Repeater>                				
				<%--<div class="col-md-12 col-lg-12 col-sm-12 ">							
					<ul class="pagination pull-left">
						<li><a href="#">First</a></li>
						<li><a href="#">«</a></li>
						<li class="active"><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
						<li><a href="#">»</a></li>
						<li><a href="#">Last</a></li>
					</ul>
				</div>--%>
            </div>
            <!--end row-->
        </div>
    </div>
</section>