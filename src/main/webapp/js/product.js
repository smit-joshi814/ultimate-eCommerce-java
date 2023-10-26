//Loads the Product Grid
function loadProductsGrid(search, page_no, brands, variations) {
	let category_id = $("#hdncategoryId").val();
	if (page_no == null) {
		page_no = $("#currentpage").val();
	}

	//price Range
	let minPrice = $("#priceRangeMin").val();
	let maxPrice = $("#priceRangeMax").val();

	if (brands == null && variations == null) {
		$.ajax({
			url: "Products",
			type: "POST",
			data: { category_id: category_id, search: search, page_no: page_no },
			beforeSend: function() {
				$("#ProductGrid").html("<div class='d-flex justify-content-center mt-5 mb-5'><div class='spinner-border text-primary' role='status'><span class='visually-hidden'>Loading...</span></div></div>");
			},
			success: function(data) {
				$("#ProductGrid").html(data);
				$("#ProductGrid").fadeIn("slow");
			}
		});
	} else if (brands == null) {
		$.ajax({
			url: "Products",
			type: "POST",
			data: { category_id: category_id, search: search, page_no: page_no, variations: variations, minPrice: minPrice, maxPrice: maxPrice },
			beforeSend: function() {
				$("#ProductGrid").html("<div class='d-flex justify-content-center mt-5 mb-5'><div class='spinner-border text-primary' role='status'><span class='visually-hidden'>Loading...</span></div></div>");
			},
			success: function(data) {
				$("#ProductGrid").html(data);
				$("#ProductGrid").fadeIn("slow");
			}
		});
	} else if (variations == null) {
		$.ajax({
			url: "Products",
			type: "POST",
			data: { category_id: category_id, search: search, page_no: page_no, brands: brands, minPrice: minPrice, maxPrice: maxPrice },
			beforeSend: function() {
				$("#ProductGrid").html("<div class='d-flex justify-content-center mt-5 mb-5'><div class='spinner-border text-primary' role='status'><span class='visually-hidden'>Loading...</span></div></div>");
			},
			success: function(data) {
				$("#ProductGrid").html(data);
				$("#ProductGrid").fadeIn("slow");
			}
		});
	} else {
		$.ajax({
			url: "Products",
			type: "POST",
			data: { category_id: category_id, search: search, page_no: page_no, brands: brands, variations: variations, minPrice: minPrice, maxPrice: maxPrice },
			beforeSend: function() {
				$("#ProductGrid").html("<div class='d-flex justify-content-center mt-5 mb-5'><div class='spinner-border text-primary' role='status'><span class='visually-hidden'>Loading...</span></div></div>");
			},
			success: function(data) {
				$("#ProductGrid").html(data);
				$("#ProductGrid").fadeIn("slow");
			}
		});
	}
}

//Loads the Product List
function loadProductsList(search, page_no, brands, variations) {
	let category_id = $("#hdncategoryId").val();
	if (page_no == null) {
		page_no = $("#currentpage").val();
	}

	//price Range
	let minPrice = $("#priceRangeMin").val();
	let maxPrice = $("#priceRangeMax").val();

	if (brands == null && variations == null) {
		$.ajax({
			url: "ProductsList",
			type: "POST",
			data: { category_id: category_id, search: search, page_no: page_no },
			beforeSend: function() {
				$("#ProductList").html("<div class='d-flex justify-content-center mt-5 mb-5'><div class='spinner-border text-primary' role='status'><span class='visually-hidden'>Loading...</span></div></div>");
			},
			success: function(data) {
				$("#ProductList").html(data);
				$("#ProductList").fadeIn("slow");
			}
		});
	} else if (brands == null) {
		$.ajax({
			url: "ProductsList",
			type: "POST",
			data: { category_id: category_id, search: search, page_no: page_no, variations: variations, minPrice: minPrice, maxPrice: maxPrice },
			beforeSend: function() {
				$("#ProductList").html("<div class='d-flex justify-content-center mt-5 mb-5'><div class='spinner-border text-primary' role='status'><span class='visually-hidden'>Loading...</span></div></div>");
			},
			success: function(data) {
				$("#ProductList").html(data);
				$("#ProductList").fadeIn("slow");
			}
		});
	} else if (variations == null) {
		$.ajax({
			url: "ProductsList",
			type: "POST",
			data: { category_id: category_id, search: search, page_no: page_no, brands: brands, minPrice: minPrice, maxPrice: maxPrice },
			beforeSend: function() {
				$("#ProductList").html("<div class='d-flex justify-content-center mt-5 mb-5'><div class='spinner-border text-primary' role='status'><span class='visually-hidden'>Loading...</span></div></div>");
			},
			success: function(data) {
				$("#ProductList").html(data);
				$("#ProductList").fadeIn("slow");
			}
		});
	} else {
		$.ajax({
			url: "ProductsList",
			type: "POST",
			data: { category_id: category_id, search: search, page_no: page_no, brands: brands, variations: variations, minPrice: minPrice, maxPrice: maxPrice },
			beforeSend: function() {
				$("#ProductList").html("<div class='d-flex justify-content-center mt-5 mb-5'><div class='spinner-border text-primary' role='status'><span class='visually-hidden'>Loading...</span></div></div>");
			},
			success: function(data) {
				$("#ProductList").html(data);
				$("#ProductList").fadeIn("slow");
			}
		});
	}
}

