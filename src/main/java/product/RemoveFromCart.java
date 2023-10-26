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
 * Servlet implementation class RemoveFromCart
 */
@WebServlet("/RemoveFromCart")
public class RemoveFromCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RemoveFromCart() {
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

			HttpSession session = request.getSession();
			if (session.getAttribute("uid") != null) {
				int user_id = Integer.parseInt(session.getAttribute("uid").toString());
				Connection cn = ConnectionProvider.getCon();
				PreparedStatement ps = cn.prepareStatement("SELECT cart_id FROM shopping_cart WHERE user_id=?");
				ps.setInt(1, user_id);
				ResultSet rs = ps.executeQuery();
				rs.next();
				int cart_id = rs.getInt("cart_id");
				ps = cn.prepareStatement("DELETE FROM shopping_cart_item WHERE cart_id=? AND product_item_id=?");
				ps.setInt(1, cart_id);
				ps.setInt(2, product_item_id);
				ps.execute();
			} else {
				// getting available cookie
				String items = getCookie(request.getCookies(), "cart");
				if (items != null) {
					// creating available item array
					String availabeItems[] = items.split("&");
					// creating two different arrays for storing product_item_id and quantity
					String[] item_ids = new String[availabeItems.length];
					String[] item_quantities = new String[availabeItems.length];

					int j = 0;
					for (String availabeItem : availabeItems) {
						int item_id = Integer.parseInt(availabeItem.substring(0, availabeItem.indexOf('-')));
						if (product_item_id != item_id) {
							// splitting string to their relative arrays
							item_ids[j] = availabeItem.substring(0, availabeItem.indexOf('-'));
							item_quantities[j] = availabeItem.substring(availabeItem.indexOf('-') + 1);
							j++;
						}
					}

					items = "";
					for (int i = 0; i < item_ids.length; i++) {
						if (item_ids[i] != null) {
							items += item_ids[i] + "-";
							items += item_quantities[i] + "&";
						}
					}

					Cookie cart = new Cookie("cart", items);
					if (item_ids[0] == null) {
						cart.setMaxAge(0);
					} else {
						cart.setMaxAge(SiteConstants.MAX_COOKIE_AGE_FOR_CART);
					}
					response.addCookie(cart);
				}
			}
			// out.print("Item Removed Success Fully");
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
