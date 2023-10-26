<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
String email = "";
if (request.getParameter("verify") != null && request.getParameter("email") != null) {
	email = request.getParameter("email");
} else {
	response.sendRedirect("index.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Password Renewal</title>
<%@include file="components/imports.jsp"%>

</head>
<!-- Body-->
<body>
	<main class="page-wrapper">
		<!-- Navbar 3 Level (Light)-->
		<%@include file="components/header.jsp"%>

		<div class="container py-4 py-lg-5 my-4">
			<div class="row justify-content-center">
				<div class="col-lg-8 col-md-10">
					<h2 class="h3 mb-4">Set New password</h2>
					<div class="card py-2 mt-4">
						<form class="card-body needs-validation" novalidate
							id="SetNewPassword">
							<div class="mb-3">
								<label class="form-label" for="password">Enter Password</label>
								<input class="form-control" type="password" id="password"
									name="password" required>
							</div>
							<div class="mb-3">
								<label class="form-label" for="conpassword">Confirm
									Password</label> <input class="form-control" type="password"
									id="conpassword" name="conpassword" required>
							</div>
							<input type="hidden" name="hdnemail" id="hdnemail"
								value="<%=email%>" />
							<div class="mt-3 mb-3" id="passwordResetStatus"></div>
							<button class="btn btn-primary" type="submit">Set new
								password</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<script>
		$(document).ready(function() {
			$("#SetNewPassword").on("submit", function(e) {
				e.preventDefault();
				let password=$("#password").val();
				let conpassword=$("#conpassword").val();
				if(password!=conpassword){
					$("#passwordResetStatus").hide();
					$("#passwordResetStatus").html("<p class='text-danger'>Password Does not match</p>");
					$("#passwordResetStatus").fadeIn("slow");
				}else if(password.length < 8){
					$("#passwordResetStatus").hide();
					$("#passwordResetStatus").html("<p class='text-danger'>Password Should Be Atleast 8 characters Long</p>");
					$("#passwordResetStatus").fadeIn("slow");
				}else{
				$.ajax({
					url : "SetNewPasswordForUser",
					type : "POST",
					data : $(this).serialize(),
					success : function(data) {
						$("#passwordResetStatus").hide();
						$("#passwordResetStatus").html(data);
						$("#passwordResetStatus").fadeIn("slow");
						$("#SetNewPassword").trigger("reset");
					}
				});
				}
			});
		});
	</script>
</body>
</html>