<%@page import="java.sql.*"%>
<%@page import="conModule.*"%>
<%
ResultSet rsH=null;
String name[]=null;
boolean signedIn=false;
if(session.getAttribute("uid")!=null){
	Connection conH=ConnectionProvider.getCon();
	PreparedStatement psH=conH.prepareStatement("SELECT * FROM site_users WHERE user_id=?");
	psH.setString(1, session.getAttribute("uid").toString());
	rsH=psH.executeQuery();
	rsH.next();
	signedIn=true;
	name=rsH.getString("user_name").split(" ");
}
%>
<header class="shadow-sm">
	<!-- Remove "navbar-sticky" class to make navigation bar scrollable with the page.-->
	<div class="navbar-sticky bg-light">
		<div class="navbar navbar-expand-lg navbar-light">
			<div class="container">
				<a class="navbar-brand d-flex flex-shrink-0 align-items-center"
					style="font-size: 0.879rem" href="index.jsp"><img
					class="rounded-circle" style="max-width: 40px;" src="img/logo.png"
					alt="MyECommerceSite">&nbsp;MyECommerceSite</a>
				<form class="input-group d-none d-lg-flex mx-4"
					action="products-rs.jsp">
					<input class="form-control rounded-end pe-5" type="text"
						name="search"
						value="<%=request.getParameter("search")!=null?request.getParameter("search"):""%>"
						placeholder="Search for products">
					<button type="submit"
						class="border-0 bg-none position-absolute top-50 end-0 translate-middle-y text-muted fs-base me-3">
						<i class="ci-search"></i>
					</button>
				</form>
				<div class="navbar-toolbar d-flex flex-shrink-0 align-items-center">
					<button class="navbar-toggler" type="button"
						data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
						<span class="navbar-toggler-icon"></span>
					</button>
					<a class="navbar-tool navbar-stuck-toggler" href="#"><span
						class="navbar-tool-tooltip">Expand menu</span>
						<div class="navbar-tool-icon-box">
							<i class="navbar-tool-icon ci-menu"></i>
						</div></a>
					<%if(signedIn){ %>
					<a style="display: none !important"
						class="navbar-tool d-none d-lg-flex" id="nav-wishlist-icon"
						href="account-wishlist.jsp"><span class="navbar-tool-tooltip">Wishlist</span>
						<div class="navbar-tool-icon-box">
							<i class="navbar-tool-icon ci-heart"></i>
						</div></a>
					<%}if(signedIn){ %>
					<a class="navbar-tool ms-1 ms-lg-0 me-n1 me-lg-2"
						href="account-profile.jsp" data-bs-toggle="tooltip"
						data-bs-placement="bottom" title="My Account">
						<div class="navbar-tool-icon-box">
							<i class="navbar-tool-icon ci-user"></i>
						</div>
						<div class="navbar-tool-text ms-n3">
							<small>Hello, <%=name[0]%></small>My Account
						</div>
					</a>
					<%}else{ %>
					<a class="navbar-tool ms-1 ms-lg-0 me-n1 me-lg-2"
						href="account-signin.jsp" data-bs-toggle="tooltip"
						data-bs-placement="bottom" title="SignIn To Access Account">
						<div class="navbar-tool-icon-box">
							<i class="navbar-tool-icon ci-user"></i>
						</div>
						<div class="navbar-tool-text ms-n3">
							<small>Hello, Sign in</small>My Account
						</div>
					</a>
					<%} %>
					<div class="navbar-tool dropdown ms-3">
						<a class="navbar-tool-icon-box bg-secondary dropdown-toggle"
							href="shop-cart.jsp"><span class="navbar-tool-label"
							id="cart-item-count-on-header"></span><i
							class="navbar-tool-icon ci-cart"></i></a><a class="navbar-tool-text"
							href="shop-cart.jsp" id="price-label-under-MyCart"></a>
						<!-- Cart dropdown-->
						<div class="dropdown-menu dropdown-menu-end" id="cart-on-header">
							<div class="widget widget-cart px-3 pt-2 pb-3"
								style="width: 20rem;">
								<div style="max-height: 15rem; overflow-x: hidden;"
									data-simplebar="init" data-simplebar-auto-hide="false"
									id="cart-items-on-header"></div>
								<div
									class="d-flex flex-wrap justify-content-between align-items-center py-3"
									id="cart-total-value-wrapper">
									<div class="fs-sm me-2 py-2">
										<span class="text-muted">Subtotal: </span><span
											class="text-accent fs-base ms-1"
											id="cart-total-value-container"></span>
									</div>
									<a class="btn btn-outline-secondary btn-sm"
										href="shop-cart.jsp">Expand cart<i
										class="ci-arrow-right ms-1 me-n1"></i></a>
								</div>
								<a class="btn btn-primary btn-sm d-block w-100"
									href="<%if(session.getAttribute("uid")!=null){ %>checkout-details.jsp<% }else{ %>account-signin.jsp?checkout=true<% } %>"
									id="cart-header-checkout"><i
									class="ci-card me-2 fs-base align-middle"></i>Checkout</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div
			class="navbar navbar-expand-lg navbar-light navbar-stuck-menu mt-n2 pt-0 pb-2">
			<div class="container">
				<div class="collapse navbar-collapse" id="navbarCollapse">
					<!-- Search-->
					<div class="input-group d-lg-none my-3">
						<i
							class="ci-search position-absolute top-50 start-0 translate-middle-y text-muted fs-base ms-3"></i>
						<input class="form-control rounded-start" type="text"
							placeholder="Search for products">
					</div>
					<!-- Primary menu-->
					<ul class="navbar-nav">
						<li class="nav-item" id="nav-item-home"><a class="nav-link"
							href="index.jsp">Home</a></li>
						<li class="nav-item dropdown" id="nav-item-categories"><a
							class="nav-link dropdown-toggle" href="shop-categories.jsp"
							data-bs-toggle="dropdown">Categories</a>
							<div class="dropdown-menu p-0">
								<div class="d-flex flex-wrap flex-sm-nowrap px-2">

									<% 
                      Connection cnH=ConnectionProvider.getCon();
                		PreparedStatement psCat=cnH.prepareStatement("SELECT category_id,category_name FROM product_categories WHERE parent_category_id IS NULL");
                		ResultSet rsCat=psCat.executeQuery();
                		boolean flag=true;
                		while(rsCat.next()){
                			if(flag){
                      %><div
										class="mega-dropdown-column pt-1 pt-lg-4 pb-4 px-2 px-lg-3">
										<% } %>
										<div class="widget widget-links mb-4">
											<a class="fs-base mb-3 h6"
												href="shop-categories.jsp?cid=<%=rsCat.getString("category_id")%>"><%=rsCat.getString("category_name")%></a>
											<ul class="widget-list">
												<% psCat=cnH.prepareStatement("SELECT category_id,category_name FROM product_categories WHERE parent_category_id=? LIMIT 5");
                            psCat.setString(1, rsCat.getString("category_id"));
                            ResultSet rsSubCat=psCat.executeQuery();
                            while(rsSubCat.next()){
                            %>
												<li class="widget-list-item"><a
													class="widget-list-link"
													href="shop-categories.jsp?cid=<%=rsSubCat.getString("category_id")%>"><%=rsSubCat.getString("category_name") %></a></li>
												<% } %>
											</ul>
										</div>
										<% if(!flag){ %>
									</div>
									<%
                        flag=true;
                        }else{ flag=false; } } %>
								</div>
							</div></li>
						<%if(signedIn){ %>
						<li class="nav-item dropdown" id="nav-item-Account"><a
							class="nav-link dropdown-toggle" href="#"
							data-bs-toggle="dropdown" data-bs-auto-close="outside">Account</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" id="nav-Item-Account-Orders"
									href="account-orders.jsp">Orders History</a></li>
								<li><a class="dropdown-item" id="nav-Item-Account-settings"
									href="account-profile.jsp">Profile Settings</a></li>
								<li><a class="dropdown-item" id="nav-Item-Account-Address"
									href="account-address.jsp">Account Addresses</a></li>
								<li><a class="dropdown-item" id="nav-Item-Account-Payment"
									href="account-payment.jsp">Payment Methods</a></li>
								<li><a class="dropdown-item" id="nav-Item-Account-Wishlist"
									href="account-wishlist.jsp">Wishlist</a></li>
							</ul></li>
						<% } %>
						<li class="nav-item dropdown" id="nav-item-Pages"><a
							class="nav-link dropdown-toggle" href="#"
							data-bs-toggle="dropdown" data-bs-auto-close="outside">Pages</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" id="page-about-us"
									href="about.jsp">About Us</a></li>
								<li><a class="dropdown-item" id="page-contacts"
									href="contacts.jsp">Contacts</a></li>
								<li><a class="dropdown-item" id="page-help-center"
									href="help-topics.jsp">Help Center</a></li>
							</ul></li>
						<li class="nav-item" id="nav-item-Blog"><a class="nav-link"
							href="blog.jsp" data-bs-auto-close="outside">Blog</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</header>
<script>
      
      $("#nav-item-Pages").hide();
      $("#nav-item-Blog").hide();
      $("#nav-Item-Account-Wishlist").hide();
      //now working remove inline style
      $("#nav-wishlist-icon").hide();
      $("#nav-item-categories").on("click",function(){
    	  window.location.href = 'shop-categories.jsp'; 
      });
      </script>