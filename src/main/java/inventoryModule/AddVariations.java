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
 * Servlet implementation class AddVariations
 */
@WebServlet("/AddVariations")
public class AddVariations extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddVariations() {
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
			String var_name = request.getParameter("VariationName");
			String var_values[] = request.getParameter("VariationValues").split(",");

			PreparedStatement ps = cn.prepareStatement("INSERT INTO variation_combo (var_name) VALUES (?)");
			ps.setString(1, var_name);
			ps.execute();
			ps = cn.prepareStatement("SELECT LAST_INSERT_ID()");
			ResultSet rs = ps.executeQuery();
			rs.next();
			for (String value : var_values) {
				ps = cn.prepareStatement("INSERT INTO variation_combo_values (var_value,var_id) VALUES(?,?)");
				ps.setString(1, value);
				ps.setString(2, rs.getString(1));
				ps.execute();
			}
			out.print("<p class='text-success'>Variation Added SuccessFully</p>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
