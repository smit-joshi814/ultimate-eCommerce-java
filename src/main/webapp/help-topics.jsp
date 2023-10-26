<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Help-Topics</title>
<!-- Imports -->
<%@include file="components/imports.jsp"%>
</head>
<!-- Body-->
<body>

	<main class="page-wrapper">
		<!-- Navbar 3 Level (Light)-->
		<%@include file="components/header.jsp"%>


		<!-- Hero section with search-->
		<section
			class="position-relative bg-dark bg-size-cover bg-position-center-x position-relative py-5 mb-5"
			style="background-image: url(img/pages/help-hero-bg.jpg);">
			<span class="position-absolute top-0 start-0 w-100 h-100 bg-darker"
				style="opacity: .65;"></span>
			<div class="container position-relative zindex-5 py-4 my-3">
				<div class="row justify-content-center">
					<div class="col-lg-8">
						<h1 class="text-light text-center">How can we help?</h1>
						<p class="pb-3 text-light text-center">Ask Questions. Browse
							Topics. Find Answers.</p>
						<div class="input-group input-group-lg mb-3">
							<i
								class="ci-search position-absolute top-50 translate-middle-y text-muted fs-base ms-3"></i>
							<input class="form-control rounded-start" type="search"
								placeholder="Ask your question...">
						</div>
						<div class="fs-sm">
							<span class="text-light opacity-50 me-1">Suggestions:</span><a
								class="nav-link-style nav-link-light me-1 pb-1 border-bottom border-light"
								href="#"> Dashboard,</a><a
								class="nav-link-style nav-link-light me-1 pb-1 border-bottom border-light"
								href="#">Payment,</a><a
								class="nav-link-style nav-link-light me-1 pb-1 border-bottom border-light"
								href="#"> Refunds,</a><a
								class="nav-link-style nav-link-light me-1 pb-1 border-bottom border-light"
								href="#"> Delivery</a>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- Topics grid-->
		<section class="container py-3">
			<h2 class="h3 text-center">Select a topic</h2>
			<div class="row pt-4">
				<div class="col-lg-4 col-sm-6 mb-grid-gutter">
					<div class="card border-0 shadow">
						<div class="card-body text-center">
							<i class="ci-user-circle h2 mt-2 mb-4 text-primary"></i>
							<h6>Managing account</h6>
							<p class="fs-sm text-muted pb-2">Proin nec turpis vel tortor
								venenatis tempus. Sed mollis vel arcu in tempor. Mauris enim
								purus, laoreet nec elit non euismod tempur accusantium.</p>
							<a class="btn btn-outline-primary btn-sm stretched-link mb-2"
								href="help-single-topic.jsp">Learn more</a>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-sm-6 mb-grid-gutter">
					<div class="card border-0 shadow">
						<div class="card-body text-center">
							<i class="ci-laptop h2 mt-2 mb-4 text-primary"></i>
							<h6>Working with dashboard</h6>
							<p class="fs-sm text-muted pb-2">Proin nec turpis vel tortor
								venenatis tempus. Sed mollis vel arcu in tempor. Mauris enim
								purus, laoreet nec elit non euismod tempur accusantium.</p>
							<a class="btn btn-outline-primary btn-sm stretched-link mb-2"
								href="help-single-topic.jsp">Learn more</a>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-sm-6 mb-grid-gutter">
					<div class="card border-0 shadow">
						<div class="card-body text-center">
							<i class="ci-card h2 mt-2 mb-4 text-primary"></i>
							<h6>Payment options</h6>
							<p class="fs-sm text-muted pb-2">Proin nec turpis vel tortor
								venenatis tempus. Sed mollis vel arcu in tempor. Mauris enim
								purus, laoreet nec elit non euismod tempur accusantium.</p>
							<a class="btn btn-outline-primary btn-sm stretched-link mb-2"
								href="help-single-topic.jsp">Learn more</a>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-sm-6 mb-grid-gutter">
					<div class="card border-0 shadow">
						<div class="card-body text-center">
							<i class="ci-delivery h2 mt-2 mb-4 text-primary"></i>
							<h6>Delivery information</h6>
							<p class="fs-sm text-muted pb-2">Proin nec turpis vel tortor
								venenatis tempus. Sed mollis vel arcu in tempor. Mauris enim
								purus, laoreet nec elit non euismod tempur accusantium.</p>
							<a class="btn btn-outline-primary btn-sm stretched-link mb-2"
								href="help-single-topic.jsp">Learn more</a>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-sm-6 mb-grid-gutter">
					<div class="card border-0 shadow">
						<div class="card-body text-center">
							<i class="ci-currency-exchange h2 mt-2 mb-4 text-primary"></i>
							<h6>Refund policy</h6>
							<p class="fs-sm text-muted pb-2">Proin nec turpis vel tortor
								venenatis tempus. Sed mollis vel arcu in tempor. Mauris enim
								purus, laoreet nec elit non euismod tempur accusantium.</p>
							<a class="btn btn-outline-primary btn-sm stretched-link mb-2"
								href="help-single-topic.jsp">Learn more</a>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-sm-6 mb-grid-gutter">
					<div class="card border-0 shadow">
						<div class="card-body text-center">
							<i class="ci-loudspeaker h2 mt-2 mb-4 text-primary"></i>
							<h6>Affiliate program</h6>
							<p class="fs-sm text-muted pb-2">Proin nec turpis vel tortor
								venenatis tempus. Sed mollis vel arcu in tempor. Mauris enim
								purus, laoreet nec elit non euismod tempur accusantium.</p>
							<a class="btn btn-outline-primary btn-sm stretched-link mb-2"
								href="help-single-topic.jsp">Learn more</a>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- FAQ-->
		<section class="container pt-4 pb-5">
			<h2 class="h3 text-center">F.A.Q.</h2>
			<div class="row pt-4">
				<div class="col-sm-6">
					<ul class="list-unstyled">
						<li class="mb-0"><a
							class="nav-link-style d-flex align-items-center border-bottom pb-3 mb-3"
							href="#"><i class="ci-book opacity-60 me-2"></i><span>How
									long will delivery take?</span></a></li>
						<li class="mb-0"><a
							class="nav-link-style d-flex align-items-center border-bottom pb-3 mb-3"
							href="#"><i class="ci-book opacity-60 me-2"></i><span>What
									payment methods do you accept?</span></a></li>
						<li class="mb-0"><a
							class="nav-link-style d-flex align-items-center border-bottom pb-3 mb-3"
							href="#"><i class="ci-book opacity-60 me-2"></i><span>Do
									you ship internationally?</span></a></li>
						<li class="mb-0"><a
							class="nav-link-style d-flex align-items-center border-bottom pb-3 mb-3"
							href="#"><i class="ci-book opacity-60 me-2"></i><span>Do
									I need an account to place an order?</span></a></li>
						<li class="mb-0"><a
							class="nav-link-style d-flex align-items-center border-bottom pb-3 mb-3"
							href="#"><i class="ci-book opacity-60 me-2"></i><span>How
									can I track my order?</span></a></li>
					</ul>
				</div>
				<div class="col-sm-6">
					<ul class="list-unstyled">
						<li class="mb-0"><a
							class="nav-link-style d-flex align-items-center border-bottom pb-3 mb-3"
							href="#"><i class="ci-book opacity-60 me-2"></i><span>What
									are the product refund conditions?</span></a></li>
						<li class="mb-0"><a
							class="nav-link-style d-flex align-items-center border-bottom pb-3 mb-3"
							href="#"><i class="ci-book opacity-60 me-2"></i><span>Do
									you have discounts for returning customers?</span></a></li>
						<li class="mb-0"><a
							class="nav-link-style d-flex align-items-center border-bottom pb-3 mb-3"
							href="#"><i class="ci-book opacity-60 me-2"></i><span>How
									do your referral program work?</span></a></li>
						<li class="mb-0"><a
							class="nav-link-style d-flex align-items-center border-bottom pb-3 mb-3"
							href="#"><i class="ci-book opacity-60 me-2"></i><span>Where
									I can view and download invoices for my orders?</span></a></li>
						<li class="mb-0"><a
							class="nav-link-style d-flex align-items-center border-bottom pb-3 mb-3"
							href="#"><i class="ci-book opacity-60 me-2"></i><span>Do
									you provide technical support after the purchase?</span></a></li>
					</ul>
				</div>
			</div>
		</section>
		<!-- Submit request-->
		<section class="container text-center pt-1 pb-5 mb-2">
			<h2 class="h4 pb-3">Haven't found the answer? We can help.</h2>
			<i class="ci-help h3 text-primary d-block mb-4"></i><a
				class="btn btn-primary" href="help-submit-request.jsp">Submit a
				request</a>
			<p class="fs-sm pt-4">Contact us and weâll get back to you as
				soon as possible.</p>
		</section>
	</main>

	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<!-- / Footer -->

	<script>
	$("#nav-item-Pages").addClass("active");
	$("#page-help-center").addClass("active");
	</script>

</body>
</html>