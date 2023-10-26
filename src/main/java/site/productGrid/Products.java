package site.productGrid;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;

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
 * Servlet implementation class Products
 */
@WebServlet("/Products")
public class Products extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Products() {
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
			// Parameters
			String category_id = request.getParameter("category_id");
			String sort = request.getParameter("search");
			String p_no = request.getParameter("page_no");
			String minPrice = null;
			String maxPrice = null;
			if (request.getParameter("minPrice") != null && request.getParameter("maxPrice") != null) {
				minPrice = request.getParameter("minPrice");
				maxPrice = request.getParameter("maxPrice");
			}

			// brand Filtering
			String brands[] = null;
			boolean isBrand = false;
			if (request.getParameter("brands") != null) {
				brands = request.getParameter("brands").split(",");
				isBrand = true;
			}

			String variationsFilter[] = null;
			boolean isVartationFilter = false;
			if (request.getParameter("variations") != null) {
				variationsFilter = request.getParameter("variations").split(",");
				isVartationFilter = true;
			}

			// Pagination Properties
			int LIMIT = SiteConstants.PRODUCT_RS_GRID_SIZE;
			int page;
			if (p_no != null) {
				page = Integer.parseInt(p_no);
			} else {
				page = 1;
			}

			int OFFSET = (page - 1) * LIMIT;

			boolean PRODUCT_FLAG = false;

			if (sort != null) {
				if (sort.equals("Acending")) {
					PRODUCT_FLAG = true;
				} else if (sort.equals("Descending")) {
					PRODUCT_FLAG = true;
				}
			}

			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps;
			ResultSet rs, rs1, rs2, rs3;
			Map<String, Integer> productItems = new TreeMap<>();

			String SQL = "SELECT product_id FROM product WHERE category_id=? ";
			if (isBrand) {
				SQL += " AND brand_id IN(";
				for (int brand = 0; brand < brands.length; brand++) {
					if (brand == brands.length - 1) {
						SQL += brands[brand];
					} else {
						SQL += brands[brand] + ",";
					}
				}
				SQL += ")";
			}
			SQL += " LIMIT " + OFFSET + "," + LIMIT;

			ps = cn.prepareStatement(SQL);
			ps.setString(1, category_id);
			rs = ps.executeQuery();
			if (isVartationFilter) {
				SQL = "SELECT PI.product_item_id,PI.item_selling_price,P.product_name FROM product_item PI INNER JOIN product P ON PI.product_id=P.product_id INNER JOIN product_variation_mapping PVM ON PVM.product_item_id=PI.product_item_id INNER JOIN variation_options VO ON PVM.variation_option_id=VO.variation_option_id INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id WHERE Active=true AND PI.product_id=? AND VCV.var_value IN (";
				for (int var = 0; var < variationsFilter.length; var++) {
					if (var == variationsFilter.length - 1) {
						SQL += "'" + variationsFilter[var] + "'";
					} else {
						SQL += "'" + variationsFilter[var] + "',";
					}
				}
				SQL += ") AND PI.item_selling_price BETWEEN ? AND ?  ORDER BY RAND() LIMIT 1;";
			} else if (minPrice != null && maxPrice != null) {
				SQL = "SELECT PI.product_item_id,PI.item_selling_price,P.product_name FROM product_item PI INNER JOIN product P ON PI.product_id=P.product_id WHERE Active=true AND PI.product_id=? AND PI.item_selling_price BETWEEN ? AND ?  ORDER BY RAND() LIMIT 1";
			} else {
				SQL = "SELECT PI.product_item_id,PI.item_selling_price,P.product_name FROM product_item PI INNER JOIN product P ON PI.product_id=P.product_id WHERE Active=true AND PI.product_id=? ORDER BY RAND() LIMIT 1";
			}

			while (rs.next()) {
				ps = cn.prepareStatement(SQL);
				ps.setInt(1, rs.getInt("product_id"));
				if (minPrice != null && maxPrice != null) {
					ps.setString(2, minPrice);
					ps.setString(3, maxPrice);
				}
				rs1 = ps.executeQuery();
				while (rs1.next()) {

					if (PRODUCT_FLAG) {
						productItems.put(rs1.getString("product_name"), rs1.getInt("product_item_id"));
					} else {
						productItems.put(rs1.getString("product_item_id"), rs1.getInt("item_selling_price"));
					}
				}
			}

