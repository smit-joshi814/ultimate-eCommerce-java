
<%@page import="generalModule.SiteConstants"%>
<footer class="footer bg-dark pt-5">
	<div class="container">
		<div class="row pb-2">
			<div class="col-md-4 col-sm-6">
				<div class="widget widget-links widget-light pb-2 mb-4">
					<h3 class="widget-title text-light">About us</h3>
					<ul class="widget-list">
						<li class="widget-list-item"><a class="widget-list-link"
							href="#">About company</a></li>
						<li class="widget-list-item"><a class="widget-list-link"
							href="#">Our team</a></li>
						<li class="widget-list-item"><a class="widget-list-link"
							href="#">Careers</a></li>
						<li class="widget-list-item"><a class="widget-list-link"
							href="#">News</a></li>
					</ul>
				</div>
			</div>
			<div class="col-md-4 col-sm-6">
				<div class="widget widget-links widget-light pb-2 mb-4">
					<h3 class="widget-title text-light">Account &amp; shipping
						info</h3>
					<ul class="widget-list">
						<li class="widget-list-item"><a class="widget-list-link"
							href="#">Your account</a></li>
						<li class="widget-list-item"><a class="widget-list-link"
							href="#">Shipping rates &amp; policies</a></li>
						<li class="widget-list-item"><a class="widget-list-link"
							href="#">Refunds &amp; replacements</a></li>
						<li class="widget-list-item"><a class="widget-list-link"
							href="#">Order tracking</a></li>
						<li class="widget-list-item"><a class="widget-list-link"
							href="#">Delivery info</a></li>
						<li class="widget-list-item"><a class="widget-list-link"
							href="#">Taxes &amp; fees</a></li>
					</ul>
				</div>
			</div>
			<div class="col-md-4">
				<div class="widget pb-2 mb-4">
					<h3 class="widget-title text-light pb-1">Stay informed</h3>
					<form class="subscription-form validate"
						action="https://studio.us12.list-manage.com/subscribe/post?u=c7103e2c981361a6639545bd5&amp;amp;id=29ca296126"
						method="post" name="mc-embedded-subscribe-form" target="_blank"
						novalidate>
						<div class="input-group flex-nowrap">
							<i
								class="ci-mail position-absolute top-50 translate-middle-y text-muted fs-base ms-3"></i>
							<input class="form-control rounded-start" type="email"
								name="EMAIL" placeholder="Your email" required>
							<button class="btn btn-primary" type="submit" name="subscribe">Subscribe*</button>
						</div>
						<!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
						<div style="position: absolute; left: -5000px;" aria-hidden="true">
							<input class="subscription-form-antispam" type="text"
								name="b_c7103e2c981361a6639545bd5_29ca296126" tabindex="-1">
						</div>
						<div class="form-text text-light opacity-50">*Subscribe to
							our newsletter to receive early discount offers, updates and new
							products info.</div>
						<div class="subscription-status"></div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="pt-5 bg-darker">
		<div class="container">
			<div class="row pb-3">
				<div class="col-md-3 col-sm-6 mb-4">
					<div class="d-flex">
						<i class="ci-rocket text-primary" style="font-size: 2.25rem;"></i>
						<div class="ps-3">
							<h6 class="fs-base text-light mb-1">Fast and free delivery</h6>
							<p class="mb-0 fs-ms text-light opacity-50">Free delivery for
								all orders over $200</p>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 mb-4">
					<div class="d-flex">
						<i class="ci-currency-exchange text-primary"
							style="font-size: 2.25rem;"></i>
						<div class="ps-3">
							<h6 class="fs-base text-light mb-1">Money back guarantee</h6>
							<p class="mb-0 fs-ms text-light opacity-50">We return money
								within 30 days</p>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 mb-4">
					<div class="d-flex">
						<i class="ci-support text-primary" style="font-size: 2.25rem;"></i>
						<div class="ps-3">
							<h6 class="fs-base text-light mb-1">24/7 customer support</h6>
							<p class="mb-0 fs-ms text-light opacity-50">Friendly 24/7
								customer support</p>
						</div>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 mb-4">
					<div class="d-flex">
						<i class="ci-card text-primary" style="font-size: 2.25rem;"></i>
						<div class="ps-3">
							<h6 class="fs-base text-light mb-1">Secure online payment</h6>
							<p class="mb-0 fs-ms text-light opacity-50">We possess SSL /
								Secure сertificate</p>
						</div>
					</div>
				</div>
			</div>
			<hr class="hr-light mb-5">
			<!-- Footer Credits-->
			<div
				class="pb-4 fs-xs text-light opacity-50 text-center text-md-start">
				&copy; All rights reserved. Made by <a class="text-light"
					href="https://resumesmitjoshi.blogspot.com" target="_blank"
					rel="noopener">Smit Joshi</a>
			</div>
			<!-- / Footer Credits -->
		</div>
	</div>
