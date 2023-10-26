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
 * Servlet implementation class GetProductItemVariationValues
 */
@WebServlet("/GetProductItemVariationValues")
public class GetProductItemVariationValues extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetProductItemVariationValues() {
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
			String variation_id = request.getParameter("variation_id");
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement(
					"SELECT A.variation_option_id,B.var_value FROM variation_options A INNER JOIN variation_combo_values B ON A.variation_value_id=B.var_val_id WHERE variation_id=?");
			ps.setString(1, variation_id);
			ResultSet rs = ps.executeQuery();
			out.print("<option value>Select Variation Value</option>");
			while (rs.next()) {
				out.print("<option value='" + rs.getString("variation_option_id") + "'>" + rs.getString("var_value")
						+ "</option>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
