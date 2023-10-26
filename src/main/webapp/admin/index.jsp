<%@page import="generalModule.PasswordOperations"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
if (request.getParameter("SignOut") != null) {
	session.removeAttribute("aid");
	response.sendRedirect("index.jsp");
} else if (session.getAttribute("aid") != null) {
	response.sendRedirect("AdminPanel.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Admin Login</title>
<%@include file="components/imports.jsp"%>
</head>
<body>
	<main class="page-wrapper">

		<%@include file="components/header.jsp"%>

		<form class="container text-center col-md-4 mt-5 mb-5 form" action=""
			method="POST" id="frmLogin" data-aos="fade-up">
			<h1 class="display-3 mb-3">Login As Admin</h1>
			<%
			Cookie[] items=request.getCookies();
			String adminEmail="";
			String adminPassword="";
			for(Cookie item:items){
				if(item.getName().equals("adminEmail")){
					adminEmail=PasswordOperations.PasswordDecrypter(item.getValue());
				}
				if(item.getName().equals("adminPassword")){
					adminPassword=PasswordOperations.PasswordDecrypter(item.getValue());
				}
			}
			%>
			<div class="form-floating mb-3 mt-5">
				<input type="text" class="form-control" id="txtEmail"
					name="txtEmail" placeholder="name@example.com"
					value="<%=adminEmail%>" required /> <label for="txtEmail">Email</label>
			</div>
			<div class="form-floating mb-3">
				<input type="password" class="form-control" id="txtPassword"
					name="txtPassword" placeholder="*****" value="<%=adminPassword%>"
					required /> <label for="txtPassword">Password</label>
			</div>
			<div class="checkbox mt-4 mb-2 text-start">
				<label> <input type="checkbox" name="remember" checked>
					Remember me
				</label>
			</div>
			<div class="mb-4 text-end">
				<a href="ResetPassword.jsp" class="text-decoration-none">Forgot
					Password ?</a>
			</div>
			<button class="w-100 btn btn-lg btn-primary" type="submit"
				id="btnSignUp" name="btnSignUp">Login</button>
			<div class="mb-2 mt-2" id="msg"></div>
		</form>
	</main>
	<%@include file="components/footer.jsp"%>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#frmLogin").on("submit", function(e) {
				e.preventDefault();
				$.ajax({
					url : "../AdminLogin",
					method : "POST",
					data : $(this).serialize(),
					success : function(data) {
						if (data == 1) {
							window.location.href = 'AdminPanel.jsp';
						} else {
							$("#msg").html(data);
							$("#msg").fadeIn("slow");
						}
					}
				});
			});
		});
	</script>
</body>
</html>