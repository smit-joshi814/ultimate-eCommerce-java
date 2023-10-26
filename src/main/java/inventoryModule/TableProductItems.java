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
 * Servlet implementation class TableProductItems
 */
@WebServlet("/TableProductItems")
public class TableProductItems extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TableProductItems() {
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
			PreparedStatement ps = cn.prepareStatement("SELECT * FROM product_item WHERE product_id=?");
			ps.setString(1, product_id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				out.print("<tr><td>" + rs.getString("product_item_id") + "</td><td>" + rs.getString("item_sku")
						+ "</td><td>" + rs.getString("item_quantity") + "</td><td>" + rs.getString("item_listing_price")
						+ "</td><td>" + rs.getString("item_selling_price") + "</td><td>" + rs.getString("Active")
						+ "</td>");
				out.print("<td><button data-pitemvar='" + rs.getString("product_item_id")
						+ "' class='btn btn-sm btn-info pitemvar' data-bs-toggle='modal' data-bs-target='#ShowProductItemVariations'><i class='ci-eye'></i></button></td>");
				out.print("<td><button data-productitemid='" + rs.getString("product_item_id") + "' data-pitemsku='"
						+ rs.getString("item_sku")
						+ "' class='btn btn-sm btn-warning pitemedit' data-bs-toggle='modal' data-bs-target='#ShowEditProductItem'><i class='ci-edit'></i></button></td>");
				out.print("<td><button data-productitemid='" + rs.getString("product_id") + "' data-pitemsku='"
						+ rs.getString("item_sku")
						+ "' class='btn btn-sm btn-danger pitemdelete'><i class='ci-trash'></i></button></td>");
				out.print("</tr>");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
