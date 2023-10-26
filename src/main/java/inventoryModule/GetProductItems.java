package inventoryModule;

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

import conModule.ConnectionProvider;

/**
 * Servlet implementation class GetProductItems
 */
@WebServlet("/GetProductItems")
public class GetProductItems extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetProductItems() {
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
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn
					.prepareStatement("SELECT product_item_id,item_SKU FROM product_item WHERE product_id=?");
			ps.setString(1, product_id);
			ResultSet rs = ps.executeQuery();
			out.print("<option value>Select Product Item</option>");
			while (rs.next()) {
				out.print("<option value='" + rs.getString("product_item_id") + "'>" + rs.getString("item_SKU")
						+ "</option>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
