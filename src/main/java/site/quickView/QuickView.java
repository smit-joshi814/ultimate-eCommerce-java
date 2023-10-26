package site.quickView;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conModule.ConnectionProvider;
import generalModule.FormatPrice;
import generalModule.GetPercantege;
import generalModule.SiteConstants;
import product.GetProductVariations;

/**
 * Servlet implementation class QuickView
 */
@WebServlet("/QuickView")
public class QuickView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public QuickView() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()) {
			String product_id = request.getParameter("product_id");
			String product_item_id = request.getParameter("product_item_id");
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement(
					"SELECT P.*,PI.item_listing_price,PI.item_selling_price,PI.product_item_id,PI.item_quantity,PC.category_name FROM product P INNER JOIN product_item PI ON p.product_id=PI.product_id INNER JOIN product_categories PC ON P.category_id=PC.category_id WHERE P.product_id=? AND PI.product_item_id=?");
			ps.setString(1, product_id);
			ps.setString(2, product_item_id);
			ResultSet rs = ps.executeQuery();
			rs.next();

			// Modal Heading
			out.print("<div class='modal-dialog modal-xl'>");
			out.print("<div class='modal-content'>");
			out.print("<div class='modal-header'>");
			out.print("<h4 class='modal-title product-title'>");
			out.print("<a href='product-view.jsp?pid=" + product_id + "&piid=" + product_item_id
					+ "' data-bs-toggle='tooltip' data-bs-placement='right' title='Go to product page'>"
					+ rs.getString("product_name") + "<i class='ci-arrow-right fs-lg ms-2'></i></a>");
			out.print("</h4>");
			out.print(
					"<button class='btn-close' type='button' data-bs-dismiss='modal'	aria-label='Close'></button></div>");

			// Modal Body
			// Product Images
			List<String> images = GetProductVariations.getProductItemImagesFor(product_item_id);

			// Getting All The Available Variations For This Item
			Map<String, String> variations = GetProductVariations.getAllVariationsFor(rs.getString("product_item_id"));

			// Color Variations
			Map<String, Integer> colors = GetProductVariations.getColorVariation(product_id);

			// Size Variation
			Map<String, Integer> capSize = GetProductVariations.getSizeCapacityVariation(product_id);

			out.print("<div class='modal-body'>");
			out.print("<div class='row'>");

			// Product Images
			out.print("<div class='col-lg-7 pe-lg-0'>");

			// Start Product gallery

			out.print("<div id='quickviewimages' class='carousel carousel-dark slide' data-bs-ride='carousel'>");

			out.print("<div class='carousel-indicators'>");
			for (int i = 0; i < images.size(); i++) {
				out.print("<button type='button' data-bs-target='#quickviewimages' data-bs-slide-to='" + i + "'");
				if (i == 0) {
					out.print(" class='active' ");
				}
				out.print("></button>");
			}
			out.print("</div>");

			out.print("<div class='carousel-inner'>");

			for (int i = 0; i < images.size(); i++) {
				String path = images.get(i);
				out.print("<div class='carousel-item");
				if (i == 0) {
					out.print(" active");
				}
				out.print("' data-bs-interval='3000' >");
				out.print("<img src=\"img/shop/products/" + path
						+ "\" class='d-block w-100 rounded-3' alt='...' style='max-height:600px;object-fit:scale-down;'>");
				out.print("</div>");
			}
			out.print("</div>");

			out.print(
					"<button class='carousel-control-prev' type='button' data-bs-target='#quickviewimages' data-bs-slide='prev'>");
			out.print("<span class='carousel-control-prev-icon' aria-hidden='true'></span>");
			out.print("<span class='visually-hidden'>Previous</span>");
			out.print("</button>");
			out.print(
					"<button class='carousel-control-next' type='button' data-bs-target='#quickviewimages' data-bs-slide='next'>");
			out.print("<span class='carousel-control-next-icon' aria-hidden='true'></span>");
			out.print("<span class='visually-hidden'>Next</span>");
			out.print("</button>");
			out.print("</div>");

