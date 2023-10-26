<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Admin | Password Reset</title>
<%@include file="components/imports.jsp"%>
</head>
<body>
	<main class="page-wrapper">

		<%@include file="components/header.jsp"%>

		<form class="container text-center col-md-4 mt-5 mb-5 form" action=""
			method="POST" id="frmRecovery" data-aos="fade-up">
			<h1 class="display-4 mb-3">Recover Password</h1>
			<div class="form-floating mb-3 mt-5">
				<input type="email" class="form-control" id="Email" name="Email"
					placeholder="name@example.com" required /> <label for="Email">Email</label>
			</div>
			<div class="checkbox mb-2 text-center">
				<p>
					Enter Your Email, We Will Send You A <b>Recovery Link</b>
				</p>
			</div>
			<div class="mb-2 mt-2" id="msg"></div>
			<button class="w-100 btn btn-lg btn-primary" type="submit">Send
				Recovery Link</button>
		</form>
	</main>
	<%@include file="components/footer.jsp"%>
	<script>
		$(document).ready(function() {
			$("#frmRecovery").on("submit", function(e) {
				e.preventDefault();
				$.ajax({
					url : "../PasswordRecoveryEmail",
					type : "POST",
					data : $(this).serialize(),
					success : function(data) {
						$("#msg").hide();
						$("#msg").html(data);
						$("#msg").fadeIn("slow");
						$("#frmRecovery").trigger("reset");
					}
				});
			});
		});
	</script>
</body>
</html>