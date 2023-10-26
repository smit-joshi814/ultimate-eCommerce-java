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
<title>MyECommerceSite | Support tickets</title>
<%@include file="components/imports.jsp"%>


</head>
<!-- Body-->
<body>
	<main class="page-wrapper">
		<!-- Open Ticket Modal-->
		<form class="needs-validation modal fade" method="post"
			id="open-ticket" tabindex="-1" novalidate>
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Submit new ticket</h5>
						<button class="btn-close" type="button" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p class="text-muted fs-sm">We normally respond tickets within
							2 business days.</p>
						<div class="row gx-4 gy-3">
							<div class="col-12">
								<label class="form-label" for="ticket-subject">Subject</label> <input
									class="form-control" type="text" id="ticket-subject" required>
								<div class="invalid-feedback">Please fill in the subject
									line!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="ticket-type">Type</label> <select
									class="form-select" id="ticket-type" required>
									<option value="">Choose type</option>
									<option value="Website problem">Website problem</option>
									<option value="Partner request">Partner request</option>
									<option value="Complaint">Complaint</option>
									<option value="Info inquiry">Info inquiry</option>
								</select>
								<div class="invalid-feedback">Please choose ticket type!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="ticket-priority">Priority</label>
								<select class="form-select" id="ticket-priority" required>
									<option value="">How urgent is your issue?</option>
									<option value="Urgent">Urgent</option>
									<option value="High">High</option>
									<option value="Medium">Medium</option>
									<option value="Low">Low</option>
								</select>
								<div class="invalid-feedback">Please choose how urgent
									your ticket is!</div>
							</div>
							<div class="col-12">
								<label class="form-label" for="ticket-description">Describe
									your issue</label>
								<textarea class="form-control" id="ticket-description" rows="8"
									required></textarea>
								<div class="invalid-feedback">Please provide ticket
									description!</div>
							</div>
							<div class="col-12">
								<input class="form-control" type="file" id="file-input">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"
							data-bs-dismiss="modal">Close</button>
						<button class="btn btn-primary" type="submit">Submit
							Ticket</button>
					</div>
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
								aria-current="page">Support tickets</li>
						</ol>
					</nav>
				</div>
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
					<h1 class="h3 text-light mb-0">Support tickets</h1>
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
										data-bs-toggle="tooltip" title="RVerified">Verified</span><img
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
										class="fs-sm text-muted ms-auto"><%=rs.getInt(1) %></span></a></li>
								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-wishlist.jsp"><i
										class="ci-heart opacity-60 me-2"></i>Wishlist<span
										class="fs-sm text-muted ms-auto">3</span></a></li>
								<li class="mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3 active"
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
									class="nav-link-style d-flex align-items-center px-4 py-3"
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
						class="d-flex justify-content-between align-items-center pt-lg-2 pb-4 pb-lg-5 mb-lg-3">
						<div class="d-flex align-items-center">
							<label
								class="d-none d-lg-block fs-sm text-light text-nowrap opacity-75 me-2"
								for="ticket-sort">Sort tickets:</label> <label
								class="d-lg-none fs-sm text-nowrap opacity-75 me-2"
								for="ticket-sort">Sort tickets:</label> <select
								class="form-select" id="ticket-sort">
								<option>All</option>
								<option>Open</option>
								<option>Closed</option>
							</select>
						</div>
						<a class="btn btn-primary btn-sm d-none d-lg-inline-block"
							href="account-signin.jsp?SignOut=1"><i
							class="ci-sign-out me-2"></i>Sign out</a>
					</div>
					<!-- Tickets list-->
					<div class="table-responsive fs-md mb-4">
						<table class="table table-hover mb-0">
							<thead>
								<tr>
									<th>Ticket Subject</th>
									<th>Date Submitted | Updated</th>
									<th>Type</th>
									<th>Priority</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="py-3"><a class="nav-link-style fw-medium"
										href="account-single-ticket.jsp">My new ticket</a></td>
									<td class="py-3">09/27/2019 | 09/30/2019</td>
									<td class="py-3">Website problem</td>
									<td class="py-3"><span class="badge bg-warning m-0">High</span></td>
									<td class="py-3"><span class="badge bg-success m-0">Open</span></td>
								</tr>
								<tr>
									<td class="py-3"><a class="nav-link-style fw-medium"
										href="account-single-ticket.jsp">Another ticket</a></td>
									<td class="py-3">08/21/2019 | 08/23/2019</td>
									<td class="py-3">Partner request</td>
									<td class="py-3"><span class="badge bg-info m-0">Medium</span></td>
									<td class="py-3"><span class="badge bg-secondary m-0">Closed</span></td>
								</tr>
								<tr>
									<td class="py-3"><a class="nav-link-style fw-medium"
										href="account-single-ticket.jsp">Yet another ticket</a></td>
									<td class="py-3">11/19/2018 | 11/20/2018</td>
									<td class="py-3">Complaint</td>
									<td class="py-3"><span class="badge bg-danger m-0">Urgent</span></td>
									<td class="py-3"><span class="badge bg-secondary m-0">Closed</span></td>
								</tr>
								<tr>
									<td class="py-3"><a class="nav-link-style fw-medium"
										href="account-single-ticket.jsp">My old ticket</a></td>
									<td class="py-3">06/19/2018 | 06/20/2018</td>
									<td class="py-3">Info inquiry</td>
									<td class="py-3"><span class="badge bg-success m-0">Low</span></td>
									<td class="py-3"><span class="badge bg-secondary m-0">Closed</span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="text-end">
						<button class="btn btn-primary" data-bs-toggle="modal"
							data-bs-target="#open-ticket">Submit new ticket</button>
					</div>
				</section>
			</div>
		</div>
	</main>
	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<script>
		$("#nav-item-Account").addClass("active");
	</script>
</body>
</html>