</footer>
<%
if (SiteConstants.HAND_HALD_TOOLBAR) {
	boolean logedIn = false;
	if (session.getAttribute("uid") != null) {
		logedIn = true;
	} else {
		logedIn = false;
	}
%>

<div class="handheld-toolbar">
	<div class="d-table table-layout-fixed w-100">
		<a class="d-table-cell handheld-toolbar-item" href="#"
			data-bs-toggle="offcanvas" data-bs-target="#shop-sidebar"><span
			class="handheld-toolbar-icon" data-bs-toggle="tooltip"
			data-bs-placement="top" title="Filters"><i
				class="ci-filter-alt"></i></span><span class="handheld-toolbar-label">Filters</span></a>
		<%
		if (logedIn) {
		%><a class="d-table-cell handheld-toolbar-item"
			href="account-wishlist.jsp"><span class="handheld-toolbar-icon"
			data-bs-toggle="tooltip" data-bs-placement="top" title="Wishlist"><i
				class="ci-heart"></i></span><span class="handheld-toolbar-label">Wishlist</span></a>
		<%
		}
		%><a class="d-table-cell handheld-toolbar-item" href="shop-cart.jsp"><span
			class="handheld-toolbar-icon" data-bs-toggle="tooltip"
			data-bs-placement="top" title="My Cart"><i class="ci-cart"></i></span></a>
	</div>
</div>
<%
}
%>

<!-- Back To Top Button-->
<a class="btn-scroll-top" id="btn-scroll-top" href="#top" data-scroll><span
	class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i
	class="btn-scroll-top-icon ci-arrow-up"></i></a>

<script src="vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<script src="vendor/simplebar/dist/simplebar.min.js"></script>
<script src="vendor/tiny-slider/dist/min/tiny-slider.js"></script>
<script src="vendor/smooth-scroll/dist/smooth-scroll.polyfills.min.js"></script>
<script src="vendor/prismjs/components/prism-core.min.js"></script>
<script src="vendor/prismjs/components/prism-markup.min.js"></script>
<script src="vendor/prismjs/components/prism-clike.min.js"></script>
<script src="vendor/prismjs/components/prism-javascript.min.js"></script>
<script src="vendor/prismjs/components/prism-pug.min.js"></script>
<script src="vendor/prismjs/plugins/toolbar/prism-toolbar.min.js"></script>
<script
	src="vendor/prismjs/plugins/copy-to-clipboard/prism-copy-to-clipboard.min.js"></script>
<script
	src="vendor/prismjs/plugins/line-numbers/prism-line-numbers.min.js"></script>
<script src="vendor/drift-zoom/dist/Drift.min.js"></script>
<script src="vendor/card/dist/card.js"></script>
<script src="vendor/nouislider/dist/nouislider.min.js"></script>
<script src="vendor/aos/aos.js"></script>
<script src="vendor/lightgallery/lightgallery.min.js"></script>
<script
	src="vendor/lightgallery/plugins/fullscreen/lg-fullscreen.min.js"></script>
