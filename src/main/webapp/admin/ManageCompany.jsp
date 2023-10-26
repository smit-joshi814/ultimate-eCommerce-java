<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<%@page import="conModule.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%
String email;
if (session.getAttribute("aid") == null) {
	response.sendRedirect("index.jsp");
	email = "";
} else {
	Connection con = ConnectionProvider.getCon();
	PreparedStatement prs = con.prepareStatement("SELECT admin_email FROM site_admins WHERE admin_id=?");
	prs.setString(1, session.getAttribute("aid").toString());
	ResultSet rs = prs.executeQuery();
	rs.next();
	email = rs.getString(1);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Company</title>
<%@include file="components/imports.jsp"%>
</head>
<body>
	<main class="page-wrapper">

		<%@include file="components/header.jsp"%>

		<form class="container text-center col-md-4 mt-5 mb-5 form" action=""
			method="POST" id="frmUpdateCompany" data-aos="fade-up">
			<h6 class="display-6 mb-3">Update Company Information</h6>
			<div class="form-floating mb-3 mt-5">
				<input type="text" class="form-control" id="txtName" name="txtName"
					placeholder="name@example.com" required /> <label for="txtName">Company
					Name </label>
			</div>
			<div class="form-floating mb-3">
				<input type="text" class="form-control" id="txtEmail"
					name="txtEmail" placeholder="name@example.com" value="<%=email%>"
					disabled /> <label for="txtEmail">Email</label> <input
					type="hidden" value="<%=email%>" name="hdnEmail" id="hdnEmail" />
			</div>
			<div class="form-floating mb-3">
				<input type="number" class="form-control" id="txtPhone"
					name="txtPhone" placeholder="name@example.com" required /> <label
					for="txtPhone">Company Phone</label>
			</div>
			<div class="form-floating mb-3">
				<input type="text" class="form-control" id="txtSite" name="txtSite"
					placeholder="name@example.com" /> <label for="txtSite">WebSite
					<span class="text-info"><small>(Optional)</small></span>
				</label>
			</div>
			<div class="form-floating mb-3">
				<input type="text" class="form-control" id="txtGst" name="txtGst"
					placeholder="name@example.com" required /> <label for="txtGst">GST
					NO</label>
			</div>
			<div class="form-floating mb-3">
				<input type="password" class="form-control" id="txtPassword"
					name="txtPassword" placeholder="...." required /> <label
					for="txtPassword">Password</label>
			</div>
			<div class="form-floating mb-3">
				<input type="password" class="form-control" id="txtConPassword"
					name="txtConPassword" placeholder="...." required /> <label
					for="txtConPassword">Confirm Password</label>
			</div>
			<div id="msg" class="mt-2 mb-2"></div>
			<button class="w-100 btn btn-lg btn-warning" type="submit"
				id="btnSignUp" name="btnSignUp">Update</button>
		</form>
		<div class="mt-5 mb-5">
			<%
		if(request.getParameter("hideTable")==null){
		%>
			<table
				class="container table table-striped-columns border table-hover"
				data-aos="fade-left">
				<thead>
					<tr>
						<th colspan="2">Company informaction</th>
					</tr>
				</thead>
				<tbody>
					<%
					Connection cn = ConnectionProvider.getCon();
					PreparedStatement ps = cn.prepareStatement("SELECT * FROM site_companies_info WHERE login_id=?");
					ps.setString(1, session.getAttribute("aid").toString());
					ResultSet rs = ps.executeQuery();
					while (rs.next()) {
					%>
					<tr>
						<td>Company Name</td>
						<td><%=rs.getString("company_name")%></td>
					</tr>
					<tr>
						<td>Company Phone</td>
						<td><%=rs.getString("company_phone")%></td>
					</tr>
					<tr>
						<td>Company Email</td>
						<td><%=email%></td>
					</tr>

					<tr>
						<td>Company Website</td>
						<td><%=rs.getString("company_website")%></td>
					</tr>
					<tr>
						<td>Company GSTN</td>
						<td><%=rs.getString("company_GSTN")%></td>
					</tr>
					<tr>
						<td>Is Verified</td>
						<td><%=rs.getString("is_Allowed")%></td>
					</tr>

					<%
					}
					%>
				</tbody>

			</table>
			<% } %>
		</div>

	</main>

	<%@include file="components/footer.jsp"%>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$("#frmUpdateCompany")
									.on(
											"submit",
											function(e) {
												e.preventDefault();
												let phone = $("#txtPhone")
														.val();
												let gst = $("#txtGst").val();
												let password = $("#txtPassword")
														.val();
												let conPassword = $(
														"#txtConPassword")
														.val();
												$("#msg").hide();
												if (phone.length != 10) {
													$("#msg")
															.html(
																	"<p class='text-danger'>Invalid Mobile Number</p>");
												} else if (gst.length != 15) {
													$("#msg")
															.html(
																	"<p class='text-danger'>Invalid GST Number</p>");
												} else if (password.length < 8) {
													$("#msg")
															.html(
																	"<p class='text-danger'>Password Should Contain Minimum 8 Charachters</p>");
												} else if (password != conPassword) {
													$("#msg")
															.html(
																	"<p class='text-danger'>Password DosentMatch</p>");
												} else {
													$
															.ajax({
																url : "../ManageCompany",
																type : "POST",
																data : $(this)
																		.serialize(),
																cache : false,
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
																			"#frmUpdateCompany")
																			.trigger(
																					"reset");
																}
															});
												}
												$("#msg").fadeIn("slow");
											});
						});
	</script>
</body>
</html>