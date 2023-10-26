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
 * Servlet implementation class CartItemsOnHeader
 */
@WebServlet("/CartItemsOnHeader")
public class CartItemsOnHeader extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartItemsOnHeader() {
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
			int cartTotal = 0;
			int totalItems = 0;

			HttpSession session = request.getSession();
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
					out.print("<input type='hidden' id='cart-total-value' value='" + cartTotal + "' >");
					out.print("<input type='hidden' id='cart-total-items-value' value='" + totalItems + "'>");
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
					out.print("<h6 class='h6'>Cart Is Empty</h6>");
					out.print("</div>");
					out.print("<input type='hidden' id='cart-total-value' value='" + cartTotal + "'>");
					out.print("<input type='hidden' id='cart-total-items-value' value='" + totalItems + "'>");
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
		int totalItems = 0;
		for (Cart item : cart) {
			if (!item.isInStock()) {
				continue;
			}

			out.print("<div class='widget-cart-item pb-2 border-bottom'>");
			out.print("<button class='btn-close text-danger remove-from-cart' data-piid=" + item.getProduct_item_id()
					+ " type='button' aria-label='Remove'><span aria-hidden='true'>&times;</span></button>");
			out.print("<div class='d-flex align-items-center'><a class='flex-shrink-0' href='product-view.jsp?pid="
					+ item.getProduct_id() + "&piid=" + item.getProduct_item_id() + "'><img src=\""
					+ item.getProduct_item_image_path() + "\" width='64' alt='" + item.getProduct_name() + "'></a>");
			out.print("<div class='ps-2'>");
			out.print("<h6 class='widget-product-title'><a href='product-view.jsp?pid=" + item.getProduct_id()
					+ "&piid=" + item.getProduct_item_id() + "'>" + item.getProduct_name() + "</a></h6>");
			out.print("<div class='widget-product-meta'><span class='text-accent me-2'>"
					+ FormatPrice.formatPrice(item.getProduct_price() + "") + "</span><span class='text-muted'>x "
					+ item.getProduct_quantity() + "</span></div>");
			out.print("</div></div></div>");
			cartTotal += item.getProduct_final_price();
			totalItems++;
		}
		out.print(
				"<input type='hidden' id='cart-total-value' value='" + FormatPrice.formatPrice(cartTotal + "") + "'>");
		out.print("<input type='hidden' id='cart-total-items-value' value='" + totalItems + "'>");
	}

}