			if (sort != null) {
				if (sort.equals("Low")) {
					productItems = productItems.entrySet().stream()
							.sorted(Map.Entry.<String, Integer>comparingByValue())
							.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue,
									(oldValue, newValue) -> oldValue, LinkedHashMap::new));
				} else if (sort.equals("High")) {
					productItems = productItems.entrySet().stream()
							.sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
							.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue,
									(oldValue, newValue) -> oldValue, LinkedHashMap::new));
				} else if (sort.equals("Acending")) {
					productItems = productItems.entrySet().stream().sorted(Map.Entry.<String, Integer>comparingByKey())
							.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue,
									(oldValue, newValue) -> oldValue, LinkedHashMap::new));

				} else if (sort.equals("Descending")) {
					productItems = productItems.entrySet().stream()
							.sorted(Map.Entry.<String, Integer>comparingByKey().reversed())
							.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue,
									(oldValue, newValue) -> oldValue, LinkedHashMap::new));
				}
			}
			out.print("<div class='row mx-n2'>");

			int banner = 1;
			for (Map.Entry<String, Integer> item : productItems.entrySet()) {

				SQL = "SELECT P.*,PI.item_listing_price,PI.item_selling_price,PI.product_item_id,PI.item_quantity,PC.category_name,B.brand_name FROM product_item PI INNER JOIN product P ON PI.product_id=P.product_id INNER JOIN product_categories PC ON PC.category_id=P.category_id INNER JOIN brands B ON P.brand_id=B.brand_id WHERE PI.product_item_id=? AND PI.Active=?";
				ps = cn.prepareStatement(SQL, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				if (PRODUCT_FLAG) {
					ps.setInt(1, item.getValue());
				} else {
					ps.setString(1, item.getKey());
				}
				ps.setBoolean(2, true);
				rs = ps.executeQuery();
				rs.next();

				ps = cn.prepareStatement(
						"SELECT PM.map_id FROM product_variation_mapping PM INNER JOIN variation_options VO ON PM.variation_option_id=VO.variation_option_id INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation_combo VC ON VCV.var_id=VC.var_id WHERE product_item_id=? and VC.var_name IN('COLOR')");
				ps.setString(1, rs.getString("product_item_id"));
				rs2 = ps.executeQuery();
				rs2.next();
				ps = cn.prepareStatement("SELECT * FROM product_item_images WHERE map_id=? LIMIT 1");
				ps.setString(1, rs2.getString("map_id"));
				rs3 = ps.executeQuery();
				rs3.next();
				int percentage = GetPercantege.getPercantage(rs.getInt("item_listing_price"),
						rs.getInt("item_selling_price"));

				// Product
				out.print("<div class='col-md-4 col-sm-6 px-2 mb-4'>");
				out.print("<div class='card product-card'>");
				if (rs.getInt("item_quantity") <= SiteConstants.STOCK_LEFT_MESSAGE_BADGE_AT
						&& rs.getInt("item_quantity") >= 1) {
					out.print("<span class='badge bg-danger badge-shadow'><i class='bi bi-graph-up'></i> "
							+ rs.getInt("item_quantity") + " Left</span>");
				} else if (percentage >= SiteConstants.MINIMUM_DISCOUNT_RATE_BADGE
						&& percentage <= SiteConstants.MAXIMUM_DISCOUNT_RATE_BADGE) {
					out.print("<span class='badge bg-success badge-shadow'>" + percentage + "% off</span>");
				}

				out.print(
						"<button class='btn-wishlist btn-sm' type='button' data-bs-toggle='tooltip' data-bs-placement='left' title='Add to wishlist'><i class='ci-heart'></i></button>");
				out.print("<a class='card-img-top d-block overflow-hidden image-wrapper' href='product-view.jsp?pid="
						+ rs.getString("product_id") + "&piid=" + rs.getString("product_item_id")
						+ "'><img src=\"img/shop/products/" + rs3.getString("image_name") + "\" alt='"
						+ rs.getString("product_name")
						+ "' style='object-fit: scale-down; height: 250px; width: inherit;' id='productimage"
						+ rs.getString("product_id") + "'></a>");
				out.print("<div class='card-body py-2'>");
				out.print("<a class='product-meta d-block fs-xs pb-1' href='products-rs.jsp?bid="
						+ rs.getString("brand_id") + "'>" + rs.getString("brand_name")
						+ "</a><h3 class='product-title fs-sm'><a href='product-view.jsp?pid="
						+ rs.getString("product_id") + "^ppid=" + rs.getString("product_item_id") + "'>"
						+ rs.getString("product_name") + "</a></h3>");
				out.print(
						"<div class='d-flex justify-content-between'><div class='product-price'><span class='text-accent'>"
								+ FormatPrice.formatPrice(rs.getString("item_selling_price")) + "</span> ");
				out.print("<del class='fs-sm text-muted'><small>"
						+ FormatPrice.formatPrice(rs.getString("item_listing_price")) + "</small></del>");
				out.print("</div>");
				out.print("<div class='star-rating'>");
				out.print("<i class='star-rating-icon ci-star-filled active'>");
				out.print("</i><i class='star-rating-icon ci-star-filled active'>");
				out.print("</i><i class='star-rating-icon ci-star-filled active'>");
				out.print("</i><i class='star-rating-icon ci-star-filled active'>");
				out.print("</i><i class='star-rating-icon ci-star'></i>");
				out.print("</div></div></div>");

				Map<String, Integer> colors = GetProductVariations.getColorVariation(rs.getString("product_id"));
				Map<String, Integer> CapSize = GetProductVariations
						.getSizeCapacityVariation(rs.getString("product_id"));
				Map<String, String> variations = GetProductVariations
						.getAllVariationsFor(rs.getString("product_item_id"));

				String var_name = SiteConstants.VAR_NAME_COMBO;

				// Configuring Layout
				String layoutOption = "";
				if (CapSize != null) {
					if (colors.size() > 1 && CapSize.size() > 1) {
						layoutOption = "1";
					} else if (colors.size() > 1 && CapSize.size() <= 1) {
						layoutOption = "2";
					} else if (colors.size() <= 1 && CapSize.size() > 1) {
						layoutOption = "3";
					} else {
						layoutOption = "4";
					}
				} else {
					if (colors.size() > 1) {
						layoutOption = "2";
					} else {
						layoutOption = "4";
					}
				}

				out.print("<div class='card-body card-body-hidden'>");
				// For Layout Option 1
				if (layoutOption.equals("1")) {
					out.print("<div class='text-center pb-2'>");

					for (Map.Entry<String, Integer> color : colors.entrySet()) {
						String nameVarient = "colorbox" + rs.getString("product_id");
						out.print("<div class='form-check form-option form-check-inline mb-2'>");
						out.print("<input class='form-check-input chcolor' data-pid=" + rs.getString("product_id")
								+ " data-piid=" + color.getValue() + " type='radio' name='" + nameVarient + "' id='"
								+ nameVarient + color.getKey() + "' value='" + color.getKey() + "' ");
						for (Map.Entry<String, String> variation : variations.entrySet()) {
							if (color.getKey().equals(variation.getValue())) {
								out.print(" checked");
							}
						}
						out.print("> <label	class='form-option-label rounded-circle' for='" + nameVarient
								+ color.getKey()
								+ "'><span class='form-option-color rounded-circle'	style='background-color: "
								+ color.getKey().replaceAll("\\s", "") + "'></span></label></div>");
					}
					out.print("</div>");

					String nameSelect = "combobox" + rs.getString("product_id");
					out.print("<div class='d-flex mb-2'><select id='" + nameSelect
							+ "' class='form-select form-select-sm me-2' onchange='changeImage(this.value,"
							+ rs.getString("product_id") + ")'	name='" + nameSelect + "'>");

					out.print("<option value=''>Select " + var_name + "</option>");

					for (Map.Entry<String, Integer> size : CapSize.entrySet()) {
						out.print("<option value='" + size.getKey() + "' ");
						for (Map.Entry<String, String> variation : variations.entrySet()) {
							if (size.getKey().equals(variation.getValue())) {
								out.print(" selected");
							}
						}
						out.print(">" + size.getKey() + "</option>");
					}
					out.print("</select>");

					// Add To Cart
					if (SiteConstants.ADD_TO_CART_ON_GRID_LIST) {
						out.print("<button class='btn btn-primary btn-sm add-to-cart' data-pid="
								+ rs.getString("product_id")
								+ " type='button'><i class='ci-cart fs-sm me-1'></i>Add to Cart</button>");
					}
					out.print("</div><div class='text-center'><a class='nav-link-style fs-ms quick' data-pid="
							+ rs.getString("product_id") + " data-piid=" + rs.getString("product_item_id")
							+ " href='#quick-view' data-bs-toggle='modal'><i class='ci-eye align-middle me-1'></i>Quick view</a></div>");
				} else if (layoutOption.equals("2")) {
					out.print("<div class='text-center pb-2'>");

					for (Map.Entry<String, Integer> color : colors.entrySet()) {
						String nameVarient = "colorbox" + rs.getString("product_id");
						out.print("<div class='form-check form-option form-check-inline mb-2'>");
						out.print("<input class='form-check-input chcolor' data-pid=" + rs.getString("product_id")
								+ " data-piid=" + color.getValue() + " type='radio' value='" + color.getKey()
								+ "' name='" + nameVarient + "' id='" + nameVarient + color.getKey() + "' ");
						for (Map.Entry<String, String> variation : variations.entrySet()) {
							if (color.getKey().equals(variation.getValue())) {
								out.print(" checked");
							}
						}
						out.print("> <label	class='form-option-label rounded-circle' for='" + nameVarient
								+ color.getKey()
								+ "'><span class='form-option-color rounded-circle'	style='background-color: "
								+ color.getKey().replaceAll("\\s", "") + "'></span></label></div>");
					}
					// for image changing feature
					out.print("<div class='d-none'>");
					if (CapSize != null) {
						for (Map.Entry<String, Integer> size : CapSize.entrySet()) {
							out.print("<input type='radio' name='combobox" + rs.getString("product_id") + "' value='"
									+ size.getKey() + "' checked/>");
						}
					} else {
						out.print("<input type='radio' name='combobox" + rs.getString("product_id")
								+ "' value='' checked/>");
					}
					out.print("</div>");
					out.print("</div>");

					// Add To Cart Button
					if (SiteConstants.ADD_TO_CART_ON_GRID_LIST) {
						out.print("<button class='btn btn-primary btn-sm d-block w-100 mb-2 add-to-cart' data-pid="
								+ rs.getString("product_id")
								+ " type='button'><i class='ci-cart fs-sm me-1'></i>Add to Cart</button>");
					}

					out.print("<div class='text-center'><a class='nav-link-style fs-ms quick' data-pid="
							+ rs.getString("product_id") + " data-piid=" + rs.getString("product_item_id")
							+ " href='#quick-view'	data-bs-toggle='modal'><i class='ci-eye align-middle me-1'></i>Quick view</a></div>");
				} else if (layoutOption.equals("3")) {
					out.print("<div class='text-center pb-2'>");

					for (Map.Entry<String, Integer> size : CapSize.entrySet()) {
						String nameVarient = "combobox" + rs.getString("product_id");
						out.print(
								"<div class='form-check form-option form-check-inline mb-2'><input class='form-check-input chsize' data-pid="
										+ rs.getString("product_id") + " data-piid=" + size.getValue()
										+ " type='radio' name='" + nameVarient + "' value='" + size.getKey() + "' id='"
										+ nameVarient + size.getKey() + "' ");
						for (Map.Entry<String, String> variation : variations.entrySet()) {
							if (size.getKey().equals(variation.getValue())) {
								out.print(" checked");
							}
						}
						out.print("> <label class='form-option-label' for='" + nameVarient + size.getKey() + "'>"
								+ size.getKey() + "</label></div>");
					}

					// for image changing feature
					out.print("<div class='d-none'>");
					for (Map.Entry<String, Integer> color : colors.entrySet()) {
						out.print("<input type='radio' name='colorbox" + rs.getString("product_id") + "' value='"
								+ color.getKey() + "' checked/>");
					}
					out.print("</div>");

					out.print("</div>");

//					Add To Cart
					if (SiteConstants.ADD_TO_CART_ON_GRID_LIST) {
						out.print("<button class='btn btn-primary btn-sm d-block w-100 mb-2 add-to-cart' data-pid="
								+ rs.getString("product_id")
								+ " type='button'><i class='ci-cart fs-sm me-1'></i>Add to Cart</button>");
					}

					out.print("<div class='text-center'><a class='nav-link-style fs-ms quick' data-pid="
							+ rs.getString("product_id") + " data-piid=" + rs.getString("product_item_id")
							+ " href='#quick-view' data-bs-toggle='modal'><i class='ci-eye align-middle me-1'></i>Quick view</a></div>");
				} else if (layoutOption.equals("4")) {
					if (SiteConstants.ADD_TO_CART_ON_GRID_LIST) {
						out.print("<button class='btn btn-primary btn-sm d-block w-100 mb-2 add-to-cart' data-pid="
								+ rs.getString("product_id")
								+ " type='button'><i class='ci-cart fs-sm me-1'></i>Add to Cart</button>");
					}

					// product item id
					out.print("<div class='d-none'>");
					if (CapSize != null) {
						for (Map.Entry<String, Integer> size : CapSize.entrySet()) {
							out.print("<input type='radio' name='combobox" + rs.getString("product_id") + "' value='"
									+ size.getKey() + "' />");
						}
					} else {
						out.print("<input type='radio' name='combobox" + rs.getString("product_id") + "' value='' />");
					}
					for (Map.Entry<String, Integer> color : colors.entrySet()) {
						out.print("<input type='radio' name='colorbox" + rs.getString("product_id") + "' value='"
								+ color.getKey() + "' />");
					}
					out.print("</div>");

					out.print("<div class='text-center'><a class='nav-link-style fs-ms quick' data-pid="
							+ rs.getString("product_id") + " data-piid=" + rs.getString("product_item_id")
							+ " href='#quick-view' data-bs-toggle='modal'><i class='ci-eye align-middle me-1'></i>Quick view</a></div>");
				}
				out.print("<input type='hidden' id='currentProduct" + rs.getString("product_id") + "' value='"
						+ rs.getString("product_item_id") + "' />");
				out.print("</div></div><hr class='d-sm-none'></div>");

				if ((LIMIT / 2) == (banner)) {
					out.print(
							"<div class='py-sm-2'><div class='d-sm-flex justify-content-between align-items-center bg-secondary overflow-hidden mb-4 rounded-3'>");
					out.print("<div class='py-4 my-2 my-md-0 py-md-5 px-4 ms-md-3 text-center text-sm-start'>");
					out.print("<h4 class='fs-lg fw-light mb-2'>Converse All Star</h4>");
					out.print("<h3 class='mb-4'>Make Your Day Comfortable</h3>");
					out.print("<a class='btn btn-primary btn-shadow btn-sm' href='#'>Shop Now</a>");
					out.print(
							"</div><img class='d-block ms-auto' src='img/shop/catalog/banner.jpg' alt='Shop Converse'></div></div>");
				}
				banner++;

			}
			out.print("</div>");

			out.print("	<hr class='my-3'>");

			// Pagination
			SQL = "SELECT COUNT(product_id) FROM product WHERE category_id=? ";

			if (isBrand) {
				SQL += " AND brand_id IN(";
				for (int brand = 0; brand < brands.length; brand++) {
					if (brand == brands.length - 1) {
						SQL += brands[brand];
					} else {
						SQL += brands[brand] + ",";
					}
				}
				SQL += ")";
			}

			ps = cn.prepareStatement(SQL);
			ps.setString(1, category_id);
			rs = ps.executeQuery();

			rs.next();
			double TOTAL_RECORDS = rs.getInt(1);
			int TOTAL_PAGES = (int) Math.ceil(TOTAL_RECORDS / LIMIT);

			out.print("<nav class='d-flex justify-content-between pt-2'");
			out.print("aria-label='Page navigation'>");
			if (page != 1) {
				out.print("<ul class='pagination' id='previouspage'>");
				out.print("<li class='page-item'><a class='page-link' data-page='" + (page - 1) + "' href=''><i");
				out.print(" class='ci-arrow-left me-2'></i>Prev</a></li>");
				out.print("</ul>");
			}

			out.print("<ul class='pagination' id='pagination'>");
			out.print("<li class='page-item d-sm-none'><span");
			out.print(" class='page-link page-link-static'>" + page + " / " + TOTAL_PAGES + "</span></li>");

			for (int i = 1; i <= TOTAL_PAGES; i++) {
				out.print("<li class='page-item d-none d-sm-block");
				if (page == i) {
					out.print(" active ");
				}
				out.print("' aria-current='page'>");
				if (page == i) {
					out.print("<span class='page-link'>" + i + "<span class='visually-hidden'>(current)</span></span>");

				} else {
					out.print("<a class='page-link' href='' id='" + i + "'>" + i + "</a>");
				}
				out.print("</li>");
			}
			out.print("<input type='hidden' id='currentpage' value='" + page + "'/>");
			out.print("<input type='hidden' id='maxpages' value='" + TOTAL_PAGES + "' />");
			out.print("</ul>");

			if (page != TOTAL_PAGES) {
				out.print("<ul class='pagination' id='nextpage'>");
				out.print("<li class='page-item'><a class='page-link' data-page=" + (page + 1) + " href='' ");
				out.print(" aria-label='Next'>Next<i class='ci-arrow-right ms-2'></i></a></li>");
				out.print("</ul>");
			}
			out.print("</nav>");

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
