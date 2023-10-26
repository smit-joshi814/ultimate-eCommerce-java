<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@page import="conModule.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Shop categories</title>
<%@include file="components/imports.jsp"%>

</head>
<!-- Body-->
<body>
	<main class="page-wrapper">
		<!-- Navbar 3 Level (Light)-->
		<%@include file="components/header.jsp"%>
		<!-- Page Title (Light)-->
		<div class="bg-secondary py-4">
			<div class="container d-lg-flex justify-content-between py-2 py-lg-3">
				<div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
					<nav aria-label="breadcrumb">
						<ol
							class="breadcrumb flex-lg-nowrap justify-content-center justify-content-lg-start">
							<li class="breadcrumb-item"><a class="text-nowrap"
								href="index.jsp"><i class="ci-home"></i>Home</a></li>
							<li class="breadcrumb-item text-nowrap"><a href="#">Shop</a>
							</li>
							<li class="breadcrumb-item text-nowrap active"
								aria-current="page">Categories</li>
						</ol>
					</nav>
				</div>
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
					<h1 class="h3 mb-0">Shop categories</h1>
				</div>
			</div>
		</div>
		<div class="container pb-4 pb-sm-5">

			<%
      ResultSet rs,subcat,counts;
      Connection cn=ConnectionProvider.getCon();
      PreparedStatement ps;
      if(request.getParameter("cid")!=null){
    	  ps=cn.prepareStatement("SELECT * from product_categories WHERE parent_category_id=?");
    	  ps.setString(1, request.getParameter("cid"));
      }else{
    	  ps=cn.prepareStatement("SELECT * FROM product_categories WHERE parent_category_id IS NULL");  
      }
      rs=ps.executeQuery();
      %>
			<!-- Categories grid-->
			<div class="row pt-5 justify-content-start justify-content-sm-center">
				<!-- Catogory-->

				<%while(rs.next()){
          	ps=cn.prepareStatement("SELECT count(category_id) FROM product_categories WHERE parent_category_id=?");
          	ps.setString(1, rs.getString("category_id"));
          	counts=ps.executeQuery();
          	counts.next();
          %>
				<div class="col-lg-4 col-md-6 col-sm-8 mb-3">
					<div class="card border-1" data-bs-toggle="tooltip"
						data-bs-placement="Top" title="<%=rs.getString("category_name")%>">
						<% 	if(counts.getString(1).equals("0")){ %>
						<a class="d-flex justify-content-center overflow-hidden rounded-3"
							href="products-rs.jsp?cid=<%=rs.getString("category_id")%> ">
							<%}else{ %> <a
							class="d-flex justify-content-center overflow-hidden rounded-3"
							href="shop-categories.jsp?cid=<%=rs.getString("category_id")%> ">
								<%} %> <img class="w-100 mt-1"
								style="max-width: 100%; height: 150px; object-fit: contain;"
								src="img/shop/categories/<%=rs.getString("category_image")%>"
								alt="<%=rs.getString("category_name")%>">
						</a>
							<div class="card-body">
								<h2 class="h5"><%=rs.getString("category_name")%></h2>
								<ul class="list-unstyled fs-sm mb-0">
									<%
                	ps=cn.prepareStatement("SELECT category_id,category_name from product_categories WHERE parent_category_id=? LIMIT 5");
                	ps.setString(1, rs.getString("category_id"));
                	subcat=ps.executeQuery();
                	while(subcat.next()){
                		ps = cn.prepareStatement("SELECT count(category_id) FROM product_categories WHERE parent_category_id=?");
                		ps.setString(1, subcat.getString("category_id"));
                		counts=ps.executeQuery();
                		counts.next();
                		if(counts.getString(1).equals("0")){
                %>
									<li class="d-flex align-items-center justify-content-between"><a
										class="nav-link-style"
										href="products-rs.jsp?cid=<%=subcat.getString("category_id")%>"><i
											class="ci-arrow-right-circle me-2"></i><%=subcat.getString("category_name")%></a><span
										class="fs-ms text-muted">&nbsp;</span></li>
									<% }else {
				%>
									<li class="d-flex align-items-center justify-content-between"><a
										class="nav-link-style"
										href="shop-categories.jsp?cid=<%=subcat.getString("category_id")%>"><i
											class="ci-arrow-right-circle me-2"></i><%=subcat.getString("category_name")%></a><span
										class="fs-ms text-muted">&nbsp;</span></li>
									<%
                   }
              } %>
									<li>
										<hr>
									</li>
									<li class="d-flex align-items-center justify-content-between"><a
										class="nav-link-style"
										href="products-rs.jsp?cid=<%=rs.getString("category_id")%>"><i
											class="ci-arrow-right-circle me-2"></i>View Products</a><span
										class="fs-ms text-muted">&nbsp;</span></li>
								</ul>
							</div>
					</div>
				</div>
				<% } %>
				<!-- Catogory-->
			</div>
			<!-- Popular brands-->

		</div>
	</main>
	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<script>
		$("#nav-item-categories").addClass("active");
	</script>
</body>
</html>