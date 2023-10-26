<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Signle ticket</title>
<%@include file="components/imports.jsp"%>
<!-- Google Tag Manager-->
<script>
      (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
      new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
      j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
      '../www.googletagmanager.com/gtm5445.jsp?id='+i+dl;f.parentNode.insertBefore(j,f);
      })(window,document,'script','dataLayer','GTM-WKV3GT5');
    </script>
</head>
<!-- Body-->
<body>
	<!-- Google Tag Manager (noscript)-->
	<noscript>
		<iframe src="http://www.googletagmanager.com/ns.jsp?id=GTM-WKV3GT5"
			height="0" width="0" style="display: none; visibility: hidden;"></iframe>
	</noscript>

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
								aria-current="page">Single ticket</li>
						</ol>
					</nav>
				</div>
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
					<h1 class="h3 text-light mb-0">Signle ticket</h1>
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
										src="img/shop/account/<%=rsH.getString("user_image") %>"
										alt="<%=rsH.getString("user_name")%>">
								</div>
								<div class="ps-md-3">
									<h3 class="fs-base mb-0"><%=rsH.getString("user_name") %></h3>
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
								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-orders.jsp"><i class="ci-bag opacity-60 me-2"></i>Orders<span
										class="fs-sm text-muted ms-auto">1</span></a></li>
								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-wishlist.jsp"><i
										class="ci-heart opacity-60 me-2"></i>Wishlist<span
										class="fs-sm text-muted ms-auto">3</span></a></li>
								<li class="mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3 active"
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
						class="d-none d-lg-flex justify-content-between align-items-center pt-lg-3 pb-4 pb-lg-5 mb-lg-4">
						<div class="d-flex w-100 text-light text-center me-3">
							<div class="fs-ms px-3">
								<div class="fw-medium">Date Submitted</div>
								<div class="opacity-60">09/27/2019</div>
							</div>
							<div class="fs-ms px-3">
								<div class="fw-medium">Last Updated</div>
								<div class="opacity-60">09/30/2019</div>
							</div>
							<div class="fs-ms px-3">
								<div class="fw-medium">Type</div>
								<div class="opacity-60">Website problem</div>
							</div>
							<div class="fs-ms px-3">
								<div class="fw-medium">Priority</div>
								<span class="badge bg-warning">High</span>
							</div>
							<div class="fs-ms px-3">
								<div class="fw-medium">Status</div>
								<span class="badge bg-success">Open</span>
							</div>
						</div>
						<a class="btn btn-primary btn-sm"
							href="account-signin.jsp?SignOut=1"><i
							class="ci-sign-out me-2"></i>Sign out</a>
					</div>
					<!-- Ticket details (visible on mobile)-->
					<div
						class="d-flex d-lg-none flex-wrap bg-secondary text-center rounded-3 pt-4 px-4 pb-1 mb-4">
						<div class="fs-sm px-3 pb-3">
							<div class="fw-medium">Date Submitted</div>
							<div class="text-muted">09/27/2019</div>
						</div>
						<div class="fs-sm px-3 pb-3">
							<div class="fw-medium">Last Updated</div>
							<div class="text-muted">09/30/2019</div>
						</div>
						<div class="fs-sm px-3 pb-3">
							<div class="fw-medium">Type</div>
							<div class="text-muted">Website problem</div>
						</div>
						<div class="fs-sm px-3 pb-3">
							<div class="fw-medium">Priority</div>
							<span class="badge bg-warning">High</span>
						</div>
						<div class="fs-sm px-3 pb-3">
							<div class="fw-medium">Status</div>
							<span class="badge bg-success">Open</span>
						</div>
					</div>
					<!-- Comment-->
					<div class="d-flex align-items-start pb-4 border-bottom">
						<img class="rounded-circle" src="img/testimonials/03.jpg"
							width="50" alt="Michael Davis">
						<div class="ps-3">
							<h6 class="fs-md mb-2">Michael Davis</h6>
							<p class="fs-md mb-1">Lorem ipsum dolor sit amet, consectetur
								adipiscing elit, sed do eiusmod tempor incididunt ut labore et
								dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
								exercitation ullamco laboris nisi ut aliquip ex ea commodo
								consequat cupidatat non proident, sunt in culpa qui.</p>
							<span class="fs-ms text-muted"><i
								class="ci-time align-middle me-2"></i>Sep 30, 2019 at 11:05AM</span>
						</div>
					</div>
					<!-- Comment reply-->
					<div class="d-flex align-items-start py-4 border-bottom">
						<img class="rounded-circle" src="img/testimonials/03.jpg"
							width="50" alt="Michael Davis">
						<div class="ps-3">
							<h6 class="fs-md mb-2">Michael Davis</h6>
							<p class="fs-md mb-1">Sed elementum tempus egestas sed sed.
								Aliquam faucibus purus in massa tempor nec feugiat. Interdum
								varius sit amet mattis. Magna ac placerat vestibulum lectus
								mauris. Magna fringilla urna porttitor rhoncus dolor purus non.
								Urna et pharetra pharetra massa massa ultricies mi quis.</p>
							<span class="fs-ms text-muted"><i
								class="ci-time align-middle me-2"></i>Sep 28, 2019 at 10:00AM</span>
							<!-- Comment-->
							<div class="d-flex align-items-start border-top pt-4 mt-4">
								<img class="rounded-circle" src="img/testimonials/04.jpg"
									width="50" alt="Susan Gardner">
								<div class="ps-3">
									<h6 class="fs-md mb-2">Susan Gardner</h6>
									<p class="fs-md mb-1">Egestas sed sed risus pretium quam
										vulputate dignissim. A diam sollicitudin tempor id eu nisl. Ut
										porttitor leo a diam. Bibendum at varius vel pharetra vel
										turpis nunc.</p>
									<span class="fs-ms text-muted"><i
										class="ci-time align-middle me-2"></i>Sep 27, 2019 at 6:30PM</span>
								</div>
							</div>
						</div>
					</div>
					<!-- Leave message-->
					<h3 class="h5 mt-2 pt-4 pb-2">Leave a Message</h3>
					<form class="needs-validation" novalidate>
						<div class="mb-3">
							<textarea class="form-control" rows="8"
								placeholder="Write your message here..." required></textarea>
							<div class="invalid-tooltip">Please write the message!</div>
						</div>
						<div
							class="d-flex flex-wrap justify-content-between align-items-center">
							<div class="form-check">
								<input class="form-check-input" type="checkbox"
									id="close-ticket"> <label class="form-check-label"
									for="close-ticket">Submit and close the ticket</label>
							</div>
							<button class="btn btn-primary my-2" type="submit">Submit
								message</button>
						</div>
					</form>
				</section>
			</div>
		</div>
	</main>
	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<script>
   $("#nav-item-Account").addClass("active");
   </script>
</body>
</html>