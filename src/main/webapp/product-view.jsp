<%@page import="java.util.Iterator"%>
<%@page import="product.ProductItemCatalog"%>
<%@page import="java.util.ArrayList"%>
<%@page import="product.Product"%>
<%@page import="generalModule.FormatPrice"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
String product_id = "";
String product_item_id = "";
boolean hasItemId = false;
if (request.getParameter("pid") != null) {
	product_id = request.getParameter("pid");
	if (request.getParameter("piid") != null) {
		product_item_id = request.getParameter("piid");
		hasItemId = true;
	}
} else {
	response.sendRedirect("index.jsp");
}
%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="product.GetProductVariations"%>
<%@page import="generalModule.GetPercantege"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Product View</title>
<!-- Imports -->
<%@include file="components/imports.jsp"%>
<%
Connection cn = ConnectionProvider.getCon();
PreparedStatement ps;
ResultSet rs;
%>
</head>
<!-- Body-->
<body class="handheld-toolbar-enabled">

	<main class="page-wrapper">
		<!-- Size chart modal-->
		<div class="modal fade" id="size-chart">
			<div class="modal-dialog modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header bg-secondary">
						<ul class="nav nav-tabs card-header-tabs" role="tablist"
							style="margin-bottom: -1rem;">
							<li class="nav-item"><a class="nav-link fw-medium active"
								href="#mens" data-bs-toggle="tab" role="tab"
								aria-controls="mens" aria-selected="true">Men's sizes</a></li>
							<li class="nav-item"><a class="nav-link fw-medium"
								href="#womens" data-bs-toggle="tab" role="tab"
								aria-controls="womens" aria-selected="false">Women's sizes</a></li>
						</ul>
						<button class="btn-close" type="button" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body p-0">
						<div class="tab-content">
							<div class="tab-pane fade show active" id="mens" role="tabpanel">
								<div class="p-1">
									<h6 class="p-2">T-Shirt</h6>
									<div class="table-responsive">
										<table class="table fs-sm text-center mb-0">
											<thead>
												<tr>
													<th class="align-middle bg-secondary">Size</th>
													<th class="align-middle">Chest</th>
													<th class="align-middle">Brand Size</th>
													<th class="align-middle">Shoulder</th>
													<th class="align-middle">Length</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>S</td>
													<td>37.5</td>
													<td>S</td>
													<td>16.3</td>
													<td>26.5</td>
												</tr>
												<tr>
													<td>M</td>
													<td>39.5</td>
													<td>M</td>
													<td>16.8</td>
													<td>27</td>
												</tr>
												<tr>
													<td>L</td>
													<td>41.5</td>
													<td>L</td>
													<td>17.3</td>
													<td>27.5</td>
												</tr>
												<tr>
													<td>XL</td>
													<td>44.5</td>
													<td>XL</td>
													<td>18</td>
													<td>28</td>
												</tr>
												<tr>
													<td>XXL</td>
													<td>47.5</td>
													<td>XXL</td>
													<td>18.8</td>
													<td>28.5</td>
												</tr>
												<tr>
													<td>3XL</td>
													<td>50</td>
													<td>3XL</td>
													<td>19.8</td>
													<td>29</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div class="p-1">
									<h6 class="p-2">Shirts</h6>
									<div class="table-responsive">
										<table class="table fs-sm text-center mb-0">
											<thead>
												<tr>
													<th class="align-middle bg-secondary">Size</th>
													<th class="align-middle">Chest</th>
													<th class="align-middle">Length</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>M</td>
													<td>39</td>
													<td>29</td>
												</tr>
												<tr>
													<td>L</td>
													<td>40</td>
													<td>30</td>
												</tr>
												<tr>
													<td>XL</td>
													<td>43</td>
													<td>31</td>
												</tr>
											</tbody>
										</table>
									</div>

								</div>
							</div>
							<div class="tab-pane fade" id="womens" role="tabpanel">
								<div class="table-responsive">
									<table class="table fs-sm text-center mb-0">
										<thead>
											<tr>
												<th class="align-middle bg-secondary">US<br>Sizes
												</th>
												<th class="align-middle">Euro<br>Sizes
												</th>
												<th class="align-middle">UK<br>Sizes
												</th>
												<th class="align-middle">Inches</th>
												<th class="align-middle">CM</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="bg-secondary fw-medium">4</td>
												<td>35</td>
												<td>2</td>
												<td>8.1875"</td>
												<td>20.8</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">4.5</td>
												<td>35</td>
												<td>2.5</td>
												<td>8.375"</td>
												<td>21.3</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">5</td>
												<td>35-36</td>
												<td>3</td>
												<td>8.5"</td>
												<td>21.6</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">5.5</td>
												<td>36</td>
												<td>3.5</td>
												<td>8.75"</td>
												<td>22.2</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">6</td>
												<td>36-37</td>
												<td>4</td>
												<td>8.875"</td>
												<td>22.5</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">6.5</td>
												<td>37</td>
												<td>4.5</td>
												<td>9.0625"</td>
												<td>23</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">7</td>
												<td>37-38</td>
												<td>5</td>
												<td>9.25"</td>
												<td>23.5</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">7.5</td>
												<td>38</td>
												<td>5.5</td>
												<td>9.375"</td>
												<td>23.8</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">8</td>
												<td>38-39</td>
												<td>6</td>
												<td>9.5"</td>
												<td>24.1</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">8.5</td>
												<td>39</td>
												<td>6.5</td>
												<td>9.6875"</td>
												<td>24.6</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">9</td>
												<td>39-40</td>
												<td>7</td>
												<td>9.875"</td>
												<td>25.1</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">9.5</td>
												<td>40</td>
												<td>7.5</td>
												<td>10"</td>
												<td>25.4</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">10</td>
												<td>40-41</td>
												<td>8</td>
												<td>10.1875"</td>
												<td>25.9</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">10.5</td>
												<td>41</td>
												<td>8.5</td>
												<td>10.3125"</td>
												<td>26.2</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">11</td>
												<td>41-42</td>
												<td>9</td>
												<td>10.5"</td>
												<td>26.7</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">11.5</td>
												<td>42</td>
												<td>9.5</td>
												<td>10.6875"</td>
												<td>27.1</td>
											</tr>
											<tr>
												<td class="bg-secondary fw-medium">12</td>
												<td>42-43</td>
												<td>10</td>
												<td>10.875"</td>
												<td>27.6</td>
											</tr>
										</tbody>
									</table>
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
			<%
			if (hasItemId) {
				ps = cn.prepareStatement(
				"SELECT P.*,PI.item_listing_price,PI.item_selling_price,PI.product_item_id,PI.item_quantity,PC.category_name FROM product P INNER JOIN product_item PI ON p.product_id=PI.product_id INNER JOIN product_categories PC ON P.category_id=PC.category_id WHERE P.product_id=? AND PI.product_item_id=?");
				ps.setString(2, product_item_id);
			} else {
				ps = cn.prepareStatement(
				"SELECT P.*,PI.item_listing_price,PI.item_selling_price,PI.product_item_id,PI.item_quantity,PC.category_name FROM product P INNER JOIN product_item PI ON p.product_id=PI.product_id INNER JOIN product_categories PC ON P.category_id=PC.category_id WHERE P.product_id=? LIMIT 1");
			}

			ps.setString(1, product_id);
			rs = ps.executeQuery();
			if (!rs.isBeforeFirst()) {
				ps = cn.prepareStatement(
				"SELECT P.*,PI.item_listing_price,PI.item_selling_price,PI.item_quantity,PI.product_item_id,PC.category_name FROM product P INNER JOIN product_item PI ON p.product_id=PI.product_id INNER JOIN product_categories PC ON P.category_id=PC.category_id ORDER BY RAND() LIMIT 1");
			}
			rs = ps.executeQuery();
			rs.next();

			Map<String, String> variations = GetProductVariations.getAllVariationsFor(rs.getString("product_item_id"));
			List<String> images = GetProductVariations.getProductItemImagesFor(rs.getString("product_item_id"));
			Map<String, Integer> colors = GetProductVariations.getColorVariation(product_id);
			Map<String, Integer> CapSize = GetProductVariations.getSizeCapacityVariation(rs.getString("product_id"));
			%>

			<div class="container d-lg-flex justify-content-between py-2 py-lg-3">
				<div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
					<nav aria-label="breadcrumb">
						<ol
							class="breadcrumb breadcrumb-light flex-lg-nowrap justify-content-center justify-content-lg-start">
							<li class="breadcrumb-item"><a class="text-nowrap"
								href="index.jsp"><i class="ci-home"></i>Home</a></li>
							<li class="breadcrumb-item text-nowrap"><a
								href="products-rs.jsp?cid=<%=rs.getString("category_id")%>">Shop</a>
							</li>
							<li class="breadcrumb-item text-nowrap active"
								aria-current="page"><%=rs.getString("category_name")%></li>
						</ol>
					</nav>
				</div>
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
					<h1 class="h3 text-light mb-0"><%=rs.getString("product_name")%></h1>
				</div>
			</div>
		</div>
		<div class="container">


			<!-- Gallery + details-->
			<div class="bg-light shadow-lg rounded-3 px-4 py-3 mb-5">
				<div class="px-lg-3">
					<div class="row">

						<!-- Product gallery-->
						<div class="col-lg-7 pe-lg-0 pt-lg-4">
							<div class="product-gallery">
								<div class="product-gallery-preview order-sm-2">
									<%
									for (int i = 0; i < images.size(); i++) {
										String path = images.get(i);
									%>
									<div
										class="product-gallery-preview-item <%if (i == 0) {
	out.print("active");
}%>"
										id="img<%=i + 1%>">
										<img class="image-zoom" src="img/shop/products/<%=path%>"
											data-zoom="img/shop/products/<%=path%>"
											alt="<%=rs.getString("product_name")%> img<%=i + 1%>">
										<div class="image-zoom-pane"></div>
									</div>
									<%
									}
									%>
								</div>
								<div class="product-gallery-thumblist order-sm-1">
									<%
									for (int i = 0; i < images.size(); i++) {
										String path = images.get(i);
									%>
									<a
										class="product-gallery-thumblist-item <%if (i == 0) {
	out.print("active");
}%>"
										href="#img<%=i + 1%>"> <img
										src="img/shop/products/<%=path%>"
										alt="<%=rs.getString("product_name")%> img<%=i + 1%>">
									</a>
									<%
									}
									%>
								</div>
							</div>
						</div>
						<!-- Product details-->
						<div class="col-lg-5 pt-4 pt-lg-0">
							<div class="product-details ms-auto pb-3">
								<%
								//for ratting
								ps = cn.prepareStatement(
										"SELECT count(review_id) as total_reviews FROM user_review UR INNER JOIN order_line L ON UR.ordered_product_id=L.order_line_id INNER JOIN product_item PI ON L.product_item_id=PI.product_item_id INNER JOIN product P ON PI.product_id=P.product_id WHERE P.product_id=?");
								ps.setString(1, product_id);
								ResultSet rs2 = ps.executeQuery();
								rs2.next();
								int total_reviews = rs2.getInt("total_reviews");
								ps = cn.prepareStatement(
										"SELECT UR.rating_value FROM user_review UR INNER JOIN order_line L ON UR.ordered_product_id=L.order_line_id INNER JOIN product_item PI ON L.product_item_id=PI.product_item_id INNER JOIN product P ON PI.product_id=P.product_id WHERE P.product_id=?");
								ps.setString(1, product_id);
								rs2 = ps.executeQuery();
								int rating_values = 1;
								while (rs2.next()) {
									rating_values += rs2.getInt("rating_value");
								}
								double average = 0;
								if (total_reviews != 0) {
									average = rating_values / total_reviews;
								}
								%>
								<div
									class="d-flex justify-content-between align-items-center mb-2">
									<a href="#reviews" data-scroll>
										<div class="star-rating">
											<%
											double tempaverage = average;
											for (int i = 1; i <= 5; i++) {
												if (tempaverage >= 1) {
											%>
											<i class="star-rating-icon ci-star-filled active"></i>
											<%
											tempaverage--;
											} else {
											%>
											<i class="star-rating-icon ci-star"></i>
											<%
											}
											}
											%>
										</div> <span
										class="d-inline-block fs-sm text-body align-middle mt-1 ms-1"><%=total_reviews%>
											Reviews</span>
									</a>
									<button class="btn-wishlist me-0 me-lg-n3" type="button"
										data-bs-toggle="tooltip" title="Add to wishlist">
										<i class="ci-heart"></i>
									</button>
								</div>
								<div class="mb-3">
									<span class="h3 fw-normal text-accent me-1"><%=FormatPrice.formatPrice(rs.getString("item_selling_price"))%></span>
									<del class="text-muted fs-lg me-3">

										<%=FormatPrice.formatPrice(rs.getString("item_listing_price"))%>
									</del>
									<span class="badge bg-success badge-shadow align-middle mt-n2"><%=GetPercantege.getPercantage(rs.getInt("item_listing_price"), rs.getInt("item_selling_price"))%>%
										off</span>
								</div>
								<%
								int item_quantity = rs.getInt("item_quantity");
								String colorval = "";
								if (colors.size() >= 1) {
								%>
								<div class="position-relative fs-sm mb-4">
									<span class="text-heading fw-medium me-1">Color:</span> <span
										class="text-muted" id="colorOption"> <%
 int i = 0;
 for (Map.Entry<String, Integer> color : colors.entrySet()) {
 	out.print(color.getKey());
 	colorval = color.getKey();
 	if (colors.size()-1 != i) {
 		out.print(" / ");
 	}
 	 i++;
 }
 %>
									</span>
									<%
									if (item_quantity >= 40) {
									%>
									<div class="product-badge product-available mt-n1">
										<i class="ci-security-check"></i> Product available
									</div>
									<%
									} else if (item_quantity >= 30) {
									%>
									<div class="bg-warning product-badge product-available mt-n1">
										<i class="bi bi-exclamation-triangle"></i> Product available
									</div>
									<%
									} else if (item_quantity < SiteConstants.STOCK_LEFT_MESSAGE_BADGE_AT && item_quantity >= 1) {
									%>
									<div class="bg-danger product-badge product-available mt-n1">
										<i class="bi bi-graph-up"></i> Hurry Up, Only <b><%=item_quantity%></b>
										Left
									</div>
									<%
									} else if (item_quantity < 1) {
									%>
									<div class="bg-danger product-badge product-available mt-n1">
										<i class="bi bi-x-square"></i> Product Is Out Of Stock
									</div>
									<%
									}
									%>
								</div>
								<%
								}
								%>
								<div class="position-relative me-n4 mb-3">
									<%
									if (colors.size() > 1) {
										for (Map.Entry<String, Integer> color : colors.entrySet()) {
											String nameVarient = "Color" + product_id;
									%>
									<div class="form-check form-option form-check-inline mb-2">
										<input class="form-check-input pvchcolor"
											data-pid="<%=product_id%>" data-piid="<%=color.getValue()%>"
											type="radio" name="rdocolors"
											id="<%=nameVarient + color.getKey()%>"
											value="<%=color.getKey()%>"
											<%for (Map.Entry<String, String> variation : variations.entrySet()) {
	if (color.getKey().equals(variation.getValue())) {
		out.print(" checked");
	}
}%>>
										<label class="form-option-label rounded-circle"
											for="<%=nameVarient + color.getKey()%>"><span
											class="form-option-color rounded-circle"
											style="background-color: <%=color.getKey()%>"></span></label>
									</div>
									<%
									}
									} else if (colors.size() == 1) {
									%>
									<input class='d-none' type="radio" name="rdocolors"
										value="<%=colorval%>" checked />
									<%
									}
									%>

								</div>
								<form class="mb-grid-gutter" method="post">
									<%
									if (CapSize != null) {
									%>
									<div class="mb-3">
										<div
											class="d-flex justify-content-between align-items-center pb-1">
											<label class="form-label" for="product-size">Size:
												&nbsp;<%
											if (CapSize.size() == 1) {
												for (Map.Entry<String, Integer> size : CapSize.entrySet()) {
													out.print(size.getKey());
											%>
												<div class='d-none'>
													<select id="product-size">
														<option value="<%=size.getKey()%>" selected><%=size.getKey()%></option>
													</select>
												</div> <%
 }
 }
 %>
											</label> <a class="nav-link-style fs-sm" href="#size-chart"
												data-bs-toggle="modal"><i
												class="ci-ruler lead align-middle me-1 mt-n1"></i>Size guide</a>
										</div>
										<%
										if (CapSize.size() > 1) {
											String nameSelect = "ComboSize" + rs.getString("product_id");
										%>
										<select class="form-select" required id="product-size"
											onchange="passProductId(<%=product_id%>)"
											name="<%=nameSelect%>">
											<%
											for (Map.Entry<String, Integer> size : CapSize.entrySet()) {
											%>
											<option value="<%=size.getKey()%>"
												<%for (Map.Entry<String, String> variation : variations.entrySet()) {
	if (size.getKey().equals(variation.getValue())) {
		out.print(" selected");
	}
}%>><%=size.getKey()%></option>
											<%
											}
											%>
										</select>
										<%
										}
										%>

									</div>
									<%
									}else{
									%>
									<div class='d-none'>
										<select id="product-size">
											<option value="" selected>&nbsp;</option>
										</select>
									</div>
									<% } %>
									<div class="mb-3 d-flex align-items-center">
										<select class="form-select me-3" id="item_quantity"
											style="width: 5rem;">
											<option value="1" selected>1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
										</select>
										<%
										if (item_quantity >= 1) {
										%>
										<button
											class="btn btn-primary btn-shadow d-block w-100 add-to-cart"
											data-pid="<%=product_id%>"
											data-piid="<%=rs.getString("product_item_id")%>"
											type="button">
											<i class="ci-cart fs-lg me-2"></i>Add to Cart
										</button>
										<%
										} else {
										%>
										<button class="btn btn-primary btn-shadow d-block w-100"
											type="submit" disabled>
											<i class="ci-cart fs-lg me-2"></i>Add to Cart
										</button>
										<%
										}
										%>
									</div>
								</form>
								<!-- Product panels-->
								<div class="accordion mb-4" id="productPanels">
									<div class="accordion-item">
										<h3 class="accordion-header">
											<a class="accordion-button" href="#productInfo" role="button"
												data-bs-toggle="collapse" aria-expanded="true"
												aria-controls="productInfo"><i
												class="ci-announcement text-muted fs-lg align-middle mt-n1 me-2"></i>Product
												info</a>
										</h3>
										<div class="accordion-collapse collapse show" id="productInfo"
											data-bs-parent="#productPanels">

											<div class="accordion-body">
												<ul class="fs-sm list-group list-group-flush">
													<%
													for (Map.Entry<String, String> variation : variations.entrySet()) {
													%>
													<li class="list-group-item"><b><%=variation.getKey()%></b>
														: <%=variation.getValue()%></li>
													<%
													}
													%>
												</ul>
											</div>
										</div>
									</div>
									<div class="accordion-item">
										<h3 class="accordion-header">
											<a class="accordion-button collapsed" href="#shippingOptions"
												role="button" data-bs-toggle="collapse" aria-expanded="true"
												aria-controls="shippingOptions"><i
												class="ci-delivery text-muted lead align-middle mt-n1 me-2"></i>Shipping
												options</a>
										</h3>
										<div class="accordion-collapse collapse" id="shippingOptions"
											data-bs-parent="#productPanels">
											<div class="accordion-body fs-sm">
												<%
												ps = cn.prepareStatement("SELECT * FROM shipping_method");
												ResultSet rs1 = ps.executeQuery();
												while (rs1.next()) {
												%>
												<div class="d-flex justify-content-between pt-2">
													<div>
														<div class="fw-semibold text-dark"><%=rs1.getString("shipping_method_name")%></div>
														<div class="fs-sm text-muted"><%=rs1.getString("shipping_time")%></div>
													</div>
													<div><%=FormatPrice.formatPrice(rs1.getString("price"))%></div>
												</div>
												<%
												}
												%>

											</div>
										</div>
									</div>
								</div>
								<!-- Sharing-->
								<label class="form-label d-inline-block align-middle my-2 me-3">Share:</label><a
									class="btn-share btn-twitter me-2 my-2" href="#"><i
									class="ci-twitter"></i>Twitter</a><a
									class="btn-share btn-instagram me-2 my-2" href="#"><i
									class="ci-instagram"></i>Instagram</a><a
									class="btn-share btn-facebook my-2" href="#"><i
									class="ci-facebook"></i>Facebook</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Product description section 1-->
			<div class="row align-items-center py-md-3">
				<div class="col-lg-5 col-md-6 offset-lg-1 order-md-2 gallery"
					data-video="true">

					<h6 class="h3 mb-4 pb-2 text-center">Product Image Gallery</h6>
					<!-- Gallery grid with gutters -->
					<div class="d-flex flex-wrap justify-content-center">
						<%
						for (int i = 0; i < images.size(); i++) {
							String path = images.get(i);
						%>
						<!-- Item -->
						<div class="mb-grid-gutter px-2">
							<a href="img/shop/products/<%=path%>"
								class="gallery-item rounded-3"
								data-sub-html='<h6 class="fs-sm text-light">Product Image <%=i + 1%></h6>'>
								<img src="img/shop/products/<%=path%>" alt="Gallery thumbnail"
								style="min-height: 180px; max-height: 300px; max-width: 200px; object-fit: scale-down;">
								<span class="gallery-item-caption">Product Image <%=i + 1%></span>
							</a>
						</div>
						<%
						}
						%>
					</div>

				</div>
				<div class="col-lg-4 col-md-6 offset-lg-1 py-4 order-md-1">
					<h2 class="h3 mb-4 pb-2">Product Detail</h2>
					<p class="fs-sm text-muted pb-2"><%=rs.getString("product_description")%></p>
					<div class="table-responsive">
						<table class="table table-striped">
							<thead>
								<tr>
									<th colspan="2">More Details</th>
								</tr>
							</thead>
							<tbody>
								<%
								for (Map.Entry<String, String> variation : variations.entrySet()) {
								%>
								<tr>
									<th><%=variation.getKey()%></th>
									<td><%=variation.getValue()%></td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- Reviews-->
		<div class="border-top border-bottom my-lg-3 py-5">
			<div class="container pt-md-2" id="reviews">
				<div class="row pb-3">
					<div class="col-lg-4 col-md-5">
						<h2 class="h3 mb-4"><%=total_reviews%>
							Reviews
						</h2>
						<div class="star-rating me-2">
							<%
							tempaverage = average;
							for (int i = 1; i <= 5; i++) {
								if (tempaverage >= 1) {
							%>
							<i class="ci-star-filled fs-sm text-accent me-1"></i>
							<%
							tempaverage--;
							} else {
							%>
							<i class="ci-star fs-sm text-muted me-1"></i>
							<%
							}
							}
							%>
						</div>
						<span class="d-inline-block align-middle"><%=average%>
							Overall rating</span>
					</div>
					<div class="col-lg-8 col-md-7">
						<div class="d-flex align-items-center mb-2">
							<div class="text-nowrap me-3">
								<span class="d-inline-block align-middle text-muted">5</span><i
									class="ci-star-filled fs-xs ms-1"></i>
							</div>
							<div class="w-100">
								<div class="progress" style="height: 4px;">
									<div class="progress-bar bg-success" role="progressbar"
										style="width: 60%;" aria-valuenow="60" aria-valuemin="0"
										aria-valuemax="100"></div>
								</div>
							</div>
							<span class="text-muted ms-3"><%=Product.getRatingCount(product_id, 5)%></span>
						</div>
						<div class="d-flex align-items-center mb-2">
							<div class="text-nowrap me-3">
								<span class="d-inline-block align-middle text-muted">4</span><i
									class="ci-star-filled fs-xs ms-1"></i>
							</div>
							<div class="w-100">
								<div class="progress" style="height: 4px;">
									<div class="progress-bar" role="progressbar"
										style="width: 27%; background-color: #a7e453;"
										aria-valuenow="27" aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</div>
							<span class="text-muted ms-3"><%=Product.getRatingCount(product_id, 4)%></span>
						</div>
						<div class="d-flex align-items-center mb-2">
							<div class="text-nowrap me-3">
								<span class="d-inline-block align-middle text-muted">3</span><i
									class="ci-star-filled fs-xs ms-1"></i>
							</div>
							<div class="w-100">
								<div class="progress" style="height: 4px;">
									<div class="progress-bar" role="progressbar"
										style="width: 17%; background-color: #ffda75;"
										aria-valuenow="17" aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</div>
							<span class="text-muted ms-3"><%=Product.getRatingCount(product_id, 3)%></span>
						</div>
						<div class="d-flex align-items-center mb-2">
							<div class="text-nowrap me-3">
								<span class="d-inline-block align-middle text-muted">2</span><i
									class="ci-star-filled fs-xs ms-1"></i>
							</div>
							<div class="w-100">
								<div class="progress" style="height: 4px;">
									<div class="progress-bar" role="progressbar"
										style="width: 9%; background-color: #fea569;"
										aria-valuenow="9" aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</div>
							<span class="text-muted ms-3"><%=Product.getRatingCount(product_id, 2)%></span>
						</div>
						<div class="d-flex align-items-center">
							<div class="text-nowrap me-3">
								<span class="d-inline-block align-middle text-muted">1</span><i
									class="ci-star-filled fs-xs ms-1"></i>
							</div>
							<div class="w-100">
								<div class="progress" style="height: 4px;">
									<div class="progress-bar bg-danger" role="progressbar"
										style="width: 4%;" aria-valuenow="4" aria-valuemin="0"
										aria-valuemax="100"></div>
								</div>
							</div>
							<span class="text-muted ms-3"><%=Product.getRatingCount(product_id, 1)%></span>
						</div>
					</div>
				</div>
				<hr class="mt-4 mb-3">
				<div class="row pt-4">
					<!-- Reviews list-->
					<div
						class="col-md-<%if (signedIn) {
	out.print("7");
} else {
	out.print("12");
}%>">
						<div class="d-flex justify-content-end pb-4">
							<div class="d-flex align-items-center flex-nowrap">
								<label
									class="fs-sm text-muted text-nowrap me-2 d-none d-sm-block"
									for="sort-reviews">Sort by:</label> <select
									class="form-select form-select-sm" id="sort-reviews">
									<option>Newest</option>
									<option>Oldest</option>
									<option>Popular</option>
									<option>High rating</option>
									<option>Low rating</option>
								</select>
							</div>
						</div>

						<!-- Review-->
						<%
						ps = cn.prepareStatement(
								"SELECT UR.user_id,UR.rating_value,UR.comment,DATE_FORMAT(UR.review_date,'%D-%M-%Y') as review_date FROM user_review UR INNER JOIN order_line L ON UR.ordered_product_id=L.order_line_id INNER JOIN product_item PI ON L.product_item_id=PI.product_item_id INNER JOIN product P ON PI.product_id=P.product_id WHERE P.product_id=? LIMIT 2");
						ps.setString(1, product_id);
						ResultSet reviews = ps.executeQuery();
						if (!reviews.isBeforeFirst()) {
						%>
						<div class='d-flex justify-content-center mt-5 mb-5'>No
							Reviews Available For This Product</div>
						<%
						} else {
						while (reviews.next()) {
							ps = cn.prepareStatement("SELECT user_name,user_image FROM site_users WHERE user_id=?");
							ps.setString(1, reviews.getString("user_id"));
							rs = ps.executeQuery();
							rs.next();
						%>
						<div class="product-review pb-4 mb-4 border-bottom">
							<div class="d-flex mb-3">
								<div class="d-flex align-items-center me-4 pe-2">
									<img class="rounded"
										src="img/shop/account/<%=rs.getString("user_image")%>"
										width="50" alt="<%=rs.getString("user_name")%>">
									<div class="ps-3">
										<h6 class="fs-sm mb-0"><%=rs.getString("user_name")%></h6>
										<span class="fs-ms text-muted"><%=reviews.getString("review_date")%></span>
									</div>
								</div>
								<div>
									<div class="star-rating">
										<%
										int rating_value = reviews.getInt("rating_value");
										for (int i = 1; i <= 5; i++) {
											if (rating_value != 0) {
										%>
										<i class="star-rating-icon ci-star-filled active"></i>
										<%
										rating_value--;
										} else {
										%>
										<i class="star-rating-icon ci-star"></i>
										<%
										}
										}
										%>
									</div>
								</div>
							</div>
							<p class="fs-md mb-2"><%=reviews.getString("comment")%></p>
						</div>
						<%
						}
						}
						%>

						<div class="text-center">
							<button class="btn btn-outline-accent" type="button">
								<i class="ci-reload me-2"></i>Load more reviews
							</button>
						</div>
					</div>

					<!-- Leave review form-->
					<%
					if (signedIn) {
					%>
					<div class="col-md-5 mt-2 pt-4 mt-md-0 pt-md-0">
						<div class="bg-secondary py-grid-gutter px-grid-gutter rounded-3">
							<h3 class="h4 pb-2">Write a review</h3>
							<form id="post-review">
								<div class="mb-3">
									<label class="form-label" for="review-rating">Rating<span
										class="text-danger">*</span></label> <select class="form-select"
										required id="review-rating" name="review-rating">
										<option value="">Choose rating</option>
										<option value="5">5 stars</option>
										<option value="4">4 stars</option>
										<option value="3">3 stars</option>
										<option value="2">2 stars</option>
										<option value="1">1 star</option>
									</select>
								</div>
								<div class="mb-3">
									<label class="form-label" for="review-text">Review<span
										class="text-danger">*</span></label>
									<textarea class="form-control" rows="6" required
										id="review-text" name="review-text" minlength="50"
										maxlength="255"></textarea>
									<small class="form-text text-muted">Your review must be
										at least 50 characters.</small>
								</div>
								<%
								ps = cn.prepareStatement(
										"SELECT count(O.user_id) FROM order_line L INNER JOIN shop_order O ON L.order_id=O.order_id INNER JOIN product_item PI ON L.product_item_id=PI.product_item_id INNER JOIN product P ON P.product_id=PI.product_id WHERE O.user_id=? AND P.product_id=?");
								ps.setString(1, session.getAttribute("uid").toString());
								ps.setString(2, product_id);
								rs1 = ps.executeQuery();
								rs1.next();
								String value = "";
								if (rs1.getInt(1) < 1) {
									value = "disabled";
								}
								%>
								<input type="hidden" name="hdnreview" value="<%=product_id%>" />
								<button class="btn btn-primary btn-shadow d-block w-100"
									data-bs-toggle="tooltip" title="Write A Review"
									data-bs-placement="bottom" type="submit" <%=value%>>Submit
									a Review</button>
							</form>
							<div class="mt-2" id="reviewPostStatus"></div>
						</div>
					</div>
					<%
					}
					%>
				</div>
			</div>
		</div>



		<!-- Product carousel (Style with)-->
		<%
		ps = cn.prepareStatement("SELECT category_id FROM product P WHERE product_id=?");
		ps.setString(1, product_id);
		rs = ps.executeQuery();
		rs.next();
		ps = cn.prepareStatement("SELECT product_id,product_name FROM product WHERE category_id=? ORDER BY RAND() LIMIT 6");
		ps.setInt(1, rs.getInt("category_id"));
		rs = ps.executeQuery();
		%>


		<div class="container pt-5" id="you-may-like">
			<h2 class="h3 text-center pb-4">Style with</h2>
			<div class="tns-carousel tns-controls-static tns-controls-outside">
				<div class="tns-carousel-inner"
					data-carousel-options="{&quot;items&quot;: 2, &quot;controls&quot;: true, &quot;nav&quot;: false, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1},&quot;500&quot;:{&quot;items&quot;:2, &quot;gutter&quot;: 18},&quot;768&quot;:{&quot;items&quot;:3, &quot;gutter&quot;: 20}, &quot;1100&quot;:{&quot;items&quot;:4, &quot;gutter&quot;: 30}}}">
					<!-- Product-->
					<div>
						<div class="card product-card card-static">
							<button class="btn-wishlist btn-sm" type="button"
								data-bs-toggle="tooltip" data-bs-placement="left"
								title="Add to wishlist">
								<i class="ci-heart"></i>
							</button>
							<a
								class="card-img-top d-flex justify-content-center overflow-hidden"
								href="#"><img src="#" alt="Product"
								style="object-fit: scale-down; height: 300px;"></a>
							<div class="card-body py-2">
								<h3 class="product-title fs-sm">
									<a href="#">Product Name</a>
								</h3>
								<div class="d-flex justify-content-between">
									<div class="product-price text-accent">PRICE HERE</div>
								</div>
							</div>
						</div>
					</div>


				</div>
			</div>
		</div>

		<!-- Product carousel (You may also like)-->
		<div class="container py-5 my-md-3">
			<h2 class="h3 text-center pb-4">You may also like</h2>
			<div class="tns-carousel tns-controls-static tns-controls-outside">
				<div class="tns-carousel-inner"
					data-carousel-options="{&quot;items&quot;: 2, &quot;controls&quot;: true, &quot;nav&quot;: false, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1},&quot;500&quot;:{&quot;items&quot;:2, &quot;gutter&quot;: 18},&quot;768&quot;:{&quot;items&quot;:3, &quot;gutter&quot;: 20}, &quot;1100&quot;:{&quot;items&quot;:4, &quot;gutter&quot;: 30}}}">
					<!-- Product-->
					<%
					while (rs.next()) {
						ArrayList<ProductItemCatalog> item = Product.getProductItemInfo(rs.getInt("product_id"), 1, " ORDER BY RAND() ");
						if (item.size() != 0) {
							ProductItemCatalog it_style = item.get(0);
							ArrayList<String> images_style = GetProductVariations
							.getProductItemImagesFor(it_style.getProduct_item_id() + "");
							String image_path_style = images_style.get(0);
					%>

					<div>
						<div class="card product-card card-static">
							<button class="btn-wishlist btn-sm" type="button"
								data-bs-toggle="tooltip" data-bs-placement="left"
								title="Add to wishlist">
								<i class="ci-heart"></i>
							</button>
							<a class="card-img-top d-block overflow-hidden"
								href="product-view.jsp?pid=<%=rs.getInt("product_id")%>&piid=<%=it_style.getProduct_item_id()%>"><img
								src="img/shop/products/<%=image_path_style%>" alt="Product"
								style="object-fit: scale-down; height: 300px;"></a>
							<div class="card-body py-2">
								<h3 class="product-title fs-sm">
									<a
										href="product-view.jsp?pid=<%=rs.getInt("product_id")%>&piid=<%=it_style.getProduct_item_id()%>"><%=rs.getString("product_name")%></a>
								</h3>
								<div class="d-flex justify-content-between">
									<div class="product-price text-accent">
										<%=FormatPrice.formatPrice(it_style.getItem_selling_price() + "")%>
									</div>
								</div>
							</div>
						</div>
					</div>
					<%
					}
					}
					%>

				</div>
			</div>
		</div>
	</main>

	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<!-- / Footer -->
	<script type="text/javascript">
	$("#you-may-like").hide();
	
	$("#post-review").on("submit",function(e){
		e.preventDefault();
		$.ajax({
			url:"PostReview",
			type:"POST",
			data:$(this).serialize(),
			success:function(data){
				$("#reviewPostStatus").hide();
				$("#reviewPostStatus").html(data);
				$("#reviewPostStatus").fadeIn("slow");
				$("#post-review").trigger("reset");
			}
		});
	});
	</script>
</body>

</html>