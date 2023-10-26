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
 * Servlet implementation class AddToCart
 */
@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddToCart() {
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
			String quantity = request.getParameter("item_quantity");

			// a flag to check if product item exist in the cart or not
			boolean isExist = false;

			int item_quantity;
			if (quantity != null) {
				item_quantity = Integer.parseInt(quantity);
			} else {
				item_quantity = 1;
			}

			HttpSession session = request.getSession();
			if (session.getAttribute("uid") != null) {

				// getting user id from session
				int user_id = Integer.parseInt(session.getAttribute("uid").toString());

				Connection cn = ConnectionProvider.getCon();
				// checking if the user has cart or not
				PreparedStatement ps = cn.prepareStatement("SELECT count(cart_id) FROM shopping_cart WHERE user_id=?");
				ps.setInt(1, user_id);
				ResultSet rs = ps.executeQuery();
				rs.next();
				boolean isCartExist = rs.getString(1).equals("1");

				if (isCartExist) {
					// getting the cart id for current user
					ps = cn.prepareStatement("SELECT cart_id FROM shopping_cart WHERE user_id=?");
					ps.setInt(1, user_id);
					rs = ps.executeQuery();
					rs.next();
					int cart_id = rs.getInt("cart_id");

					// checking if product exist or not
					ps = cn.prepareStatement(
							"SELECT count(product_item_id) FROM shopping_cart_item WHERE cart_id=? AND product_item_id=?");
					ps.setInt(1, cart_id);
					ps.setInt(2, product_item_id);
					rs = ps.executeQuery();
					rs.next();
					isExist = rs.getString(1).equals("1");
					if (isExist) {
						// if product is already in the cart then updating the product quantity
						ps = cn.prepareStatement(
								"UPDATE shopping_cart_item SET item_quantity=item_quantity+? WHERE product_item_id=? AND cart_id=?");
						ps.setInt(1, item_quantity);
						ps.setInt(2, product_item_id);
						ps.setInt(3, cart_id);
						ps.execute();
						out.print("2");
					} else {
						ps.close();
						// if not then inserting the product to the cart item
						ps = cn.prepareStatement(
								"INSERT INTO shopping_cart_item (cart_id,product_item_id,item_quantity) VALUES(?,?,?)");
						ps.setInt(1, cart_id);
						ps.setInt(2, product_item_id);
						ps.setInt(3, item_quantity);
						ps.execute();
						out.print("1");
					}
				} else {
					ps.close();
					ps = cn.prepareStatement("INSERT INTO shopping_cart (user_id) VALUES(?)");
					ps.setInt(1, user_id);
					ps.execute();
					rs.close();
					ps = cn.prepareStatement("SELECT LAST_INSERT_ID()");
					rs = ps.executeQuery();
					rs.next();
					int cart_id = rs.getInt(1);
					ps = cn.prepareStatement(
							"INSERT INTO shopping_cart_item (cart_id,product_item_id,item_quantity) VALUES(?,?,?)");
					ps.setInt(1, cart_id);
					ps.setInt(2, product_item_id);
					ps.setInt(3, item_quantity);
					ps.execute();
					out.print("1");
				}
			} else {

				// getting available cookie
				String items = getCookie(request.getCookies(), "cart");
				// my new cookie value
				String newCartitem = product_item_id + "-" + item_quantity + "&";
				Cookie cartItem;

				// if there is no items means cart is not available
				if (items != null) {
					// creating available item array
					String availabeItems[] = items.split("&");
					// creating two different arrays for storing product_item_id and quantity
					String[] item_ids = new String[availabeItems.length];
					String[] item_quantities = new String[availabeItems.length];

					for (int i = 0; i < availabeItems.length; i++) {
						// splitting string to their relative arrays
						item_ids[i] = availabeItems[i].substring(0, availabeItems[i].indexOf('-'));
						item_quantities[i] = availabeItems[i].substring(availabeItems[i].indexOf('-') + 1);

						if (item_ids[i].equals(request.getParameter("product_item_id"))) {
							// if item is already in the cart then increasing the quantity of the item
							int increaseQty = Integer.parseInt(item_quantities[i]);
							increaseQty += item_quantity;
							item_quantities[i] = increaseQty + "";
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
					} else {
						// if item does not exist in the cookie than just appending the new item to
						// existing "item string"
						items += newCartitem;
					}
					// creating cookie
					cartItem = new Cookie("cart", items);
					cartItem.setMaxAge(SiteConstants.MAX_COOKIE_AGE_FOR_CART);
				} else {
					// if there is no cart then cart cookie will be created
					cartItem = new Cookie("cart", newCartitem);
					cartItem.setMaxAge(SiteConstants.MAX_COOKIE_AGE_FOR_CART);
				}
				response.addCookie(cartItem);

				if (isExist) {
					out.print("2");
				} else {
					out.print("1");
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
