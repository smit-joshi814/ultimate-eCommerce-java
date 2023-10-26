<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | 401 Error</title>
<!-- Imports -->
<%@include file="components/imports.jsp"%>
</head>
<body>
	<main class="page-wrapper">
		<!-- Navbar 3 Level (Light)-->
		<%@include file="components/header.jsp"%>
		<div class="container text-center mt-5 mb-5">
			<div class="noentry">
				<div class="ban"></div>
				<div class="messagebox">
					<h2>RESTRICTED ACCESS</h2>
					<p>This page is meant to only be accessed by certain people.</p>
					<a class="mt-2 mb-5 btn btn-outline-primary rounded-3"
						href="index.jsp">Go Back</a>
				</div>
			</div>
		</div>
	</main>
	<!-- Footer-->
	<%@include file="components/footer.jsp"%>
	<!-- / Footer -->

</body>
</html>