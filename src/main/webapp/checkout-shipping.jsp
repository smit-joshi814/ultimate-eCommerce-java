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
<title>MyECommerceSite | Checkout-Shipping</title>
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
			<form action="checkout-payment.jsp" method="POST">
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
							</a><a class="step-item active current" href="checkout-shipping.jsp">
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
						<!-- Shipping methods table-->
						<h2 class="h6 pb-3 mb-2">Choose shipping method</h2>
						<div class="table-responsive">
							<table class="table table-hover fs-sm border-top">
								<thead>
									<tr>
										<th class="align-middle"></th>
										<th class="align-middle">Shipping method</th>
										<th class="align-middle">Delivery time</th>
										<th class="align-middle">Handling fee</th>
									</tr>
								</thead>
								<tbody>
									<%
							PreparedStatement ps=cnH.prepareStatement("SELECT * FROM shipping_method");
							ResultSet rs=ps.executeQuery();
							while(rs.next()){
							%>
									<tr>
										<td>
											<div class="form-check">
												<input class="form-check-input align-middle" type="radio"
													name="shipping-method"
													data-price="<%=rs.getString("price") %>"
													value="<%=rs.getString("shipping_method_id")%>" required />
											</div>
										</td>
										<td class="align-middle"><span
											class="text-dark fw-medium"><%=rs.getString("shipping_method_name") %></span></td>
										<td class="align-middle"><%=SiteConstants.COUNTRY_CURRANCY_UNICODE+" "+rs.getString("price") %></td>
										<td class="align-middle"><%=rs.getString("shipping_time")%></td>
									</tr>
									<% } %>
								</tbody>
							</table>
						</div>
						<!-- Address Details Hidden Fields -->
						<input type="hidden" name="addressIdShip"
							value="<%=request.getParameter("addressIdShip")%>" /> <input
							type="hidden" name="addressIdBill"
							value="<%=request.getParameter("addressIdBill")%>" /> <input
							type="hidden" name="same-address"
							value="<%=request.getParameter("same-address") %>" /> <input
							type="hidden" id="priceToPay" name="priceToPay" value="" /> <input
							type="hidden" id="shippingPrice" name="shippingPrice" value="" />

						<!-- Navigation (desktop)-->
						<div class="d-none d-lg-flex pt-4">
							<div class="w-50 pe-3">
								<a class="btn btn-secondary d-block w-100"
									href="checkout-details.jsp"><i
									class="ci-arrow-left mt-sm-0 me-1"></i><span
									class="d-none d-sm-inline">Back to Adresses</span><span
									class="d-inline d-sm-none">Back</span></a>
							</div>
							<div class="w-50 ps-2">
								<button type="submit" class="btn btn-primary d-block w-100">
									<span class="d-none d-sm-inline">Proceed to Payment</span><span
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
								%>
								</div>
								<ul class="list-unstyled fs-sm pb-2 border-bottom">
									<li class="d-flex justify-content-between align-items-center"><span
										class="me-2">SubTotal:</span><span class="text-end"><%=FormatPrice.formatPrice(subToal+"")%></span></li>
									<li class="d-flex justify-content-between align-items-center"><span
										class="me-2">Shipping:</span><span class="text-end"
										id="shipping-price">-</span></li>
									<li class="d-flex justify-content-between align-items-center"><span
										class="me-2">Service Taxes:</span><span class="text-end"><%=FormatPrice.formatPrice(((int)Math.ceil(serviceCharges))+"")%></span></li>
								</ul>
								<h3 class="fw-normal text-center my-4" id="totalPay">
									<%=FormatPrice.formatPrice(subToal+((int)Math.ceil(serviceCharges))+"")%>
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
									href="checkout-details.jsp"><i
									class="ci-arrow-left mt-sm-0 me-1"></i><span
									class="d-none d-sm-inline">Back to Adresses</span><span
									class="d-inline d-sm-none">Back</span></a>
							</div>
							<div class="w-50 ps-2">
								<button type="submit" class="btn btn-primary d-block w-100">
									<span class="d-none d-sm-inline">Proceed to Payment</span><span
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
$('input[type=radio][name=shipping-method]').change(function() {
   let price=$(this).data("price");
   let totalPayable=<%=request.getParameter("totalPayable")%>
   $("#shipping-price").html("<%=SiteConstants.COUNTRY_CURRANCY_UNICODE%>"+price);
   totalPayable+=price;
   $("#priceToPay").val(totalPayable);
   $("#shippingPrice").val(price);
   $.ajax({
	  url:"CalcTotalPayable",
	  type:"POST",
	  data:{totalPayable:totalPayable},
	  success:function(data){
		  $("#totalPay").html(data);
	  }
   });
});
</script>
</body>
</html>