//filter ProductGrid
function filterProductsGrid(page_id) {
	//Filter Brands
	let brands = "";
	$.each($("input[name='brands[]']:checked"), function() {
		brands += $(this).val() + ",";
	});

	//Filter Variations
	let variations = "";
	$.each($("input[name='filterVariations[]']:checked"), function() {
		variations += $(this).val() + ",";
	});

	//selected sorting
	let search = $("#sorting").find(":selected").val();


	if (brands == "" && variations == "") {
		loadProductsGrid(search, page_id);
	} else if (brands == "") {
		loadProductsGrid(search, page_id, null, variations);
	} else if (variations == "") {
		loadProductsGrid(search, page_id, brands);
	} else {
		loadProductsGrid(search, page_id, brands, variations);
	}
}

//filter ProductList
function filterProductsList(page_id) {
	//Filter Brands
	let brands = "";
	$.each($("input[name='brands[]']:checked"), function() {
		brands += $(this).val() + ",";
	});

	//Filter Variations
	let variations = "";
	$.each($("input[name='filterVariations[]']:checked"), function() {
		variations += $(this).val() + ",";
	});

	//selected sorting
	let search = $("#sorting").find(":selected").val();


	if (brands == "" && variations == "") {
		loadProductsList(search, page_id);
	} else if (brands == "") {
		loadProductsList(search, page_id, null, variations);
	} else if (variations == "") {
		loadProductsList(search, page_id, brands);
	} else {
		loadProductsList(search, page_id, brands, variations);
	}
}



//Loads cart items
function loadCart() {
	$.ajax({
		url: "GetCartItems",
		type: "POST",
		beforeSend: function() {
			$("#cart-items").html("<div class='d-flex justify-content-center mt-5 mb-5'><div class='spinner-border text-primary' role='status'><span class='visually-hidden'>Loading...</span></div></div>");
		},
		success: function(data) {
			$("#cart-items").html(data);
			$("#cart-items").fadeIn("slow");
			let cartTotal = $("#cart-page-total").val();
			if (cartTotal == 0) {
				$("#cart-total-checkout-area").hide();
				$("#cart-section").removeClass("col-lg-8");
				$("#cart-section").addClass("col-lg-12");
			} else {
				$("#cart-total-container").html(cartTotal);
			}
		}
	});
}

//Update Cart Button
$("#update-cart").on("click", function() {
	loadCart();
});

//Loads The Quick View Model
function loadQuickview(product_id, product_item_id) {
	$.ajax({
		url: "QuickView",
		type: "POST",
		data: { product_id: product_id, product_item_id: product_item_id },
		beforeSend: function() {
			$("#quick-view").html("<div class='d-flex justify-content-center align-items-center mt-5 mb-5 bg-white h-100 w-100'><div class='spinner-border text-primary' role='status'><span class='visually-hidden'>Loading...</span></div></div>");
		},
		success: function(data) {
			$("#quick-view").html(data);
			$("#quick-view").fadeIn();
		}
	});
}

//Load Quick View
$(document).on("click", ".quick", function() {
	let product_id = $(this).data("pid");
	let product_item_id = $("#currentProduct" + product_id).val();
	loadQuickview(product_id, product_item_id);
});

//Reloads The Pade With Different Product Items created To manage Variation
function reLoadView(product_id) {
	let other = $("#product-size").find(":selected").val();
	let color = $('input[name="rdocolors"]:checked').val();
	$.ajax({
		url: "GetProductItemId",
		type: "POST",
		data: { product_id: product_id, other: other, color: color },
		success: function(data) {
			window.location = "product-view.jsp?pid=" + product_id + "&piid=" + data;
		}
	});
}

//Product Image Changing for product-view page
$(document).on("click", ".pvchcolor", function() {
	let product_id = $(this).data("pid");
	reLoadView(product_id);
});

//Product Image Changing for product-view page
function passProductId(product_id) {
	reLoadView(product_id);
}


//Product Image Changing for Quick-view Model
$(document).on("click", ".qvchcolor", function() {
	let product_id = $(this).data("pid");
	reloadQuickView(product_id);
});

//just to pass the id
function passProductIdForQuickView(product_id) {
	reloadQuickView(product_id);
}

//reloads the quick view / Just to manage variations
function reloadQuickView(product_id) {
	let other = $("#product-sizeqv").find(":selected").val();
	let color = $('input[name="colorinputqv"]:checked').val();
	$.ajax({
		url: "GetProductItemId",
		type: "POST",
		data: { product_id: product_id, other: other, color: color },
		success: function(data) {
			loadQuickview(product_id, data);
		}
	});
}

//To Get Product Item Id Based On Selected variations
function setProductItemId(product_id, color, other) {
	$.ajax({
		url: "GetProductItemId",
		type: "POST",
		data: { product_id: product_id, other: other, color: color },
		success: function(data) {
			$("#currentProduct" + product_id).val(data);
		}
	});
}

