<%@page import="generalModule.FormatPrice"%>
<%@page import="product.Product"%>
<%@page import="product.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Checkout-Review</title>
<!-- Imports -->
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
							<li class="breadcrumb-item text-nowrap"><a
								href="shop-categories.jsp">Shop</a></li>
							<li class="breadcrumb-item text-nowrap active"
								aria-current="page">Checkout</li>
						</ol>
					</nav>
				</div>
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
					<h1 class="h3 text-light mb-0">Checkout</h1>
				</div>
			</div>
		</div>
		<div class="container pb-5 mb-2 mb-md-4">
			<form method="POST" id="place-order">
				<div class="row">
					<section class="col-lg-8">
						<!-- Steps-->
						<div class="steps steps-light pt-2 pb-3 mb-5">
							<a class="step-item active" href="shop-cart.jsp">
								<div class="step-progress">
									<span class="step-count">1</span>
								</div>
								<div class="step-label">
									<i class="ci-cart"></i>Cart
								</div>
							</a><a class="step-item active" href="checkout-details.jsp">
								<div class="step-progress">
									<span class="step-count">2</span>
								</div>
								<div class="step-label">
									<i class="ci-user-circle"></i>Details
								</div>
							</a><a class="step-item active" href="checkout-shipping.jsp">
								<div class="step-progress">
									<span class="step-count">3</span>
								</div>
								<div class="step-label">
									<i class="ci-package"></i>Shipping
								</div>
							</a><a class="step-item active" href="checkout-payment.jsp">
								<div class="step-progress">
									<span class="step-count">4</span>
								</div>
								<div class="step-label">
									<i class="ci-card"></i>Payment
								</div>
							</a><a class="step-item active current" href="checkout-review.jsp">
								<div class="step-progress">
									<span class="step-count">5</span>
								</div>
								<div class="step-label">
									<i class="ci-check-circle"></i>Review
								</div>
							</a>
						</div>
						<!-- Order details-->
						<h2 class="h6 pt-1 pb-3 mb-3 border-bottom">Review your order</h2>

						<!-- Item-->
						<%
						ArrayList<Cart> cart = new ArrayList<>();
						int TotalPayable = 0;
						PreparedStatement ps;
						ResultSet rs;
						int subToal = 0;
						int user_id = Integer.parseInt(session.getAttribute("uid").toString());
						ps = cnH.prepareStatement(
								"SELECT product_item_id,item_quantity FROM shopping_cart_item SCI INNER JOIN shopping_cart SC ON SCI.cart_id=SC.cart_id WHERE SC.user_id=?",
								ResultSet.TYPE_SCROLL_INSENSITIVE);
						ps.setInt(1, user_id);
						rs = ps.executeQuery();
						while (rs.next()) {
							cart.add(Product.getCartItems(rs.getInt("product_item_id"), rs.getInt("item_quantity")));
						}

						for (Cart item : cart) {
							String option[] = item.getOption3();
						%>
						<div
							class="d-sm-flex justify-content-between my-4 pb-3 border-bottom">
							<div class="d-sm-flex text-center text-sm-start">
								<a class="d-inline-block flex-shrink-0 mx-auto me-sm-4"
									href="product-view.jsp?pid=<%=item.getProduct_id()%>&piid=<%=item.getProduct_item_id()%>"><img
									src="<%=item.getProduct_item_image_path()%>" width="160"
									alt="<%=item.getProduct_name()%>"
									style="object-fit: scale-down; height: 150px;"></a>
								<div class="pt-2">
									<h3 class="product-title fs-base mb-2">
										<a
											href="product-view.jsp?pid=<%=item.getProduct_id()%>&piid=<%=item.getProduct_item_id()%>"><%=item.getProduct_name()%></a>
									</h3>
									<div class="fs-sm">
										<span class="text-muted me-2">Brand:</span><%=item.getOption2()%>
									</div>
									<div class="fs-sm">
										<span class="text-muted me-2"><%=option[0]%>:</span><%=option[1]%>
									</div>
									<div class="fs-lg text-accent pt-2">
										<%=FormatPrice.formatPrice(item.getProduct_final_price() + "")%>
									</div>
								</div>
							</div>
							<div
								class="pt-2 pt-sm-0 ps-sm-3 mx-auto mx-sm-0 text-center text-sm-end"
								style="max-width: 9rem;">
								<p class="mb-0">
									<span class="text-muted fs-sm">Quantity:</span><span>&nbsp;<%=item.getProduct_quantity()%></span>
								</p>
							</div>
						</div>
						<%
						TotalPayable += item.getProduct_final_price();
						}
						double serviceCharges = SiteConstants.SERVICE_TAX * TotalPayable;
						%>
						<!-- Client details-->

						<%
						ps = cnH.prepareStatement(
								"SELECT user.user_name,user.user_phone,address.address_line1,address.address_line2,CO.country_phone FROM site_users user INNER JOIN user_address_mapping user_address ON user.user_id=user_address.user_id INNER JOIN address ON user_address.address_id=address.address_id INNER JOIN cities C ON address.city_id=C.city_id INNER JOIN states S ON S.state_id=C.state_id INNER JOIN countries CO ON S.country_id=CO.country_id WHERE user.user_id=? AND address.address_id=?");
						ps.setString(1, session.getAttribute("uid").toString());
						ps.setString(2, request.getParameter("addressIdShip"));
						rs = ps.executeQuery();
						rs.next();
						%>
						<div class="bg-secondary rounded-3 px-4 pt-4 pb-2">
							<div class="row">
								<div class="col-sm-6">
									<h4 class="h6">Shipping to:</h4>
									<ul class="list-unstyled fs-sm">
										<li><span class="text-muted">Client:&nbsp;</span><%=rs.getString("user_name")%></li>
										<li><span class="text-muted">Address:&nbsp;</span><%=rs.getString("address_line1")%></li>
										<li><span class="text-muted">Phone:&nbsp;</span>+<%=rs.getString("country_phone")%>&nbsp;&nbsp;<%=rs.getString("user_phone")%></li>
									</ul>
								</div>

								<div class="col-sm-6">
									<h4 class="h6">Payment method:</h4>
									<ul class="list-unstyled fs-sm">
										<%
										if (request.getParameter("cash-on-delivery") == null) {
										%>
										<li><span class="text-muted">Credit Card:&nbsp;</span>****
											**** **** <%=request.getParameter("number").substring(request.getParameter("number").length() - 4)%></li>
										<%
										} else {
										%>
										<li><span class="text-muted">Cash On Delivery</span></li>
										<%
										}
										%>
									</ul>
								</div>
							</div>
						</div>
						<!-- Hidden Values -->
						<input type="hidden" name="shipping-method"
							value="<%=request.getParameter("shipping-method")%>" /> <input
							type="hidden" name="addressIdShip"
							value="<%=request.getParameter("addressIdShip")%>" /> <input
							type="hidden" name="addressIdBill"
							value="<%=request.getParameter("addressIdBill")%>" /> <input
							type="hidden" name="same-address"
							value="<%=request.getParameter("same-address")%>" /> <input
							type="hidden" name="priceToPay"
							value="<%=request.getParameter("priceToPay")%>" /> <input
							type="hidden" name="shippingPrice"
							value="<%=request.getParameter("shippingPrice")%>" /> <input
							type="hidden" name="cardNumber"
							value="<%=request.getParameter("number")%>" /> <input
							type="hidden" name="cash-on-delivery"
							value="<%=request.getParameter("cash-on-delivery")%>" /> <input
							type="hidden" name="payment_method_id"
							value="<%=request.getParameter("payment_method_id")%>" />

						<!-- Navigation (desktop)-->
						<div class="d-none d-lg-flex pt-4">
							<div class="w-50 pe-3">
								<a class="btn btn-secondary d-block w-100"
									href="checkout-payment.jsp"><i
									class="ci-arrow-left mt-sm-0 me-1"></i><span
									class="d-none d-sm-inline">Back to Payment</span><span
									class="d-inline d-sm-none">Back</span></a>
							</div>
							<div class="w-50 ps-2">
								<button class="btn btn-primary d-block w-100" type="submit">
									<span class="d-none d-sm-inline">Complete order</span><span
										class="d-inline d-sm-none">Complete</span><i
										class="ci-arrow-right mt-sm-0 ms-1"></i>
								</button>
							</div>
						</div>
					</section>
					<!-- Sidebar-->
					<aside class="col-lg-4 pt-4 pt-lg-0 ps-xl-5">
						<div class="bg-white rounded-3 shadow-lg p-4 ms-lg-auto">
							<div class="py-2 px-xl-2">
								<h2 class="h6 text-center mb-4">Order summary</h2>
								<ul class="list-unstyled fs-sm pb-2 border-bottom">
									<li class="d-flex justify-content-between align-items-center"><span
										class="me-2">Subtotal:</span><span class="text-end"><%=FormatPrice.formatPrice(TotalPayable + "")%></span></li>
									<li class="d-flex justify-content-between align-items-center"><span
										class="me-2">Shipping:</span><span class="text-end"><%=SiteConstants.COUNTRY_CURRANCY_UNICODE + request.getParameter("shippingPrice")%></span></li>
									<li class="d-flex justify-content-between align-items-center"><span
										class="me-2">Service Charges:</span><span class="text-end"><%=FormatPrice.formatPrice(((int) Math.ceil(serviceCharges)) + "")%></span></li>
								</ul>
								<h3 class="fw-normal text-center my-4">
									<%=FormatPrice.formatPrice(request.getParameter("priceToPay"))%>
								</h3>
							</div>
						</div>
					</aside>
				</div>
				<!-- Navigation (mobile)-->
				<div class="row d-lg-none">
					<div class="col-lg-8">
						<div class="d-flex pt-4 mt-3">
							<div class="w-50 pe-3">
								<a class="btn btn-secondary d-block w-100"
									href="checkout-payment.jsp"><i
									class="ci-arrow-left mt-sm-0 me-1"></i><span
									class="d-none d-sm-inline">Back to Payment</span><span
									class="d-inline d-sm-none">Back</span></a>
							</div>
							<div class="w-50 ps-2">
								<button type="submit" class="btn btn-primary d-block w-100">
									<span class="d-none d-sm-inline">Complete order</span><span
										class="d-inline d-sm-none">Complete</span><i
										class="ci-arrow-right mt-sm-0 ms-1"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</main>

	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<!-- / Footer -->
	<script>
		$("#place-order").on("submit", function(e) {
			e.preventDefault();
			$.ajax({
				url : "PlaceOrder",
				type : "POST",
				data : $(this).serialize(),
				success : function(data) {
						window.location.href="checkout-complete.jsp?order_id="+data;
				}
			});
		});
	</script>

</body>

</html>