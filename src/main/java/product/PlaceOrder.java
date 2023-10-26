package product;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conModule.ConnectionProvider;
import generalModule.SendNewEmail;
import generalModule.SiteConstants;

/**
 * Servlet implementation class PlaceOrder
 */
@WebServlet("/PlaceOrder")
public class PlaceOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PlaceOrder() {
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

			String cash_on_delivery = request.getParameter("cash-on-delivery");
			String payment_method_id;
			if (cash_on_delivery != null) {
				payment_method_id = null;
			} else {
				payment_method_id = request.getParameter("payment_method_id");
			}
			String shipping_address = request.getParameter("addressIdShip");
			String shipping_method = request.getParameter("shipping-method");
			String order_total = request.getParameter("priceToPay");

			HttpSession session = request.getSession();
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn
					.prepareStatement("SELECT status_id FROM order_status WHERE status_value LIKE '%pending%' LIMIT 1");
			ResultSet rs = ps.executeQuery();
			rs.next();
			String SQL = "";
			if (cash_on_delivery != null) {
				SQL = "INSERT INTO shop_order(user_id, order_date, payment_method_id, shipping_address, shipping_method, order_total, order_status, payment_date) VALUES (?,CURDATE(),?,?,?,?,?,null)";
			} else {
				SQL = "INSERT INTO shop_order(user_id, order_date, payment_method_id, shipping_address, shipping_method, order_total, order_status, payment_date) VALUES (?,CURDATE(),?,?,?,?,?,CURDATE())";
			}
			ps = cn.prepareStatement(SQL);
			ps.setString(1, session.getAttribute("uid").toString());
			if (cash_on_delivery != null) {
				ps.setString(2, null);
			} else {
				ps.setString(2, payment_method_id);
			}
			ps.setString(3, shipping_address);
			ps.setString(4, shipping_method);
			ps.setString(5, order_total);
			ps.setString(6, rs.getString("status_id"));

			ps.executeUpdate();
			ps = cn.prepareStatement("SELECT LAST_INSERT_ID()");
			rs = ps.executeQuery();
			rs.next();

			String order_id = rs.getString(1);

			ps = cn.prepareStatement("SELECT cart_id FROM shopping_cart WHERE user_id=?");
			ps.setString(1, session.getAttribute("uid").toString());
			rs = ps.executeQuery();
			rs.next();
			String cart_id = rs.getString("cart_id");
			ps = cn.prepareStatement("SELECT * FROM shopping_cart_item WHERE cart_id=?");
			ps.setString(1, cart_id);
			rs = ps.executeQuery();
			while (rs.next()) {
				ps = cn.prepareStatement(
						"INSERT INTO order_line(product_item_id, order_id, order_quantity) VALUES (?,?,?)");
				ps.setInt(1, rs.getInt("product_item_id"));
				ps.setString(2, order_id);
				ps.setInt(3, rs.getInt("item_quantity"));
				ps.executeUpdate();

				ps = cn.prepareStatement(
						"UPDATE product_item SET item_quantity=item_quantity - ? WHERE product_item_id=?");
				ps.setInt(1, rs.getInt("item_quantity"));
				ps.setInt(2, rs.getInt("product_item_id"));
				ps.executeUpdate();
			}

			ps = cn.prepareStatement("DELETE FROM shopping_cart_item WHERE cart_id=?");
			ps.setString(1, cart_id);
			ps.executeUpdate();

			ps = cn.prepareStatement("SELECT user_name,user_email FROM site_users WHERE user_id=?");
			ps.setString(1, session.getAttribute("uid").toString());
			rs = ps.executeQuery();
			rs.next();

			String to = rs.getString("user_email");
			String subject = "Hello, " + rs.getString("user_name") + " Here's Your invoice for Order " + order_id;
			String body = "<h2>Thank You for your Purchase From MyECommerceSite</h2><br/><p> You Can Download Your invoice From Here</p><br/><a href='"
					+ SiteConstants.SITE_URL + "/GenerateOrderinvoice?oid=" + order_id + "&uid="
					+ session.getAttribute("uid") + "' >Click here To Download invoice</a>";
			SendNewEmail email = new SendNewEmail();
			email.send(to, subject, body);

			out.print(order_id);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
