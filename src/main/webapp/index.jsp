<%@page import="java.util.Map"%>
<%@page import="generalModule.FormatPrice"%>
<%@page import="product.GetProductVariations"%>
<%@page import="product.ProductItemCatalog"%>
<%@page import="java.util.Iterator"%>
<%@page import="product.Product"%>
<%@page import="product.ProductCatalog"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Home</title>
<!-- Imports -->
<%@include file="components/imports.jsp"%>

</head>
<!-- Body-->
<body>
	<main class="page-wrapper">
		<!-- Quick View Modal-->
		<div class="modal-quick-view modal fade" id="quick-view" tabindex="-1">
			<div class="modal-dialog modal-xl">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title product-title">
							<a href="shop-single-v1.html" data-bs-toggle="tooltip"
								data-bs-placement="right" title="Go to product page">Sports
								Hooded Sweatshirt<i class="ci-arrow-right fs-lg ms-2"></i>
							</a>
						</h4>
						<button class="btn-close" type="button" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="row">
							<!-- Product gallery-->
							<div class="col-lg-7 pe-lg-0">
								<div class="product-gallery">
									<div class="product-gallery-preview order-sm-2">
										<div class="product-gallery-preview-item" id="fourth">
											<img class="image-zoom" src="img/shop/single/gallery/04.jpg"
												data-zoom="img/shop/single/gallery/04.jpg"
												alt="Product image">
											<div class="image-zoom-pane"></div>
										</div>
									</div>
									<div class="product-gallery-thumblist order-sm-1">
										<a class="product-gallery-thumblist-item active" href="#first"><img
											src="img/shop/single/gallery/th01.jpg" alt="Product thumb"></a>
									</div>
								</div>
							</div>
							<!-- Product details-->
							<div class="col-lg-5 pt-4 pt-lg-0 image-zoom-pane">
								<div class="product-details ms-auto pb-3">
									<div
										class="d-flex justify-content-between align-items-center mb-2">
										<a href="shop-single-v1.html#reviews">
											<div class="star-rating">
												<i class="star-rating-icon ci-star-filled active"></i><i
													class="star-rating-icon ci-star-filled active"></i><i
													class="star-rating-icon ci-star-filled active"></i><i
													class="star-rating-icon ci-star-filled active"></i><i
													class="star-rating-icon ci-star"></i>
											</div> <span
											class="d-inline-block fs-sm text-body align-middle mt-1 ms-1">74
												Reviews</span>
										</a>
										<button class="btn-wishlist" type="button"
											data-bs-toggle="tooltip" title="Add to wishlist">
											<i class="ci-heart"></i>
										</button>
									</div>
									<div class="mb-3">
										<span class="h3 fw-normal text-accent me-1">$18.<small>99</small></span>
										<del class="text-muted fs-lg me-3">
											$25.<small>00</small>
										</del>
										<span class="badge bg-danger badge-shadow align-middle mt-n2">Sale</span>
									</div>
									<div class="fs-sm mb-4">
										<span class="text-heading fw-medium me-1">Color:</span><span
											class="text-muted" id="colorOptionText">Red/Dark
											blue/White</span>
									</div>
									<div class="position-relative me-n4 mb-3">
										<div class="form-check form-option form-check-inline mb-2">
											<input class="form-check-input" type="radio" name="color"
												id="color1" data-bs-label="colorOptionText"
												value="Red/Dark blue/White" checked> <label
												class="form-option-label rounded-circle" for="color1"><span
												class="form-option-color rounded-circle"
												style="background-image: url(img/shop/single/color-opt-1.png)"></span></label>
										</div>
										<div class="form-check form-option form-check-inline mb-2">
											<input class="form-check-input" type="radio" name="color"
												id="color2" data-bs-label="colorOptionText"
												value="Beige/White/Black"> <label
												class="form-option-label rounded-circle" for="color2"><span
												class="form-option-color rounded-circle"
												style="background-image: url(img/shop/single/color-opt-2.png)"></span></label>
										</div>
										<div class="form-check form-option form-check-inline mb-2">
											<input class="form-check-input" type="radio" name="color"
												id="color3" data-bs-label="colorOptionText"
												value="Dark grey/White/Mustard"> <label
												class="form-option-label rounded-circle" for="color3"><span
												class="form-option-color rounded-circle"
												style="background-image: url(img/shop/single/color-opt-3.png)"></span></label>
										</div>
										<div class="product-badge product-available mt-n1">
											<i class="ci-security-check"></i>Product available
										</div>
									</div>
									<form class="mb-grid-gutter">
										<div class="mb-3">
											<label class="fw-medium pb-1" for="product-size">Size:</label>
											<select class="form-select" required id="product-size">
												<option value="">Select size</option>
												<option value="xs">XS</option>
												<option value="s">S</option>
												<option value="m">M</option>
												<option value="l">L</option>
												<option value="xl">XL</option>
											</select>
										</div>
										<div class="mb-3 d-flex align-items-center">
											<select class="form-select me-3" style="width: 5rem;">
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
											</select>
											<button class="btn btn-primary btn-shadow d-block w-100"
												type="submit">
												<i class="ci-cart fs-lg me-2"></i>Add to Cart
											</button>
										</div>
									</form>
									<h5 class="h6 mb-3 pb-2 border-bottom">
										<i
											class="ci-announcement text-muted fs-lg align-middle mt-n1 me-2"></i>Product
										info
									</h5>
									<h6 class="fs-sm mb-2">Style</h6>
									<ul class="fs-sm ps-4">
										<li>Hooded top</li>
									</ul>
									<h6 class="fs-sm mb-2">Composition</h6>
									<ul class="fs-sm ps-4">
										<li>Elastic rib: Cotton 95%, Elastane 5%</li>
										<li>Lining: Cotton 100%</li>
										<li>Cotton 80%, Polyester 20%</li>
									</ul>
									<h6 class="fs-sm mb-2">Art. No.</h6>
									<ul class="fs-sm ps-4 mb-0">
										<li>183260098</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Navbar 3 Level (Light)-->

		<%@include file="components/header.jsp"%>


		<!-- Hero slider-->
		<section class="tns-carousel tns-controls-lg">
			<div class="tns-carousel-inner"
				data-carousel-options="{&quot;mode&quot;: &quot;gallery&quot;, &quot;responsive&quot;: {&quot;0&quot;:{&quot;nav&quot;:true, &quot;controls&quot;: false},&quot;992&quot;:{&quot;nav&quot;:false, &quot;controls&quot;: true}}}">
				<!-- Item-->
				<div class="px-lg-5" style="background-color: #3aafd2;">
					<div
						class="d-lg-flex justify-content-between align-items-center ps-lg-4">
						<img class="d-block order-lg-2 me-lg-n5 flex-shrink-0"
							src="img/home/hero-slider/slider2.png" alt="Summer Collection"
							style="max-height: 600px;">
						<div
							class="position-relative mx-auto me-lg-n5 py-5 px-4 mb-lg-5 order-lg-1"
							style="max-width: 42rem; z-index: 10;">
							<div
								class="pb-lg-5 mb-lg-5 text-center text-lg-start text-lg-nowrap">
								<h3 class="h2 text-light fw-light pb-1 from-start">Hurry
									up! Limited time offer.</h3>
								<h2 class="text-light display-5 from-start delay-1">Computer
									Accessories</h2>
								<p class="fs-lg text-light pb-3 from-start delay-2">Laptops,
									Cables, Printers, Displays &amp; much more...</p>
								<div class="d-table scale-up delay-4 mx-auto mx-lg-0">
									<a class="btn btn-primary" href="products-rs.jsp">Shop Now<i
										class="ci-arrow-right ms-2 me-n1"></i></a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Item-->
				<div class="px-lg-5" style="background-color: #f5b1b0;">
					<div
						class="d-lg-flex justify-content-between align-items-center ps-lg-4">
						<img class="d-block order-lg-2 me-lg-n5 flex-shrink-0"
							src="img/home/hero-slider/slider1.png" alt=""
							style="max-height: 600px;">
						<div
							class="position-relative mx-auto me-lg-n5 py-5 px-4 mb-lg-5 order-lg-1"
							style="max-width: 42rem; z-index: 10;">
							<div
								class="pb-lg-5 mb-lg-5 text-center text-lg-start text-lg-nowrap">
								<h3 class="h2 text-light fw-light pb-1 from-bottom">Hurry
									up! Limited time offer.</h3>
								<h2 class="text-light display-5 from-bottom delay-1">Women
									Sportswear Sale</h2>
								<p class="fs-lg text-light pb-3 from-bottom delay-2">Sneakers,
									Keds, Sweatshirts, Hoodies &amp; much more...</p>
								<div class="d-table scale-up delay-4 mx-auto mx-lg-0">
									<a class="btn btn-primary" href="products-rs.jsp">Shop Now<i
										class="ci-arrow-right ms-2 me-n1"></i></a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Item-->
				<div class="px-lg-5" style="background-color: #eba170;">
					<div
						class="d-lg-flex justify-content-between align-items-center ps-lg-4">
						<img class="d-block order-lg-2 me-lg-n5 flex-shrink-0"
							src="img/home/hero-slider/03.jpg" alt="Men Accessories"
							style="max-height: 600px">
						<div
							class="position-relative mx-auto me-lg-n5 py-5 px-4 mb-lg-5 order-lg-1"
							style="max-width: 42rem; z-index: 10;">
							<div
								class="pb-lg-5 mb-lg-5 text-center text-lg-start text-lg-nowrap">
								<h3 class="h2 text-light fw-light pb-1 from-top">Complete
									your look with</h3>
								<h2 class="text-light display-5 from-top delay-1">New Men's
									Accessories</h2>
								<p class="fs-lg text-light pb-3 from-top delay-2">Hats &amp;
									Caps, Sunglasses, Bags &amp; much more...</p>
								<div class="d-table scale-up delay-4 mx-auto mx-lg-0">
									<a class="btn btn-primary" href="products-rs.jsp">Shop Now<i
										class="ci-arrow-right ms-2 me-n1"></i></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- Popular categories-->
		<section
			class="container position-relative pt-3 pt-lg-0 pb-5 mt-lg-n10"
			style="z-index: 10;">
			<div class="row">
				<div class="col-xl-8 col-lg-9">
					<div class="card border-0 shadow-lg">
						<div class="card-body px-3 pt-grid-gutter pb-0">
							<div class="row g-0 ps-1 align-items-center">
								<%
								Connection cn = ConnectionProvider.getCon();
								PreparedStatement ps = cn.prepareStatement("SELECT * FROM product_categories Order By Rand() LIMIT 3");
								ResultSet rs = ps.executeQuery();
								while (rs.next()) {
								%>
								<div data-bs-toggle="tooltip" data-bs-placement="top"
									title="<%=rs.getString("category_name")%>"
									class="col-sm-4 px-2 mb-grid-gutter d-flex justify-content-center">
									<a class="d-block text-center text-decoration-none me-1"
										href="products-rs.jsp?cid=<%=rs.getString("category_id")%>"><img
										class="d-block rounded mb-3"
										style="max-width: 100%; height: 150px; object-fit: scale-down;"
										src="img/shop/categories/<%=rs.getString("category_image")%>"
										alt="<%=rs.getString("category_name")%>">
										<h3 class="fs-base pt-1 mb-0">
											<%
											if (rs.getString("category_name").length() <= 15) {
												out.print(rs.getString("category_name"));
											} else {
												out.print(rs.getString("category_name").substring(0, 15).trim() + "..");
											}
											%>
										</h3></a>
								</div>
								<%
								}
								%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- Products grid (Trending products)-->
		<section class="container pt-md-3 pb-5 mb-md-3">
			<h2 class="h3 text-center">Trending products</h2>
			<div class="row pt-4 mx-n2">

				<%
				ArrayList<ProductCatalog> products = Product.getProductInfo(4, " ORDER BY RAND() ");
				for (ProductCatalog it : products) {
					ArrayList<ProductItemCatalog> product_items = Product.getProductItemInfo(it.getProduct_id(), 1);
					ProductItemCatalog product_item = product_items.get(0);
					ArrayList<String> image = GetProductVariations.getProductItemImagesFor(product_item.getProduct_item_id(), 1);
				%>

				<!-- Product-->


				<div class="col-lg-3 col-md-4 col-sm-6 px-2 mb-4">
					<div class="card product-card">
						<span class="badge bg-danger badge-shadow">Sale</span>
						<button class="btn-wishlist btn-sm" type="button"
							data-bs-toggle="tooltip" data-bs-placement="left"
							title="Add to wishlist">
							<i class="ci-heart"></i>
						</button>
						<a
							class="card-img-top d-flex justify-content-center overflow-hidden image-wrapper"
							href="product-view.jsp?pid=<%=it.getProduct_id()%>&piid=<%=product_item.getProduct_item_id()%>"><img
							src="img/shop/products/<%=image.get(0)%>"
							alt="<%=it.getProduct_name()%>"
							style="height: 250px; object-fit: scale-down;"
							id="productimage<%=it.getProduct_id()%>"></a>
						<div class="card-body py-2">
							<a class="product-meta d-block fs-xs pb-1"
								href="products-rs.jsp?cid=<%=it.getProduct_category_id()%>"><%=it.getProduct_category()%></a>
							<h3 class="product-title fs-sm">
								<a
									href="product-view.jsp?pid=<%=it.getProduct_id()%>&piid=<%=product_item.getProduct_item_id()%>"><%=it.getProduct_name()%></a>
							</h3>
							<div class="d-flex justify-content-between">
								<div class="product-price">
									<span class="text-accent"><%=FormatPrice.formatPrice(product_item.getItem_selling_price() + "")%></span>
									<del class="fs-sm text-muted">
										<%=FormatPrice.formatPrice(product_item.getItem_listing_price() + "")%>
									</del>
								</div>
							</div>
						</div>
					</div>
					<hr class="d-sm-none">
				</div>
				<%
				}
				%>

			</div>
			<div class="text-center pt-3">
				<a class="btn btn-outline-accent" href="shop-categories.jsp">Browse
					Categories<i class="ci-arrow-right ms-1"></i>
				</a>
			</div>
		</section>
		<!-- Banners-->
		<section class="container pb-4 mb-md-3">
			<div class="row">
				<div class="col-md-8 mb-4">
					<div
						class="d-sm-flex justify-content-between align-items-center bg-secondary overflow-hidden rounded-3">
						<div
							class="py-4 my-2 my-md-0 py-md-5 px-4 ms-md-3 text-center text-sm-start">
							<h4 class="fs-lg fw-light mb-2">Hurry up! Limited time offer</h4>
							<h3 class="mb-4">Converse All Star on Sale</h3>
							<a class="btn btn-primary btn-shadow btn-sm" href="#">Shop
								Now</a>
						</div>
						<img class="d-block ms-auto" src="img/shop/catalog/banner.jpg"
							alt="Shop Converse">
					</div>
				</div>
				<div class="col-md-4 mb-4">
					<div
						class="d-flex flex-column h-100 justify-content-center bg-size-cover bg-position-center rounded-3"
						style="background-image: url(img/blog/banner-bg.jpg);">
						<div class="py-4 my-2 px-4 text-center">
							<div class="py-1">
								<h5 class="mb-2">Your Add Banner Here</h5>
								<p class="fs-sm text-muted">Hurry up to reserve your spot</p>
								<a class="btn btn-primary btn-shadow btn-sm" href="#">Contact
									us</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- Featured category-->
		<%
		products = Product.getProductInfo(SiteConstants.FEACTURED_CATEGORY," ORDER BY RAND() ");
		%>
		<section class="container mb-4 pb-3 pb-sm-0 mb-sm-5">
			<div class="row">
				<!-- Banner with controls-->
				<div class="col-md-5">
					<div class="d-flex flex-column h-100 overflow-hidden rounded-3"
						style="background-color: #e2e9ef;">
						<div
							class="d-flex justify-content-between px-grid-gutter py-grid-gutter">
							<div>
								<h3 class="mb-1"><%=SiteConstants.FEACTURED_CATEGORY.toUpperCase()%></h3>
								<a class="fs-md"
									href="products-rs.jsp?cid=<%=products.get(0).getProduct_category_id()%>">Shop
									<%=SiteConstants.FEACTURED_CATEGORY%><i
									class="ci-arrow-right fs-xs align-middle ms-1"></i>
								</a>
							</div>
							<div class="tns-carousel-controls" id="hoodie-day">
								<button type="button">
									<i class="ci-arrow-left"></i>
								</button>
								<button type="button">
									<i class="ci-arrow-right"></i>
								</button>
							</div>
						</div>
						<a class="d-none d-md-block mt-auto"
							href="products-rs.jsp?cid=<%=products.get(0).getProduct_category_id()%>"><img
							class="d-block w-100" src="img/home/categories/cat-lg04.jpg"
							alt="For Women"></a>
					</div>
				</div>
				<!-- Product grid (carousel)-->

				<div class="col-md-7 pt-4 pt-md-0">
					<div class="tns-carousel">
						<div class="tns-carousel-inner"
							data-carousel-options="{&quot;nav&quot;: false, &quot;controlsContainer&quot;: &quot;#hoodie-day&quot;}">
							<!-- Carousel item-->
							<div>
								<div class="row mx-n2">
									<%
									int iterate;
									if (products.size() > 6) {
										iterate = 6;
									} else {
										iterate = products.size();
									}
									for (int i = 0; i < iterate; i++) {
										ArrayList<ProductItemCatalog> items = Product.getProductItemInfo(products.get(i).getProduct_id(), 1,
										" ORDER BY RAND() ");
										ProductItemCatalog product_item = items.get(0);
										ArrayList<String> image = GetProductVariations.getProductItemImagesFor(items.get(0).getProduct_item_id(), 1);
									%>
									<!--Item-->
									<div
										class="col-lg-4 col-6 px-0 px-sm-2 mb-sm-4 d-none d-lg-block">
										<div class="card product-card card-static">
											<button class="btn-wishlist btn-sm" type="button"
												data-bs-toggle="tooltip" data-bs-placement="left"
												title="Add to wishlist">
												<i class="ci-heart"></i>
											</button>
											<a
												class="card-img-top d-flex justify-content-center overflow-hidden"
												href="product-view.jsp?pid=<%=products.get(i).getProduct_id()%>&piid=<%=product_item.getProduct_item_id()%>"><img
												src="img/shop/products/<%=image.get(0)%>"
												alt="<%=products.get(i).getProduct_name()%>"
												style="max-width: 98%; height: 250px; object-fit: scale-down;"></a>
											<div class="card-body py-2">
												<a class="product-meta d-block fs-xs pb-1"
													href="products-rs.jsp?cid=<%=products.get(i).getProduct_category_id()%>"><%=products.get(i).getProduct_category()%></a>
												<h3 class="product-title fs-sm">
													<a
														href="product-view.jsp?pid=<%=products.get(i).getProduct_id()%>&piid=<%=product_item.getProduct_item_id()%>"><%=products.get(i).getProduct_name()%></a>
												</h3>
												<div class="d-flex justify-content-between">
													<div class="product-price">
														<span class="text-accent"><%=FormatPrice.formatPrice(product_item.getItem_selling_price() + "")%></span>
													</div>
												</div>
											</div>
										</div>
									</div>
									<%
									}
									%>
									<!--/Item-->
								</div>
							</div>
							<!-- Carousel item-->
							<%
							if (products.size() > 6) {
							%>
							<div>
								<div class="row mx-n2">
									<!--Item-->
									<%
									if (products.size() >= 12) {
										iterate = 12;
									} else {
										iterate = products.size();
									}
									for (int i = 6; i < iterate; i++) {
										ArrayList<ProductItemCatalog> items = Product.getProductItemInfo(products.get(i).getProduct_id(), 1,
										" ORDER BY RAND() ");
										ProductItemCatalog product_item = items.get(0);
										ArrayList<String> image = GetProductVariations.getProductItemImagesFor(items.get(0).getProduct_item_id(), 1);
									%>
									<!--Item-->
									<div
										class="col-lg-4 col-6 px-0 px-sm-2 mb-sm-4 d-none d-lg-block">
										<div class="card product-card card-static">
											<button class="btn-wishlist btn-sm" type="button"
												data-bs-toggle="tooltip" data-bs-placement="left"
												title="Add to wishlist">
												<i class="ci-heart"></i>
											</button>
											<a
												class="card-img-top d-flex justify-content-center overflow-hidden"
												href="product-view.jsp?pid=<%=products.get(i).getProduct_id()%>&piid=<%=product_item.getProduct_item_id()%>"><img
												src="img/shop/products/<%=image.get(0)%>"
												alt="<%=products.get(i).getProduct_name()%>"
												style="max-width: 98%; height: 250px; object-fit: scale-down;"></a>
											<div class="card-body py-2">
												<a class="product-meta d-block fs-xs pb-1"
													href="products-rs.jsp?cid=<%=products.get(i).getProduct_category_id()%>"><%=products.get(i).getProduct_category()%></a>
												<h3 class="product-title fs-sm">
													<a
														href="product-view.jsp?pid=<%=products.get(i).getProduct_id()%>&piid=<%=product_item.getProduct_item_id()%>"><%=products.get(i).getProduct_name()%></a>
												</h3>
												<div class="d-flex justify-content-between">
													<div class="product-price">
														<span class="text-accent"><%=FormatPrice.formatPrice(product_item.getItem_selling_price() + "")%></span>
													</div>
												</div>
											</div>
										</div>
									</div>
									<%
									}
									%>
									<!--/Item-->
								</div>
							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- Footer-->

	<%@include file="components/footer.jsp"%>

	<script src="js/product.js"></script>

	<script>
    $("#nav-item-home").addClass("active");
    <!-- index.html -->
    window.addEventListener("load", () => {
    	  if ("serviceWorker" in navigator) {
    	    navigator.serviceWorker.register("service-worker.js");
    	  }
    });
    </script>

</body>
</html>