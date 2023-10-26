<%@page import="generalModule.PasswordOperations"%>
<%@page import="generalModule.FormatPrice"%>
<%@page import="product.Cart"%>
<%@page import="product.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Checkout-Payment</title>
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
								href="product-categories.jsp">Shop</a></li>
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
			<form action="checkout-review.jsp" method="POST">
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
							</a><a class="step-item active current" href="checkout-payment.jsp">
								<div class="step-progress">
									<span class="step-count">4</span>
								</div>
								<div class="step-label">
									<i class="ci-card"></i>Payment
								</div>
							</a><a class="step-item" href="checkout-review.jsp">
								<div class="step-progress">
									<span class="step-count">5</span>
								</div>
								<div class="step-label">
									<i class="ci-check-circle"></i>Review
								</div>
							</a>
						</div>
						<!-- Payment methods accordion-->
						<h2 class="h6 pb-3 mb-2">Choose payment method</h2>
						<div class="accordion mb-2" id="payment-method">
							<div class="accordion-item">
								<h3 class="accordion-header">
									<a class="accordion-button" href="#card"
										data-bs-toggle="collapse"><i
										class="ci-card fs-lg me-2 mt-n1 align-middle"></i>Pay with
										Credit Card</a>
								</h3>
								<div class="accordion-collapse collapse show" id="card"
									data-bs-parent="#payment-method">
									<div class="accordion-body">
										<%
										PreparedStatement ps = cnH.prepareStatement("SELECT * FROM payment_methods WHERE user_id=? AND is_default=? LIMIT 1");
										ps.setString(1, session.getAttribute("uid").toString());
										ps.setBoolean(2, true);
										ResultSet rs = ps.executeQuery();
										if (!rs.isBeforeFirst()) {
											ps = cnH.prepareStatement("SELECT * FROM payment_methods WHERE user_id=? LIMIT 1");
											ps.setString(1, session.getAttribute("uid").toString());
											rs = ps.executeQuery();
										}
										if (rs.isBeforeFirst()) {
											rs.next();
										%>
										<p class="fs-sm">
											We accept following credit cards:&nbsp;&nbsp;<img
												class="d-inline-block align-middle" src="img/cards.png"
												width="187" alt="Cerdit Cards">
										</p>
										<div class="credit-card-wrapper"></div>
										<div class="credit-card-form row">
											<div class="mb-3 col-sm-6">
												<input class="form-control" type="text" id="number"
													name="number" placeholder="Card Number"
													value="<%=PasswordOperations.PasswordDecrypter(rs.getString("account_number"))%>"
													required>
											</div>
											<div class="mb-3 col-sm-6">
												<input class="form-control" type="text" id="name"
													name="name" placeholder="Full Name"
													value="<%=rs.getString("name_on_card")%>" required>
											</div>
											<div class="mb-3 col-sm-6">
												<input class="form-control" type="text"
													value="<%=rs.getString("expiry_date")%>" id="expiry"
													name="expiry" placeholder="MM/YY" required>
											</div>
											<div class="mb-3 col-sm-6">
												<input class="form-control" type="text" id="cvc" name="cvc"
													placeholder="CVC" required>
											</div>
										</div>
										<input type="hidden" name="payment_method_id"
											value="<%=rs.getString("payment_method_id")%>" />
										<%
										} else {
										%>
										<p class="fs-sm">
											We accept following credit cards:&nbsp;&nbsp;<img
												class="d-inline-block align-middle" src="img/cards.png"
												width="187" alt="Cerdit Cards">
										</p>
										<div class="credit-card-wrapper"></div>
										<div class="credit-card-form row">
											<div class="mb-3 col-sm-6">
												<input class="form-control" type="text" id="number"
													name="number" placeholder="Card Number" required>
											</div>
											<div class="mb-3 col-sm-6">
												<input class="form-control" type="text" id="name"
													name="name" placeholder="Full Name" required>
											</div>
											<div class="mb-3 col-sm-6">
												<input class="form-control" type="text" id="expiry"
													name="expiry" placeholder="MM/YY" required>
											</div>
											<div class="mb-3 col-sm-6">
												<input class="form-control" type="text" id="cvc" name="cvc"
													placeholder="CVC" required>
											</div>
										</div>
										<%
										}
										%>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h3 class="accordion-header">
									<a class="accordion-button collapsed" href="#cod"
										data-bs-toggle="collapse"><i class="bi bi-cash-coin me-2"></i>Cash
										On Delivery</a>
								</h3>
								<div class="accordion-collapse collapse" id="cod"
									data-bs-parent="#payment-method">
									<div class="accordion-body">
										<div class="form-check d-block">
											<input class="form-check-input" type="checkbox"
												id="cash-on-delivery" name="cash-on-delivery"> <label
												class="form-check-label" for="cash-on-delivery">Proceed
												With cash On Delivery</label>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- hidden values -->
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
							type="hidden" name="cardNumber" id="cardNumber" value="" />

						<!-- Navigation (desktop)-->
						<div class="d-none d-lg-flex pt-4">
							<div class="w-50 pe-3">
								<a class="btn btn-secondary d-block w-100"
									href="checkout-shipping.jsp"><i
									class="ci-arrow-left mt-sm-0 me-1"></i><span
									class="d-none d-sm-inline">Back to Shipping</span><span
									class="d-inline d-sm-none">Back</span></a>
							</div>
							<div class="w-50 ps-2">
								<button class="btn btn-primary d-block w-100" type="submit">
									<span class="d-none d-sm-inline">Review your order</span><span
										class="d-inline d-sm-none">Review order</span><i
										class="ci-arrow-right mt-sm-0 ms-1"></i>
								</button>
							</div>
						</div>
					</section>
					<!-- Sidebar-->
					<aside class="col-lg-4 pt-4 pt-lg-0 ps-xl-5">
						<div class="bg-white rounded-3 shadow-lg p-4 ms-lg-auto">
							<div class="py-2 px-xl-2">
								<div class="widget mb-3">
									<h2 class="widget-title text-center">Order summary</h2>
									<%
									ArrayList<Cart> cart = new ArrayList<>();

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
									%>
									<div class="d-flex align-items-center pb-2 border-bottom">
										<a class="d-block flex-shrink-0" href="shop-single-v1.jsp"><img
											src="<%=item.getProduct_item_image_path()%>" width="64"
											alt="<%=item.getProduct_name()%>"></a>
										<div class="ps-2">
											<h6 class="widget-product-title">
												<a
													href="product-view.jsp?pid=<%=item.getProduct_id()%>&piid=<%=item.getProduct_item_id()%>"><%=item.getProduct_name()%></a>
											</h6>
											<div class="widget-product-meta">
												<span class="text-accent me-2"><%=FormatPrice.formatPrice(item.getProduct_final_price() + "")%></span><span
													class="text-muted">x <%=item.getProduct_quantity()%></span>
											</div>
										</div>
									</div>
									<%
									subToal += item.getProduct_final_price();
									}
									double serviceCharges = SiteConstants.SERVICE_TAX * subToal;
									%>
								</div>
								<ul class="list-unstyled fs-sm pb-2 border-bottom">
									<li class="d-flex justify-content-between align-items-center"><span
										class="me-2">SubTotal:</span><span class="text-end"><%=FormatPrice.formatPrice(subToal + "")%></span></li>
									<li class="d-flex justify-content-between align-items-center"><span
										class="me-2">Shipping:</span><span class="text-end"
										id="shipping-price"><%=SiteConstants.COUNTRY_CURRANCY_UNICODE+request.getParameter("shippingPrice")%></span></li>
									<li class="d-flex justify-content-between align-items-center"><span
										class="me-2">Service Charges:</span><span class="text-end"><%=FormatPrice.formatPrice(((int) Math.ceil(serviceCharges)) + "")%></span></li>
								</ul>
								<h3 class="fw-normal text-center my-4" id="totalPay">
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
									href="checkout-shipping.jsp"><i
									class="ci-arrow-left mt-sm-0 me-1"></i><span
									class="d-none d-sm-inline">Back to Shipping</span><span
									class="d-inline d-sm-none">Back</span></a>
							</div>
							<div class="w-50 ps-2">
								<button type="submit" class="btn btn-primary d-block w-100">
									<span class="d-none d-sm-inline">Review your order</span><span
										class="d-inline d-sm-none">Review order</span><i
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
		$("#cash-on-delivery").on("change", function() {
			if ($(this).prop('checked')) {
				$("#number").removeAttr("required");
				$("#name").removeAttr("required");
				$("#expiry").removeAttr("required");
				$("#cvc").removeAttr("required");
			} else {
				$("#number").attr("required", "required");
				$("#name").attr("required", "required");
				$("#expiry").attr("required", "required");
				$("#cvc").attr("required", "required");
			}
		});
		let acNum = $("#number").val();
		$("#cardNumber").val(acNum);
	</script>

</body>
</html>