<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | 404 Error</title>
<!-- Imports -->
<%@include file="components/imports.jsp"%>
</head>
<!-- Body-->
<body>

	<main class="page-wrapper">

		<!-- Navbar 3 Level (Light)-->
		<%@include file="components/header.jsp"%>


		<div class="container py-5 mb-lg-3">
			<div class="row justify-content-center pt-lg-4 text-center">
				<div class="col-lg-5 col-md-7 col-sm-9">
					<img class="d-block mx-auto mb-5" src="img/pages/404.png"
						width="340" alt="404 Error">
					<h1 class="h3">404 error</h1>
					<h3 class="h5 fw-normal mb-4">We can't seem to find the page
						you are looking for.</h3>
					<div class="fs-md mb-4">
						<p class="text-decoration-underline">Here are some helpful
							links instead:</p>
					</div>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-xl-8 col-lg-10">
					<div class="row">
						<div class="col-sm-4 mb-3">
							<a class="card h-100 border-0 shadow-sm" href="index.jsp">
								<div class="card-body">
									<div class="d-flex align-items-center">
										<i class="ci-home text-primary h4 mb-0"></i>
										<div class="ps-3">
											<h5 class="fs-sm mb-0">Homepage</h5>
											<span class="text-muted fs-ms">Return to homepage</span>
										</div>
									</div>
								</div>
							</a>
						</div>
						<div class="col-sm-4 mb-3">
							<a class="card h-100 border-0 shadow-sm" href="#">
								<div class="card-body">
									<div class="d-flex align-items-center">
										<i class="ci-search text-success h4 mb-0"></i>
										<div class="ps-3">
											<h5 class="fs-sm mb-0">Search</h5>
											<span class="text-muted fs-ms">Find with advanced
												search</span>
										</div>
									</div>
								</div>
							</a>
						</div>
						<div class="col-sm-4 mb-3">
							<a class="card h-100 border-0 shadow-sm" href="help-topics.jsp">
								<div class="card-body">
									<div class="d-flex align-items-center">
										<i class="ci-help text-info h4 mb-0"></i>
										<div class="ps-3">
											<h5 class="fs-sm mb-0">Help &amp; Support</h5>
											<span class="text-muted fs-ms">Visit our help center</span>
										</div>
									</div>
								</div>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<!-- / Footer -->

	<script>
	$("#nav-item-Pages").addClass("active");
	$("#page-about-us").addClass("active");
	</script>
</body>
</html>