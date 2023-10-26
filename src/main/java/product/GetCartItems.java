package product;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conModule.ConnectionProvider;
import generalModule.FormatPrice;

/**
 * Servlet implementation class GetCartItems
 */
@WebServlet("/GetCartItems")
public class GetCartItems extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetCartItems() {
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
			ArrayList<Cart> cart = new ArrayList<>();
			HttpSession session = request.getSession();
			int cartTotal = 0;

			if (session.getAttribute("uid") != null) {
				int user_id = Integer.parseInt(session.getAttribute("uid").toString());
				Connection cn = ConnectionProvider.getCon();
				PreparedStatement ps = cn.prepareStatement(
						"SELECT product_item_id,item_quantity FROM shopping_cart_item SCI INNER JOIN shopping_cart SC ON SCI.cart_id=SC.cart_id WHERE SC.user_id=?",
						ResultSet.TYPE_SCROLL_INSENSITIVE);
				ps.setInt(1, user_id);
				ResultSet rs = ps.executeQuery();
				if (rs.isBeforeFirst()) {
					while (rs.next()) {
						cart.add(Product.getCartItems(rs.getInt("product_item_id"), rs.getInt("item_quantity")));
					}
					if (cart.size() != 0) {
						listItems(out, cart);
					}
				} else {
					out.print("<div class='d-flex justify-content-center align-items-center'>");
					out.print("<h6 class='display-6'>Cart Is Empty</h6>");
					out.print("</div>");
					out.print("<input type='hidden' id='cart-page-total' value='" + cartTotal + "' >");
				}
			} else {
				String items = getCookie(request.getCookies(), "cart");
				if (items != null) {
					// creating available item array
					String availabeItems[] = items.split("&");
					// creating two different arrays for storing product_item_id and quantity
					int[] item_ids = new int[availabeItems.length];
					int[] item_quantities = new int[availabeItems.length];

					for (int i = 0; i < availabeItems.length; i++) {
						// splitting string to their relative arrays
						item_ids[i] = Integer.parseInt(availabeItems[i].substring(0, availabeItems[i].indexOf('-')));
						item_quantities[i] = Integer
								.parseInt(availabeItems[i].substring(availabeItems[i].indexOf('-') + 1));
						cart.add(Product.getCartItems(item_ids[i], item_quantities[i]));
					}

					if (cart.size() != 0) {
						listItems(out, cart);
					}
				} else {
					out.print("<div class='d-flex justify-content-center align-items-center'>");
					out.print("<h6 class='display-6'>Cart Is Empty</h6>");
					out.print("</div>");
					out.print("<input type='hidden' id='cart-page-total' value='" + cartTotal + "' >");
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private String getCookie(Cookie[] items, String cookie_name) {
		for (Cookie item : items) {
			if (item.getName().equals(cookie_name)) {
				return item.getValue();
			}
		}
		return null;
	}

	private void listItems(PrintWriter out, ArrayList<Cart> cart) {
		int cartTotal = 0;
		for (Cart item : cart) {
			String[] option = new String[2];
			boolean islimitedItems = false;
			if (item.getStock_items() > 0 && item.getStock_items() < item.getProduct_quantity()) {
				item.setProduct_quantity(item.getStock_items());
				item.setProduct_final_price();
				islimitedItems = true;
			}
			out.print("<div class='d-sm-flex justify-content-between align-items-center my-2 pb-3 border-bottom'>");
			out.print("<div class='d-block d-sm-flex align-items-center text-center text-sm-start'>");
			out.print("<a class='d-inline-block flex-shrink-0 mx-auto me-sm-4' href='product-view.jsp?pid="
					+ item.getProduct_id() + "&piid=" + item.getProduct_item_id() + "'>");
			out.print("<img src=\"" + item.getProduct_item_image_path() + "\"	width='160' alt='"
					+ item.getProduct_name() + "'></a>");
			out.print("<div class='pt-2'><h3 class='product-title fs-base mb-2'>");
			out.print("<a href='product-view.jsp?pid=" + item.getProduct_id() + "&piid=" + item.getProduct_item_id()
					+ "'>" + item.getProduct_name() + "</a></h3>");

			option = item.getOption3();

			out.print("<div class='fs-sm'><span class='text-muted me-2'>" + option[0] + " : </span> " + option[1]);
			out.print("</div><div class='fs-sm'>");
			option = item.getOption4();
			out.print("<span class='text-muted me-2'>" + option[0] + " : </span> " + option[1]);
			out.print("</div>");
			out.print("<div class='fs-lg text-accent pt-2'>");
			out.print(FormatPrice.formatPrice(item.getProduct_price() + "") + "<small class='text-dark'> x "
					+ item.getProduct_quantity() + "</small>");
			out.print("</div></div></div>");

			out.print(
					"<div class='pt-2 pt-sm-0 ps-sm-3 mx-auto mx-sm-0 text-center text-sm-start' id='managequantity' style='max-width: 9rem;'>");
			if (islimitedItems) {
				out.print("<label class='form-label' for='quantity" + item.getProduct_item_id() + "'>Quantity</label>");
				out.print("<input class='form-control' data-piid=" + item.getProduct_item_id() + " data-oldquantity="
						+ item.getProduct_quantity()
						+ " type='number' inputmode='numaric' pattern='[0-9]*'  id='quantity"
						+ item.getProduct_item_id() + "' min='1' max='15' value='" + item.getProduct_quantity() + "'>");
				out.print("<button class='btn btn-link px-0 text-danger remove-from-cart' data-piid="
						+ item.getProduct_item_id() + " type='button'  >");
				out.print("<i class='ci-close-circle me-2'></i><span class='fs-sm'>Remove</span>");
				out.print("</button>");
				cartTotal += item.getProduct_final_price();
			} else if (item.isInStock()) {
				out.print("<label class='form-label' for='quantity" + item.getProduct_item_id() + "'>Quantity</label>");
				out.print("<input class='form-control' data-piid=" + item.getProduct_item_id() + " data-oldquantity="
						+ item.getProduct_quantity()
						+ " type='number' inputmode='numaric' pattern='[0-9]*'  id='quantity"
						+ item.getProduct_item_id() + "' min='1' max='15' value='" + item.getProduct_quantity() + "'>");
				out.print("<button class='btn btn-link px-0 text-danger remove-from-cart' data-piid="
						+ item.getProduct_item_id() + " type='button'  >");
				out.print("<i class='ci-close-circle me-2'></i><span class='fs-sm'>Remove</span>");
				out.print("</button>");
				cartTotal += item.getProduct_final_price();
			} else {
				out.print("<h6 class='text-danger'>Out Of Stock</h6>");
			}

			out.print("</div></div>");

		}
		out.print(
				"<input type='hidden' id='cart-page-total' value='" + FormatPrice.formatPrice(cartTotal + "") + "' >");

	}
}
