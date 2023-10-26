<%@page import="product.Product"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
Connection cn = ConnectionProvider.getCon();
PreparedStatement ps;
ResultSet rs, rs1;
String category_id = "";

if (request.getParameter("cid") != null) {
	category_id = request.getParameter("cid");
} else if (request.getParameter("search") != null) {
	String search = request.getParameter("search");
	ps = cn.prepareStatement(
	"SELECT DISTINCT(PC.category_id) FROM product P INNER JOIN product_categories PC ON P.category_id=PC.category_id INNER JOIN brands B ON P.brand_id=B.brand_id WHERE P.product_name LIKE ? OR PC.category_name LIKE ? OR B.brand_name LIKE ? ORDER BY RAND()");
	ps.setString(1, "%" + search + "%");
	ps.setString(2, "%" + search + "%");
	ps.setString(3, "%" + search + "%");
	rs = ps.executeQuery();
	if (rs.isBeforeFirst()) {
		rs.next();
		category_id = rs.getString("category_id");
	} else {
		response.sendRedirect("shop-categories.jsp");
	}
} else {
	response.sendRedirect("shop-categories.jsp");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Products</title>
<!-- Imports -->
<%@include file="components/imports.jsp"%>
</head>
<!-- Body-->
<body class="handheld-toolbar-enabled">
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
										<div class="product-gallery-preview-item active" id="first">
											<img class="image-zoom" src="img/shop/single/gallery/01.jpg"
												data-zoom="img/shop/single/gallery/01.jpg"
												alt="Product image">
											<div class="image-zoom-pane"></div>
										</div>
										<div class="product-gallery-preview-item" id="second">
											<img class="image-zoom" src="img/shop/single/gallery/02.jpg"
												data-zoom="img/shop/single/gallery/02.jpg"
												alt="Product image">
											<div class="image-zoom-pane"></div>
										</div>
										<div class="product-gallery-preview-item" id="third">
											<img class="image-zoom" src="img/shop/single/gallery/03.jpg"
												data-zoom="img/shop/single/gallery/03.jpg"
												alt="Product image">
											<div class="image-zoom-pane"></div>
										</div>
										<div class="product-gallery-preview-item" id="fourth">
											<img class="image-zoom" src="img/shop/single/gallery/04.jpg"
												data-zoom="img/shop/single/gallery/04.jpg"
												alt="Product image">
											<div class="image-zoom-pane"></div>
										</div>
									</div>
									<div class="product-gallery-thumblist order-sm-1">
										<a class="product-gallery-thumblist-item active" href="#first"><img
											src="img/shop/single/gallery/th01.jpg" alt="Product thumb"></a><a
											class="product-gallery-thumblist-item" href="#second"><img
											src="img/shop/single/gallery/th02.jpg" alt="Product thumb"></a><a
											class="product-gallery-thumblist-item" href="#third"><img
											src="img/shop/single/gallery/th03.jpg" alt="Product thumb"></a><a
											class="product-gallery-thumblist-item" href="#fourth"><img
											src="img/shop/single/gallery/th04.jpg" alt="Product thumb"></a>
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
		<!-- Page Title-->
		<div class="page-title-overlap bg-dark pt-4">
			<div class="container d-lg-flex justify-content-between py-2 py-lg-3">
				<div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
					<nav aria-label="breadcrumb">
						<ol
							class="breadcrumb breadcrumb-light flex-lg-nowrap justify-content-center justify-content-lg-start">
							<li class="breadcrumb-item"><a class="text-nowrap"
								href="index.jsp"><i class="ci-home"></i>Home</a></li>
							<li class="breadcrumb-item text-nowrap active"
								aria-current="page">Shop</li>
						</ol>
					</nav>
				</div>
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
					<%
					ps = cn.prepareStatement("SELECT category_name FROM product_categories WHERE category_id=?");
					ps.setString(1, category_id);
					rs = ps.executeQuery();
					rs.next();
					String category_name = rs.getString("category_name");
					ps = cn.prepareStatement("SELECT COUNT(product_id) as products FROM product WHERE category_id=?");
					ps.setString(1, category_id);
					rs = ps.executeQuery();
					rs.next();
					while (rs.getString("products").equals("0")) {
						category_id = Product.getSuperCategoryId(Integer.parseInt(category_id)) + "";
						ps = cn.prepareStatement("SELECT category_id FROM product_categories WHERE parent_category_id=? ORDER BY RAND()");
						ps.setString(1, category_id);
						rs1 = ps.executeQuery();
						while (rs1.next()) {
							ps = cn.prepareStatement("SELECT COUNT(product_id) as products FROM product WHERE category_id=?");
							ps.setString(1, rs1.getString("category_id"));
							rs.close();
							rs = ps.executeQuery();
							rs.next();
							if (rs.getInt("products") != 0) {
						category_id = rs1.getString("category_id");
						break;
							}
						}
					}
					%>
					<h4 class="h4 text-light mb-0">
						Product's Available In
						<%=category_name%>
						(<%=rs.getString("products")%>)
					</h4>
				</div>
			</div>
		</div>
		<div class="container pb-5 mb-2 mb-md-4">
			<div class="row">
				<!-- Content  -->
				<section class="col-lg-8">
					<!-- Toolbar-->
					<div
						class="d-flex justify-content-center justify-content-sm-between align-items-center pt-2 pb-4 pb-sm-5">
						<div class="d-flex flex-wrap">
							<div
								class="d-flex align-items-center flex-nowrap me-3 me-sm-4 pb-3">
								<label
									class="text-light fs-sm opacity-75 text-nowrap me-2 d-none d-sm-block"
									for="sorting">Sort by:</label> <select class="form-select"
									id="sorting" name="sorting" onChange="filterProductsList()">
									<option value="Sales">Popularity</option>
									<option value="Low">Low - Hight Price</option>
									<option value="High">High - Low Price</option>
									<option value="Rating">Average Rating</option>
									<option value="Acending">A - Z Order</option>
									<option value="Descending">Z - A Order</option>
								</select><span
									class="fs-sm text-light opacity-75 text-nowrap ms-2 d-none d-md-block">of
									<%=rs.getString("products")%> products
								</span>
							</div>
						</div>
						<div class="d-none d-sm-flex pb-3">
							<a class="btn btn-icon nav-link-style nav-link-light me-2"
								href="products-rs.jsp?cid=<%=category_id%>"><i
								class="ci-view-grid"></i></a><a
								class="btn btn-icon nav-link-style bg-light text-dark disabled opacity-100"
								href="#"><i class="ci-view-list"></i></a>
						</div>
					</div>


					<!-- Products list-->
					<input type="hidden" name="hdncategoryId" id="hdncategoryId"
						value="<%=category_id%>" />
					<!-- Products-->
					<div id="ProductList"></div>

				</section>
				<!-- Sidebar-->
				<aside class="col-lg-4">
					<!-- Sidebar-->
					<div
						class="offcanvas offcanvas-collapse offcanvas-end bg-white w-100 rounded-3 shadow-lg ms-lg-auto py-1"
						id="shop-sidebar" style="max-width: 22rem;">
						<div class="offcanvas-header align-items-center shadow-sm">
							<h2 class="h5 mb-0">Filters</h2>
							<button class="btn-close ms-auto" type="button"
								data-bs-dismiss="offcanvas" aria-label="Close"></button>
						</div>
						<div class="offcanvas-body py-grid-gutter px-lg-grid-gutter">
							<!-- Categories-->
							<div class="widget widget-categories mb-4 pb-4 border-bottom"
								id="ProductCategoriesFilter">
								<h3 class="widget-title">Categories</h3>
								<div class="accordion mt-n1" id="shop-categories">
									<!-- Shoes-->
									<div class="accordion-item">
										<h3 class="accordion-header">
											<a class="accordion-button collapsed" href="#shoes"
												role="button" data-bs-toggle="collapse"
												aria-expanded="false" aria-controls="shoes">Shoes</a>
										</h3>
										<div class="accordion-collapse collapse" id="shoes"
											data-bs-parent="#shop-categories">
											<div class="accordion-body">
												<div class="widget widget-links widget-filter">
													<div class="input-group input-group-sm mb-2">
														<input
															class="widget-filter-search form-control rounded-end"
															type="text" placeholder="Search"><i
															class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
													</div>
													<ul class="widget-list widget-filter-list pt-1"
														style="height: 12rem;" data-simplebar
														data-simplebar-auto-hide="false">
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">View
																	all</span><span class="fs-xs text-muted ms-3">1,953</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Pumps
																	&amp; High Heels</span><span class="fs-xs text-muted ms-3">247</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Ballerinas
																	&amp; Flats</span><span class="fs-xs text-muted ms-3">156</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Sandals</span><span
																class="fs-xs text-muted ms-3">310</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Sneakers</span><span
																class="fs-xs text-muted ms-3">402</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Boots</span><span
																class="fs-xs text-muted ms-3">393</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Ankle
																	Boots</span><span class="fs-xs text-muted ms-3">50</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Loafers</span><span
																class="fs-xs text-muted ms-3">93</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Slip-on</span><span
																class="fs-xs text-muted ms-3">122</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Flip
																	Flops</span><span class="fs-xs text-muted ms-3">116</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Clogs
																	&amp; Mules</span><span class="fs-xs text-muted ms-3">24</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Athletic
																	Shoes</span><span class="fs-xs text-muted ms-3">31</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Oxfords</span><span
																class="fs-xs text-muted ms-3">9</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Smart
																	Shoes</span><span class="fs-xs text-muted ms-3">18</span></a></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									<!-- Clothing-->
									<div class="accordion-item">
										<h3 class="accordion-header">
											<a class="accordion-button" href="#clothing" role="button"
												data-bs-toggle="collapse" aria-expanded="true"
												aria-controls="clothing">Clothing</a>
										</h3>
										<div class="accordion-collapse collapse show" id="clothing"
											data-bs-parent="#shop-categories">
											<div class="accordion-body">
												<div class="widget widget-links widget-filter">
													<div class="input-group input-group-sm mb-2">
														<input
															class="widget-filter-search form-control rounded-end"
															type="text" placeholder="Search"><i
															class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
													</div>
													<ul class="widget-list widget-filter-list pt-1"
														style="height: 12rem;" data-simplebar
														data-simplebar-auto-hide="false">
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">View
																	all</span><span class="fs-xs text-muted ms-3">2,548</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Blazers
																	&amp; Suits</span><span class="fs-xs text-muted ms-3">235</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Blouses</span><span
																class="fs-xs text-muted ms-3">410</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Cardigans
																	&amp; Jumpers</span><span class="fs-xs text-muted ms-3">107</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Dresses</span><span
																class="fs-xs text-muted ms-3">93</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Hoodie
																	&amp; Sweatshirts</span><span class="fs-xs text-muted ms-3">122</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Jackets
																	&amp; Coats</span><span class="fs-xs text-muted ms-3">116</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Jeans</span><span
																class="fs-xs text-muted ms-3">215</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Lingerie</span><span
																class="fs-xs text-muted ms-3">150</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Maternity
																	Wear</span><span class="fs-xs text-muted ms-3">8</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Nightwear</span><span
																class="fs-xs text-muted ms-3">26</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Shirts</span><span
																class="fs-xs text-muted ms-3">164</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Shorts</span><span
																class="fs-xs text-muted ms-3">147</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Socks
																	&amp; Tights</span><span class="fs-xs text-muted ms-3">139</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Sportswear</span><span
																class="fs-xs text-muted ms-3">65</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Swimwear</span><span
																class="fs-xs text-muted ms-3">18</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">T-shirts
																	&amp; Vests</span><span class="fs-xs text-muted ms-3">209</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Tops</span><span
																class="fs-xs text-muted ms-3">132</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Trousers</span><span
																class="fs-xs text-muted ms-3">105</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Underwear</span><span
																class="fs-xs text-muted ms-3">87</span></a></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									<!-- Bags-->
									<div class="accordion-item">
										<h3 class="accordion-header">
											<a class="accordion-button collapsed" href="#bags"
												role="button" data-bs-toggle="collapse"
												aria-expanded="false" aria-controls="bags">Bags</a>
										</h3>
										<div class="accordion-collapse collapse" id="bags"
											data-bs-parent="#shop-categories">
											<div class="accordion-body">
												<div class="widget widget-links widget-filter">
													<div class="input-group input-group-sm mb-2">
														<input
															class="widget-filter-search form-control rounded-end"
															type="text" placeholder="Search"><i
															class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
													</div>
													<ul class="widget-list widget-filter-list pt-1"
														style="height: 12rem;" data-simplebar
														data-simplebar-auto-hide="false">
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">View
																	all</span><span class="fs-xs text-muted ms-3">801</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Handbags</span><span
																class="fs-xs text-muted ms-3">238</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Backpacks</span><span
																class="fs-xs text-muted ms-3">116</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Wallets</span><span
																class="fs-xs text-muted ms-3">104</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Luggage</span><span
																class="fs-xs text-muted ms-3">115</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Lumbar
																	Packs</span><span class="fs-xs text-muted ms-3">17</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Duffle
																	Bags</span><span class="fs-xs text-muted ms-3">9</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Bag
																	/ Travel Accessories</span><span class="fs-xs text-muted ms-3">93</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Diaper
																	Bags</span><span class="fs-xs text-muted ms-3">5</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Lunch
																	Bags</span><span class="fs-xs text-muted ms-3">8</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Messenger
																	Bags</span><span class="fs-xs text-muted ms-3">2</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Laptop
																	Bags</span><span class="fs-xs text-muted ms-3">31</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Briefcases</span><span
																class="fs-xs text-muted ms-3">45</span></a></li>
														<li class="widget-list-item widget-filter-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span class="widget-filter-item-text">Sport
																	Bags</span><span class="fs-xs text-muted ms-3">18</span></a></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									<!-- Sunglasses-->
									<div class="accordion-item">
										<h3 class="accordion-header">
											<a class="accordion-button collapsed" href="#sunglasses"
												role="button" data-bs-toggle="collapse"
												aria-expanded="false" aria-controls="sunglasses">Sunglasses</a>
										</h3>
										<div class="collapse" id="sunglasses"
											data-bs-parent="#shop-categories">
											<div class="accordion-body">
												<div class="widget widget-links">
													<ul class="widget-list">
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>View all</span><span
																class="fs-xs text-muted ms-3">1,842</span></a></li>
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>Fashion Sunglasses</span><span
																class="fs-xs text-muted ms-3">953</span></a></li>
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>Sport Sunglasses</span><span
																class="fs-xs text-muted ms-3">589</span></a></li>
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>Classic Sunglasses</span><span
																class="fs-xs text-muted ms-3">300</span></a></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									<!-- Watches-->
									<div class="accordion-item">
										<h3 class="accordion-header">
											<a class="accordion-button collapsed" href="#watches"
												role="button" data-bs-toggle="collapse"
												aria-expanded="false" aria-controls="watches">Watches</a>
										</h3>
										<div class="accordion-collapse collapse" id="watches"
											data-bs-parent="#shop-categories">
											<div class="accordion-body">
												<div class="widget widget-links">
													<ul class="widget-list">
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>View all</span><span
																class="fs-xs text-muted ms-3">734</span></a></li>
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>Fashion Watches</span><span
																class="fs-xs text-muted ms-3">572</span></a></li>
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>Casual Watches</span><span
																class="fs-xs text-muted ms-3">110</span></a></li>
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>Luxury Watches</span><span
																class="fs-xs text-muted ms-3">34</span></a></li>
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>Sport Watches</span><span
																class="fs-xs text-muted ms-3">18</span></a></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									<!-- Accessories-->
									<div class="accordion-item">
										<h3 class="accordion-header">
											<a class="accordion-button collapsed" href="#accessories"
												role="button" data-bs-toggle="collapse"
												aria-expanded="false" aria-controls="accessories">Accessories</a>
										</h3>
										<div class="accordion-collapse collapse" id="accessories"
											data-bs-parent="#shop-categories">
											<div class="accordion-body">
												<div class="widget widget-links">
													<ul class="widget-list">
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>View all</span><span
																class="fs-xs text-muted ms-3">920</span></a></li>
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>Belts</span><span
																class="fs-xs text-muted ms-3">364</span></a></li>
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>Hats</span><span
																class="fs-xs text-muted ms-3">405</span></a></li>
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>Jewelry</span><span
																class="fs-xs text-muted ms-3">131</span></a></li>
														<li class="widget-list-item"><a
															class="widget-list-link d-flex justify-content-between align-items-center"
															href="#"><span>Cosmetics</span><span
																class="fs-xs text-muted ms-3">20</span></a></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- Price range-->

							<div class="widget mb-4 pb-4 border-bottom">
								<h3 class="widget-title">Price</h3>
								<div class="range-slider" data-start-min="250"
									data-start-max="4500" data-min="0" data-max="20000"
									data-step="1" onchange="filterProductsGrid()">
									<div class="range-slider-ui"></div>
									<div class="d-flex pb-1">
										<div class="w-50 pe-2 me-2">
											<div class="input-group input-group-sm">
												<span class="input-group-text"><%=SiteConstants.COUNTRY_CURRANCY_UNICODE%></span>
												<input class="form-control range-slider-value-min"
													type="text" name="priceRangeMin" id="priceRangeMin"
													onchange="filterProductsList()">
											</div>
										</div>
										<div class="w-50 ps-2">
											<div class="input-group input-group-sm">
												<span class="input-group-text"><%=SiteConstants.COUNTRY_CURRANCY_UNICODE%></span>
												<input class="form-control range-slider-value-max"
													type="text" name="priceRangeMax" id="priceRangeMax"
													onchange="filterProductsList()">
											</div>
										</div>
									</div>
								</div>
							</div>


							<!-- Filter by Brand-->
							<div class="widget widget-filter mb-4 pb-4 border-bottom">
								<h3 class="widget-title">Brand</h3>
								<div class="input-group input-group-sm mb-2">
									<input
										class="widget-filter-search form-control rounded-end pe-5"
										type="text" placeholder="Search"><i
										class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
								</div>
								<ul class="widget-list widget-filter-list list-unstyled pt-1"
									style="max-height: 11rem;" data-simplebar
									data-simplebar-auto-hide="false">
									<%
									ps = cn.prepareStatement("SELECT * FROM brands");
									rs = ps.executeQuery();
									while (rs.next()) {
									%>
									<li
										class="widget-filter-item d-flex justify-content-between align-items-center mb-1">
										<div class="form-check">
											<input class="form-check-input" name="brands[]"
												onchange="filterProductsList()" type="checkbox"
												id="<%=rs.getString("brand_name")%>"
												value="<%=rs.getString("brand_id")%>"> <label
												class="form-check-label widget-filter-item-text"
												for="<%=rs.getString("brand_name")%>"><%=rs.getString("brand_name")%></label>
										</div> <span class="fs-xs text-muted"></span>
									</li>
									<%
									}
									%>
								</ul>
							</div>

							<%
							if (category_id != "") {
							%>
							<!-- Filter by Color-->
							<div class="widget mb-4 pb-4 border-bottom">
								<h3 class="widget-title">Color</h3>
								<div class="d-flex flex-wrap" data-simplebar
									data-simplebar-auto-hide="false"
									style="max-height: 11rem; overflow-y: unset;">
									<%
									ps = cn.prepareStatement(
											"SELECT VCV.var_value FROM variation_options VO INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation V ON V.variation_id=VO.variation_id INNER JOIN variation_combo VC ON VC.var_id=VCV.var_id WHERE V.category_id=? AND VC.var_name IN('COLOR') ORDER BY var_value ASC",
											ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
									ps.setString(1, category_id);
									rs = ps.executeQuery();
									while (!rs.isBeforeFirst()) {
										int category_id_color = Product.getSuperCategoryId(Integer.parseInt(category_id));
										ps = cn.prepareStatement(
										"SELECT VCV.var_value FROM variation_options VO INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation V ON V.variation_id=VO.variation_id INNER JOIN variation_combo VC ON VC.var_id=VCV.var_id WHERE V.category_id=? AND VC.var_name IN('COLOR') ORDER BY var_value ASC",
										ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
										ps.setInt(1, category_id_color);
										rs.close();
										rs = ps.executeQuery();
									}
									while (rs.next()) {
									%>
									<div
										class="form-check form-option text-center mb-2 mx-1 FilterColors"
										style="width: 4rem;">
										<input class="form-check-input" name="filterVariations[]"
											onchange="filterProductsList()" type="checkbox"
											id="color-<%=rs.getString("var_value")%>"
											value="<%=rs.getString("var_value")%>"> <label
											class="form-option-label rounded-circle"
											for="color-<%=rs.getString("var_value")%>"><span
											class="form-option-color rounded-circle"
											style="background-color: <%=rs.getString("var_value").replaceAll("\\s", "")%>"></span></label>
										<label class="d-block fs-xs text-muted mt-n1"
											for="color-<%=rs.getString("var_value")%>"><%=rs.getString("var_value")%></label>
									</div>
									<%
									}
									%>
								</div>
							</div>
							<%
							}
							%>


							<!-- Filter by Different variations-->
							<%
							ps = cn.prepareStatement(
									"SELECT V.variation_id,VC.var_name FROM variation V INNER JOIN variation_combo VC ON V.variation_name_id=VC.var_id WHERE V.category_id=? AND VC.var_name NOT LIKE '%COLOR%'",
									ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
							ps.setString(1, category_id);
							rs = ps.executeQuery();
							while (!rs.isBeforeFirst()) {
								int category_id_size = Product.getSuperCategoryId(Integer.parseInt(category_id));
								ps = cn.prepareStatement(
								"SELECT V.variation_id,VC.var_name FROM variation V INNER JOIN variation_combo VC ON V.variation_name_id=VC.var_id WHERE V.category_id=? AND VC.var_name NOT LIKE '%COLOR%'",
								ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
								ps.setInt(1, category_id_size);
								rs.close();
								rs = ps.executeQuery();
							}
							while (rs.next()) {
								ps = cn.prepareStatement(
								"SELECT VO.variation_value_id,VCV.var_value FROM variation_options VO INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id WHERE VO.variation_id=?");
								ps.setInt(1, rs.getInt("variation_id"));
								rs1 = ps.executeQuery();
							%>
							<div class="widget widget-filter mb-4 pb-4 border-bottom">
								<h3 class="widget-title"><%=rs.getString("var_name")%></h3>
								<div class="input-group input-group-sm mb-2">
									<input
										class="widget-filter-search form-control rounded-end pe-5"
										type="text" placeholder="Search"><i
										class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
								</div>
								<ul class="widget-list widget-filter-list list-unstyled pt-1"
									style="max-height: 11rem;" data-simplebar
									data-simplebar-auto-hide="false">
									<%
									while (rs1.next()) {
									%>
									<li
										class="widget-filter-item d-flex justify-content-between align-items-center mb-1">
										<div class="form-check">
											<input class="form-check-input"
												onchange="filterProductsList()" name="filterVariations[]"
												type="checkbox" value="<%=rs1.getString("var_value")%>"
												id="<%=rs.getString("var_name")%>-"> <label
												class="form-check-label widget-filter-item-text"
												for="<%=rs.getString("var_name")%>-"><%=rs1.getString("var_value")%></label>
										</div> <span class="fs-xs text-muted"></span>
									</li>
									<%
									}
									%>

								</ul>
							</div>
							<%
							}
							%>
						</div>
					</div>
				</aside>
			</div>
		</div>
	</main>

	<%
	SiteConstants.HAND_HALD_TOOLBAR = true;
	%>
	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<!-- / Footer -->

	<%
	SiteConstants.HAND_HALD_TOOLBAR = false;
	%>

	<script>
		loadProductsList();
		$("#ProductCategoriesFilter").hide();
	</script>
</body>

</html>