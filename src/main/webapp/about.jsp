<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | About Us</title>
<!-- Imports -->
<%@include file="components/imports.jsp"%>
</head>
<body>

	<main class="page-wrapper">
		<!-- Navbar 3 Level (Light)-->
		<%@include file="components/header.jsp"%>


		<main class="container-fluid px-0">
			<!-- Row: Shop online-->
			<section class="row g-0">
				<div class="col-md-6 bg-position-center bg-size-cover bg-secondary"
					style="min-height: 15rem; background-image: url(img/about/01.jpg);"></div>
				<div class="col-md-6 px-3 px-md-5 py-5">
					<div class="mx-auto py-lg-5" style="max-width: 35rem;">
						<h2 class="h3 pb-3">Search, Select, Buy online</h2>
						<p class="fs-sm pb-3 text-muted">Lorem ipsum dolor sit amet,
							consectetur adipiscing elit. Aliquam id purus at risus
							pellentesque faucibus a quis eros. In eu fermentum leo. Integer
							ut eros lacus. Proin ut accumsan leo. Morbi vitae est eget dolor
							consequat aliquam eget quis dolor. Mauris rutrum fermentum erat,
							at euismod lorem pharetra nec. Duis erat lectus, ultrices euismod
							sagittis at, pharetra eu nisl. Phasellus id ante at velit
							tincidunt hendrerit. Aenean dolor dolor tristique nec. Tristique
							nulla aliquet enim tortor at auctor urna nunc. Sit amet aliquam
							id diam maecenas ultricies mi eget.</p>
						<a class="btn btn-primary btn-shadow" href="shop-categories.jsp">View
							products</a>
					</div>
				</div>
			</section>
			<!-- Row: Delivery-->
			<section class="row g-0">
				<div
					class="col-md-6 bg-position-center bg-size-cover bg-secondary order-md-2"
					style="min-height: 15rem; background-image: url(img/about/02.jpg);"></div>
				<div class="col-md-6 px-3 px-md-5 py-5 order-md-1">
					<div class="mx-auto py-lg-5" style="max-width: 35rem;">
						<h2 class="h3 pb-3">Fast delivery worldwide</h2>
						<p class="fs-sm pb-3 text-muted">Lorem ipsum dolor sit amet,
							consectetur adipiscing elit. Aliquam id purus at risus
							pellentesque faucibus a quis eros. In eu fermentum leo. Integer
							ut eros lacus. Proin ut accumsan leo. Morbi vitae est eget dolor
							consequat aliquam eget quis dolor. Mauris rutrum fermentum erat,
							at euismod lorem pharetra nec. Duis erat lectus, ultrices euismod
							sagittis at, pharetra eu nisl. Phasellus id ante at velit
							tincidunt hendrerit. Aenean dolor dolor tristique nec. Tristique
							nulla aliquet enim tortor at auctor urna nunc. Sit amet aliquam
							id diam maecenas ultricies mi eget.</p>
						<a class="btn btn-accent btn-shadow" href="#">Shipping details</a>
					</div>
				</div>
			</section>
			<!-- Row: Mobile app-->
			<section class="row g-0">
				<div class="col-md-6 bg-position-center bg-size-cover bg-secondary"
					style="min-height: 15rem; background-image: url(img/about/03.jpg);"></div>
				<div class="col-md-6 px-3 px-md-5 py-5">
					<div class="mx-auto py-lg-5" style="max-width: 35rem;">
						<h2 class="h3 pb-3">Great mobile app. Shop on the go</h2>
						<p class="fs-sm pb-3 text-muted">Lorem ipsum dolor sit amet,
							consectetur adipiscing elit. Aliquam id purus at risus
							pellentesque faucibus a quis eros. In eu fermentum leo. Integer
							ut eros lacus. Proin ut accumsan leo. Morbi vitae est eget dolor
							consequat aliquam eget quis dolor. Mauris rutrum fermentum erat,
							at euismod. Duis erat lectus, ultrices euismod sagittis at dolor
							tristique nec. Tristique nulla aliquet enim tortor at auctor urna
							nunc. Sit amet aliquam id diam maecenas ultricies mi eget.</p>
						<a class="btn-market btn-apple me-3 mb-3" href="#" role="button"><span
							class="btn-market-subtitle">Download on the</span><span
							class="btn-market-title">App Store</span></a><a
							class="btn-market btn-google mb-3" href="#" role="button"><span
							class="btn-market-subtitle">Download on the</span><span
							class="btn-market-title">Google Play</span></a>
					</div>
				</div>
			</section>
			<!-- Section: Shopping outlets-->
			<section class="row g-0">
				<div
					class="col-md-6 bg-position-center bg-size-cover bg-secondary order-md-2"
					style="min-height: 15rem; background-image: url(img/about/04.jpg);"></div>
				<div class="col-md-6 px-3 px-md-5 py-5 order-md-1">
					<div class="mx-auto py-lg-5" style="max-width: 35rem;">
						<h2 class="h3 pb-3">Shop offline. Cozy outlet stores</h2>
						<p class="fs-sm pb-3 text-muted">Lorem ipsum dolor sit amet,
							consectetur adipiscing elit. Aliquam id purus at risus
							pellentesque faucibus a quis eros. In eu fermentum leo. Integer
							ut eros lacus. Proin ut accumsan leo. Morbi vitae est eget dolor
							consequat aliquam eget quis dolor. Mauris rutrum fermentum erat,
							at euismod lorem pharetra nec. Duis erat lectus, ultrices euismod
							sagittis at, pharetra eu nisl. Phasellus id ante at velit
							tincidunt hendrerit. Aenean dolor dolor tristique nec. Tristique
							nulla aliquet enim tortor at auctor urna nunc. Sit amet aliquam
							id diam maecenas ultricies mi eget.</p>
						<a class="btn btn-warning btn-shadow" href="contacts.jsp">See
							outlet stores</a>
					</div>
				</div>
			</section>
			<hr>
			<!-- Section: Team-->
			<section class="container py-3 py-lg-5 mt-4 mb-3">
				<h2 class="h3 my-2">Our core team</h2>
				<p class="fs-sm text-muted">People behind your great shopping
					experience</p>
				<div class="row pt-3">
					<div class="col-lg-4 col-sm-6 mb-grid-gutter">
						<div class="d-flex align-items-center">
							<img class="rounded-circle" src="img/team/03.jpg" width="96"
								alt="Jonathan Doe">
							<div class="ps-3">
								<h6 class="fs-base pt-1 mb-1">Jonathan Doe</h6>
								<p class="fs-ms text-muted mb-0">CEO, Co-founder</p>
								<a class="nav-link-style fs-ms text-nowrap"
									href="mailto:johndoe@example.com"><i class="ci-mail me-2"></i>johndoe@example.com</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-grid-gutter">
						<div class="d-flex align-items-center">
							<img class="rounded-circle" src="img/team/04.jpg" width="96"
								alt="Barbara Palson">
							<div class="ps-3">
								<h6 class="fs-base pt-1 mb-1">Barbara Palson</h6>
								<p class="fs-ms text-muted mb-0">Chief of Marketing</p>
								<a class="nav-link-style fs-ms text-nowrap"
									href="mailto:b.palson@example.com"><i class="ci-mail me-2"></i>b.palson@example.com</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-grid-gutter">
						<div class="d-flex align-items-center">
							<img class="rounded-circle" src="img/team/06.jpg" width="96"
								alt="William Smith">
							<div class="ps-3">
								<h6 class="fs-base pt-1 mb-1">William Smith</h6>
								<p class="fs-ms text-muted mb-0">Financial director</p>
								<a class="nav-link-style fs-ms text-nowrap"
									href="mailto:w.smith@example.com"><i class="ci-mail me-2"></i>w.smith@example.com</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-grid-gutter">
						<div class="d-flex align-items-center">
							<img class="rounded-circle" src="img/team/02.jpg" width="96"
								alt="Amanda Gallaher">
							<div class="ps-3">
								<h6 class="fs-base pt-1 mb-1">Amanda Gallaher</h6>
								<p class="fs-ms text-muted mb-0">Lead UX designer</p>
								<a class="nav-link-style fs-ms text-nowrap"
									href="mailto:a.gallaher@example.com"><i
									class="ci-mail me-2"></i>a.gallaher@example.com</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-grid-gutter">
						<div class="d-flex align-items-center">
							<img class="rounded-circle" src="img/team/01.jpg" width="96"
								alt="Benjamin Miller">
							<div class="ps-3">
								<h6 class="fs-base pt-1 mb-1">Benjamin Miller</h6>
								<p class="fs-ms text-muted mb-0">Website development</p>
								<a class="nav-link-style fs-ms text-nowrap"
									href="mailto:b.miller@example.com"><i class="ci-mail me-2"></i>b.miller@example.com</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-grid-gutter">
						<div class="d-flex align-items-center">
							<img class="rounded-circle" src="img/team/07.jpg" width="96"
								alt="Miguel Rodrigez">
							<div class="ps-3">
								<h6 class="fs-base pt-1 mb-1">Miguel Rodrigez</h6>
								<p class="fs-ms text-muted mb-0">Content manager</p>
								<a class="nav-link-style fs-ms text-nowrap"
									href="mailto:b.miller@example.com"><i class="ci-mail me-2"></i>m.rodrigez@example.com</a>
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- Section: We are hiring-->
			<hr>
			<section class="row g-0">
				<div
					class="col-md-6 bg-position-center bg-size-cover bg-secondary order-md-2"
					style="min-height: 15rem; background-image: url(img/about/05.jpg);"></div>
				<div class="col-md-6 px-3 px-md-5 py-5 order-md-1">
					<div class="mx-auto py-lg-5" style="max-width: 35rem;">
						<h2 class="h3 mb-2">We are hiring new talents</h2>
						<p class="fs-sm text-muted pb-2">If you want to be part of our
							team please submit you CV using the form below:</p>
						<form class="needs-validation row g-4" method="post" novalidate>
							<div class="col-sm-6">
								<input class="form-control" type="text" placeholder="Your name"
									required>
							</div>
							<div class="col-sm-6">
								<input class="form-control" type="email"
									placeholder="Your email" required>
							</div>
							<div class="col-12">
								<textarea class="form-control" rows="4" placeholder="Message"
									required></textarea>
							</div>
							<div class="col-12">
								<input class="form-control" type="file" required>
							</div>
							<div class="col-12">
								<button class="btn btn-info btn-shadow" type="submit">Submit
									your CV</button>
							</div>
						</form>
					</div>
				</div>
			</section>
		</main>
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