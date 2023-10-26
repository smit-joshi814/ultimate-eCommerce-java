function LoadBrands() {
	$.ajax({
		url: "../LoadBrands",
		type: "POST",
		success: function(data) {
			$("#tblBrands").hide();
			$("#tblBrands").html(data);
			$("#tblBrands").fadeIn("Slow");
		}
	});
}
LoadBrands();
$("#addBrands").on("submit", function(e) {
	e.preventDefault();
	let brand = $("#txtBrand").val();
	$.ajax({
		url: "../NewBrand",
		type: "POST",
		data: {
			brand: brand
		},
		success: function(data) {
			$("#msgtxtBrand").hide();
			$("#msgtxtBrand").html(data);
			$("#msgtxtBrand").fadeIn("slow");
			$("#addBrands").trigger("reset");
		}
	});
	setTimeout(function() {
		LoadBrands();
	}, 3000);
});
function getAvailableCategories(lavel, keep, removeAll) {
	let curr = $("#cat_lavel0").val();
	let oldDiv = $("#hdnMaxlevel").val();
	if (removeAll == "1") {
		$("#isSuperCatHidden").empty();
		getAvailableCategories("0");
	}
	$.ajax({
		url: "../getAvailableCategories",
		type: "POST",
		data: {
			lavel: lavel
		},
		success: function(data) {
			$("<div id='isSuperCatHidden" + lavel + "'></div>").appendTo(
				"#isSuperCatHidden");
			if (oldDiv != "0" && keep == "0") {
				$("#isSuperCatHidden" + oldDiv).remove();
			}
			$("#isSuperCatHidden" + lavel).html(data);
			$("#hdnMaxlevel").val(lavel);
			$("#hdnMaxlevelOld").val(oldDiv);
			if (curr) {
				$('#cat_lavel0').val(curr);
			} else {
				$('#cat_lavel0').val(0);
			}
		}
	});
}
getAvailableCategories("0");

function getProductCategories(lavel, keep, removeAll) {
	let curr = $("#cat_lavelP0").val();
	let oldDiv = $("#hdnMaxlevelP").val();
	if (removeAll == "1") {
		$("#productCategories").empty();
		getProductCategories("0");
	}
	$.ajax({
		url: "../GetProductCategories",
		type: "POST",
		data: {
			lavel: lavel
		},
		success: function(data) {
			$("<div id='productCategories" + lavel + "'></div>").appendTo(
				"#productCategories");
			if (oldDiv != "0" && keep == "0") {
				$("#productCategories" + oldDiv).remove();
			}
			$("#productCategories" + lavel).html(data);
			$("#hdnMaxlevelP").val(lavel);
			$("#hdnMaxlevelOldP").val(oldDiv);
			if (curr) {
				$('#cat_lavelP0').val(curr);
			} else {
				$('#cat_lavelP0').val(0);
			}
		}
	});
}
getProductCategories("0");

function getProductCategoriesForVar(lavel, keep, removeAll) {
	let curr = $("#cat_lavelPV0").val();
	let oldDiv = $("#hdnMaxlevelPV").val();
	if (removeAll == "1") {
		$("#productCategoriesForVar").empty();
		getProductCategoriesForVar("0");
	}
	$.ajax({
		url: "../GetProductCategoriesForVar",
		type: "POST",
		data: {
			lavel: lavel
		},
		success: function(data) {
			$("<div id='productCategoriesForVar" + lavel + "'></div>")
				.appendTo("#productCategoriesForVar");
			if (oldDiv != "0" && keep == "0") {
				$("#productCategoriesForVar" + oldDiv).remove();
			}
			$("#productCategoriesForVar" + lavel).html(data);
			$("#hdnMaxlevelPV").val(lavel);
			$("#hdnMaxlevelOldPV").val(oldDiv);
			if (curr) {
				$('#cat_lavelPV0').val(curr);
			} else {
				$('#cat_lavelPV0').val(0);
			}
		}
	});
}
getProductCategoriesForVar("0");

