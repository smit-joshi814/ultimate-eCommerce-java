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
<title>MyECommerceSite | Profile info</title>

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
							<li class="breadcrumb-item text-nowrap"><a href="#">Account</a>
							</li>
							<li class="breadcrumb-item text-nowrap active"
								aria-current="page">Profile info</li>
						</ol>
					</nav>
				</div>
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
					<h1 class="h3 text-light mb-0">Profile info</h1>
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
										data-bs-toggle="tooltip" title="verified">Verified</span><img
										class="rounded" width="300px"
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
									class="nav-link-style d-flex align-items-center px-4 py-3 active"
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
						class="d-none d-lg-flex justify-content-between align-items-center pt-lg-3 pb-4 pb-lg-5 mb-lg-3">
						<h6 class="fs-base text-light mb-0">Update you profile
							details below:</h6>
						<a class="btn btn-primary btn-sm"
							href="account-signin.jsp?SignOut=1"><i
							class="ci-sign-out me-2"></i>Sign out</a>
					</div>
					<!-- Profile form-->
					<form id="AccountUpdate">
						<div class="bg-secondary rounded-3 p-4 mb-4">
							<div class="d-flex align-items-center">
								<img class="rounded"
									src="img/shop/account/<%=rsH.getString("user_image")%>"
									width="90" alt="<%=rsH.getString("user_name")%>">
								<div class="ps-3">
									<div class="input-group mb-3">
										<div class="custom-file">
											<input type="file" accept="image/*"
												onchange="fileSelect(event)"
												class="custom-file-input d-none" id="ProfileImage"
												name="ProfileImage" aria-describedby="inputGroupFileAddon01">
											<label
												class="custom-file-label btn btn-light btn-shadow btn-sm mb-2"
												id="custom-file" for="ProfileImage"><i
												class="ci-loading me-2"></i>Change avatar</label>
										</div>
									</div>
									<div class="p mb-0 fs-ms text-muted" id="selectedFileName">Upload
										JPG, GIF or PNG image.</div>
								</div>
							</div>
						</div>
						<div class="row gx-4 gy-3">
							<div class="col-sm-12">
								<label class="form-label" for="txtName">Name</label> <input
									class="form-control" type="text" id="txtName" name="txtName"
									value="<%=rsH.getString("user_name")%>">
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="account-email">Email
									Address</label> <input class="form-control" type="email"
									id="account-email" value="<%=rsH.getString("user_email")%>"
									disabled>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="txtPhone">Phone Number</label> <input
									class="form-control" type="text" id="txtPhone" name="txtPhone"
									value="<%=rsH.getString("user_phone")%>" required>
							</div>
							<div class="col-12">
								<div
									class="d-flex flex-wrap justify-content-end align-items-center">
									<a class="text-primary mt-sm-0"
										href="account-password-recovery.jsp">Forget Password ?</a>
								</div>
							</div>
							<div class="col-12">
								<hr class="mt-2 mb-3">
								<div
									class="d-flex flex-wrap justify-content-between align-items-center">
									<div class="form-check">
										<input class="form-check-input" type="checkbox"
											id="subscribe_me" checked> <label
											class="form-check-label" for="subscribe_me">Subscribe
											me to Newsletter</label>
									</div>

									<button class="btn btn-primary mt-3 mt-sm-0" type="submit">Update
										profile</button>
									<div class="col-12 mt-1 mb-1" id="msgUpdate"></div>
								</div>

							</div>
						</div>
					</form>
				</section>
			</div>
		</div>
	</main>
	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<script>
		$("#nav-item-Account").addClass("active");
		$("#nav-Item-Account-settings").addClass("active");
		$("#wish-list").hide();
		$("#support-tickets").hide();

		$("#AccountUpdate").on("submit", function(e) {
			e.preventDefault();
			$.ajax({
				url : "UpdateUser",
				type : "POST",
				data : new FormData(this),
				enctype : "multipart/form-data",
				cache : false,
				contentType : false,
				processData : false,
				success : function(data) {
					$("#msgUpdate").hide();
					$("#msgUpdate").html(data);
					$("#msgUpdate").fadeIn("slow");
				}
			});
		});

		function fileSelect(id, e) {
			$("#custom-file").addClass("text-bg-primary");
			let filename = $("input[type=file]").val().split('\\').pop();
			$("#selectedFileName").text(filename);
		}
	</script>
</body>
</html>