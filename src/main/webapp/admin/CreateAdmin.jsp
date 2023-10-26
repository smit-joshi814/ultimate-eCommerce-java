<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Admin</title>
<%@include file="components/imports.jsp"%>
</head>
<body>
	<main class="page-wrapper">
		<%@include file="components/header.jsp"%>

		<form class="container text-center col-md-4 mt-5 mb-5 form" action=""
			method="POST" id="frmSignIn" data-aos="fade-up">
			<h1 class="display-3 mb-3">Create Admin</h1>
			<div class="form-floating mb-3 mt-5">
				<input type="text" class="form-control" id="txtName" name="txtName"
					placeholder="name@example.com" required /> <label for="txtName">Name</label>
			</div>
			<div class="form-floating mb-3">
				<input type="text" class="form-control" id="txtEmail"
					name="txtEmail" placeholder="name@example.com" required /> <label
					for="txtEmail">Email</label>
			</div>
			<div class="form-floating mb-3">
				<input type="password" class="form-control" id="txtPassword"
					name="txtPassword" placeholder="...." required /> <label
					for="txtPassword">Password</label>
			</div>
			<div class="form mb-3">
				<select class="form-select" aria-label="Default select example"
					id="AdminRole" name="AdminRole" required>
					<option value="1">Root Admin</option>
					<option value="2">Company Admin</option>
				</select>
			</div>
			<div id="msg" class="mt-2 mb-2"></div>
			<button class="w-100 btn btn-lg btn-primary" type="submit"
				id="btnSignUp" name="btnSignUp">Create New Admin</button>
		</form>
	</main>
	<%@include file="components/footer.jsp"%>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#navSignIn").hide();
			$("#frmSignIn").on("submit", function(e) {
				e.preventDefault();
				$.ajax({
					url : "../CreateNewAdmin",
					type : "POST",
					data : $(this).serialize(),
					success : function(data) {
						$("#msg").hide();
						$("#msg").html(data);
						$("#msg").fadeIn("slow");
						$("#frmSignIn").trigger("reset");
					}
				});
			});
		});
	</script>
</body>
</html>