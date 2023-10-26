package product;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conModule.ConnectionProvider;
import generalModule.SiteConstants;

/**
 * Servlet implementation class UpdateCart
 */
@WebServlet("/UpdateCart")
public class UpdateCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateCart() {
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
			int product_item_id = Integer.parseInt(request.getParameter("product_item_id"));
			int item_quantity = Integer.parseInt(request.getParameter("item_quantity"));

			// a flag to check if product item exist in the cart or not
			boolean isExist = false;

			HttpSession session = request.getSession();
			if (session.getAttribute("uid") != null) {
				int user_id = Integer.parseInt(session.getAttribute("uid").toString());
				Connection cn = ConnectionProvider.getCon();
				PreparedStatement ps = cn.prepareStatement("SELECT cart_id FROM shopping_cart WHERE user_id=?");
				ps.setInt(1, user_id);
				ResultSet rs = ps.executeQuery();
				rs.next();
				int cart_id = rs.getInt("cart_id");
				ps = cn.prepareStatement(
						"UPDATE shopping_cart_item SET item_quantity=item_quantity+? WHERE product_item_id=? AND cart_id=?");
				ps.setInt(1, item_quantity);
				ps.setInt(2, product_item_id);
				ps.setInt(3, cart_id);
				ps.execute();
			} else {
				// getting available cookie
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

						if (item_ids[i] == product_item_id) {
							// if item is already in the cart then increasing the quantity of the item
							int Qty = item_quantities[i];
							if (item_quantity > 0) {
								Qty += item_quantity;
							} else {
								Qty += item_quantity;
							}
							item_quantities[i] = Qty;
							isExist = true;
						}
					}
					if (isExist) {
						// constructing new cookie string
						items = "";
						for (int i = 0; i < availabeItems.length; i++) {
							items += item_ids[i] + "-";
							items += item_quantities[i] + "&";
						}
					}
					// creating cookie
					Cookie cart = new Cookie("cart", items);
					cart.setMaxAge(SiteConstants.MAX_COOKIE_AGE_FOR_CART);
					response.addCookie(cart);
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
}