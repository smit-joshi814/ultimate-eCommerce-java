<%@page import="generalModule.FormatPrice"%>
<%@page import="java.text.Format"%>
<%@page import="com.mysql.cj.xdevapi.Result"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
Connection cn = ConnectionProvider.getCon();
PreparedStatement ps;
ResultSet rs;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | My orders</title>

<%@include file="components/imports.jsp"%>

</head>
<!-- Body-->
<body>

	<main class="page-wrapper">
		<!-- Order Details Modal-->
		<div class="modal fade" id="order-details">
			<div class="modal-dialog modal-lg modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Order No - 34VB5540K83</h5>
						<button class="btn-close" type="button" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body pb-0">
						<!-- Item-->
						<div
							class="d-sm-flex justify-content-between mb-4 pb-3 pb-sm-2 border-bottom">
							<div class="d-sm-flex text-center text-sm-start">
								<a class="d-inline-block flex-shrink-0 mx-auto"
									href="shop-single-v1.jsp" style="width: 10rem;"><img
									src="img/shop/cart/01.jpg" alt="Product"></a>
								<div class="ps-sm-4 pt-2">
									<h3 class="product-title fs-base mb-2">
										<a href="shop-single-v1.jsp">Women Colorblock Sneakers</a>
									</h3>
									<div class="fs-sm">
										<span class="text-muted me-2">Size:</span>8.5
									</div>
									<div class="fs-sm">
										<span class="text-muted me-2">Color:</span>White &amp; Blue
									</div>
									<div class="fs-lg text-accent pt-2">
										$154.<small>00</small>
									</div>
								</div>
							</div>
							<div class="pt-2 ps-sm-3 mx-auto mx-sm-0 text-center">
								<div class="text-muted mb-2">Quantity:</div>
								1
							</div>
							<div class="pt-2 ps-sm-3 mx-auto mx-sm-0 text-center">
								<div class="text-muted mb-2">Subtotal</div>
								$154.<small>00</small>
							</div>
						</div>
						<!-- Item-->
						<div
							class="d-sm-flex justify-content-between my-4 pb-3 pb-sm-2 border-bottom">
							<div class="d-sm-flex text-center text-sm-start">
								<a class="d-inline-block flex-shrink-0 mx-auto"
									href="shop-single-v1.jsp" style="width: 10rem;"><img
									src="img/shop/cart/02.jpg" alt="Product"></a>
								<div class="ps-sm-4 pt-2">
									<h3 class="product-title fs-base mb-2">
										<a href="shop-single-v1.jsp">TH Jeans City Backpack</a>
									</h3>
									<div class="fs-sm">
										<span class="text-muted me-2">Brand:</span>Tommy Hilfiger
									</div>
									<div class="fs-sm">
										<span class="text-muted me-2">Color:</span>Khaki
									</div>
									<div class="fs-lg text-accent pt-2">
										$79.<small>50</small>
									</div>
								</div>
							</div>
							<div class="pt-2 ps-sm-3 mx-auto mx-sm-0 text-center">
								<div class="text-muted mb-2">Quantity:</div>
								1
							</div>
							<div class="pt-2 ps-sm-3 mx-auto mx-sm-0 text-center">
								<div class="text-muted mb-2">Subtotal</div>
								$79.<small>50</small>
							</div>
						</div>
						<!-- Item-->
						<div
							class="d-sm-flex justify-content-between my-4 pb-3 pb-sm-2 border-bottom">
							<div class="d-sm-flex text-center text-sm-start">
								<a class="d-inline-block flex-shrink-0 mx-auto"
									href="shop-single-v1.jsp" style="width: 10rem;"><img
									src="img/shop/cart/03.jpg" alt="Product"></a>
								<div class="ps-sm-4 pt-2">
									<h3 class="product-title fs-base mb-2">
										<a href="shop-single-v1.jsp">3-Color Sun Stash Hat</a>
									</h3>
									<div class="fs-sm">
										<span class="text-muted me-2">Brand:</span>The North Face
									</div>
									<div class="fs-sm">
										<span class="text-muted me-2">Color:</span>Pink / Beige / Dark
										blue
									</div>
									<div class="fs-lg text-accent pt-2">
										$22.<small>50</small>
									</div>
								</div>
							</div>
							<div class="pt-2 ps-sm-3 mx-auto mx-sm-0 text-center">
								<div class="text-muted mb-2">Quantity:</div>
								1
							</div>
							<div class="pt-2 ps-sm-3 mx-auto mx-sm-0 text-center">
								<div class="text-muted mb-2">Subtotal</div>
								$22.<small>50</small>
							</div>
						</div>
						<!-- Item-->
						<div class="d-sm-flex justify-content-between my-4">
							<div class="d-sm-flex text-center text-sm-start">
								<a class="d-inline-block flex-shrink-0 mx-auto"
									href="shop-single-v1.jsp" style="width: 10rem;"><img
									src="img/shop/cart/04.jpg" alt="Product"></a>
								<div class="ps-sm-4 pt-2">
									<h3 class="product-title fs-base mb-2">
										<a href="shop-single-v1.jsp">Cotton Polo Regular Fit</a>
									</h3>
									<div class="fs-sm">
										<span class="text-muted me-2">Size:</span>42
									</div>
									<div class="fs-sm">
										<span class="text-muted me-2">Color:</span>Light blue
									</div>
									<div class="fs-lg text-accent pt-2">
										$9.<small>00</small>
									</div>
								</div>
							</div>
							<div class="pt-2 ps-sm-3 mx-auto mx-sm-0 text-center">
								<div class="text-muted mb-2">Quantity:</div>
								1
							</div>
							<div class="pt-2 ps-sm-3 mx-auto mx-sm-0 text-center">
								<div class="text-muted mb-2">Subtotal</div>
								$9.<small>00</small>
							</div>
						</div>
					</div>
					<!-- Footer-->
					<div
						class="modal-footer flex-wrap justify-content-between bg-secondary fs-md">
						<div class="px-2 py-1">
							<span class="text-muted">Subtotal:&nbsp;</span><span>$265.<small>00</small></span>
						</div>
						<div class="px-2 py-1">
							<span class="text-muted">Shipping:&nbsp;</span><span>$22.<small>50</small></span>
						</div>
						<div class="px-2 py-1">
							<span class="text-muted">Tax:&nbsp;</span><span>$9.<small>50</small></span>
						</div>
						<div class="px-2 py-1">
							<span class="text-muted">Total:&nbsp;</span><span class="fs-lg">$297.<small>00</small></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Navbar 3 Level (Light)-->
		<%@include file="components/header.jsp"%>
		<!-- Page Title-->
		<div class="page-title-overlap bg-dark pt-4">
			<div class="container d-lg-flex justify-content-between py-2 py-lg-3">
				<div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
					<nav aria-label="breadcrumb">
						<ol
							class="breadcrumb breadcrumb-light flex-lg-nowrap justify-content-center justify-content-lg-start">
							<li class="breadcrumb-item"><a class="text-nowrap"
								href="index.jsp"><i class="ci-home"></i>Home</a></li>
							<li class="breadcrumb-item text-nowrap"><a href="#">Account</a>
							</li>
							<li class="breadcrumb-item text-nowrap active"
								aria-current="page">Orders history</li>
						</ol>
					</nav>
				</div>
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
					<h1 class="h3 text-light mb-0">My orders</h1>
				</div>
			</div>
		</div>
		<div class="container pb-5 mb-2 mb-md-4">
			<div class="row">
				<!-- Sidebar-->
				<aside class="col-lg-4 pt-4 pt-lg-0 pe-xl-5">
					<div class="bg-white rounded-3 shadow-lg pt-1 mb-5 mb-lg-0">
						<div
							class="d-md-flex justify-content-between align-items-center text-center text-md-start p-4">
							<div class="d-md-flex align-items-center">
								<div
									class="img-thumbnail rounded position-relative flex-shrink-0 mx-auto mb-2 mx-md-0 mb-md-0"
									style="width: 6.375rem;">
									<span class="badge bg-success position-absolute end-0 mt-n2"
										data-bs-toggle="tooltip" title="verified">Verified</span><img
										class="rounded"
										src="img/shop/account/<%=rsH.getString("user_image")%>"
										alt="<%=rsH.getString("user_name")%>">
								</div>
								<div class="ps-md-3">
									<h3 class="fs-base mb-0"><%=rsH.getString("user_name")%></h3>
									<span class="text-accent fs-sm"><%=rsH.getString("user_email")%></span>
								</div>
							</div>
							<a class="btn btn-primary d-lg-none mb-2 mt-3 mt-md-0"
								href="#account-menu" data-bs-toggle="collapse"
								aria-expanded="false"><i class="ci-menu me-2"></i>Account
								menu</a>
						</div>
						<div class="d-lg-block collapse" id="account-menu">
							<div class="bg-secondary px-4 py-3">
								<h3 class="fs-sm mb-0 text-muted">Dashboard</h3>
							</div>
							<ul class="list-unstyled mb-0">
								<%
								ps = cn.prepareStatement("SELECT count(order_id) FROM shop_order WHERE user_id=?");
								ps.setString(1, session.getAttribute("uid").toString());
								rs = ps.executeQuery();
								rs.next();
								%>

								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3 active"
									href="account-orders.jsp"><i class="ci-bag opacity-60 me-2"></i>Orders<span
										class="fs-sm text-muted ms-auto"><%=rs.getInt(1) %></span></a></li>
								<li class="border-bottom mb-0" id="wish-list"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-wishlist.jsp"><i
										class="ci-heart opacity-60 me-2"></i>Wishlist<span
										class="fs-sm text-muted ms-auto">3</span></a></li>
								<li class="mb-0" id="support-tickets"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-tickets.jsp"><i
										class="ci-help opacity-60 me-2"></i>Support tickets<span
										class="fs-sm text-muted ms-auto">1</span></a></li>
							</ul>
							<div class="bg-secondary px-4 py-3">
								<h3 class="fs-sm mb-0 text-muted">Account settings</h3>
							</div>
							<ul class="list-unstyled mb-0">
								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-profile.jsp"><i
										class="ci-user opacity-60 me-2"></i>Profile info</a></li>
								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-address.jsp"><i
										class="ci-location opacity-60 me-2"></i>Addresses</a></li>
								<li class="mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-payment.jsp"><i
										class="ci-card opacity-60 me-2"></i>Payment methods</a></li>
								<li class="d-lg-none border-top mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-signin.jsp?SignOut=1"><i
										class="ci-sign-out opacity-60 me-2"></i>Sign out</a></li>
							</ul>
						</div>
					</div>
				</aside>
				<!-- Content  -->
				<section class="col-lg-8">
					<!-- Toolbar-->
					<div
						class="d-flex justify-content-between align-items-center pt-lg-2 pb-4 pb-lg-5 mb-lg-3">
						<div class="d-flex align-items-center">
							<label
								class="d-none d-lg-block fs-sm text-light text-nowrap opacity-75 me-2"
								for="order-sort">Sort orders:</label> <label
								class="d-lg-none fs-sm text-nowrap opacity-75 me-2"
								for="order-sort">Sort orders:</label> <select
								class="form-select" id="order-sort">
								<option>All</option>
								<option>Delivered</option>
								<option>In Progress</option>
								<option>Delayed</option>
								<option>Canceled</option>
							</select>
						</div>
						<a class="btn btn-primary btn-sm d-none d-lg-inline-block"
							href="account-signin.jsp?SignOut=1"><i
							class="ci-sign-out me-2"></i>Sign out</a>
					</div>
					<!-- Orders list-->
					<div class="table-responsive fs-md mb-4">
						<table class="table table-hover mb-0">
							<thead>
								<tr>
									<th>Order #</th>
									<th>Date Purchased</th>
									<th>Status</th>
									<th>Total</th>
								</tr>
							</thead>
							<tbody>
								<%
								ps = cn.prepareStatement(
										"SELECT O.order_id,DATE_FORMAT(O.order_date,'%d-%M-%Y')as order_date,O.order_total,S.status_value FROM shop_order O INNER JOIN order_status S ON O.order_status=S.status_id WHERE O.user_id=?");
								ps.setString(1, session.getAttribute("uid").toString());
								rs = ps.executeQuery();
								while (rs.next()) {
									String status = rs.getString("status_value");
									String badgeColor = "";
									if (status.equalsIgnoreCase("pending")) {
										badgeColor = "bg-warning";
									}
									if (status.equalsIgnoreCase("Shipped")) {
										badgeColor = "bg-info";
									}
									if (status.equalsIgnoreCase("Manual Verification")) {
										badgeColor = "bg-secondary";
									}
									if (status.equalsIgnoreCase("Dispatched")) {
										badgeColor = "bg-primary";
									}
									if (status.equalsIgnoreCase("completed")) {
										badgeColor = "bg-success";
									}
									if (status.equalsIgnoreCase("Cancelled")) {
										badgeColor = "bg-danger";
									}
								%>
								<tr>
									<td class="py-3"><a class="nav-link-style fw-medium fs-sm"
										href="#order-detailss" data-bs-toggle="modal"><%=rs.getString("order_id")%></a></td>
									<td class="py-3"><%=rs.getString("order_date")%></td>
									<td class="py-3"><span class="badge <%=badgeColor%> m-0"><%=rs.getString("status_value")%></span></td>
									<td class="py-3"><%=FormatPrice.formatPrice(rs.getString("order_total"))%></td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
					<!-- Pagination-->
					<nav class="d-flex justify-content-between pt-2"
						aria-label="Page navigation">
						<ul class="pagination">
							<li class="page-item"><a class="page-link" href="#"><i
									class="ci-arrow-left me-2"></i>Prev</a></li>
						</ul>
						<ul class="pagination">
							<li class="page-item d-sm-none"><span
								class="page-link page-link-static">1 / 5</span></li>
							<li class="page-item active d-none d-sm-block"
								aria-current="page"><span class="page-link">1<span
									class="visually-hidden">(current)</span></span></li>
							<li class="page-item d-none d-sm-block"><a class="page-link"
								href="#">2</a></li>
							<li class="page-item d-none d-sm-block"><a class="page-link"
								href="#">3</a></li>
							<li class="page-item d-none d-sm-block"><a class="page-link"
								href="#">4</a></li>
							<li class="page-item d-none d-sm-block"><a class="page-link"
								href="#">5</a></li>
						</ul>
						<ul class="pagination">
							<li class="page-item"><a class="page-link" href="#"
								aria-label="Next">Next<i class="ci-arrow-right ms-2"></i></a></li>
						</ul>
					</nav>
				</section>
			</div>
		</div>
	</main>
	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<script>
		$("#nav-Item-Account").addClass("active");
		$("#nav-Item-Account-Orders").addClass("active");
		$("#wish-list").hide();
		$("#support-tickets").hide();
	</script>
</body>
</html>