			///

//			out.print("<div class='product-gallery'>");
//			out.print("<div class='product-gallery-preview order-sm-2'>");
//			for (int i = 0; i < images.size(); i++) {
//				String path = images.get(i);
//				out.print("<div class='product-gallery-preview-item");
//				if (i == 0) {
//					out.print(" active");
//				}
//				out.print("' id='img" + (i + 1) + "'>");
//				out.print("<img class='image-zoom' src='img/shop/products/" + path + "'	data-zoom='img/shop/products/"
//						+ path + "' alt='Product " + (i + 1) + " image'>");
//				out.print("<div class='image-zoom-pane'></div>");
//				out.print("</div>");
//			}
//			out.print("</div>");
//
//			out.print("<div class='product-gallery-thumblist order-sm-1'>");
//			for (int i = 0; i < images.size(); i++) {
//				String path = images.get(i);
//				out.print("<a class='product-gallery-thumblist-item");
//				if (i == 0) {
//					out.print(" active");
//				}
//				out.print("' href='#img" + (i + 1) + "'>");
//				out.print("<img src='img/shop/products/" + path + "' alt='Product " + (i + 1) + " thumb'></a>");
//			}
//			out.print("</div>");
//			out.print("</div>");

			// End Product Gallery

			out.print("</div>");

			// Product Details

			out.print("<div class='col-lg-5 pt-4 pt-lg-0 image-zoom-pane'>");
			out.print("<div class='product-details ms-auto pb-3'>");
			out.print("<div class='d-flex justify-content-between align-items-center mb-2'>");
			out.print("<a href='product-view.jsp?pid=" + product_id + "&piid=" + product_item_id + "#reviews'>");
			out.print("<div class='star-rating'>");
			out.print("<i class='star-rating-icon ci-star-filled active'></i>");
			out.print("<i class='star-rating-icon ci-star-filled active'></i>");
			out.print("<i class='star-rating-icon ci-star-filled active'></i>");
			out.print("<i class='star-rating-icon ci-star-filled active'></i>");
			out.print("<i class='star-rating-icon ci-star'></i>");
			out.print(
					"</div><span class='d-inline-block fs-sm text-body align-middle mt-1 ms-1'>74	Reviews</span></a>");
			out.print(
					"<button class='btn-wishlist' type='button' data-bs-toggle='tooltip' title='Add to wishlist'><i class='ci-heart'></i></button></div>");
			out.print("<div class='mb-3'>");
			out.print("<span class='h3 fw-normal text-accent me-1'>"
					+ FormatPrice.formatPrice(rs.getString("item_selling_price")) + "</span> ");
			out.print("<del class='text-muted fs-lg me-3'>"
					+ FormatPrice.formatPrice(rs.getString("item_listing_price")) + "</del>");
			out.print("<span class='badge bg-success badge-shadow align-middle mt-n2'>"
					+ GetPercantege.getPercantage(rs.getInt("item_listing_price"), rs.getInt("item_selling_price"))
					+ "% off</span>");
			out.print("</div>");

			// Color Variations
			String colorval = "";
			int item_quantity = rs.getInt("item_quantity");
			if (colors.size() >= 1) {

				out.print("<div class='position-relative fs-sm mb-4'>");
				out.print(
						"<span class='text-heading fw-medium me-1'>Color: </span><span class='text-muted' id='colorOptionText'>");
				int i = 0;

				for (Map.Entry<String, Integer> color : colors.entrySet()) {
					out.print(color.getKey());
					colorval = color.getKey();
					if (colors.size() - 1 != i) {
						out.print(" / ");
					}
					i++;
				}
				out.print("</span>");
				if (item_quantity >= 40) {
					out.print(
							"<div class='product-badge product-available mt-n1'><i class='ci-security-check'></i> Product available</div>");
				} else if (item_quantity > 30) {
					out.print(
							"<div class='bg-warning product-badge product-available mt-n1'><i class='bi bi-exclamation-triangle'></i> Product available</div>");
				} else if (item_quantity <= SiteConstants.STOCK_LEFT_MESSAGE_BADGE_AT && item_quantity >= 1) {
					out.print(
							"<div class='bg-danger product-badge product-available mt-n1'><i class='bi bi-graph-up'></i> Hurry Up, Only <b>"
									+ item_quantity + "</b> Left</div>");
				} else if (item_quantity < 1) {
					out.print(
							"<div class='bg-danger product-badge product-available mt-n1'><i class='bi bi-x-square'></i> Product Is Out Of Stock</div>");
				}
				out.print("</div>");
			}
			out.print("<div class='position-relative me-n4 mb-3'>");

