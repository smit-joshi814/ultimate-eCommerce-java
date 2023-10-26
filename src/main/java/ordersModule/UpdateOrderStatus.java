package ordersModule;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conModule.ConnectionProvider;

/**
 * Servlet implementation class UpdateOrderStatus
 */
@WebServlet("/UpdateOrderStatus")
public class UpdateOrderStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateOrderStatus() {
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
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement("UPDATE shop_order SET order_status=? WHERE order_id=?");
			ps.setString(1, request.getParameter("order_status"));
			ps.setString(2, request.getParameter("order_id"));
			ps.executeUpdate();
			if (request.getParameter("order_status").equals("15")) {
				ps = cn.prepareStatement("UPDATE shop_order SET payment_date=CURDATE() WHERE order_id=?");
				ps.setString(1, request.getParameter("order_id"));
				ps.executeUpdate();
			}

			out.print("Order Status Updated Successfully");

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
