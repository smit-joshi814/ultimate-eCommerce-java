package userModule;

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

/**
 * Servlet implementation class FillShoppingCart
 */
@WebServlet("/FillShoppingCart")
public class FillShoppingCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FillShoppingCart() {
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

			String items = getCookie(request.getCookies(), "cart");
			if (items != null) {
				HttpSession session = request.getSession();
				if (session.getAttribute("uid") != null) {
					int user_id = Integer.parseInt(session.getAttribute("uid").toString());
					int cart_id;
					Connection cn = ConnectionProvider.getCon();
					PreparedStatement ps = cn.prepareStatement("SELECT cart_id FROM shopping_cart WHERE user_id=?");
					ps.setInt(1, user_id);
					ResultSet rs = ps.executeQuery();
					if (rs.isBeforeFirst()) {
						rs.next();
						cart_id = rs.getInt("cart_id");
					} else {
						ps = cn.prepareStatement("INSERT INTO shopping_cart (user_id) VALUES(?)");
						ps.setInt(1, user_id);
						ps.execute();
						ps = cn.prepareStatement("SELECT LAST_INSERT_ID()");
						rs = ps.executeQuery();
						rs.next();
						cart_id = rs.getInt(1);
					}
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
					}
					for (int i = 0; i < availabeItems.length; i++) {
						ps = cn.prepareStatement(
								"SELECT count(cart_item_id) FROM shopping_cart_item WHERE cart_id=? AND product_item_id=?");
						ps.setInt(1, cart_id);
						ps.setInt(2, item_ids[i]);
						rs = ps.executeQuery();
						rs.next();
						boolean isProductExist = rs.getString(1).equals("1");
						if (!isProductExist) {
							ps = cn.prepareStatement(
									"INSERT INTO shopping_cart_item (cart_id,product_item_id,item_quantity) VALUES(?,?,?)");
							ps.setInt(1, cart_id);
							ps.setInt(2, item_ids[i]);
							ps.setInt(3, item_quantities[i]);
							ps.execute();
						}
					}
				}
			}
			Cookie cart = new Cookie("cart", null);
			cart.setMaxAge(0);
			response.addCookie(cart);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private String getCookie(Cookie[] cookies, String cart) {
		for (Cookie item : cookies) {
			if (item.getName().equals(cart)) {
				return item.getValue();
			}
		}
		return null;
	}

}