$("#addProductVariations").on("submit", function(e) {
	e.preventDefault();
	$.ajax({
		url: "../AddProductVariation",
		type: "POST",
		data: $(this).serialize(),
		success: function(data) {
			$("#msgPVar").hide();
			$("#msgPVar").html(data);
			$("#msgPVar").fadeIn("slow");
			$("#addProductVariations").trigger("reset");
			$('#cat_lavelPV0').val(0);
			$("#productCategoriesForVar").empty();
			getProductCategoriesForVar("0");
			$("#productCategoriesForVar").fadeIn("slow");
			$("#SelectedVariationValues").hide();
		}
	});
});

$("#addProduct").on("submit", function(e) {
	e.preventDefault();
	$.ajax({
		url: "../CreateProduct",
		type: "POST",
		data: $(this).serialize(),
		success: function(data) {
			$("#msgP").hide();
			$("#msgP").html(data);
			$("#msgP").fadeIn("slow");
			$("#addProduct").trigger("reset");
			$('#cat_lavelP0').val(0);
			$("#productCategories").empty();
			getProductCategories("0");
			$("#getProductCategories").fadeIn("slow");
		}
	});
});

$("#addCategory").on("submit", function(e) {
	e.preventDefault();
	$.ajax({
		url: "../AddCategory",
		type: "POST",
		data: new FormData(this),
		enctype: "multipart/form-data",
		cache: false,
		contentType: false,
		processData: false,
		success: function(data) {
			$("#addCategory").trigger("reset");
			$('#cat_lavel0').val(0);
			$("#isSuperCatHidden").empty();
			getAvailableCategories("0");
			$("#isSuperCatHidden").fadeIn("slow");
			$("#msg").hide();
			$("#msg").html(data);
			$("#msg").fadeIn("slow");
		}
	});
});
$("#isSuper").change(function() {
	if ($("#isSuper").is(':checked')) {
		$("#isSuperCatHidden").fadeOut();
	} else {
		$("#isSuperCatHidden").fadeIn("slow");
	}
});

$(document).on("click", ".shCat", function() {
	let catId = $(this).data("cid");
	let catName = $(this).data("cname");
	$("#ShowCatLabel").text(catName);
	$.ajax({
		url: "../ShowSubCategory",
		type: "POST",
		data: {
			catId: catId,
			catName: catName,
		},
		success: function(data) {
			$("#mdlSubCat").html(data);
		}
	});
});
$(document).on("click", ".prevSubCat", function() {
	let catId = $(this).data("cid");
	let catName = $(this).data("cname");
	$("#ShowCatLabel").text(catName);
	$.ajax({
		url: "../ShowSubCategory",
		type: "POST",
		data: {
			catId: catId,
			catName: catName,
		},
		success: function(data) {
			$("#mdlSubCat").hide();
			$("#mdlSubCat").html(data);
			$("#mdlSubCat").fadeIn();
		}
	});
});
$(document).on("click", ".shSubCat", function() {
	let catId = $(this).data("cid");
	let catName = $(this).data("cname");
	$("#ShowCatLabel").text(catName);
	$.ajax({
		url: "../ShowSubCategory",
		type: "POST",
		data: {
			catId: catId,
			catName: catName,
		},
		success: function(data) {
			$("#mdlSubCat").hide();
			$("#mdlSubCat").html(data);
			$("#mdlSubCat").fadeIn();
		}
	});
});

$(document)
	.on(
		"click",
		".catDel",
		function() {
			let catId = $(this).data("cid");
			let catName = $(this).data("cname");
			let element = this;
			$
				.confirm({
					title: '<p><small>Do yo Really Want To Delete <b class="text-danger">'
						+ catName + '</b> ?</small></p>',
					content: '<p>Deleting Supercategory <b class="text-danger">'
						+ catName
						+ '</b> will delete All The Sub Categories Available Within this Category.</p>',
					buttons: {
						confirm: function() {
							$
								.ajax({
									url: "../RemoveCategory",
									type: "POST",
									data: {
										catId: catId
									},
									success: function(data) {
										if (data == 1) {
											$
												.alert('Category Deleted SuccessFully');
											$(element)
												.closest(
													"tr")
												.fadeOut();
										} else {
											$
												.alert("Internal Error Can't Delete Category");
										}
									}
								});
						},
						cancel: function() {
							$.alert('Operation Aborted!');
						}
					}
				});
		});