			// Colors
			if (colors.size() > 1) {

				for (Map.Entry<String, Integer> color : colors.entrySet()) {
					String nameVarient = "colorqv" + product_id;
					out.print("<div class='form-check form-option form-check-inline mb-2'>");
					out.print("<input class='form-check-input qvchcolor' data-pid=" + product_id + " data-piid="
							+ color.getValue() + " type='radio' name='colorinputqv' id='"
							+ (nameVarient + color.getKey()) + "' value='" + color.getKey() + "' ");
					for (Map.Entry<String, String> variation : variations.entrySet()) {
						if (color.getKey().equals(variation.getValue())) {
							out.print(" checked");
						}
					}
					out.print(">");
					out.print("<label class='form-option-label rounded-circle' for='" + (nameVarient + color.getKey())
							+ "'>");
					out.print("<span class='form-option-color rounded-circle' style='background-color:" + color.getKey()
							+ "'></span></label>");
					out.print("</div>");
				}
			} else if (colors.size() == 1) {
				out.print(
						"<input class='d-none' type='radio' name='colorinputqv'	value='" + colorval + "' checked />");
			}
			out.print("</div>");
			out.print("<form class='mb-grid-gutter'>");
			out.print("<div class='mb-3'>");

			// Size Variation
			if (capSize != null) {
				out.print("<label class='fw-medium pb-1' for='product-size'>Size: ");
				if (capSize.size() == 1) {
					for (Map.Entry<String, Integer> size : capSize.entrySet()) {
						out.print(size.getKey());
						out.print("<div class='d-none'><select id='product-sizeqv'><option value='" + size.getKey()
								+ "' selected>" + size.getKey() + "</option></select></div>");
					}
				}
				out.print("</label>");
				if (capSize.size() > 1) {
					String nameSelect = "quickComboSize" + product_id;
					out.print("<select class='form-select' required id='product-sizeqv' name='" + nameSelect
							+ "' onchange='passProductIdForQuickView(" + product_id + ")'>");
					out.print("<option value=''>Select size</option>");
					for (Map.Entry<String, Integer> size : capSize.entrySet()) {
						out.print("<option value='" + size.getKey() + "' ");
						for (Map.Entry<String, String> variation : variations.entrySet()) {
							if (size.getKey().equals(variation.getValue())) {
								out.print(" selected");
							}
						}
						out.print(">" + size.getKey() + "</option>");
					}
					out.print("</select>");
				}
			} else {
				out.print(
						"<div class='d-none'><select id='product-sizeqv'><option value='' selected>''</option></select></div>");
			}

			out.print("</div><div class='mb-3 d-flex align-items-center'>");
			out.print("<select class='form-select me-3' style='width: 5rem;'>");
			out.print("<option value='1'>1</option>");
			out.print("<option value='2'>2</option>");
			out.print("<option value='3'>3</option>");
			out.print("<option value='4'>4</option>");
			out.print("<option value='5'>5</option>");
			out.print("</select>");
			out.print("<button class='btn btn-primary btn-shadow d-block w-100 add-to-cart' data-pid=" + product_id
					+ " data-piid=" + product_item_id + " type='button' ");
			if (item_quantity == 0) {
				out.print("disabled");
			}
			out.print("><i class='ci-cart fs-lg me-2'></i>Add to Cart</button>");
			out.print("</div></form>");
			out.print("<h5 class='h6 mb-3 pb-2 border-bottom'>");
			out.print("<i class='ci-announcement text-muted fs-lg align-middle mt-n1 me-2'></i>Product	info</h5>");

			out.print("<ul class='fs-sm list-group list-group-flush'>");
			for (Map.Entry<String, String> variation : variations.entrySet()) {
				out.print("<li class='list-group-item'><b>" + variation.getKey() + "</b> : " + variation.getValue()
						+ "</li>");
			}
			out.print("</ul>");
			out.print("</div></div></div></div></div></div>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
