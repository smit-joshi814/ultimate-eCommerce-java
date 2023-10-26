<%@page import="generalModule.FormatPrice"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="conModule.*"%>
<%@page import="java.sql.*"%>
<%@page import="generalModule.SiteConstants"%>
<%
boolean isAdmin, isVerified = false;
Connection cn = ConnectionProvider.getCon();
PreparedStatement ps;
ResultSet rs, rs1, rs2;
String disable = "";
String company_id = null;
if (session.getAttribute("aid") == null) {
	response.sendRedirect("index.jsp");
	isAdmin = false;
} else {
	ps = cn.prepareStatement("SELECT Admin_type FROM site_admins WHERE admin_id=?");
	ps.setString(1, session.getAttribute("aid").toString());
	rs = ps.executeQuery();
	rs.next();
	isAdmin = rs.getString(1).equals("1");
	if (!isAdmin) {
		ps = cn.prepareStatement("SELECT is_Allowed,company_id FROM site_companies_info WHERE login_id=?");
		ps.setString(1, session.getAttribute("aid").toString());
		rs = ps.executeQuery();
		rs.next();
		isVerified = rs.getString("is_Allowed").equals("1");
		company_id = rs.getString("company_id");
		if (!isVerified) {
	disable = "Disabled";
		}
	} else {
		isVerified = true;
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>MyEshop | Admin Panel</title>
<%@ include file="components/imports.jsp"%>
</head>
<body>

	<main class="page-wrapper">
		<!-- Modal Start -->
		<div>
			<!--  Models -->
			<div class="modal fade" id="ShowCat" data-bs-backdrop="static"
				data-keyboard="false" tabindex="-1" aria-labelledby="ShowCatLabel1"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="ShowCatLabel"></h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div id="mdlSubCat"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal modal-lg fade" id="ShowProductItems"
				data-bs-backdrop="static" data-keyboard="false" tabindex="-1"
				aria-labelledby="ShowProductItemsLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="ShowProductItemsLabel">Available
								Product Items</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<table
								class="table table-hover table-striped table-responsive-sm table-responsive-md table-responsive-lg">
								<thead class="thead-dark">
									<tr>
										<th>Product Item Id</th>
										<th>Item SKU</th>
										<th>Item quantity</th>
										<th>Item listing price</th>
										<th>Item Selling Price</th>
										<th>Status</th>
										<th>See Variations</th>
										<th>Edit</th>
										<th>Delete</th>
									</tr>
								</thead>
								<tbody id="mdlProductItems">
								</tbody>
							</table>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>


			<div class="modal modal-lg fade" id="ShowEditProduct"
				data-bs-backdrop="static" data-keyboard="false" tabindex="-1"
				aria-labelledby="ShowPEditProductLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="ShowEditProductLabel"></h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body" id="updateProductForm"></div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" id="ShowEditProductItem"
				data-bs-backdrop="static" data-keyboard="false" tabindex="-1"
				aria-labelledby="ShowPEditProductItemLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="ShowEditProductItemLabel"></h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body" id="updateProductItemForm">
							<form id="UpdateProductItem">
								<div class="mb-3">
									<label for="updateProductItem" class="form-label">Product
										Item</label> <input id="updateProductItem" name="updateProductItem"
										class='form-control' value="" disabled> <input
										type="hidden" name="hdnProductItemId" id="hdnProductItemId"
										value="" />
								</div>
								<div class="mb-3">
									<label for="updateproductQty" class="form-label">Update
										Item Quantity <b>In Stock</b>
									</label> <input type="number" class="form-control"
										id="updateproductQty" name="updateproductQty" value=""
										required>
								</div>
								<div class="mb-3">
									<label for="updatelistPrice" class="form-label">Update
										Listing Price</label> <input type="number" class="form-control"
										id="updatelistPrice" name="updatelistPrice" value="" required>
								</div>
								<div class="mb-3">
									<label for="updateselPrice" class="form-label">Update
										Selling Price</label> <input type="number" class="form-control"
										id="updateselPrice" name="updateselPrice" value="" required>
								</div>
								<div class="mb-3">
									<label for="updatesku" class="form-label">Update SKU</label> <input
										type="text" class="form-control" id="updatesku"
										name="updatesku" required>
								</div>
								<div class="mb-2 mt-2" id="msgUpdateProductItemInfo"></div>
								<button type="submit" class="btn btn-outline-primary">Update
									Item</button>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>


			<div class="modal fade" id="ShowProductItemVariations"
				data-bs-backdrop="static" data-keyboard="false" tabindex="-1"
				aria-labelledby="ItemVariationLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="ItemVariationLabel">Available
								Item Variations</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<table
								class="table table-hover table-striped table-responsive-sm table-responsive-md table-responsive-lg">
								<thead class="thead-dark">
									<tr>
										<th>Variation Name</th>
										<th>Variation value</th>
										<th>Delete</th>
									</tr>
								</thead>
								<tbody id="mdlItemVariations">
								</tbody>
							</table>
						</div>
						<div class="modal-footer">

							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>


			<div class="modal fade" id="EditCat" data-bs-backdrop="static"
				data-keyboard="false" tabindex="-1" aria-labelledby="EditCatLabel1"
				aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="EditCatLabel"></h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body" id="updateCategories">
							<form id="updateCategory">
								<div class="mb-3">
									<label for="mdlCategoryName" class="form-label">Category
										Name</label> <input type="text" class="form-control"
										id="mdlCategoryName" name="mdlCategoryName" required /> <input
										type="hidden" name="hdnCatId" id="hdnCatId" value="" />
								</div>
								<div id="getCategories"></div>
								<div id="mdlCatImg"></div>
								<div class="form-check mt-5 mb-3">
									<input class="form-check-input" type="checkbox" value=""
										id="isUpdcatImg" name="isUpdcatImg" value="1"> <label
										class="form-check-label" for="isUpdcatImg"> Update
										Category Image ? </label>
								</div>
								<div class="mb-3" id="mdlCatImgDiv">
									<label for="catImage" class="form-label">Update Image</label> <input
										class="form-control" type="file" id="mdlcatImage"
										name="mdlcatImage" />
								</div>
								<button type="submit" class="btn btn-warning">Update</button>
							</form>
							<div id="updateCatmsg" class="mb-3 mt-3"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" id="EditVar" data-bs-backdrop="static"
				data-keyboard="false" tabindex="-1" aria-labelledby="EditVarLabel1"
				aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="EditVarLabel"></h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form id="UpdateVariationsOptions">
								<div class="mb-3 widget">
									<div class="" id="UpdateSelectedVariationValues"></div>
								</div>
								<input type="hidden" name="mdlHdnVariationId"
									id="mdlHdnVariationId" />
								<button type="submit" class="btn btn-warning btn-sm">Update</button>
							</form>
							<div id="updateMessageVariationOptions" class="mb-3 mt-3"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" id="editVariationName"
				data-bs-backdrop="static" data-keyboard="false" tabindex="-1"
				aria-labelledby="editVariationNameLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="editVariationNameLabel">Edit
								Variation</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form id="UpdateVariationName">
								<div class="mb-3">
									<label for="mdlUpdateVariationName" class="form-label">Variation
										Name</label> <input type="text" class="form-control"
										id="mdlUpdateVariationName" name="mdlUpdateVariationName"
										required /> <input type="hidden" name="hdnmdlVarId"
										id="hdnmdlVarId" value="" />
								</div>
								<button type="submit" class="btn btn-warning btn-sm"
									title="Update">Update</button>
							</form>
							<div id="UpdateVariationMessage" class="mb-3 mt-3"></div>
							<h6 class="h5">Edit Values</h6>
							<div id="showVariationTable"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" id="editVarValue" data-bs-backdrop="static"
				data-keyboard="false" tabindex="-1"
				aria-labelledby="editVariationValueLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="editVariationValueLabel">Edit
								Variation Value</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form id="UpdateVariationValue">
								<div class="mb-3">
									<label for="mdlUpdateVariationValue" class="form-label">Variation
										Value</label> <input type="text" class="form-control"
										id="mdlUpdateVariationValue" name="mdlUpdateVariationValue"
										required /> <input type="hidden" name="hdnmdlVarValId"
										id="hdnmdlVarValId" value="" />
								</div>
								<button type="submit" class="btn btn-warning btn-sm"
									title="Update">Update</button>
							</form>
							<div id="UpdateVariationValueMessage" class="mb-3 mt-3"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" id="Editbrand" data-bs-backdrop="static"
				data-keyboard="false" tabindex="-1" aria-labelledby="EditVarLabel1"
				aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="EditBrandLabel">Update
								Brand</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form id="UpdateBrand">
								<div class="mb-3">
									<label for="mdlBrandName" class="form-label">Brand Name</label>
									<input type="text" class="form-control" id="mdlBrandName"
										name="mdlBrandName" required /> <input type="hidden"
										name="hdnBrandId" id="hdnBrandId" value="" />
								</div>
								<div class="mb-2 mt-2" id="msgUpBrand"></div>
								<button type="submit" class="btn btn-warning">Update</button>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- / Models END -->

		<%@include file="components/header.jsp"%>
		<%
		if (isVerified) {
		%>

		<div class="px-3 py-2">
			<div class="container">
				<ul
					class="nav col-12 col-lg-auto my-2 justify-content-center my-md-0 text-small">
					<%
					if (isAdmin) {
					%>
					<li><button id="adminHome"
							class="btn nav-link btn-sm text-dark active">
							<i class="bi bi-house-door d-block mx-auto mb-1"></i> Home
						</button></li>
					<%
					}
					%>
					<li><button id="adminInventory"
							class="btn btn-sm nav-link text-dark" <%=disable%>>
							<i class="bi bi-archive d-block mx-auto mb-1"></i>Inventory
						</button></li>
					<li><button id="adminOrders"
							class="btn btn-sm nav-link text-dark" <%=disable%>>
							<i class="bi bi-table d-block mx-auto mb-1"></i> Orders
						</button></li>
					<li><button id="adminProducts"
							class="btn btn-sm nav-link text-dark" <%=disable%>>
							<i class="bi bi-grid d-block mx-auto mb-1"></i> Products
						</button></li>

					<li><button id="adminReports"
							class="btn btn-sm nav-link text-dark">
							<i class="bi bi-file-text d-block mx-auto mb-1"></i> Reports
						</button></li>
					<%
					if (isAdmin) {
					%>
					<li><button id="adminLayout"
							class="btn btn-sm nav-link text-dark">
							<i class="bi bi-window d-block mx-auto mb-1"></i> Layout Manager
						</button></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>


		<div class="container-fluid" id="Home">
			<%
			Statement st = cn.createStatement();
			rs = st.executeQuery("SELECT count(category_id) FROM product_categories WHERE parent_category_id IS NULL");
			rs.next();
			%>
			<div class="row mt-3 mb-5">
				<div class="col">
					<div class="card border-info mb-3" style="max-width: 18rem;">
						<div class="card-header">Categories</div>
						<button class="card-body btn btn-outline-light text-start"
							id="showHirarchy">
							<h5 class="card-title"><%=rs.getString(1)%></h5>
							<p class="card-text">Total Main Categories Available</p>
						</button>
					</div>
					<div id="CategoryTree"></div>
				</div>
			</div>
			<script>
				$("#CategoryTree").hide();
				$("#showHirarchy").on("click", function() {
					if (isCategoryTreeHidden) {
						$.ajax({
							url : "../GetCategoryTree",
							type : "POST",
							success : function(data) {
								$("#CategoryTree").hide();
								$("#CategoryTree").html(data);
								$("#CategoryTree").fadeIn("slow");
							}
						});
						isCategoryTreeHidden = false;
					} else {
						isCategoryTreeHidden = true;
						$("#CategoryTree").hide();
					}
				});
			</script>
		</div>

		<div class="container-fluid" id="Inventory">
			<%
			if (session.getAttribute("aid") != null) {
			%>
			<div class="row">
				<div class="col-md-12">
					<nav>
						<div class="nav nav-tabs" id="nav-tab" role="tablist">
							<%
							if (isAdmin) {
							%>
							<button class="nav-link" id="nav-category-tab"
								data-bs-toggle="tab" data-bs-target="#nav-category"
								type="button" role="tab" aria-controls="nav-category"
								aria-selected="false">Manage Category</button>
							<button class="nav-link" id="nav-Variation-tab"
								data-bs-toggle="tab" data-bs-target="#nav-Variation"
								type="button" role="tab" aria-controls="nav-Variation"
								aria-selected="false">Manage Variations</button>
							<button class="nav-link" id="nav-Brands-tab" data-bs-toggle="tab"
								data-bs-target="#nav-Brands" type="button" role="tab"
								aria-controls="nav-Brands" aria-selected="false">Manage
								Brands</button>
							<%
							}
							%>
							<button class="nav-link active" id="nav-Products-tab"
								data-bs-toggle="tab" data-bs-target="#nav-Products"
								type="button" role="tab" aria-controls="nav-Products"
								aria-selected="false">Manage Products</button>
						</div>
					</nav>
					<div class="tab-content" id="nav-tabContent">

						<!-- Add category -->
						<div class="tab-pane fade" id="nav-category" role="tabpanel"
							aria-labelledby="nav-category-tab" tabindex="0">
							<div class="container-fluid">
								<div class="row mb-5 mt-5">
									<div class="col-md-4 mb-5">
										<h6 class="display-6">Add Category</h6>
										<form id="addCategory">
											<div class="form-check mt-5 mb-3">
												<input class="form-check-input" type="checkbox" value=""
													id="isSuper" name="isSuper" value="1"> <label
													class="form-check-label" for="isSuper"> add Main
													Category </label>
											</div>
											<div id="isSuperCatHidden"></div>
											<div class="mb-3">
												<label for="CategoryName" class="form-label">Category
													Name</label> <input type="text" class="form-control"
													id="CategoryName" name="CategoryName" required />
											</div>
											<div class="mb-3">
												<label for="catImage" class="form-label">Category
													Image</label> <input class="form-control" type="file" id="catImage"
													name="catImage" required />
											</div>
											<div class="mb-2 mt-2" id="msg"></div>
											<button type="submit" class="btn btn-primary">Add</button>
										</form>

									</div>
									<div class="col-md-1"></div>
									<div class="col-md-7 mb-5">
										<h6 class="display-6">Available Categories</h6>
										<table
											class="table table-hover table-striped table-responsive-sm table-responsive-md table-responsive-lg">
											<thead class="thead-dark">
												<tr>
													<th>Category Id</th>
													<th>Category Name</th>
													<th>View</th>
													<th>Edit</th>
													<th>Delete</th>
												</tr>
												<tr id="msgCat"></tr>
											</thead>
											<tbody id="tblCat">
												<%
												ps = cn.prepareStatement("SELECT category_id,category_name from product_categories WHERE parent_category_id IS NULL");
												rs = ps.executeQuery();
												while (rs.next()) {
												%>
												<tr>
													<td><%=rs.getString("category_id")%></td>
													<td><%=rs.getString("category_name")%></td>
													<td class="text-center"><button type="button"
															class="btn btn-info btn-sm shCat" data-bs-toggle="modal"
															data-bs-target="#ShowCat"
															data-cid="<%=rs.getString("category_id")%>"
															data-cname="<%=rs.getString("category_name")%>"
															data-bs-toggle="tooltip" title="View">
															<i class="ci-eye"></i>
														</button></td>
													<td><button type="button"
															class="btn btn-warning btn-sm EdtCat"
															data-bs-toggle="modal" data-bs-target="#EditCat"
															data-cid="<%=rs.getString("category_id")%>"
															data-cname="<%=rs.getString("category_name")%>"
															data-bs-toggle="tooltip" title="Edit">
															<i class="ci-edit"></i>
														</button></td>
													<td><button class='btn btn-danger btn-sm catDel'
															data-cid="<%=rs.getString("category_id")%>"
															data-cname="<%=rs.getString("category_name")%>"
															data-bs-toggle="tooltip" title="Remove">
															<i class="ci-trash"></i>
														</button></td>
												</tr>
												<%
												}
												%>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						<!-- Add Product Variation -->
						<div class="tab-pane fade" id="nav-Variation" role="tabpanel"
							aria-labelledby="nav-Variation-tab" tabindex="0">
							<div class="container-fluid">
								<div class="row mt-5 mb-5">
									<div class="col-md-4">
										<h6 class="display-6">Create Product Variation</h6>
										<form id="addProductVariations">
											<div id="productCategoriesForVar"></div>
											<div class="mb-3">

												<div class="widget widget-filter mb-4 pb-4 border-bottom">
													<h3 class="widget-title">Variation</h3>
													<div class="input-group input-group-sm mb-2">
														<input
															class="widget-filter-search form-control rounded-end pe-5"
															type="text" placeholder="Search"><i
															class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
													</div>
													<ul
														class="widget-list widget-filter-list list-unstyled pt-1"
														style="max-height: 11rem;" data-simplebar
														data-simplebar-auto-hide="false">
														<%
														ps = cn.prepareStatement("SELECT * FROM variation_combo");
														rs = ps.executeQuery();
														while (rs.next()) {
														%>
														<li
															class="widget-filter-item d-flex justify-content-between align-items-center mb-1">
															<div>
																<input class="form-radio-input" type="radio"
																	name="productVariationNames"
																	onchange="GetVariationvalues(this)"
																	value="<%=rs.getString("var_id")%>"
																	id="<%=rs.getString("var_name")%>" required> <label
																	class="form-check-label widget-filter-item-text"
																	for="<%=rs.getString("var_name")%>"><%=rs.getString("var_name")%></label>
															</div>
														</li>
														<%
														}
														%>
													</ul>
												</div>
											</div>
											<div class="mb-3 widget">
												<div class="" id="SelectedVariationValues"></div>
											</div>
											<div class="mb-2 mt-2" id="msgPVar"></div>
											<button type="submit"
												class="btn btn-outline-primary mb-5 mt-2">Create
												Variation</button>
										</form>
									</div>
									<div class="col-md-1"></div>
									<div class="col-md-7">
										<h6 class="display-6">Available Product Variations</h6>
										<table
											class="table table-hover table-striped table-responsive-sm table-responsive-md table-responsive-lg">
											<thead class="thead-dark">
												<tr>
													<th>Variation Id</th>
													<th>Variation Name</th>
													<th>Variation values</th>
													<th>Category Name</th>
													<th>Edit</th>
													<th>Delete</th>
												</tr>
												<tr id="msgProduct"></tr>
											</thead>
											<tbody>
												<%
												ps = cn.prepareStatement(
														"SELECT A.variation_id,B.var_name,c.category_name FROM variation A INNER JOIN variation_combo B ON A.variation_name_id=B.var_id INNER JOIN product_categories C ON A.category_id=c.category_id");
												rs = ps.executeQuery();
												while (rs.next()) {
													ps = cn.prepareStatement(
													"SELECT B.var_value FROM variation_options A INNER JOIN variation_combo_values B ON A.variation_value_id=B.var_val_id WHERE A.variation_id=?");
													ps.setString(1, rs.getString("variation_id"));
													rs1 = ps.executeQuery();
													String value = "";
													while (rs1.next()) {
														value += rs1.getString("var_value") + ",";
													}
												%>
												<tr>
													<td><%=rs.getString("variation_id")%></td>
													<td><%=rs.getString("var_name")%></td>
													<td>
														<%
														if (value.length() > 20) {
															out.print(value.substring(0, 20).trim() + "...");
														} else {
															out.print(value);
														}
														%>
													</td>
													<td><%=rs.getString("category_name")%></td>
													<td><button class="btn btn-warning btn-sm evar"
															data-bs-toggle="modal" data-bs-target="#EditVar"
															data-evid="<%=rs.getString("variation_id")%>"
															data-evname="<%=rs.getString("var_name")%>" title="Edit">
															<i class="ci-edit"></i>
														</button></td>
													<td><button class="btn btn-danger btn-sm dvar"
															data-dvid="<%=rs.getString("variation_id")%>"
															data-dvname="<%=rs.getString("var_name")%>"
															title="Remove">
															<i class="ci-trash"></i>
														</button></td>
												</tr>
												<%
												}
												%>
											</tbody>
										</table>
									</div>
									<hr class="mt-5 hr" />
									<div class="row mt-5 mb-5">
										<div class="col-md-4">
											<h6 class="display-6">Add Variation</h6>
											<form id="addVariations">
												<div class="mb-3">
													<label for="VariationName" class="form-label">Variation
														Name</label> <input type="text" class="form-control"
														id="VariationName" name="VariationName"
														placeholder="ex. Color" required>
												</div>
												<div class="mb-3">
													<label for="VariationValues" class="form-label">Variation
														Values</label>
													<textarea class="form-control" id="VariationValues"
														name="VariationValues" placeholder="ex. Red,Green,Blue"
														rows="10" area-describedby="ValuesHelp" required></textarea>
													<div id="ValuesHelp" class="text-dark">Give Variation
														Values In Comma ( , ) Separated Format</div>
												</div>
												<div class="mb-2 mt-2" id="messgeVariation"></div>
												<button type="submit" class="btn btn-outline-primary">Add
													Variation</button>
											</form>
										</div>
										<div class="col-md-1"></div>
										<div class="col-md-7">
											<h6 class="display-6">Available Variations</h6>
											<table
												class="table table-hover table-striped table-responsive-sm table-responsive-md table-responsive-lg">
												<thead class="thead-dark">
													<tr>
														<th>Variation Id</th>
														<th>Variation Name</th>
														<th>Variation values</th>
														<th>Edit</th>
														<th>Delete</th>
													</tr>
													<tr id="msgProduct"></tr>
												</thead>
												<tbody>
													<%
													ps = cn.prepareStatement("SELECT * FROM variation_combo");
													rs = ps.executeQuery();
													while (rs.next()) {
														ps = cn.prepareStatement("SELECT * FROM variation_combo_values WHERE var_id=?");
														ps.setString(1, rs.getString("var_id"));
														rs1 = ps.executeQuery();
														String values = "";
														while (rs1.next()) {
															values += rs1.getString("var_value") + ",";
														}
													%>
													<tr>
														<td><%=rs.getString("var_id")%></td>
														<td><%=rs.getString("var_name")%></td>
														<td>
															<%
															if (values.length() > 20) {
																out.print(values.substring(0, 20).trim() + "...");
															} else {
																out.print(values);
															}
															%>
														</td>
														<td><button class="btn btn-warning btn-sm editVar"
																data-bs-toggle="modal"
																data-bs-target="#editVariationName"
																data-evid="<%=rs.getString("var_id")%>"
																data-evname="<%=rs.getString("var_name")%>" title="Edit">
																<i class="ci-edit"></i>
															</button></td>
														<td><button class="btn btn-danger btn-sm deleteVar"
																data-dvid="<%=rs.getString("var_id")%>"
																data-dvname="<%=rs.getString("var_name")%>"
																title="Remove">
																<i class="ci-trash"></i>
															</button></td>
													</tr>
													<%
													}
													%>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Add Brand -->
						<div class="tab-pane fade" id="nav-Brands" role="tabpanel"
							aria-labelledby="nav-Brands-tab" tabindex="0">
							<div class="container-fluid">
								<div class="row mt-5 mb-5">
									<div class="col-md-4">
										<h6 class="display-6">Add Brand</h6>
										<form id="addBrands">
											<div class="mb-3">
												<label for="txtBrand" class="form-label">Brand Name</label>
												<input type="text" class="form-control" id="txtBrand"
													name="txtBrand" placeholder="ex. Zara" required>
											</div>
											<div class="mb-2 mt-2" id="msgtxtBrand"></div>
											<button type="submit" class="btn btn-outline-primary">Add
												Brand</button>
										</form>
									</div>
									<div class="col-md-1"></div>
									<div class="col-md-7">
										<h6 class="display-6">Available Brands</h6>
										<table
											class="table table-hover table-striped table-responsive-sm table-responsive-md table-responsive-lg">
											<thead class="thead-dark">
												<tr>
													<th>Brand Id</th>
													<th>Brand Name</th>
													<th>Edit</th>
													<th>Delete</th>
												</tr>
												<tr id="msgProduct"></tr>
											</thead>
											<tbody id="tblBrands"></tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						<!-- Add Product -->
						<div class="tab-pane fade show active" id="nav-Products"
							role="tabpanel" aria-labelledby="nav-Products-tab" tabindex="0">
							<div class="container-fluid">
								<div class="row mt-5">
									<div class="col-md-4 mb-5">
										<h6 class="display-6">Create Product</h6>
										<form id="addProduct">
											<div class="mb-3">
												<label for="productName" class="form-label">Product
													Name</label> <input type="text" class="form-control"
													id="productName" name="productName"
													placeholder="ex. boAt Rockerz 450 Pro with Upto 70 Hours Playback Bluetooth Headset"
													required>
											</div>
											<div id="productCategories"></div>
											<div class="mb-3">
												<label for="ProductBrand">Select Brand</label> <select
													class="form-select" id="ProductBrand" name="ProductBrand"
													required></select>
											</div>
											<div class="mb-3">
												<label for="productDescription" class="form-label">Description</label>
												<textarea class="form-control" id="productDescription"
													rows="8" minlength="200" maxlength="2000"
													placeholder="Give Detailed Description About Product And It's Key Feactures Or Qualities"
													name="productDescription" required></textarea>
											</div>
											<div class="mb-2 mt-2" id="msgP"></div>
											<button type="submit" class="btn btn-outline-primary">Create
												Product</button>
										</form>
									</div>
									<div class="col-md-4 mb-5">
										<h6 class="display-6">Add Product Item</h6>
										<form id="AddProductItem">
											<div class="mb-3">
												<label for="ProductList" class="form-label">Select
													Product</label> <select id="ProductList" name="ProductList"
													class='form-select' required>
													<option value="">Select Product</option>
													<%
													if (company_id != null) {
														ps = cn.prepareStatement(
														"SELECT * FROM product P INNER JOIN product_company_mapping PC ON P.product_id=PC.product_id WHERE PC.company_id=?");
														ps.setString(1, company_id);
													} else {
														ps.close();
														ps = cn.prepareStatement("SELECT * FROM PRODUCT");
													}
													rs = ps.executeQuery();
													while (rs.next()) {
													%>
													<option value="<%=rs.getString("product_id")%>"><%=rs.getString("product_name")%></option>
													<%
													}
													%>
												</select>
											</div>
											<div class="mb-3">
												<label for="productQty" class="form-label">Item
													Quantity <b>In Stock</b>
												</label> <input type="number" class="form-control" id="productQty"
													name="productQty" placeholder="ex. 100" required>
											</div>
											<div class="mb-3">
												<label for="listPrice" class="form-label">Listing
													Price</label> <input type="number" class="form-control"
													id="listPrice" name="listPrice" placeholder="ex. 2999"
													required>
											</div>
											<div class="mb-3">
												<label for="selPrice" class="form-label">Selling
													Price</label> <input type="number" class="form-control"
													id="selPrice" name="selPrice" placeholder="ex. 1999"
													required>
											</div>
											<div class="mb-3">
												<label for="sku" class="form-label">Create SKU</label> <input
													type="text" class="form-control" id="sku" name="sku"
													placeholder="ex. brkz1499r" required>
											</div>
											<div class="mb-2 mt-2" id="msgPItem"></div>
											<button type="submit" class="btn btn-outline-primary">Add
												Item</button>
										</form>
									</div>
									<div class="col-md-4 mb-5">
										<h6 class="display-6">Add Product Variation</h6>
										<form id="AddProductItemVariation">
											<div class="mb-3">
												<label for="ProductListVar" class="form-label">Select
													Product</label> <select id="ProductListVar" name="ProductListVar"
													class='form-select' onchange="getProductItems(this)"
													required>
													<option value="">Select Product</option>
													<%
													if (company_id != null) {
														ps = cn.prepareStatement(
														"SELECT * FROM product P INNER JOIN product_company_mapping PC ON P.product_id=PC.product_id WHERE PC.company_id=?");
														ps.setString(1, company_id);
													} else {
														ps.close();
														ps = cn.prepareStatement("SELECT * FROM PRODUCT");
													}
													rs = ps.executeQuery();
													while (rs.next()) {
													%>
													<option value="<%=rs.getString("product_id")%>"><%=rs.getString("product_name")%></option>
													<%
													}
													%>
												</select>
											</div>
											<div class="mb-3">
												<label for="ProductItemList" class="form-label">Select
													Product Item</label> <select id="ProductItemList"
													name="ProductItemList" class='form-select'
													onchange="getProductItemVariations(this)" required>
													<option value="">Select Product First</option>
												</select>
											</div>
											<div class="mb-3">
												<label for="ProductVariationList" class="form-label">Select
													Variation</label> <select id="ProductVariationList"
													name="ProductVariationList" class='form-select'
													onchange="getProductItemVariationValues(this)" required>
													<option value="">Select Product Item First</option>
												</select>
											</div>
											<div class="mb-3">
												<label for="ProductVariationValueList" class="form-label">Select
													Variation Value</label> <select id="ProductVariationValueList"
													name="ProductVariationValueList" class='form-select'
													required>
													<option value="">Select Variation First</option>
												</select> <input type="hidden" name="hdnIsColor" id="hdnIsColor" />
											</div>
											<div id="ProductImages">
												<div class="mb-3">
													<label for="productImg1" class="form-label">Product
														Image 1</label> <input class="form-control" type="file"
														id="productImg1" name="productImg1" accept="image/*" />
												</div>
												<div class="mb-3">
													<label for="productImg2" class="form-label">Product
														Image 2</label> <input class="form-control" type="file"
														id="productImg2" name="productImg2" accept="image/*" />
												</div>
												<div class="mb-3">
													<label for="productImg3" class="form-label">Product
														Image 3</label> <input class="form-control" type="file"
														id="productImg3" name="productImg3" accept="image/*" />
												</div>
												<div class="mb-3">
													<label for="productImg4" class="form-label">Product
														Image 4</label> <input class="form-control" type="file"
														id="productImg4" name="productImg4" accept="image/*" />
												</div>
												<div class="mb-3">
													<label for="productImg5" class="form-label">Product
														Image 5</label> <input class="form-control" type="file"
														id="productImg5" name="productImg5" accept="image/*" />
												</div>
												<div class="form-check form-switch mb-3">
													<input class="form-check-input" name="isPublish"
														type="checkbox" role="switch" id="isPublish"> <label
														class="form-check-label" for="isPublish">Publish ?</label>
												</div>
											</div>
											<div class="mb-2 mt-2" id="msgProductItemVariation"></div>
											<button type="submit" class="btn btn-primary">Add
												Variation</button>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


			<%
			}
			} else {
			%>
			<div class="mt-5 mb-5 text-center">
				<h5 class="h5">To Publish Products Give Company Information And
					Verify</h5>
				<a class="btn btn-primary" href="ManageCompany.jsp">Verify</a>
			</div>


			<%
			}
			%>
		</div>

		<div class="container-fluid" id="Orders">
			<div class="row mb-5 mt-5">
				<div class="col-md-12">
					<table
						class="table table-hover table-striped table-responsive-sm table-responsive-md table-responsive-lg">
						<thead class="thead-dark">
							<tr>
								<th>Order Id</th>
								<th>Order Date</th>
								<th>Order Total</th>
								<th>Address / Postal Code</th>
								<th>order Status</th>
							</tr>
							<tr>
								<td colspan="5" id="orderStatusMessage"></td>
							</tr>
						</thead>
						<tbody id="tblOrders">
							<%
							if (isAdmin) {
								ps = cn.prepareStatement(
								"SELECT SO.order_id,SO.order_date,SO.order_total,SO.order_status,A.address_line1,A.address_line2,A.postal_code FROM shop_order SO INNER JOIN address A ON SO.shipping_address=A.address_id");
								rs = ps.executeQuery();
							} else {
								ps = cn.prepareStatement(
								"SELECT DISTINCT(SO.order_id),SO.order_id,SO.order_date,SO.order_total,SO.order_status,A.address_line1,A.address_line2,A.postal_code FROM order_line OL INNER JOIN shop_order SO ON SO.order_id=OL.order_id INNER JOIN product_item PI ON OL.product_item_id=PI.product_item_id INNER JOIN product P ON PI.product_id =P.product_id INNER JOIN product_company_mapping PCM ON PCM.product_id=P.product_id INNER JOIN address A ON SO.shipping_address=A.address_id WHERE PCM.company_id=?");
								ps.setString(1, company_id);
								rs = ps.executeQuery();
							}
							ps = cn.prepareStatement("SELECT * FROM order_status", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
							rs1 = ps.executeQuery();
							while (rs.next()) {
								rs1.beforeFirst();
							%>
							<tr>
								<td><%=rs.getString("order_id")%></td>
								<td><%=rs.getString("order_date")%></td>
								<td><%=FormatPrice.formatPrice(rs.getString("order_total"))%></td>
								<td><%=rs.getString("address_line1") + "<br/>" + rs.getString("address_line2")%></td>
								<td><select onchange="UpdateOrderStatus(this)"
									data-oid="<%=rs.getString("order_id")%>">
										<%
										while (rs1.next()) {
											if (rs.getString("order_status").equals(rs1.getString("status_id"))) {
										%>
										<option value="<%=rs1.getString("status_id")%>" selected><%=rs1.getString("status_value")%></option>
										<%
										} else {
										%>
										<option value="<%=rs1.getString("status_id")%>"><%=rs1.getString("status_value")%></option>
										<%
										}
										}
										%>
								</select></td>
							</tr>

							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

		</div>

		<div class="container-fluid" id="ProductsContainer">
			<div class="row mb-5 mt-5">
				<div class="col-md-12">
					<table
						class="table table-hover table-striped table-responsive-sm table-responsive-md table-responsive-lg">
						<thead class="thead-dark">
							<tr>
								<th>Product Id</th>
								<th>Product Name</th>
								<th>Category</th>
								<th>Brand</th>
								<th>Item id</th>
								<th>Quantity In Stock</th>
								<th>Description</th>
								<th>See Items</th>
								<th>Edit</th>
								<th>Delete</th>
							</tr>
							<tr id="msgProduct"></tr>
						</thead>
						<tbody id="tblProductsMain">

						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="container" id="Reports">
			<div class="row mt-5 mb-5">
				<div class="mb-3">
					<h6 class="display-6">Generate Reports</h6>
				</div>
				<div class="col-md-5">
					<form action="../SellsReportsRange">
						<h6>Generate Report For Specific Time Period</h6>
						<div class="mb-3">
							<!-- Date range -->
							<label>Date range</label>
							<div class="input-group">
								<span class="input-group-text"> <i
									class="bi bi-calendar3"></i>
								</span> <input class="form-control date-picker date-range"
									name="fromtodates" type="text" placeholder="From date"
									data-datepicker-options='{"altInput": true, "altFormat": "F j, Y", "dateFormat": "Y-m-d","defaultDate": "today", "maxDate": "today"}'
									data-linked-input="#end-date" required> <input
									class="form-control date-picker" type="text"
									placeholder="To date"
									data-datepicker-options='{"altInput": true, "altFormat": "F j, Y", "dateFormat": "Y-m-d", "maxDate": "today"}'
									id="end-date" required>
							</div>
						</div>
						<button type="submit" class="btn btn-primary">Generate
							Report</button>
					</form>
				</div>
				<div class="col-md-2"></div>
				<div class="col-md-5">
					<form action="../SpecificDaySellsReport">
						<h6>Generate Report Specific day</h6>
						<div class="mb-3">
							<div class="input-group">
								<input class="form-control date-picker rounded pe-5" type="text"
									name="daydate" placeholder="Choose date and time"
									data-datepicker-options='{"altInput": true, "altFormat": "F j, Y", "dateFormat": "Y-m-d", "defaultDate": "today", "maxDate": "today"}'>
								<i
									class="fi-calendar position-absolute top-50 end-0 translate-middle-y me-3"></i>
							</div>
						</div>
						<button type="submit" class="btn btn-primary">Generate
							Report</button>
					</form>
				</div>
			</div>

		</div>

		<div class="container-fluid" id="Layout">
			<div class="row mt-5 mb-5">
				<form class="col d-flex flex-column align-items-center"
					id="LayoutManagerFrm">
					<div class="mb-3 col-md-6 col-sm-12">
						<label for="productGridMax" class="form-label">Products To
							Show On Products Grid </label> <input type="number" class="form-control"
							id="productGridMax" name="productGridMax"
							value=<%=SiteConstants.PRODUCT_RS_GRID_SIZE%> placeholder="ex. 6"
							required>
					</div>
					<div class="mb-3 col-md-6 col-sm-12">
						<label for="productListMax" class="form-label">Products To
							Show On Products List</label> <input type="number" class="form-control"
							id="productListMax" name="productListMax"
							value=<%=SiteConstants.PRODUCTS_RS_LIST_SIZE%>
							placeholder="ex. 4" required>
					</div>
					<div class="mb-3 col-md-6 col-sm-12">
						<label for="discountLblMin" class="form-label">Discount
							Label Minimum Rate</label> <input type="number" class="form-control"
							id="discountLblMin" name="discountLblMin"
							value=<%=SiteConstants.MINIMUM_DISCOUNT_RATE_BADGE%>
							placeholder="20" max="99" required>
					</div>
					<div class="mb-3 col-md-6 col-sm-12">
						<label for="discountLblMax" class="form-label">Discount
							Label Maximum Rate</label> <input type="number" class="form-control"
							id="discountLblMax" name="discountLblMax" max="99"
							value=<%=SiteConstants.MAXIMUM_DISCOUNT_RATE_BADGE%>
							placeholder="80" required>
					</div>
					<div class="mb-3 col-md-6 col-sm-12">
						<label for="MaxtempStorage" class="form-label">Maximum Age
							For Local Cart <small>In days</small>
						</label> <input type="number" class="form-control" id="MaxtempStorage"
							value=<%=(((SiteConstants.MAX_COOKIE_AGE_FOR_CART) / 24) / 60) / 60%>
							name="MaxtempStorage" placeholder="ex. 2" required>
					</div>
					<div class="mb-3 col-md-6 col-sm-12">
						<label for="serviceTax" class="form-label">Service Tax <small>In
								Percentage</small></label> <input type="number" class="form-control"
							id="serviceTax" value=<%=SiteConstants.SERVICE_TAX * 100%>
							name="serviceTax" placeholder="ex. 1" required>
					</div>
					<div class="mb-3 col-md-6 col-sm-12">
						<label for="stockLeft" class="form-label">Stock Left
							Message at</label> <input type="number" class="form-control"
							id="stockLeft"
							value="<%=SiteConstants.STOCK_LEFT_MESSAGE_BADGE_AT%>"
							name="stockLeft" placeholder="ex.30" required>
					</div>
					<div class="mb-3 col-md-6 col-sm-12">
						<label for="FeaturedCategory" class="form-label">Featured
							Category</label> <input type="text" class="form-control"
							id="FeaturedCategory"
							value="<%=SiteConstants.FEACTURED_CATEGORY%>"
							name="FeaturedCategory" placeholder="ex. Shirts" required>
					</div>

					<div class="mb-3 col-md-6 col-sm-12">
						<label for="Currencyunicode" class="form-label">Country
							Currency Unicode</label> <input type="text" class="form-control"
							id="Currencyunicode"
							value="<%=SiteConstants.COUNTRY_CURRANCY_UNICODE%>"
							name="Currencyunicode" disabled>
					</div>
					<div class="mb-2 mt-2 col-md-6" id="updatePreferencesStatus"></div>
					<button type="submit" class="col-md-6 btn btn-lg btn-primary">Update
						Preferences</button>
				</form>
			</div>
		</div>
	</main>
	<%@include file="components/footer.jsp"%>

	<script src="js/manageInventory.js"></script>

	<script type="text/javascript">
		$("#header-shadow").removeClass("shadow-sm");
		hideAll();
		$("#adminHome").addClass("active");
		$("#Home").fadeIn("slow");

		function hideAll() {
			$("#Inventory").hide();
			$("#Home").hide();
			$("#Orders").hide();
			$("#ProductsContainer").hide();
			$("#Reports").hide();
			$("#Layout").hide();

			$("#adminInventory").removeClass("active");
			$("#adminHome").removeClass("active");
			$("#adminOrders").removeClass("active");
			$("#adminProducts").removeClass("active");
			$("#adminReports").removeClass("active");
			$("#adminLayout").removeClass("active");
		}

		$("#adminProducts").on("click", function() {
			hideAll();
			$("#ProductsContainer").fadeIn("slow");
			$(this).addClass("active");
		});
		$("#adminLayout").on("click", function() {
			hideAll();
			$("#Layout").fadeIn("slow");
			$(this).addClass("active");
		});

		$("#adminReports").on("click", function() {
			hideAll();
			$("#Reports").fadeIn("slow");
			$(this).addClass("active");
		});

		$("#adminInventory").on("click", function() {
			hideAll();
			$("#Inventory").fadeIn("slow");
			$(this).addClass("active");
		});

		$("#adminOrders").on("click", function() {
			hideAll();
			$("#Orders").fadeIn("slow");
			$(this).addClass("active");
		});

		$("#adminHome").on("click", function() {
			hideAll();
			$("#Home").fadeIn("slow");
			$(this).addClass("active");
		});
		$("#showHirarchy").on("click", function() {
			if ($(this).hasClass("text-bg-primary")) {
				$(this).removeClass("text-bg-primary");
			} else {
				$(this).addClass("text-bg-primary");
			}
		});
		let isCategoryTreeHidden = true;
	</script>
</body>
</html>