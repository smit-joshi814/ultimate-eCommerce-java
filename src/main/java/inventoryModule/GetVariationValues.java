package inventoryModule;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conModule.ConnectionProvider;

/**
 * Servlet implementation class GetVariationValues
 */
@WebServlet("/GetVariationValues")
public class GetVariationValues extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetVariationValues() {
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
			PreparedStatement ps = cn.prepareStatement(
					"SELECT A.variation_name_id,B.var_val_id,b.var_value FROM variation A INNER JOIN variation_combo_values B ON A.variation_name_id= B.var_id WHERE variation_id=?");
			ps.setString(1, request.getParameter("varId"));
			ResultSet rs = ps.executeQuery();
			PreparedStatement ps1 = cn
					.prepareStatement("SELECT variation_value_id FROM variation_options WHERE variation_id=?");
			ps1.setString(1, request.getParameter("varId"));
			ResultSet rs1 = ps1.executeQuery();
			ArrayList<String> values = new ArrayList<>();
			while (rs1.next()) {
				values.add(rs1.getString("variation_value_id"));
			}
			out.print("<h3 class=\"widget-title\">Modify Variation Values</h3>");
			boolean selected = false;
			while (rs.next()) {
				for (String value : values) {
					if (value.equals(rs.getString("var_val_id"))) {
						selected = true;
					}
				}
				if (selected) {
					out.print(
							"<div class='btn-tag me-2 mb-2 text-bg-primary'><input class='form-check-input' type='checkbox' value='"
									+ rs.getString("var_val_id") + "'  name='UpdatevarValues[]' id='updatevar_val"
									+ rs.getString("var_val_id")
									+ "' checked/> <label class='form-check-label' for='updatevar_val"
									+ rs.getString("var_val_id") + "'>" + rs.getString("var_value") + "</label></div>");
					selected = false;
				} else {
					out.print("<div class='btn-tag me-2 mb-2'><input class='form-check-input' type='checkbox' value='"
							+ rs.getString("var_val_id") + "'  name='UpdatevarValues[]' id='updatevar_val"
							+ rs.getString("var_val_id") + "' /> <label class='form-check-label' for='updatevar_val"
							+ rs.getString("var_val_id") + "'>" + rs.getString("var_value") + "</label></div>");
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