<script src="vendor/lightgallery/plugins/zoom/lg-zoom.min.js"></script>
<script src="vendor/lightgallery/plugins/video/lg-video.min.js"></script>
<script src="vendor/chartist/dist/chartist.min.js"></script>
<script src="vendor/flatpickr/dist/flatpickr.min.js"></script>
<script src="vendor/flatpickr/dist/plugins/rangePlugin.js"></script>
<script src="vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
<script src="vendor/shufflejs/dist/shuffle.min.js"></script>
<script src="vendor/jquery/jquery-confirm.min.js"></script>
<script src="js/product.js"></script>

<!-- Main theme script-->
<script src="js/theme.min.js"></script>

<script>
//cart Items On Header
function cartHeader(){
	$.ajax({
		url:"CartItemsOnHeader",
		type:"POST",
		beforeSend: function() {
			$("#cart-items-on-header").html("<div class='d-flex justify-content-center align-items-center mt-2 mb-2 bg-white h-100 w-100'><div class='spinner-border text-primary' role='status'><span class='visually-hidden'>Loading...</span></div></div>");
		},
		success:function(data){
			$("#cart-items-on-header").html(data);
			let cartTotal = $("#cart-total-value").val();
			let cartItems= $("#cart-total-items-value").val();
			if(cartTotal != 0){
				$("#cart-total-value-wrapper").addClass("d-flex");
				$("#cart-total-value-wrapper").fadeIn("slow");
				$("#cart-header-checkout").attr("href","<%if(session.getAttribute("uid")!=null){%>checkout-details.jsp<% }else {%>account-signin.jsp?checkout=true<%}%>");
				$("#cart-header-checkout").html('<i class="ci-card me-2 fs-base align-middle"></i>Checkout');
				$("#cart-item-count-on-header").fadeIn("slow");
				$("#cart-total-value-container").html(cartTotal);
				$("#cart-item-count-on-header").text(cartItems);
				$("#price-label-under-MyCart").html("<small>My Cart</small>"+cartTotal);
			}else{
				$("#cart-total-value-wrapper").removeClass("d-flex");
				$("#cart-total-value-wrapper").hide();
				$("#cart-header-checkout").attr("href","shop-categories.jsp");
				$("#cart-header-checkout").html('<i class="ci-bag me-2 fs-base align-middle"></i>Let\'s Shop');
				$("#cart-item-count-on-header").hide();
				$("#price-label-under-MyCart").html("<small>My Cart</small>");				
			}
		}
	});
}
cartHeader();
</script>


<script>
	AOS.init();
	AOS.init({
		// Global settings:
		disable : false, // accepts following values: 'phone', 'tablet', 'mobile', boolean, expression or function
		startEvent : 'DOMContentLoaded', // name of the event dispatched on the document, that AOS should initialize on
		initClassName : 'aos-init', // class applied after initialization
		animatedClassName : 'aos-animate', // class applied on animation
		useClassNames : false, // if true, will add content of `data-aos` as classes on scroll
		disableMutationObserver : false, // disables automatic mutations' detections (advanced)
		debounceDelay : 50, // the delay on debounce used while resizing window (advanced)
		throttleDelay : 99, // the delay on throttle used while scrolling the page (advanced)

		// Settings that can be overridden on per-element basis, by `data-aos-*` attributes:
		offset : 120, // offset (in px) from the original trigger point
		delay : 0, // values from 0 to 3000, with step 50ms
		duration : 400, // values from 0 to 3000, with step 50ms
		easing : 'ease', // default easing for AOS animations
		once : false, // whether animation should happen only once - while scrolling down
		mirror : false, // whether elements should animate out while scrolling past them
		anchorPlacement : 'top-bottom', // defines which position of the element regarding to window should trigger the animation
	});
</script>
