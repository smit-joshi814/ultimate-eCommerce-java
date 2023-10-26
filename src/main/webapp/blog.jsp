<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Blog</title>
<!-- Imports -->
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
							<li class="breadcrumb-item text-nowrap active"
								aria-current="page">Blog</li>
						</ol>
					</nav>
				</div>
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
					<h1 class="h3 mb-0">Blog grid with sidebar</h1>
				</div>
			</div>
		</div>
		<div class="container pb-5 mb-2 mb-md-4">
			<!-- Featured posts carousel-->
			<div class="featured-posts-carousel tns-carousel pt-5">
				<div class="tns-carousel-inner"
					data-carousel-options="{&quot;items&quot;: 2, &quot;nav&quot;: false, &quot;autoHeight&quot;: true, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1},&quot;700&quot;:{&quot;items&quot;:2, &quot;gutter&quot;: 20},&quot;991&quot;:{&quot;items&quot;:2, &quot;gutter&quot;: 30}}}">
					<article>
						<a class="blog-entry-thumb mb-3" href="blog-post.jsp"><span
							class="blog-entry-meta-label fs-sm"><i class="ci-time"></i>Sep
								10</span><img src="img/blog/featured/01.jpg" alt="Featured post"></a>
						<div class="d-flex justify-content-between mb-2 pt-1">
							<h2 class="h5 blog-entry-title mb-0">
								<a href="blog-post.jsp">Healthy Food - New Way of Living</a>
							</h2>
							<a class="blog-entry-meta-link fs-sm text-nowrap ms-3 pt-1"
								href="blog-post.jsp#comments"><i class="ci-message"></i>13</a>
						</div>
						<div class="d-flex align-items-center fs-sm">
							<a class="blog-entry-meta-link" href="#">
								<div class="blog-entry-author-ava">
									<img src="img/blog/meta/04.jpg" alt="Olivia Reyes">
								</div>Olivia Reyes
							</a><span class="blog-entry-meta-divider"></span>
							<div class="fs-sm text-muted">
								in <a href='#' class='blog-entry-meta-link'>Lifestyle</a>, <a
									href='#' class='blog-entry-meta-link'>Nutrition</a>
							</div>
						</div>
					</article>
					<article>
						<a class="blog-entry-thumb mb-3" href="blog-post.jsp"><span
							class="blog-entry-meta-label fs-sm"><i class="ci-time"></i>Aug
								27</span><img src="img/blog/featured/02.jpg" alt="Featured post"></a>
						<div class="d-flex justify-content-between mb-2 pt-1">
							<h2 class="h5 blog-entry-title mb-0">
								<a href="blog-post.jsp">Online Payment Security Tips for
									Shoppers</a>
							</h2>
							<a class="blog-entry-meta-link fs-sm text-nowrap ms-3 pt-1"
								href="blog-post.jsp#comments"><i class="ci-message"></i>9</a>
						</div>
						<div class="d-flex align-items-center fs-sm">
							<a class="blog-entry-meta-link" href="#">
								<div class="blog-entry-author-ava">
									<img src="img/blog/meta/05.jpg" alt="Rafael Marquez">
								</div>Rafael Marquez
							</a><span class="blog-entry-meta-divider"></span>
							<div class="fs-sm text-muted">
								in <a href='#' class='blog-entry-meta-link'>Online shpopping</a>
							</div>
						</div>
					</article>
					<article>
						<a class="blog-entry-thumb mb-3" href="blog-post.jsp"><span
							class="blog-entry-meta-label fs-sm"><i class="ci-time"></i>Aug
								16</span><img src="img/blog/featured/03.jpg" alt="Featured post"></a>
						<div class="d-flex justify-content-between mb-2 pt-1">
							<h2 class="h5 blog-entry-title mb-0">
								<a href="blog-post.jsp">We Launched New Store in San
									Francisco!</a>
							</h2>
							<a class="blog-entry-meta-link fs-sm text-nowrap ms-3 pt-1"
								href="blog-post.jsp#comments"><i class="ci-message"></i>23</a>
						</div>
						<div class="d-flex align-items-center fs-sm">
							<a class="blog-entry-meta-link" href="#">
								<div class="blog-entry-author-ava">
									<img src="img/blog/meta/03.jpg" alt="Paul Woodred">
								</div>Paul Woodred
							</a><span class="blog-entry-meta-divider"></span>
							<div class="fs-sm text-muted">
								in <a href='#' class='blog-entry-meta-link'>Cartzilla news</a>
							</div>
						</div>
					</article>
				</div>
			</div>
			<hr class="mt-5">
			<div class="row pt-5 mt-md-2">
				<!-- Entries grid-->
				<section class="col-lg-8">
					<div class="masonry-grid" data-columns="2">
						<!-- Entry-->
						<article class="masonry-grid-item">
							<div class="card">
								<div class="card-body">
									<h2 class="h6 blog-entry-title">
										<a href="blog-post.jsp">Global Travel and Vacations on a
											Tight Budget</a>
									</h2>
									<p class="fs-sm">Lorem ipsum dolor sit amet, consectetur
										adipiscing elit, sed do eiusmod tempor incididunt ut labore et
										dolore magna aliqua enim ad minim...</p>
									<a class="btn-tag me-2 mb-2" href="#">Travel</a><a
										class="btn-tag me-2 mb-2" href="#">Personal finance</a>
								</div>
								<div class="card-footer d-flex align-items-center fs-xs">
									<a class="blog-entry-meta-link" href="#">
										<div class="blog-entry-author-ava">
											<img src="img/blog/meta/01.jpg" alt="Emma Gallaher">
										</div>Emma Gallaher
									</a>
									<div class="ms-auto text-nowrap">
										<a class="blog-entry-meta-link text-nowrap" href="#">Aug
											15</a><span class="blog-entry-meta-divider mx-2"></span><a
											class="blog-entry-meta-link text-nowrap"
											href="blog-post.jsp#comments"><i class="ci-message"></i>8</a>
									</div>
								</div>
							</div>
						</article>
						<!-- Entry-->
						<article class="masonry-grid-item">
							<div class="card">
								<a class="blog-entry-thumb" href="blog-post.jsp"><img
									class="card-img-top" src="img/blog/01.jpg" alt="Post"></a>
								<div class="card-body">
									<h2 class="h6 blog-entry-title">
										<a href="blog-post.jsp">Top New Trends in Suburban High
											Fashion</a>
									</h2>
									<p class="fs-sm">Lorem ipsum dolor sit amet, consectetur
										adipiscing elit, sed do eiusmod tempor incididunt...</p>
									<a class="btn-tag me-2 mb-2" href="#">Shopping</a><a
										class="btn-tag me-2 mb-2" href="#">Fashion</a>
								</div>
								<div class="card-footer d-flex align-items-center fs-xs">
									<a class="blog-entry-meta-link" href="#">
										<div class="blog-entry-author-ava">
											<img src="img/blog/meta/02.jpg" alt="Cynthia Gomez">
										</div>Cynthia Gomez
									</a>
									<div class="ms-auto text-nowrap">
										<a class="blog-entry-meta-link text-nowrap" href="#">Jul
											23</a><span class="blog-entry-meta-divider mx-2"></span><a
											class="blog-entry-meta-link text-nowrap"
											href="blog-post.jsp#comments"><i class="ci-message"></i>19</a>
									</div>
								</div>
							</div>
						</article>
						<!-- Entry-->
						<article class="masonry-grid-item">
							<div class="card">
								<a class="blog-entry-thumb" href="blog-post.jsp"><img
									class="card-img-top" src="img/blog/02.jpg" alt="Post"></a>
								<div class="card-body">
									<h2 class="h6 blog-entry-title">
										<a href="blog-post.jsp">Shopping Tips. Places Where to Buy
											Cheap</a>
									</h2>
									<p class="fs-sm">Lorem ipsum dolor sit amet, consectetur
										adipiscing elit, sed do eiusmod tempor incididunt ut labore et
										dolore magna aliqua enim ad minim...</p>
									<a class="btn-tag me-2 mb-2" href="#">Shopping</a><a
										class="btn-tag me-2 mb-2" href="#">Personal finance</a>
								</div>
								<div class="card-footer d-flex align-items-center fs-xs">
									<a class="blog-entry-meta-link" href="#">
										<div class="blog-entry-author-ava">
											<img src="img/blog/meta/03.jpg" alt="Paul Woodred">
										</div>Paul Woodred
									</a>
									<div class="ms-auto text-nowrap">
										<a class="blog-entry-meta-link text-nowrap" href="#">Jul 6</a><span
											class="blog-entry-meta-divider mx-2"></span><a
											class="blog-entry-meta-link text-nowrap"
											href="blog-post.jsp#comments"><i class="ci-message"></i>15</a>
									</div>
								</div>
							</div>
						</article>
						<!-- Entry-->
						<article class="masonry-grid-item">
							<div class="card">
								<div class="card-body">
									<h2 class="h6 blog-entry-title">
										<a href="blog-post.jsp">Google Pay is Now Available in All
											Outlets</a>
									</h2>
									<p class="fs-sm">Lorem ipsum dolor sit amet, consectetur
										adipiscing elit, sed do eiusmod tempor incididunt ut labore et
										dolore magna aliqua enim ad minim...</p>
									<a class="btn-tag me-2 mb-2" href="#">Cartzilla news</a>
								</div>
								<div class="card-footer d-flex align-items-center fs-xs">
									<a class="blog-entry-meta-link" href="#">
										<div class="blog-entry-author-ava">
											<img src="img/blog/meta/04.jpg" alt="Olivia Reyes">
										</div>Olivia Reyes
									</a>
									<div class="ms-auto text-nowrap">
										<a class="blog-entry-meta-link text-nowrap" href="#">Jun
											12</a><span class="blog-entry-meta-divider mx-2"></span><a
											class="blog-entry-meta-link text-nowrap"
											href="blog-post.jsp#comments"><i class="ci-message"></i>7</a>
									</div>
								</div>
							</div>
						</article>
						<!-- Entry-->
						<article class="masonry-grid-item">
							<div class="card gallery" data-video="true">
								<a class="blog-entry-thumb gallery-item video-item"
									href="https://www.youtube.com/watch?v=mzhvR4wm__M"><span
									class="blog-entry-meta-label fs-sm"><i class="ci-video"></i><span
										class="fs-ms">Watch video</span></span><img class="card-img-top"
									src="img/blog/03.jpg" alt="Post"></a>
								<div class="card-body">
									<h2 class="h6 blog-entry-title">
										<a href="blog-post.jsp">We Launched Regular Drone Delivery
											in California. Watch Demo Video</a>
									</h2>
									<p class="fs-sm">Lorem ipsum dolor sit amet, consectetur
										adipiscing elit, sed do eiusmod tempor incididunt...</p>
									<a class="btn-tag me-2 mb-2" href="#">Cartzilla news</a>
								</div>
								<div class="card-footer d-flex align-items-center fs-xs">
									<a class="blog-entry-meta-link" href="#">
										<div class="blog-entry-author-ava">
											<img src="img/blog/meta/05.jpg" alt="Rafael Marquez">
										</div>Rafael Marquez
									</a>
									<div class="ms-auto text-nowrap">
										<a class="blog-entry-meta-link text-nowrap" href="#">May
											29</a><span class="blog-entry-meta-divider mx-2"></span><a
											class="blog-entry-meta-link text-nowrap"
											href="blog-post.jsp#comments"><i class="ci-message"></i>31</a>
									</div>
								</div>
							</div>
						</article>
						<!-- Entry-->
						<article class="masonry-grid-item">
							<div class="card">
								<a class="blog-entry-thumb" href="blog-post.jsp"><img
									class="card-img-top" src="img/blog/04.jpg" alt="Post"></a>
								<div class="card-body">
									<h2 class="h6 blog-entry-title">
										<a href="blog-post.jsp">Payments Made Easy. How New
											Technology will Affect E-Commerce Industry Worldwide?</a>
									</h2>
									<p class="fs-sm">Lorem ipsum dolor sit amet, consectetur
										adipiscing elit, sed do eiusmod tempor incididunt ut labore et
										dolore magna aliqua enim ad minim...</p>
									<a class="btn-tag me-2 mb-2" href="#">Shopping</a><a
										class="btn-tag me-2 mb-2" href="#">Technology</a>
								</div>
								<div class="card-footer d-flex align-items-center fs-xs">
									<a class="blog-entry-meta-link" href="#">
										<div class="blog-entry-author-ava">
											<img src="img/blog/meta/01.jpg" alt="Emma Gallaher">
										</div>Emma Gallaher
									</a>
									<div class="ms-auto text-nowrap">
										<a class="blog-entry-meta-link text-nowrap" href="#">May
											13</a><span class="blog-entry-meta-divider mx-2"></span><a
											class="blog-entry-meta-link text-nowrap"
											href="blog-post.jsp#comments"><i class="ci-message"></i>28</a>
									</div>
								</div>
							</div>
						</article>
					</div>
					<hr class="mb-4">
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
				<aside class="col-lg-4">
					<!-- Sidebar-->
					<div
						class="offcanvas offcanvas-collapse offcanvas-end border-start ms-lg-auto"
						id="blog-sidebar" style="max-width: 22rem;">
						<div class="offcanvas-header align-items-center shadow-sm">
							<h2 class="h5 mb-0">Sidebar</h2>
							<button class="btn-close ms-auto" type="button"
								data-bs-dismiss="offcanvas" aria-label="Close"></button>
						</div>
						<div class="offcanvas-body py-grid-gutter py-lg-1 px-lg-4"
							data-simplebar data-simplebar-auto-hide="true">
							<!-- Categories-->
							<div
								class="widget widget-links mb-grid-gutter pb-grid-gutter border-bottom mx-lg-2">
								<h3 class="widget-title">Blog categories</h3>
								<ul class="widget-list">
									<li class="widget-list-item"><a
										class="widget-list-link d-flex justify-content-between align-items-center"
										href="#"><span>Online shopping</span><span
											class="fs-xs text-muted ms-3">18</span></a></li>
									<li class="widget-list-item"><a
										class="widget-list-link d-flex justify-content-between align-items-center"
										href="#"><span>Fashion</span><span
											class="fs-xs text-muted ms-3">25</span></a></li>
									<li class="widget-list-item"><a
										class="widget-list-link d-flex justify-content-between align-items-center"
										href="#"><span>Personal finance</span><span
											class="fs-xs text-muted ms-3">13</span></a></li>
									<li class="widget-list-item"><a
										class="widget-list-link d-flex justify-content-between align-items-center"
										href="#"><span>Travel &amp; vacation</span><span
											class="fs-xs text-muted ms-3">7</span></a></li>
									<li class="widget-list-item"><a
										class="widget-list-link d-flex justify-content-between align-items-center"
										href="#"><span>Lifestyle</span><span
											class="fs-xs text-muted ms-3">34</span></a></li>
									<li class="widget-list-item"><a
										class="widget-list-link d-flex justify-content-between align-items-center"
										href="#"><span>Technology</span><span
											class="fs-xs text-muted ms-3">6</span></a></li>
								</ul>
							</div>
							<!-- Trending posts-->
							<div
								class="widget mb-grid-gutter pb-grid-gutter border-bottom mx-lg-2">
								<h3 class="widget-title">Trending posts</h3>
								<div class="d-flex align-items-center mb-3">
									<a class="flex-shrink-0" href="blog-post.jsp"><img
										class="rounded" src="img/blog/widget/01.jpg" width="64"
										alt="Post image"></a>
									<div class="ps-3">
										<h6 class="blog-entry-title fs-sm mb-0">
											<a href="blog-post.jsp">Retro Cameras are Trending. Why
												so Popular?</a>
										</h6>
										<span class="fs-ms text-muted">by <a href='#'
											class='blog-entry-meta-link'>Andy Williams</a></span>
									</div>
								</div>
								<div class="d-flex align-items-center mb-3">
									<a class="flex-shrink-0" href="blog-post.jsp"><img
										class="rounded" src="img/blog/widget/02.jpg" width="64"
										alt="Post image"></a>
									<div class="ps-3">
										<h6 class="blog-entry-title fs-sm mb-0">
											<a href="blog-post.jsp">New Trends in Suburban Fashion</a>
										</h6>
										<span class="fs-ms text-muted">by <a href='#'
											class='blog-entry-meta-link'>Susan Mayer</a></span>
									</div>
								</div>
								<div class="d-flex align-items-center">
									<a class="flex-shrink-0" href="blog-post.jsp"><img
										class="rounded" src="img/blog/widget/03.jpg" width="64"
										alt="Post image"></a>
									<div class="ps-3">
										<h6 class="blog-entry-title fs-sm mb-0">
											<a href="blog-post.jsp">Augmented Reality - Game Changing
												Technology</a>
										</h6>
										<span class="fs-ms text-muted">by <a href='#'
											class='blog-entry-meta-link'>John Doe</a></span>
									</div>
								</div>
							</div>
							<!-- Popular tags-->
							<div class="widget pb-grid-gutter mx-lg-2">
								<h3 class="widget-title">Popular tags</h3>
								<a class="btn-tag me-2 mb-2" href="#">#fashion</a><a
									class="btn-tag me-2 mb-2" href="#">#gadgets</a><a
									class="btn-tag me-2 mb-2" href="#">#online shopping</a><a
									class="btn-tag me-2 mb-2" href="#">#top brands</a><a
									class="btn-tag me-2 mb-2" href="#">#travel</a><a
									class="btn-tag me-2 mb-2" href="#">#cartzilla news</a><a
									class="btn-tag me-2 mb-2" href="#">#personal finance</a><a
									class="btn-tag me-2 mb-2" href="#">#tips &amp; tricks</a>
							</div>
							<!-- Promo banner-->
							<div
								class="bg-size-cover bg-position-center rounded-3 py-5 mx-lg-2"
								style="background-image: url(img/blog/banner-bg.jpg);">
								<div class="py-5 px-4 text-center">
									<h5 class="mb-2">Your Add Banner Here</h5>
									<p class="fs-sm text-muted">Hurry up to reserve your spot</p>
									<a class="btn btn-primary btn-shadow btn-sm" href="#">Contact
										us</a>
								</div>
							</div>
						</div>
					</div>
				</aside>
			</div>
		</div>
	</main>

	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<!-- /Footer -->

	<script>
	$("#nav-item-Blog").addClass("active");
	</script>

</body>
</html>