function getCategoryImage(catId) {
	$.ajax({
		url: "../GetCategoryImage",
		type: "POST",
		data: {
			catId: catId
		},
		success: function(data) {
			$("#mdlCatImg").hide();
			$("#mdlCatImg").html(data);
			$("#mdlCatImg").fadeIn("slow");
		}
	});
}
$(document).on("click", ".EdtCat", function() {
	let catId = $(this).data("cid");
	let catName = $(this).data("cname");
	$("#EditCatLabel").text(catName);
	$("#mdlCategoryName").val(catName);
	$("#hdnCatId").val(catId);
	$("#mdlCatImgDiv").hide();
	getCategoryImage(catId);

});
$("#isUpdcatImg").change(function() {
	if ($("#isUpdcatImg").is(':checked')) {
		$("#mdlCatImgDiv").fadeIn("slow");
	} else {
		$("#mdlCatImgDiv").fadeOut("slow");
	}
});

$("#updateCategory").on("submit", function(e) {
	e.preventDefault();
	let catId = $("#hdnCatId").val();
	$.ajax({
		url: "../UpdateCategory",
		type: "POST",
		data: new FormData(this),
		enctype: "multipart/form-data",
		cache: false,
		contentType: false,
		processData: false,
		success: function(data) {
			$("#updateCatmsg").hide();
			$("#updateCatmsg").html(data);
			$("#updateCatmsg").fadeIn("slow");
			if ($("#isUpdcatImg").is(':checked')) {
				setTimeout(function() {
					getCategoryImage(catId);
				}, 5000);
			}
		}
	});
});
$(document).on("click", ".evar", function() {
	let varId = $(this).data("evid");
	let varName = $(this).data("evname");
	$("#EditVarLabel").text(varName);
	$("#mdlHdnVariationId").val(varId);
	$.ajax({
		url: "../GetVariationValues",
		type: "POST",
		data: {
			varId: varId
		},
		success: function(data) {
			$("#UpdateSelectedVariationValues").hide();
			$("#UpdateSelectedVariationValues").html(data);
			$("#UpdateSelectedVariationValues").fadeIn("slow");
		}
	});
});

$("#UpdateVariations").on("submit", function(e) {
	e.preventDefault();
	$.ajax({
		url: "../UpdateProductVariations",
		type: "POST",
		data: $(this).serialize(),
		success: function(data) {
			$("#updateVarmsg").hide();
			$("#updateVarmsg").html(data);
			$("#updateVarmsg").fadeIn("slow");
		}
	});
});
$(document)
	.on(
		"click",
		".dbra",
		function() {
			let bid = $(this).data("dbid");
			let bName = $(this).data("dbname");
			let element = this;
			$
				.confirm({
					title: '<p><small>Do yo Really Want To Delete <b class="text-danger">'
						+ bName + '</b> ?</small></p>',
					content: 'This Action can\'t Be Reversed.',
					buttons: {
						confirm: function() {
							$
								.ajax({
									url: "../RemoveBrand",
									type: "POST",
									data: {
										bid: bid
									},
									success: function(data) {
										if (data == 1) {
											$
												.alert('Brand Deleted SuccessFully');
											$(element)
												.closest(
													"tr")
												.fadeOut();
										} else {
											$
												.alert("Internal Error Can't Delete Brand");
										}
									}
								});
						},
						cancel: function() {
							$.alert('Operation Aborted!');
						}
					}
				});
		});
