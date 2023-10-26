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
 * Servlet implementation class ShowVariationTable
 */
@WebServlet("/ShowVariationTable")
public class ShowVariationTable extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ShowVariationTable() {
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
			String var_id = request.getParameter("var_id");
			String sql = "SELECT var_val_id,var_value FROM variation_combo_values WHERE var_id=?";
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, var_id);
			ResultSet rs = ps.executeQuery();
			if (!rs.isBeforeFirst()) {
				out.print("<p class='text-danger'>No Variation values Available</p>");
			} else {
				out.print(
						"<table class='table table-hover table-striped table-responsive-sm table-responsive-md table-responsive-lg'>");
				out.print(
						"<thead class='thead-dark'><tr><th>Id</th><th>Value</th><th>Edit</th><th>Delete</th></tr></thead><tbody>");
				while (rs.next()) {
					out.print("<tr><td>" + rs.getString("var_val_id") + "</td><td>" + rs.getString("var_value")
							+ "</td><td><button type='button' class='btn btn-warning btn-sm editVarValue' data-bs-toggle='modal' data-bs-target='#editVarValue' data-var_vid='"
							+ rs.getString("var_val_id") + "' data-var_vvalue=\"" + rs.getString("var_value")
							+ "\" ><i class='ci-edit'></i></button></td>"
							+ "<td><button class='btn btn-danger btn-sm deleteVarValue' data-var_vid='"
							+ rs.getString("var_val_id") + "' data-var_vvalue=\"" + rs.getString("var_value")
							+ "\"><i class='ci-trash'></i></button></td></tr>");
				}
			}
			out.print("</tbody></table>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
