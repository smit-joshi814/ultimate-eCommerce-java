<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | Password Recovery</title>
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
					<h2 class="h3 mb-4">Forgot your password?</h2>
					<p class="fs-md">Change your password in three easy steps. This
						helps to keep your new password secure.</p>
					<ol class="list-unstyled fs-md">
						<li><span class="text-primary me-2">1.</span>Fill in your
							email address below.</li>
						<li><span class="text-primary me-2">2.</span>We'll email you
							a link.</li>
						<li><span class="text-primary me-2">3.</span>Use the link to
							change your password on our secure website.</li>
					</ol>
					<div class="card py-2 mt-4">
						<form class="card-body needs-validation" novalidate
							id="passwordRecovery">
							<div class="mb-3">
								<label class="form-label" for="recover-email">Enter your
									email address</label> <input class="form-control" type="email"
									id="recover-email" name="recover-email" required>
								<div class="invalid-feedback">Please provide valid email
									address.</div>
							</div>
							<div class="mt-3 mb-3" id="resetMailStatus"></div>
							<button class="btn btn-primary" type="submit">Get new
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
			$("#passwordRecovery").on("submit", function(e) {
				e.preventDefault();
				$.ajax({
					url:"SendPasswordResetMail",
					type:"POST",
					data:$(this).serialize(),
					success:function(data){
						$("#resetMailStatus").hide();
						$("#resetMailStatus").html(data);
						$("#resetMailStatus").fadeIn("slow");
					}
				});
			});
		});
	</script>
</body>
</html>