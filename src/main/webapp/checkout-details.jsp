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
<title>MyECommerceSite | Checkout-Details</title>
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
			<form action="checkout-shipping.jsp" method="POST">
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
							</a><a class="step-item active current" href="checkout-details.jsp">
								<div class="step-progress">
									<span class="step-count">2</span>
								</div>
								<div class="step-label">
									<i class="ci-user-circle"></i>Details
								</div>
							</a><a class="step-item" href="checkout-shipping.jsp">
								<div class="step-progress">
									<span class="step-count">3</span>
								</div>
								<div class="step-label">
									<i class="ci-package"></i>Shipping
								</div>
							</a><a class="step-item" href="checkout-payment.jsp">
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
						<!-- Autor info-->
						<div
							class="d-sm-flex justify-content-between align-items-center bg-secondary p-4 rounded-3 mb-grid-gutter">
							<div class="d-flex align-items-center">
								<div
									class="img-thumbnail rounded-circle position-relative flex-shrink-0">
									<span class="badge bg-success position-absolute end-0 mt-n2"
										data-bs-toggle="tooltip" title="Reward points">verified</span><img
										class="rounded"
										src="img/shop/account/<%=rsH.getString("user_image")%>"
										width="90" alt="Susan Gardner">
								</div>
								<div class="ps-3">
									<h3 class="fs-base mb-0"><%=rsH.getString("user_name")%></h3>
									<span class="text-accent fs-sm"><%=rsH.getString("user_email")%></span>
								</div>
							</div>
							<a class="btn btn-light btn-sm btn-shadow mt-3 mt-sm-0"
								href="account-profile.jsp"><i class="ci-edit me-2"></i>Edit
								profile</a>
						</div>
						<!-- Shipping address-->

						<h2 class="h6 pt-1 pb-3 mb-3 border-bottom">Shipping address</h2>
						<div class="table-responsive fs-md">

							<table class="table table-hover mb-0">
								<%
								PreparedStatement ps = cnH.prepareStatement(
										"SELECT * FROM user_address_mapping A INNER JOIN address B ON A.address_id=B.address_id WHERE A.user_id IN (SELECT A.user_id FROM user_address_mapping WHERE A.user_id=?)",
										ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
								ps.setString(1, session.getAttribute("uid").toString());
								ResultSet rs = ps.executeQuery();
								while (rs.next()) {
								%>
								<tr>
									<td class="py-3 align-middle"><input type="radio"
										name="addressIdShip" value="<%=rs.getString("address_id")%>"
										<%if (rs.getString("is_default").equals("1")) {%> checked
										<%}%> /></td>
									<td class="py-3 align-middle"><%=rs.getString("address_line1")%>
										<%
										if (rs.getString("is_default").equals("1")) {
										%><span class="align-middle badge bg-info ms-2">Primary</span>
										<%
										}
										%></td>
								</tr>
								<%
								}
								%>
							</table>
						</div>
						<h6 class="mb-3 py-3 border-bottom">Billing address</h6>
						<div class="form-check">
							<input class="form-check-input" type="checkbox" checked
								id="same-address" name="same-address"> <label
								class="form-check-label" for="same-address">Same as
								shipping address</label>
						</div>
						<div class="table-responsive fs-md" id="billing-address">
							<table class="table table-hover mb-0">
								<%
								rs.beforeFirst();
								while (rs.next()) {
								%>
								<tr>
									<td class="py-3 align-middle"><input type="radio"
										name="addressIdBill" value="<%=rs.getString("address_id")%>"
										<%if (rs.getString("is_default").equals("1")) {%> checked
										<%}%> /></td>
									<td class="py-3 align-middle"><%=rs.getString("address_line1")%>
										<%
										if (rs.getString("is_default").equals("1")) {
										%><span class="align-middle badge bg-info ms-2">Primary</span>
										<%
										}
										%></td>
								</tr>
								<%
								}
								%>
							</table>
						</div>




						<!-- Navigation (desktop)-->
						<div class="d-none d-lg-flex pt-4 mt-3">
							<div class="w-50 pe-3">
								<a class="btn btn-secondary d-block w-100" href="shop-cart.jsp"><i
									class="ci-arrow-left mt-sm-0 me-1"></i><span
									class="d-none d-sm-inline">Back to Cart</span><span
									class="d-inline d-sm-none">Back</span></a>
							</div>
							<div class="w-50 ps-2">
								<button type="submit" class="btn btn-primary d-block w-100">
									<span class="d-none d-sm-inline">Proceed to Shipping</span><span
										class="d-inline d-sm-none">Next</span><i
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
								ArrayList<Cart> cart=new ArrayList<>();
								int subToal=0;
								int user_id = Integer.parseInt(session.getAttribute("uid").toString());
								ps = cnH.prepareStatement(
										"SELECT product_item_id,item_quantity FROM shopping_cart_item SCI INNER JOIN shopping_cart SC ON SCI.cart_id=SC.cart_id WHERE SC.user_id=?",
										ResultSet.TYPE_SCROLL_INSENSITIVE);
								ps.setInt(1, user_id);
								rs = ps.executeQuery();
								while (rs.next()) {
									cart.add(Product.getCartItems(rs.getInt("product_item_id"), rs.getInt("item_quantity")));
								}
								for(Cart item:cart){
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
												<span class="text-accent me-2"><%=FormatPrice.formatPrice(item.getProduct_final_price()+"")%></span><span
													class="text-muted">x <%=item.getProduct_quantity()%></span>
											</div>
										</div>
									</div>
									<%
								subToal+=item.getProduct_final_price();
								} 
								double serviceCharges=SiteConstants.SERVICE_TAX*subToal;
								int totalPayable=subToal+((int)Math.ceil(serviceCharges));
								%>
									<input type="hidden" name="totalPayable"
										value="<%=totalPayable%>" />
								</div>
								<ul class="list-unstyled fs-sm pb-2 border-bottom">
									<li class="d-flex justify-content-between align-items-center"><span
										class="me-2">SubTotal:</span><span class="text-end"><%=FormatPrice.formatPrice(subToal+"")%></span></li>
									<li class="d-flex justify-content-between align-items-center"><span
										class="me-2">Shipping:</span><span class="text-end">-</span></li>
									<li class="d-flex justify-content-between align-items-center"><span
										class="me-2">Service Taxes:</span><span class="text-end"><%=FormatPrice.formatPrice(((int)Math.ceil(serviceCharges))+"")%></span></li>
								</ul>
								<h3 class="fw-normal text-center my-4">
									<%=FormatPrice.formatPrice(subToal+((int)Math.ceil(serviceCharges))+"")%><sup
										class='text-danger' data-bs-toggle="tooltip"
										title="+Shipping Charges">*</sup>
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
								<a class="btn btn-secondary d-block w-100" href="shop-cart.jsp"><i
									class="ci-arrow-left mt-sm-0 me-1"></i><span
									class="d-none d-sm-inline">Back to Cart</span><span
									class="d-inline d-sm-none">Back</span></a>
							</div>
							<div class="w-50 ps-2">
								<button type="submit" class="btn btn-primary d-block w-100">
									<span class="d-none d-sm-inline">Proceed to Shipping</span><span
										class="d-inline d-sm-none">Next</span><i
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
	$("#billing-address").hide();	
	$("#same-address").on("change", function() {
			if ($(this).prop('checked')) {
				$("#billing-address").hide();
			}else{
				$("#billing-address").fadeIn("slow");
			}
		});
		
	</script>

</body>
</html>