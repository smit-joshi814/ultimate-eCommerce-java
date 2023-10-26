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
 * Servlet implementation class SelectedVariationValues
 */
@WebServlet("/SelectedVariationValues")
public class SelectedVariationValues extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SelectedVariationValues() {
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
			PreparedStatement ps = cn
					.prepareStatement("SELECT var_val_id,var_value FROM variation_combo_values WHERE var_id=?");
			ps.setString(1, request.getParameter("var_id"));
			ResultSet rs = ps.executeQuery();
			out.print("<h3 class=\"widget-title\">Select Variation Values</h3>");
			out.print("<div class='form-check form-switch mb-3'>");
			out.print(
					"<input type='checkbox' class='form-check-input' onChange='selectAllVariations(this)' id='selectAllSwitch'>");
			out.print("<label class='form-check-label' for='selectAllSwitch'>Select All</label></div>");
			while (rs.next()) {
				out.print(
						"<div class='btn-tag me-2 mb-2'><input class='form-check-input check-all' type='checkbox' value='"
								+ rs.getString("var_val_id") + "'  name='varValues[]' id='var_val_id"
								+ rs.getString("var_val_id") + "' /> <label class='form-check-label' for='var_val_id"
								+ rs.getString("var_val_id") + "'>" + rs.getString("var_value") + "</label></div>");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
