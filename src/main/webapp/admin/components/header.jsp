<%@page import="java.sql.*"%>
<%@page import="conModule.*"%>
<%
ResultSet rsH=null;
String name[]=null;
boolean signedIn=false;
boolean isAdminRoot=false;
if(session.getAttribute("aid")!=null){
	Connection conH=ConnectionProvider.getCon();
	PreparedStatement psH=conH.prepareStatement("SELECT * FROM site_admins WHERE admin_id=?");
	psH.setString(1, session.getAttribute("aid").toString());
	rsH=psH.executeQuery();
	rsH.next();
	signedIn=true;
	name=rsH.getString("admin_name").split(" ");
	isAdminRoot=rsH.getString("Admin_type").equals("1");
}
%>
<header class="shadow-sm" id="header-shadow">
	<!-- Remove "navbar-sticky" class to make navigation bar scrollable with the page.-->
	<div class="bg-light">
		<div class="navbar navbar-expand-lg navbar-light">
			<div class="container">
				<a class="navbar-brand d-flex flex-shrink-0 align-items-center"
					style="font-size: 1rem" href="../index.jsp"><img
					class="rounded-circle" src="../img/logo.png" width="50"
					alt="MyECommerceSite">&nbsp;MyECommerceSite</a>
				<form class="input-group d-none d-lg-flex mx-4"
					action="../products-rs.jsp">
					<input class="form-control rounded-end pe-5" type="text"
						name="search"
						value="<%=request.getParameter("search")!=null?request.getParameter("search"):""%>"
						placeholder="Search for products">
					<button type="submit"
						class="border-0 bg-none position-absolute top-50 end-0 translate-middle-y text-muted fs-base me-3">
						<i class="ci-search"></i>
					</button>
				</form>
				<div class="navbar-toolbar d-flex flex-shrink-0 align-items-center">
					<%if(signedIn){ 
                  		if(isAdminRoot){
                  %>
					<a class="navbar-tool ms-1 ms-lg-0 me-n1 me-lg-2"
						href="CreateAdmin.jsp"> <% }else{ %> <a
						class="navbar-tool ms-1 ms-lg-0 me-n1 me-lg-2"
						href="ManageCompany.jsp"> <% } %>
							<div class="navbar-tool-icon-box">
								<i class="navbar-tool-icon ci-user"></i>
							</div>
							<div class="navbar-tool-text ms-n3">
								<small>Hello, <%=name[0]%></small>My Account
							</div>
					</a> <a class="nav-link-style d-flex align-items-center px-4 py-3"
						href="index.jsp?SignOut=1"><i
							class="ci-sign-out opacity-60 me-2"></i>Sign out</a> <%}else{ %> <a
						class="navbar-tool ms-1 ms-lg-0 me-n1 me-lg-2" href="index.jsp">
							<div class="navbar-tool-icon-box">
								<i class="navbar-tool-icon ci-user"></i>
							</div>
							<div class="navbar-tool-text ms-n3">
								<small>Hello, Sign in</small>My Account
							</div>
					</a> <%} %>
				</div>
			</div>
		</div>
	</div>
</header>
<script>
    
      </script>