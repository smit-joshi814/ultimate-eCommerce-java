package inventoryModule;

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
 * Servlet implementation class UpdateProduct
 */
@WebServlet("/UpdateProduct")
public class UpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateProduct() {
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
			String product_id = request.getParameter("hdnproduct_id");
			String product_name = request.getParameter("updateproductName");
			String product_description = request.getParameter("updateproductDescription");

			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn
					.prepareStatement("UPDATE product SET product_name=?,product_description=? WHERE product_id=?");
			ps.setString(1, product_name);
			ps.setString(2, product_description);
			ps.setString(3, product_id);
			ps.execute();
			out.print("<p class='text-success'>Product Updated Successfully</p>");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
