<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    Connection cn=ConnectionProvider.getCon();
    PreparedStatement ps;
    ResultSet rs;
    %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerseSite | My addresses</title>

<%@include file="components/imports.jsp"%>

</head>
<!-- Body-->
<body>

	<main class="page-wrapper">
		<!-- Add New Address-->

		<!-- Navbar 3 Level (Light)-->
		<%@include file="components/header.jsp"%>

		<!-- Page Title-->
		<div class="page-title-overlap bg-dark pt-4">
			<div class="container d-lg-flex justify-content-between py-2 py-lg-3">
				<div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
					<nav aria-label="breadcrumb">
						<ol
							class="breadcrumb breadcrumb-light flex-lg-nowrap justify-content-center justify-content-lg-start">
							<li class="breadcrumb-item"><a class="text-nowrap"
								href="index.jsp"><i class="ci-home"></i>Home</a></li>
							<li class="breadcrumb-item text-nowrap"><a href="#">Account</a>
							</li>
							<li class="breadcrumb-item text-nowrap active"
								aria-current="page">Addresses</li>
						</ol>
					</nav>
				</div>
				<div class="order-lg-1 pe-lg-4 text-center text-lg-start">
					<h1 class="h3 text-light mb-0">My addresses</h1>
				</div>
			</div>
		</div>
		<div class="container pb-5 mb-2 mb-md-4">
			<div class="row">
				<!-- Sidebar-->
				<aside class="col-lg-4 pt-4 pt-lg-0 pe-xl-5">
					<div class="bg-white rounded-3 shadow-lg pt-1 mb-5 mb-lg-0">
						<div
							class="d-md-flex justify-content-between align-items-center text-center text-md-start p-4">
							<div class="d-md-flex align-items-center">
								<div
									class="img-thumbnail rounded position-relative flex-shrink-0 mx-auto mb-2 mx-md-0 mb-md-0"
									style="width: 6.375rem;">
									<span class="badge bg-success position-absolute end-0 mt-n2"
										data-bs-toggle="tooltip" title="Verified">Verified</span><img
										class="rounded"
										src="img/shop/account/<%=rsH.getString("user_image") %>"
										alt="<%=rsH.getString("user_name")%>">
								</div>
								<div class="ps-md-3">
									<h3 class="fs-base mb-0"><%=rsH.getString("user_name") %></h3>
									<span class="text-accent fs-sm"><%=rsH.getString("user_email") %></span>
								</div>
							</div>
							<a class="btn btn-primary d-lg-none mb-2 mt-3 mt-md-0"
								href="#account-menu" data-bs-toggle="collapse"
								aria-expanded="false"><i class="ci-menu me-2"></i>Account
								menu</a>
						</div>
						<div class="d-lg-block collapse" id="account-menu">
							<div class="bg-secondary px-4 py-3">
								<h3 class="fs-sm mb-0 text-muted">Dashboard</h3>
							</div>
							<ul class="list-unstyled mb-0">
								<%
                ps=cn.prepareStatement("SELECT count(order_id) FROM shop_order WHERE user_id=?");
                ps.setString(1, session.getAttribute("uid").toString());
                rs=ps.executeQuery();
                rs.next();
                %>
								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-orders.jsp"><i class="ci-bag opacity-60 me-2"></i>Orders<span
										class="fs-sm text-muted ms-auto"><%=rs.getInt(1) %></span></a></li>
								<li class="border-bottom mb-0" id="wish-list"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-wishlist.jsp"><i
										class="ci-heart opacity-60 me-2"></i>Wishlist<span
										class="fs-sm text-muted ms-auto">3</span></a></li>
								<li class="mb-0" id="support-tickets"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-tickets.jsp"><i
										class="ci-help opacity-60 me-2"></i>Support tickets<span
										class="fs-sm text-muted ms-auto">1</span></a></li>
							</ul>
							<div class="bg-secondary px-4 py-3">
								<h3 class="fs-sm mb-0 text-muted">Account settings</h3>
							</div>
							<ul class="list-unstyled mb-0">
								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-profile.jsp"><i
										class="ci-user opacity-60 me-2"></i>Profile info</a></li>
								<li class="border-bottom mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3 active"
									href="account-address.jsp"><i
										class="ci-location opacity-60 me-2"></i>Addresses</a></li>
								<li class="mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-payment.jsp"><i
										class="ci-card opacity-60 me-2"></i>Payment methods</a></li>
								<li class="d-lg-none border-top mb-0"><a
									class="nav-link-style d-flex align-items-center px-4 py-3"
									href="account-signin.jsp?SignOut=1"><i
										class="ci-sign-out opacity-60 me-2"></i>Sign out</a></li>
							</ul>
						</div>
					</div>
				</aside>
				<!-- Content  -->
				<section class="col-lg-8">
					<!-- Toolbar-->
					<div
						class="d-none d-lg-flex justify-content-between align-items-center pt-lg-3 pb-4 pb-lg-5 mb-lg-3">
						<h6 class="fs-base text-light mb-0">List of your registered
							addresses:</h6>
						<a class="btn btn-primary btn-sm"
							href="account-signin.jsp?SignOut=1"><i
							class="ci-sign-out me-2"></i>Sign out</a>
					</div>
					<!-- Addresses list-->
					<div class="table-responsive fs-md">
						<table class="table table-hover mb-0">
							<thead>
								<tr>
									<th>Address</th>
									<th class="text-center" colspan="2">Actions</th>
								</tr>
							</thead>
							<tbody>
								<%
                ps=cn.prepareStatement("SELECT * FROM user_address_mapping A INNER JOIN address B ON A.address_id=B.address_id WHERE A.user_id IN (SELECT A.user_id FROM user_address_mapping WHERE A.user_id=?)");
                ps.setString(1, session.getAttribute("uid").toString());
                rs=ps.executeQuery();
                while(rs.next()){
                %>
								<tr>
									<td class="py-3 align-middle"><%=rs.getString("address_line1") %>
										<% if(rs.getString("is_default").equals("1")){ %><span
										class="align-middle badge bg-info ms-2">Primary</span> <% } %></td>
									<td class="py-3 align-middle"><a
										class="text-end btn text-warning me-2 btnEdt" id="btnEdt"
										href="#update-address" data-bs-toggle="modal"
										data-aid=<%=rs.getString("address_id")%>><i
											data-bs-toggle="tooltip" data-bs-placement="top" title="Edit"
											class="ci-edit"></i></a></td>
									<td class="py-3 align-middle"><button
											class="btn text-danger btnDel" id="btnDel"
											data-bs-toggle="tooltip" data-bs-placement="top"
											title="Remove" data-aid=<%=rs.getString("address_id")%>>
											<i class="ci-trash"></i>
										</button></td>
								</tr>
								<% } %>
							</tbody>
						</table>
						<div id="msg" class="mt-1 mb-1"></div>
					</div>
					<div class="text-sm-end pt-4">
						<a class="btn btn-primary" href="#add-address"
							data-bs-toggle="modal">Add new address</a>
					</div>
				</section>
			</div>
		</div>

		<!-- Add Address Model -->
		<form class="needs-validation modal fade" method="post"
			id="add-address" tabindex="-1">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Add a new address</h5>
						<button class="btn-close" type="button" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="row gx-4 gy-3">
							<div class="col-sm-6">
								<label class="form-label" for="address-country">Country</label>
								<select class="form-select" id="country" name="country" required>
									<option value="">Select Country</option>
									<% 
                  	ps=cn.prepareStatement("SELECT country_id,country_name FROM countries");
                	rs=ps.executeQuery();	  
                	while(rs.next()){	
               	  %>
									<option value="<%=rs.getString("country_id")%>"><%=rs.getString("country_name")%></option>
									<% } %>
								</select>
								<div class="invalid-feedback">Please select your country!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="state">State</label> <select
									class="form-select" id="state" name="state" required>
									<option value="">Select Country First</option>

								</select>
								<div class="invalid-feedback">Please select your state!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="city">City</label> <select
									class="form-select" id="city" name="city" required>
									<option value="">Select State First</option>

								</select>
								<div class="invalid-feedback">Please select your city!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="address-line1">Line 1</label> <input
									class="form-control" type="text" id="address-line1"
									name="address-line1" required>
								<div class="invalid-feedback">Please fill in your address!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="address-line2">Line 2</label> <input
									class="form-control" type="text" id="address-line2"
									name="address-line2">
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="address-zip">ZIP code</label> <input
									class="form-control" type="text" id="address-zip"
									name="address-zip" required>
								<div class="invalid-feedback">Please add your ZIP code!</div>
							</div>
							<div class="col-12">
								<div class="form-check">
									<input class="form-check-input" type="checkbox"
										id="address-primary" name="address-primary"> <label
										class="form-check-label" for="address-primary">Make
										this address primary</label>
								</div>
							</div>
							<div class="mt-2 mb-2" id="msgAdded"></div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"
							data-bs-dismiss="modal">Close</button>
						<button class="btn btn-primary btn-shadow" type="submit">Add
							address</button>
					</div>
				</div>
			</div>
		</form>

		<!-- Update Address Model -->
		<form class="needs-validation modal fade" method="post"
			id="update-address" tabindex="-1" novalidate>
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Update address</h5>
						<button class="btn-close" type="button" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body" id="LoadAddressData"></div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"
							data-bs-dismiss="modal">Close</button>
						<button class="btn btn-primary btn-shadow" type="submit">Update
							address</button>
					</div>
				</div>
			</div>
		</form>

	</main>
	<!-- Footer-->
	<%@include file="components/footer.jsp"%>

	<script>
  $("#nav-item-Account").addClass("active");
   $("#nav-Item-Account-Address").addClass("active");
	$("#wish-list").hide();
	$("#support-tickets").hide();
   
   $(document).on("click",".btnDel",function(){
	   let address_id=$(this).data("aid");
	   let element=this;
	   $.ajax({
		  url:"RemoveAddress",
		  type:"POST",
		  data:{address_id:address_id},
		  success:function(data){
			$("#msg").hide();
			$("#msg").html(data);
			$("#msg").fadeIn("slow");
			$(element).closest("tr").fadeOut("slow");
		  }
	   });
   });
   
   $(document).on("click",".btnEdt",function(){
	  let address_id=$(this).data("aid");
	  $.ajax({
		 url:"LoadAdressDetails",
		 type:"POST",
		 data:{address_id:address_id},
		 success:function(data){
			 $("#LoadAddressData").hide();
			 $("#LoadAddressData").html(data);
			 $("#LoadAddressData").fadeIn("slow");
		 }
	  });
   });
   $("#country").change(function() {
		let country = $(this).val();
		$.ajax({
			url : "GetStates",
			type : "POST",
			data : {
				country : country
			},
			success : function(data) {
				$("#state").html(data);
			}
		});
	});
   $("#state").change(function() {
		let state = $(this).val();
		$.ajax({
			url : "GetCity",
			type : "POST",
			data : {
				state : state
			},
			success : function(data) {
				$("#city").html(data);
			}
		});
	});
   $("#add-address").on("submit",function(e){
	   e.preventDefault();
	   $.ajax({
		  url:"AddAddress",
		  type:"POST",
		  data : $(this).serialize(),
		  success:function(data){
			  $("#msgAdded").hide();
			  $("#msgAdded").html(data);
			  $("#msgAdded").fadeIn("slow");
		  }
	   });
   });
   $("#update-address").on("submit",function(e){
	   e.preventDefault();
	   $.ajax({
			  url:"UpdateAddress",
			  type:"POST",
			  data : $(this).serialize(),
			  success:function(data){
				  $("#msgUpdated").hide();
				  $("#msgUpdated").html(data);
				  $("#msgUpdated").fadeIn("slow");
			  }
		   });
   });
   </script>
</body>
</html>