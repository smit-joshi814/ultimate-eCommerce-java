<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
boolean showResetForm = false;
if (request.getParameter("verify") != null && request.getParameter("email") != null) {
	showResetForm = true;
} else {
	response.sendRedirect("ResetPassword.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Admin | Set New Password</title>
<%@include file="components/imports.jsp"%>
</head>
<body>
	<main class="page-wrapper">

		<%@include file="components/header.jsp"%>
		<%
		if (showResetForm) {
		%>
		<form
			class="container text-center col-md-4 mt-5 mb-5 form needs-validation"
			method="POST" id="frmPassword" data-aos="fade-up">
			<h1 class="display-4 mb-3">Set New Password</h1>
			<div class="form-floating mb-3 mt-5">
				<input type="password" class="form-control" id="password"
					name="password" required /> <label for="password">Password</label>
			</div>
			<div class="form-floating mb-3">
				<input type="password" class="form-control" id="conpassword"
					name="conpassword" required /> <label for="conpassword">Confirm
					Password</label>
			</div>
			<input type="hidden" name="hdnemail" id="hdnemail"
				value='<%=request.getParameter("email")%>' /> <input type="hidden"
				name="hdnaid" id="hdnaid" value=<%=request.getParameter("aid")%> />
			<div class="mb-2 mt-2" id="msg"></div>
			<button class="w-100 btn btn-lg btn-primary" type="submit">Reset
				Password</button>
		</form>
		<%
		} else {
		%>
		<div class="container text-center col-md-12 mt-5 mb-5">
			<h5 class="display-5">Your Password Recovery Link Has Been
				Expired</h5>
		</div>
		<%
		}
		%>

	</main>
	<%@include file="components/footer.jsp"%>
	<script>
		$(document)
				.ready(
						function() {
							$("#frmPassword")
									.on(
											"submit",
											function(e) {
												e.preventDefault();
												let pass = $("#password").val();
												let conpass = $("#conpassword")
														.val();
												if (pass != conpass) {
													$("#msg").hide();
													$("#msg")
															.html(
																	"<p class='text-danger'>Password Does Not match</p>");
													$("#msg").fadeIn("slow");
												} else if (pass.length < 8) {
													$("#msg").hide();
													$("#msg")
															.html(
																	"<p class='text-danger'>Password Should Be Atleast 8 characters Long<p>");
													$("#msg").fadeIn("slow");
												} else {
													$
															.ajax({
																url : "../SetNewPasswordForAdmin",
																type : "POST",
																data : $(this)
																		.serialize(),
																success : function(
																		data) {
																	$("#msg")
																			.hide();
																	$("#msg")
																			.html(
																					data);
																	$("#msg")
																			.fadeIn(
																					"slow");
																	$(
																			"#frmPassword")
																			.trigger(
																					"reset");
																	window.location = "index.jsp";
																}
															});
												}
											});
						});
	</script>
</body>
</html>