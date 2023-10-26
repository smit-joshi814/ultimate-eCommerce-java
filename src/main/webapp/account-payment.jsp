<%@page import="generalModule.PasswordOperations"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%
Connection cn = ConnectionProvider.getCon();
PreparedStatement ps;
ResultSet rs;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerseSite | My payment methods</title>

<%@include file="components/imports.jsp"%>

</head>
<!-- Body-->
<body>

	<main class="page-wrapper">
		<!-- Add Payment Method-->
		<form class="modal fade" method="post" id="add-payment" tabindex="-1">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Add a payment method</h5>
						<button class="btn-close" type="button" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="row g-3 mb-2">
							<%
							ps = cn.prepareStatement("SELECT * FROM payment_types WHERE payment_type_name NOT LIKE '%cash On Delivery%'");
							rs = ps.executeQuery();
							while (rs.next()) {
							%>
							<div class="col-sm-6 form-check mb-1">
								<input class="form-check-input" type="radio"
									name="payment-method"
									value="<%=rs.getString("payment_type_id")%>" required>
								<label class="form-check-label"><%=rs.getString("payment_type_name")%></label>
							</div>
							<%
							}
							%>
							<div class="col-sm-6">
								<input class="form-control" type="number" name="account-number"
									max="9999999999999999" placeholder="Card Number" required>
								<div class="invalid-feedback">Please fill in the card
									number!</div>
							</div>
							<div class="col-sm-6">
								<input class="form-control" type="text" name="name-on-card"
									placeholder="Full Name" required>
								<div class="invalid-feedback">Please provide name on the
									card!</div>
							</div>
							<div class="col-sm-3">
								<input class="form-control" type="text" name="expiry"
									placeholder="MM/YY" required>
								<div class="invalid-feedback">Please provide card
									expiration date!</div>
							</div>
							<div class="col-sm-3 mt-4">
								<div class="form-check">
									<input class="form-check-input" type="checkbox"
										id="payment-primary" name="payment-primary"> <label
										class="form-check-label" for="payment-primary">Make
										this Card primary</label>
								</div>
							</div>
							<div class="col-sm-6">
								<button class="btn btn-primary d-block w-100" type="submit">Register
									this card</button>
							</div>
							<div class="col-sm-12" id="status"></div>
						</div>
					</div>
				</div>
			</div>
		</form>

		<!-- Update payment Method -->
		<form class="modal fade" method="post" id="update-payment"
			tabindex="-1">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Update payment method</h5>
						<button class="btn-close" type="button" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body" id="upd-mdl-bdy"></div>
				</div>
			</div>
		</form>


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
							<li class="breadcrumb-item text-nowrap"><a href="#">Account</a>
							</li>
							<li class="breadcrumb-item text-nowrap active"
								aria-current="page">Payment methods</li>
						</ol>
					</nav>
				</div>
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
					<h1 class="h3 text-light mb-0">My payment methods</h1>
				</div>
			</div>
		</div>
		<div class="container pb-5 mb-2 mb-md-4">
			<div class="row">
				<!-- Sidebar-->
				<aside class="col-lg-4 pt-4 pt-lg-0 pe-xl-5">
					<div class="bg-white rounded-3 shadow-lg pt-1 mb-5 mb-lg-0">
						<div
							class="d-md-flex justify-content-between align-items-center text-center text-md-start p-4">
							<div class="d-md-flex align-items-center">
								<div
									class="img-thumbnail rounded position-relative flex-shrink-0 mx-auto mb-2 mx-md-0 mb-md-0"
									style="width: 6.375rem;">
									<span class="badge bg-success position-absolute end-0 mt-n2"
										data-bs-toggle="tooltip" title="Verified">Verified</span><img
										class="rounded"
										src="img/shop/account/<%=rsH.getString("user_image")%>"
										alt="<%=rsH.getString("user_name")%>">
								</div>
								<div class="ps-md-3">
									<h3 class="fs-base mb-0"><%=rsH.getString("user_name")%></h3>
									<span class="text-accent fs-sm"><%=rsH.getString("user_email")%></span>
								</div>
							</div>
							<a class="btn btn-primary d-lg-none mb-2 mt-3 mt-md-0"
								href="#account-menu" data-bs-toggle="collapse"
								aria-expanded="false"><i class="ci-menu me-2"></i>Account
								menu</a>
						</div>
						<div class="d-lg-block collapse" id="account-menu">
							<div class="bg-secondary px-4 py-3">
								<h3 class="fs-sm mb-0 text-muted">Dashboard</h3>
							</div>
							<ul class="list-unstyled mb-0">
								<%
								ps = cn.prepareStatement("SELECT count(order_id) FROM shop_order WHERE user_id=?");
								ps.setString(1, session.getAttribute("uid").toString());
								rs = ps.executeQuery();
								rs.next();
								%>
								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-orders.jsp"><i class="ci-bag opacity-60 me-2"></i>Orders<span
										class="fs-sm text-muted ms-auto"><%=rs.getInt(1)%></span></a></li>
								<li class="border-bottom mb-0" id="wish-list"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-wishlist.jsp"><i
										class="ci-heart opacity-60 me-2"></i>Wishlist<span
										class="fs-sm text-muted ms-auto">3</span></a></li>
								<li class="mb-0" id="support-tickets"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-tickets.jsp"><i
										class="ci-help opacity-60 me-2"></i>Support tickets<span
										class="fs-sm text-muted ms-auto">1</span></a></li>
							</ul>
							<div class="bg-secondary px-4 py-3">
								<h3 class="fs-sm mb-0 text-muted">Account settings</h3>
							</div>
							<ul class="list-unstyled mb-0">
								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-profile.jsp"><i
										class="ci-user opacity-60 me-2"></i>Profile info</a></li>
								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-address.jsp"><i
										class="ci-location opacity-60 me-2"></i>Addresses</a></li>
								<li class="mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3 active"
									href="account-payment.jsp"><i
										class="ci-card opacity-60 me-2"></i>Payment methods</a></li>
								<li class="d-lg-none border-top mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-signin.jsp?SignOut=1"><i
										class="ci-sign-out opacity-60 me-2"></i>Sign out</a></li>
							</ul>
						</div>
					</div>
				</aside>
				<!-- Content  -->
				<section class="col-lg-8">
					<!-- Toolbar-->
					<div
						class="d-none d-lg-flex justify-content-between align-items-center pt-lg-3 pb-4 pb-lg-5 mb-lg-3">
						<h6 class="fs-base text-light mb-0">Primary payment method is
							used by default</h6>
						<a class="btn btn-primary btn-sm"
							href="account-signin.jsp?SignOut=1"><i
							class="ci-sign-out me-2"></i>Sign out</a>
					</div>
					<!-- Payment methods list-->
					<div class="table-responsive fs-md mb-4">
						<table class="table table-hover mb-0">
							<thead>
								<tr>
									<th>Your credit / debit cards</th>
									<th>Name on card</th>
									<th>Expires on</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<%
								ps = cn.prepareStatement(
										"SELECT * FROM payment_methods PM INNER JOIN payment_types PT ON PM.payment_type_id=PT.payment_type_id WHERE user_id=?");
								ps.setString(1, session.getAttribute("uid").toString());
								rs = ps.executeQuery();
								while (rs.next()) {
									String[] type_name = rs.getString("payment_type_name").split(" ");
									String acc_number=PasswordOperations.PasswordDecrypter(rs.getString("account_number"));
								%>
								<tr>
									<td class="py-3 align-middle">
										<div class="d-flex align-items-center">
											<div class="ps-2">
												<span class="fw-medium text-heading me-1"><%=type_name[0]%></span>ending
												in
												<%=acc_number.substring(acc_number.length() - 4)%>
												<%
												if (rs.getString("is_default").equals("1")) {
												%>
												<span class="align-middle badge bg-info ms-2">Primary</span>
												<%
												}
												%>
											</div>
										</div>
									</td>
									<td class="py-3 align-middle"><%=rs.getString("name_on_card")%></td>
									<td class="py-3 align-middle"><%=rs.getString("expiry_date")%></td>
									<td class="py-3 align-middle"><a
										class="nav-link-style text-warning me-2 updatepayment"
										data-pmid="<%=rs.getString("payment_method_id")%>"
										href="#update-payment" data-bs-toggle="modal"> <i
											class="ci-edit"></i></a> <a
										class="nav-link-style text-danger ms-2 delpayment"
										data-pmid="<%=rs.getString("payment_method_id")%>" href="#"
										data-bs-toggle="tooltip" title="Remove"> <i
											class="ci-trash"></i></a></td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
					<div class="text-sm-end">
						<a class="btn btn-primary" href="#add-payment"
							data-bs-toggle="modal">Add payment method</a>
					</div>
				</section>
			</div>
		</div>
	</main>
	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<script>
		$("#nav-item-Account").addClass("active");
		$("#nav-Item-Account-Payment").addClass("active");
		$("#wish-list").hide();
		$("#support-tickets").hide();

		$("#add-payment").on("submit", function(e) {
			e.preventDefault();
			$.ajax({
				url : "AddPaymentMethod",
				type : "POST",
				data : $(this).serialize(),
				success : function(data) {
					$("#status").hide();
					$("#status").html(data);
					$("#status").fadeIn();
					$("#add-payment").trigger("reset");
				}
			});
		});

		$(document).on("click", ".updatepayment", function() {
			let pmid = $(this).data("pmid");
			$.ajax({
				url : "LoadUpdatePaymentMethodModal",
				type : "POST",
				data : {
					pmid : pmid
				},
				success : function(data) {
					$("#upd-mdl-bdy").hide();
					$("#upd-mdl-bdy").html(data);
					$("#upd-mdl-bdy").fadeIn();
				}
			});
		});

		$(document)
				.on(
						"click",
						".delpayment",
						function() {
							let pmid = $(this).data("pmid");
							let element = this;
							$
									.confirm({
										title : '<p><small>Do yo Really Want To Delete This ? Card</small></p>',
										buttons : {
											confirm : function() {
												$
														.ajax({
															url : "RemovePaymentMethod",
															type : "POST",
															data : {
																pmid : pmid
															},
															success : function(
																	data) {
																if (data == 1) {
																	$
																			.alert('Card Deleted SuccessFully');
																	$(element)
																			.closest(
																					"tr")
																			.fadeOut();
																} else {
																	$
																			.alert("Internal Error Can't Remove Card");
																}
															}
														});
											},
											cancel : function() {
												$.alert('Operation Aborted!');
											}
										}
									});
						});
	</script>
</body>
</html>