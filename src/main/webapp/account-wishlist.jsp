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
<title>MyECommerseSite | My wishlist</title>

<%@include file="components/imports.jsp"%>

</head>
<!-- Body-->
<body>
	<main class="page-wrapper">
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
								aria-current="page">Wishlist</li>
						</ol>
					</nav>
				</div>
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
					<h1 class="h3 text-light mb-0">My wishlist</h1>
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
										data-bs-toggle="tooltip" title="Verified">Verified</span><img
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
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-orders.jsp"><i class="ci-bag opacity-60 me-2"></i>Orders<span
										class="fs-sm text-muted ms-auto"><%=rs.getString(1)%></span></a></li>
								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3 active"
									href="account-wishlist.jsp"><i
										class="ci-heart opacity-60 me-2"></i>Wishlist<span
										class="fs-sm text-muted ms-auto">3</span></a></li>
								<li class="mb-0"><a
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
						class="d-none d-lg-flex justify-content-between align-items-center pt-lg-3 pb-4 pb-lg-5 mb-lg-3">
						<h6 class="fs-base text-light mb-0">List of items you added
							to wishlist:</h6>
						<a class="btn btn-primary btn-sm"
							href="account-signin.jsp?SignOut=1"><i
							class="ci-sign-out me-2"></i>Sign out</a>
					</div>
					<!-- Wishlist-->
					<!-- Item-->
					<div
						class="d-sm-flex justify-content-between mt-lg-4 mb-4 pb-3 pb-sm-2 border-bottom">
						<div
							class="d-block d-sm-flex align-items-start text-center text-sm-start">
							<a class="d-block flex-shrink-0 mx-auto me-sm-4"
								href="shop-single-v1.jsp" style="width: 10rem;"><img
								src="img/shop/cart/02.jpg" alt="Product"></a>
							<div class="pt-2">
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
							<button class="btn btn-outline-danger btn-sm" type="button">
								<i class="ci-trash me-2"></i>Remove
							</button>
						</div>
					</div>
					<!-- Item-->
					<div
						class="d-sm-flex justify-content-between my-4 pb-3 pb-sm-2 border-bottom">
						<div
							class="d-block d-sm-flex align-items-start text-center text-sm-start">
							<a class="d-block flex-shrink-0 mx-auto me-sm-4"
								href="shop-single-v1.jsp" style="width: 10rem;"><img
								src="img/shop/cart/03.jpg" alt="Product"></a>
							<div class="pt-2">
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
							<button class="btn btn-outline-danger btn-sm" type="button">
								<i class="ci-trash me-2"></i>Remove
							</button>
						</div>
					</div>
					<!-- Item-->
					<div class="d-sm-flex justify-content-between mt-4">
						<div
							class="d-block d-sm-flex align-items-start text-center text-sm-start">
							<a class="d-block flex-shrink-0 mx-auto me-sm-4"
								href="shop-single-v1.jsp" style="width: 10rem;"><img
								src="img/shop/cart/04.jpg" alt="Product"></a>
							<div class="pt-2">
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
							<button class="btn btn-outline-danger btn-sm" type="button">
								<i class="ci-trash me-2"></i>Remove
							</button>
						</div>
					</div>
				</section>
			</div>
		</div>
	</main>
	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<script>
		$("#nav-item-Account").addClass("active");
		$("#nav-Item-Account-Wishlist").addClass("active");
	</script>
</body>
</html>