$(document)
	.on(
		"click",
		".dvar",
		function() {
			let varId = $(this).data("dvid");
			let varName = $(this).data("dvname");
			let element = this;
			$
				.confirm({
					title: '<p><small>Do yo Really Want To Delete <b class="text-danger">'
						+ varName + '</b> ?</small></p>',
					content: '<p>Deleting Variation <b class="text-danger">'
						+ varName
						+ '</b> will delete All The Variation Options Available Within this Variation.</p>',
					buttons: {
						confirm: function() {
							$
								.ajax({
									url: "../RemoveVariation",
									type: "POST",
									data: {
										varId: varId
									},
									success: function(data) {
										if (data == 1) {
											$
												.alert('Variation Deleted SuccessFully');
											$(element)
												.closest(
													"tr")
												.fadeOut();
										} else {
											$
												.alert("Internal Error Can't Delete Variation");
										}
									}
								});
						},
						cancel: function() {
							$.alert('Operation Aborted!');
						}
					}
				});
		});
$(document).on("click", ".ebra", function() {
	let bid = $(this).data("ebid");
	let bname = $(this).data("ebname");
	$("#mdlBrandName").val(bname);
	$("#hdnBrandId").val(bid);
});

$("#UpdateBrand").on("submit", function(e) {
	e.preventDefault();
	let bid = $("#hdnBrandId").val();
	let brandName = $("#mdlBrandName").val();
	$.ajax({
		url: "../UpdateBrand",
		type: "POST",
		data: {
			bid: bid,
			brandName: brandName
		},
		success: function(data) {
			$("#msgUpBrand").hide();
			$("#msgUpBrand").html(data);
			$("#msgUpBrand").fadeIn("slow");
		}
	});
});
function LoadProductBrands() {
	$.ajax({
		url: "../LoadProductBrands",
		type: "POST",
		success: function(data) {
			$("#ProductBrand").hide();
			$("#ProductBrand").html(data);
			$("#ProductBrand").fadeIn("slow");
		}
	});
}
LoadProductBrands();
$("#addVariations").on("submit", function(e) {
	e.preventDefault();
	$.ajax({
		url: "../AddVariations",
		type: "POST",
		data: $(this).serialize(),
		success: function(data) {
			$("#messgeVariation").hide();
			$("#messgeVariation").html(data);
			$("#messgeVariation").fadeIn("slow");
			$("#addVariations").trigger("reset");
		}
	});
});
$(document).on("click", ".editVar", function() {
	let var_id = $(this).data("evid");
	let var_name = $(this).data("evname");
	$("#mdlUpdateVariationName").val(var_name);
	$("#hdnmdlVarId").val(var_id);
	$.ajax({
		url: "../ShowVariationTable",
		type: "POST",
		data: { var_id: var_id },
		success: function(data) {
			$("#showVariationTable").hide();
			$("#showVariationTable").html(data);
			$("#showVariationTable").fadeIn("slow");
		}
	});
});
$(document).on("click", ".editVarValue", function() {
	let var_vid = $(this).data("var_vid");
	let var_vvalue = $(this).data("var_vvalue");
	$("#mdlUpdateVariationValue").val(var_vvalue);
	$("#hdnmdlVarValId").val(var_vid);
});
function GetVariationvalues(element) {
	let var_id = $(element).val();
	$.ajax({
		url: "../SelectedVariationValues",
		type: "POST",
		data: { var_id: var_id },
		success: function(data) {
			$("#SelectedVariationValues").hide();
			$("#SelectedVariationValues").html(data);
			$("#SelectedVariationValues").fadeIn("slow");
		}
	});
}
$(document).on('change', '[name="varValues[]"]', function() {
	var checkbox = $(this);
	//value = checkbox.val(); 
	if (checkbox.is(':checked')) {
		checkbox.parent().addClass("text-bg-primary");
	} else {
		checkbox.parent().removeClass("text-bg-primary");
	}
});
$("#UpdateVariationName").on("submit", function(e) {
	e.preventDefault();
	$.ajax({
		url: "../UpdateVariationName",
		type: "POST",
		data: $(this).serialize(),
		success: function(data) {
			$("#UpdateVariationMessage").hide();
			$("#UpdateVariationMessage").html(data);
			$("#UpdateVariationMessage").fadeIn("slow");

		}
	});
});
$("#UpdateVariationValue").on("submit", function(e) {
	e.preventDefault();
	$.ajax({
		url: "../UpdateVariationValue",
		type: "POST",
		data: $(this).serialize(),
		success: function(data) {
			$("#UpdateVariationValueMessage").hide();
			$("#UpdateVariationValueMessage").html(data);
			$("#UpdateVariationValueMessage").fadeIn("slow");
		}
	});
});
$(document).on("click", ".deleteVarValue", function() {
	let var_vid = $(this).data("var_vid");
	let var_vvalue = $(this).data("var_vvalue");
	let element = this;
	$.confirm({
		title: '<p><small>Do yo Really Want To Delete <b class="text-danger">'
			+ var_vvalue + '</b> ?</small></p>',
		buttons: {
			confirm: function() {
				$.ajax({
					url: "../DeleteVariationValue",
					type: "POST",
					data: {
						var_vid: var_vid
					},
					success: function(data) {
						if (data == 1) {
							$.alert('Variation Value Deleted SuccessFully');
							$(element).closest("tr").fadeOut();
						} else {
							$.alert("Internal Error Can't Delete Variation");
						}
					}
				});
			},
			cancel: function() {
				$.alert('Operation Aborted!');
			}
		}
	});
});
$(document).on("click", ".deleteVar", function() {
	let dvid = $(this).data("dvid");
	let dvname = $(this).data("dvname");
	let element = this;
	$.confirm({
		title: '<p><small>Do yo Really Want To Delete <b class="text-danger">'
			+ dvname + '</b> ? Variation</small></p>',
		buttons: {
			confirm: function() {
				$.ajax({
					url: "../DeleteVariationName",
					type: "POST",
					data: {
						dvid: dvid
					},
					success: function(data) {
						if (data == 1) {
							$.alert('Variation Deleted SuccessFully');
							$(element).closest("tr").fadeOut();
						} else {
							$.alert("Internal Error Can't Delete Variation");
						}
					}
				});
			},
			cancel: function() {
				$.alert('Operation Aborted!');
			}
		}
	});
});
$(document).on('change', '[name="UpdatevarValues[]"]', function() {
	var checkbox = $(this);
	if (checkbox.is(':checked')) {
		checkbox.parent().addClass("text-bg-primary");
	} else {
		checkbox.parent().removeClass("text-bg-primary");
	}
});
$("#UpdateVariationsOptions").on("submit", function(e) {
	e.preventDefault();
	$.ajax({
		url: "../UpdateVariationsOptions",
		type: "POST",
		data: $(this).serialize(),
		success: function(data) {
			$("#updateMessageVariationOptions").hide();
			$("#updateMessageVariationOptions").html(data);
			$("#updateMessageVariationOptions").fadeIn("slow");
		}
	});
});
$("#AddProductItem").on("submit", function(e) {
	e.preventDefault();
	$.ajax({
		url: "../AddProductItem",
		type: "POST",
		data: $(this).serialize(),
		success: function(data) {
			$("#msgPItem").hide();
			$("#msgPItem").html(data);
			$("#msgPItem").fadeIn("slow");
			$("#AddProductItem").trigger("reset");
		}
	});
});
function getProductItems(element) {
	let product_id = $(element).val();
	$.ajax({
		url: "../GetProductItems",
		type: "POST",
		data: { product_id: product_id },
		success: function(data) {
			$("#ProductItemList").hide();
			$("#ProductItemList").html(data);
			$("#ProductItemList").fadeIn("slow");
		}
	});
}
function getProductItemVariations(element) {
	let product_item_id = $(element).val();
	$.ajax({
		url: "../GetProductItemVariations",
		type: "POST",
		data: { product_item_id: product_item_id },
		success: function(data) {
			$("#ProductVariationList").hide();
			$("#ProductVariationList").html(data);
			$("#ProductVariationList").fadeIn("slow");
		}
	});
}
$("#ProductImages").hide();
function getProductItemVariationValues(element) {
	let variation_id = $(element).val();
	$.ajax({
		url: "../GetProductItemVariationValues",
		type: "POST",
		data: { variation_id: variation_id },
		success: function(data) {
			$("#ProductVariationValueList").hide();
			$("#ProductVariationValueList").html(data);
			$("#ProductVariationValueList").fadeIn("slow");
		}
	});
	let variation_name = $("#ProductVariationList option:selected").text();

	if (variation_name == "Color") {
		$("#ProductImages").fadeIn("slow");
		$("#productImg1").attr("required", "true");
		$("#productImg2").attr("required", "true");
		$("#hdnIsColor").val("yes");
	} else {
		$("#ProductImages").hide();
		$("#productImg1").removeAttr("required");
		$("#productImg2").removeAttr("required");
		$("#hdnIsColor").val("no");
	}
}

