<%@page import="generalModule.PasswordOperations"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
if (request.getParameter("SignOut") != null) {
	session.removeAttribute("uid");
	response.sendRedirect("account-signin.jsp");
}
if (session.getAttribute("uid") != null) {
	response.sendRedirect("shop-categories.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Account Sign In</title>
<%@include file="components/imports.jsp"%>


</head>
<!-- Body-->
<body>

	<main class="page-wrapper">

		<%@include file="components/header.jsp"%>

		<div class="container py-4 py-lg-5 my-4">
			<div class="row">
				<div class="col-md-6">
					<div class="card border-0 shadow">
						<div class="card-body">
							<h2 class="h4 mb-3">Sign in</h2>
							<!-- 
                <div class="py-3">
                  <h3 class="d-inline-block align-middle fs-base fw-medium mb-2 me-2">With social account:</h3>
                  <div class="d-inline-block align-middle"><a class="btn-social bs-google me-2 mb-2" href="#" data-bs-toggle="tooltip" title="Sign in with Google"><i class="ci-google"></i></a><a class="btn-social bs-facebook me-2 mb-2" href="#" data-bs-toggle="tooltip" title="Sign in with Facebook"><i class="ci-facebook"></i></a><a class="btn-social bs-twitter me-2 mb-2" href="#" data-bs-toggle="tooltip" title="Sign in with Twitter"><i class="ci-twitter"></i></a></div>
                </div>
                <hr>
                
                <h3 class="fs-base pt-4 pb-2">Or using form below</h3>
                -->
							<%
							Cookie[] user = request.getCookies();
							String email = "", password = "";
							for (Cookie c : user) {
								if (c.getName().equals("email")) {
									email = PasswordOperations.PasswordDecrypter(c.getValue());
								}
								if (c.getName().equals("password")) {
									password = PasswordOperations.PasswordDecrypter(c.getValue());
								}
							}
							%>
							<form class="needs-validation" id="formsignIn" novalidate>
								<div class="input-group mb-3">
									<i
										class="ci-mail position-absolute top-50 translate-middle-y text-muted fs-base ms-3"></i>
									<input class="form-control rounded-start" type="email"
										placeholder="Email" value="<%=email%>" name="txtEmail"
										required>
								</div>
								<div class="input-group mb-3">
									<i
										class="ci-locked position-absolute top-50 translate-middle-y text-muted fs-base ms-3"></i>
									<div class="password-toggle w-100">
										<input class="form-control" type="password"
											placeholder="Password" name="txtPassword"
											value="<%=password%>" required> <label
											class="password-toggle-btn" aria-label="Show/hide password">
											<input class="password-toggle-check" type="checkbox"><span
											class="password-toggle-indicator"></span>
										</label>
									</div>
								</div>
								<div class="d-flex flex-wrap justify-content-between">
									<div class="form-check">
										<input class="form-check-input text-primary" type="checkbox"
											checked id="remember_me" name="chkRemember"> <label
											class="form-check-label" for="remember_me">Remember
											me</label>
									</div>
									<a class="nav-link-inline fs-sm text-primary"
										href="account-password-recovery.jsp">Forgot password?</a>
								</div>
								<div class="mt-1 mb-1" id="msg"></div>
								<hr class="mt-4">
								<div class="text-end pt-4">
									<button class="btn btn-primary" type="submit" id="btnSignIn">
										<i class="ci-sign-in me-2 ms-n21"></i>Sign In
									</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="col-md-6 pt-4 mt-3 mt-md-0">
					<h2 class="h4 mb-3">No account? Sign up</h2>
					<p class="fs-sm text-muted mb-4">Registration takes less than a
						minute but gives you full control over your orders.</p>
					<form class="needs-validation" id="formSignUp">
						<div class="row gx-4 gy-3">
							<div class="col-sm-12">
								<label class="form-label" for="txtName">Name</label> <input
									class="form-control" type="text" required id="reg-ln"
									name="txtName">
								<div class="invalid-feedback">Please enter your last name!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="txtEmail">E-mail Address</label>
								<input class="form-control" type="email" required id="reg-email"
									name="txtEmail">
								<div class="invalid-feedback">Please enter valid email
									address!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="txtMobile">Phone Number</label> <input
									class="form-control" type="text" required id="reg-phone"
									name="txtMobile">
								<div class="invalid-feedback">Please enter your phone
									number!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="txtPassword">Password</label> <input
									class="form-control" type="password" required
									name="txtPassword" id="txtPassword">
								<div class="invalid-feedback">Please enter password!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="txtConPassword">Confirm
									Password</label> <input class="form-control" type="password" required
									id="txtConPassword" name="txtConPassword">
								<div class="invalid-feedback">Passwords do not match!</div>
							</div>
							<div class="mt-1 mb-1" id="msg2"></div>
							<div class="col-12 text-end">
								<button class="btn btn-primary" type="submit" id="btnSignUp">
									<i class="ci-user me-2 ms-n1"></i>Sign Up
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>
	<!-- Footer-->
	<%@include file="components/footer.jsp"%>

	<script>
		$(document)
				.ready(
						function() {
							$("#formsignIn")
									.on(
											"submit",
											function(e) {
												e.preventDefault();
												$
														.ajax({
															url : "SignInAction",
															type : "POST",
															data : $(this)
																	.serialize(),
															beforeSend : function() {
																$("#msg")
																		.fadeOut(
																				"slow");
																$("#btnSignIn")
																		.hide();
																$("#btnSignIn")
																		.html(
																				'<span class="spinner-grow spinner-grow-sm me-2" role="status" aria-hidden="true"></span> Signing In...');
																$("#btnSignIn")
																		.fadeIn(
																				"slow");
															},
															success : function(
																	data) {
																$("#msg")
																		.hide();
																if (data == 1) {
																	<% if(request.getParameter("checkout")!=null){ %>
																	window.location.href = 'checkout-details.jsp';
																	<% }else{ %>
																	window.location.href = 'shop-categories.jsp';
																	<% } %>
																} else {
																	$(
																			"#btnSignIn")
																			.hide();
																	$(
																			"#btnSignIn")
																			.html(
																					'<i class="ci-sign-in me-2 ms-n21"></i>Sign In');
																	$(
																			"#btnSignIn")
																			.fadeIn(
																					"slow");
																	$("#msg")
																			.html(
																					data);
																	$("#msg")
																			.fadeIn(
																					"slow");
																}
															}
														});
											});

							$("#formSignUp")
									.on(
											"submit",
											function(e) {
												e.preventDefault();
												let pass = $("#txtPassword")
														.val();
												let conpass = $(
														"#txtConPassword")
														.val();
												if (pass != conpass) {
													$("#msg2").hide();
													$("#msg2")
															.html(
																	"<p class='text-danger'>Password Does Not Match</p>");
													$("#msg2").fadeIn("slow");
												} else {
													$
															.ajax({
																url : "SignUpAction",
																type : "POST",
																data : $(this)
																		.serialize(),
																beforeSend : function() {
																	$("#msg2")
																			.fadeOut(
																					"slow");
																	$(
																			"#btnSignUp")
																			.hide();
																	$(
																			"#btnSignUp")
																			.html(
																					'<span class="spinner-grow spinner-grow-sm me-2" role="status" aria-hidden="true"></span> Signing Up...');
																	$(
																			"#btnSignUp")
																			.fadeIn(
																					"slow");
																},
																success : function(
																		data) {
																	$("#msg2")
																			.hide();
																	if (data == 1) {
																		window.location.href = 'shop-categories.jsp';
																	} else {
																		$(
																				"#btnSignUp")
																				.hide();
																		$(
																				"#btnSignUp")
																				.html(
																						'<i class="ci-user me-2 ms-n1"></i>Sign Up');
																		$(
																				"#btnSignUp")
																				.fadeIn(
																						"slow");
																		$(
																				"#msg2")
																				.html(
																						data);
																		$(
																				"#msg2")
																				.fadeIn(
																						"slow");
																	}
																}
															});
												}
											});
						});
	</script>
</body>
</html>