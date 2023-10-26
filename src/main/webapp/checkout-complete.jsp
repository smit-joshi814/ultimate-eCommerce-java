<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Checkout-Complete</title>
<!-- Imports -->
<%@include file="components/imports.jsp"%>
</head>
<!-- Body-->
<body>

	<main class="page-wrapper">

		<!-- Navbar 3 Level (Light)-->
		<%@include file="components/header.jsp"%>

		<div class="container pb-5 mb-sm-4">
			<div class="pt-5">
				<div class="card py-3 mt-sm-3">
					<div class="card-body text-center">
						<h2 class="h4 pb-3">Thank you for your order!</h2>
						<p class="fs-sm mb-2">Your order has been placed and will be
							processed as soon as possible.</p>
						<p class="fs-sm mb-2">
							Make sure you make note of your order number, which is <span
								class='fw-medium'><%=request.getParameter("order_id") %></span>
						</p>
						<p class="fs-sm">
							You will be receiving an email shortly with confirmation of your
							order. <b class="text-decoration-underline">You can now:</b>
						</p>
						<a class="btn btn-secondary mt-3 me-3" href="shop-categories.jsp">Go
							back shopping</a><a class="btn btn-primary mt-3"
							href="order-tracking.jsp?order_id=<%=request.getParameter("order_id")%>"><i
							class="ci-location"></i>&nbsp;Track order</a>
					</div>
				</div>
			</div>
		</div>
	</main>

	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<!-- / Footer -->
</body>
</html>