$("#AddProductItemVariation").on("submit", function(e) {
	e.preventDefault();
	$.ajax({
		url: "../AddProductItemVariation",
		type: "POST",
		data: new FormData(this),
		enctype: "multipart/form-data",
		cache: false,
		contentType: false,
		processData: false,
		success: function(data) {
			$("#msgProductItemVariation").hide();
			$("#msgProductItemVariation").html(data);
			$("#msgProductItemVariation").fadeIn("slow");
			$("#AddProductItemVariation").trigger("reset");
		}
	});
});
function loadProductsTable() {
	$.ajax({
		url: "../TableProductsMain",
		type: "POST",
		success: function(data) {
			$("#tblProductsMain").hide();
			$("#tblProductsMain").html(data);
			$("#tblProductsMain").fadeIn("slow");
		}
	});
}
loadProductsTable();

$(document).on("click", ".pshow", function() {
	let product_id = $(this).data("proid");
	$.ajax({
		url: "../TableProductItems",
		type: "POST",
		data: { product_id: product_id },
		success: function(data) {
			$("#mdlProductItems").hide();
			$("#mdlProductItems").html(data);
			$("#mdlProductItems").fadeIn("fadeIn");
		}
	});
});
$(document).on("click", ".pitemvar", function() {
	let product_item_id = $(this).data("pitemvar");
	$.ajax({
		url: "../TableProductVariations",
		type: "POST",
		data: { product_item_id: product_item_id },
		success: function(data) {
			$("#mdlItemVariations").hide();
			$("#mdlItemVariations").html(data);
			$("#mdlItemVariations").fadeIn("slow");
		}
	});
});
$(document).on("click", ".editprod", function() {
	let product_id = $(this).data("proid");
	let product_name = $(this).data("pname");
	$("#ShowEditProductLabel").text(product_name);
	$.ajax({
		url: "../UpdateProductForm",
		type: "POST",
		data: { product_id: product_id },
		success: function(data) {
			$("#updateProductForm").hide();
			$("#updateProductForm").html(data);
			$("#updateProductForm").fadeIn("slow");
		}
	});
});
$(document).on("click", ".pitemedit", function() {
	let product_item_id = $(this).data("productitemid");
	let product_item_sku = $(this).data("pitemsku");
	$("#ShowEditProductItemLabel").text(product_item_sku);
	$.ajax({
		url: "../UpdateProductItemForm",
		type: "POST",
		data: { product_item_id: product_item_id },
		success: function(data) {
			$("#updateProductItemForm").hide();
			$("#updateProductItemForm").html(data);
			$("#updateProductItemForm").fadeIn("slow");
		}
	});
});
$(document).on("click", ".mapdel", function() {
	let map_id = $(this).data("mapid");
	let var_name = $(this).data("varname");
	let isColor = var_name.toLowerCase() == "color";
	let content = "";
	if (isColor) {
		content = '<p>Deleting Variation <b class="text-danger">' + var_name + '</b> will delete All Images Mapped To This Product Item</p>';
	} else {
		content = "<small>you can always add this variation From <b>add product variation</b> section</small>";
	}
	let element = this;
	$.confirm({
		title: '<p><small>Do yo Really Want To Delete <b class="text-danger">'
			+ var_name + '</b>  Variation Mapping ?</small></p>',
		content: content,
		buttons: {
			confirm: function() {
				$.ajax({
					url: "../DeleteVariationMapping",
					type: "POST",
					data: {
						map_id: map_id, var_name: var_name
					},
					success: function(data) {
						if (data == 1) {
							if (isColor) {
								$.alert('Variation Mapping Deleted SuccessFully With All The images Associated With This Item');
							} else {
								$.alert('Variation Mapping Deleted SuccessFully');
							}

							$(element).closest("tr").fadeOut();
						} else {
							$.alert("Internal Error Can't Delete Variation");
						}
					}
				});
			},
			cancel: function() {
				$.alert('Operation Aborted!');
			}
		}
	});
});
$(document).on("click", ".pitemdelete", function() {
	let product_item_id = $(this).data("productitemid");
	let item_sku = $(this).data("pitemsku");
	let element = this;
	let content = "<p class='text-warning'><small>Deleting This Product item ( <b>" + item_sku + "</b>) Will Delete All the variations and images Associated With it.<br/><b class='text-danger'>Action is not Recoverable</b></small></p>";
	$.confirm({
		title: '<p><small>Do yo Really Want To Delete <b class="text-danger">'
			+ item_sku + '</b> ?</small></p>',
		content: content,
		buttons: {
			confirm: function() {
				$.ajax({
					url: "../DeleteProductItem",
					type: "POST",
					data: {
						product_item_id: product_item_id
					},
					success: function(data) {
						if (data == 1) {
							$.alert('Product Item Deleted SuccessFully');
							$(element).closest("tr").fadeOut();
						} else {
							$.alert("Internal Error Can't Delete Item");
						}
					}
				});
			},
			cancel: function() {
				$.alert('Operation Aborted!');
			}
		}
	});
});
$(document).on("click", ".pdelete", function() {
	let product_id = $(this).data("proid");
	let product_name = $(this).data("pname");
	let content = "<p class='text-warning'><small>Deleting This Product ( <b>" + product_name + "</b>) Will Delete All the Items and images Associated With it.<br/><b class='text-danger'>Action is not Recoverable</b></small></p>";
	let element = this;
	$.confirm({
		title: '<p><small>Do yo Really Want To Delete <b class="text-danger">'
			+ product_name + '</b> ?</small></p>',
		content: content,
		buttons: {
			confirm: function() {
				$.ajax({
					url: "../DeleteProduct",
					type: "POST",
					data: {
						product_id: product_id
					},
					success: function(data) {
						if (data == 1) {
							$.alert('Product Deleted SuccessFully');
							$(element).closest("tr").fadeOut();
						} else {
							$.alert("Internal Error Can't Delete Item");
						}
					}
				});
			},
			cancel: function() {
				$.alert('Operation Aborted!');
			}
		}
	});
});


function selectAllVariations(element){
	if($(element).is(":checked")){
		$(".check-all").prop('checked', true);
		$(".check-all").parent().addClass("text-bg-primary");
	}else{
		$(".check-all").prop('checked', false);
		$(".check-all").parent().removeClass("text-bg-primary");
	}
	
}

function UpdateOrderStatus(element){
	let order_id=$(element).data("oid");
	let order_status=$(element).val();
	$.ajax({
		url:"../UpdateOrderStatus",
		type:"POST",
		data:{order_id:order_id,order_status,order_status},
		success:function(data){
			$.alert(data);
		}
	});
}

$("#LayoutManagerFrm").on("submit",function(e){
	e.preventDefault();
	$.ajax({
		url:"../UpdateLayout",
		type:"POST",
		data:$(this).serialize(),
		success:function(data){
			$("#updatePreferencesStatus").hide();
			$("#updatePreferencesStatus").html(data);
			$("#updatePreferencesStatus").fadeIn("slow");
		}
		
	});
});