//To get Product image Path
function setProductImagePath(product_item_id, product_id) {
	$.ajax({
		url: "GetProductImage",
		type: "POST",
		data: { product_item_id: product_item_id },
		success: function(data) {
			let id = "#productimage" + product_id;
			$(id).attr("src", data);
		}
	});
}

//Pagination code Grid
$(document).on("click", "#pagination a", function(e) {
	e.preventDefault();
	let page_id = $(this).attr("id");
	filterProductsGrid(page_id);
	$("#btn-scroll-top")[0].click();
});

$(document).on("click", "#previouspage a", function(e) {
	e.preventDefault();
	let page_id = $(this).data("page");
	filterProductsGrid(page_id);
	$("#btn-scroll-top")[0].click();
});

$(document).on("click", "#nextpage a", function(e) {
	e.preventDefault();
	let page_id = $(this).data("page");
	filterProductsGrid(page_id);
	$("#btn-scroll-top")[0].click();
});

//Pagination code List
$(document).on("click", "#paginationList a", function(e) {
	e.preventDefault();
	let page_id = $(this).attr("id");
	filterProductsList(page_id);
	$("#btn-scroll-top")[0].click();
});

$(document).on("click", "#previouspageList a", function(e) {
	e.preventDefault();
	let page_id = $(this).data("page");
	filterProductsList(page_id);
	$("#btn-scroll-top")[0].click();
});

$(document).on("click", "#nextpageList a", function(e) {
	e.preventDefault();
	let page_id = $(this).data("page");
	filterProductsList(page_id);
	$("#btn-scroll-top")[0].click();
});

//To chaneg The Images On Grid
function changeImage(other, product_id) {
	let color = $('input[name="colorbox' + product_id + '"]:checked').val();
	setProductItemId(product_id, color, other);
	setTimeout(function() {
		let product_item_id = $("#currentProduct" + product_id).val();
		setProductImagePath(product_item_id, product_id);
	}, 100);
}

$(document).on("click", ".chsize", function() {
	let product_id = $(this).data("pid");
	let other = $('input[name="combobox' + product_id + '"]:checked').val();
	if (other == null) {
		other = $("#combobox" + product_id).find(":selected").val();
	}
	changeImage(other, product_id);
});

$(document).on("click", ".chcolor", function() {
	let product_id = $(this).data("pid");
	let other = $('input[name="combobox' + product_id + '"]:checked').val();
	if (other == null) {
		other = $("#combobox" + product_id).find(":selected").val();
	}
	changeImage(other, product_id);
});


/*	Product cart js	*/

//Event when add-to-cart btn is clicked
$(document).on("click", ".add-to-cart", function() {
	let product_id = $(this).data("pid");
	let product_item_id;
	let element = this;
	if (typeof $(this).data('piid') !== 'undefined') {
		product_item_id = $(element).data("piid");
	} else {
		product_item_id = $("#currentProduct" + product_id).val();
	}
	let item_quantity = $("#item_quantity").find(":selected").val();
	$.ajax({
		url: "AddToCart",
		type: "POST",
		data: { product_item_id: product_item_id, item_quantity: item_quantity },
		success: function(data) {
			if (data == 1) {
				$.alert("Product Added SuccessFully");
			} else if (data == 2) {
				$.alert("Product Is Already in the cart Quantity Increased");
			} else {
				$.alert("Unable To add Product To The Cart");
			}
			setTimeout(function() {
				cartHeader();
			}, 100);
		}
	});
});
// To Remove An Item From Cart
$(document).on("click", ".remove-from-cart", function() {
	let product_item_id = $(this).data("piid");
	$.ajax({
		url: "RemoveFromCart",
		type: "POST",
		data: { product_item_id: product_item_id },
		success: function() {
			//$.alert(data);
			loadCart();
			setTimeout(function() {
				cartHeader();
			}, 100);
		}
	});
});

//To Update The cart
function UpdateCart(item_quantity, product_item_id) {
	$.ajax({
		url: "UpdateCart",
		type: "POST",
		data: { product_item_id: product_item_id, item_quantity: item_quantity },
		success: function() {
			setTimeout(function() {
				loadCart();
			}, 100);
		}
	});
}

$(document).on('focusin', '#managequantity input', function() {
	if ($(this).val() <= 15) {
		$(this).data('oldquantity', $(this).val());
	}
}).on('change', '#managequantity input', function() {
	let prev = $(this).data('oldquantity');
	let current = $(this).val();
	if (current > 15) {
		$.alert("<small>Item Quantity Should be Less Than Or Equal To <b>15</b></small>");
	} else {
		let product_item_id = $(this).data("piid");
		let difference = current - prev;
		UpdateCart(difference, product_item_id);
	}
});

$(document).ready(function() {
	$(".FilterColors").parent().addClass("d-flex");
	$(".FilterColors").parent().addClass("flex-wrap");
	$(".FilterColors").parent().addClass("justify-content-center");
});