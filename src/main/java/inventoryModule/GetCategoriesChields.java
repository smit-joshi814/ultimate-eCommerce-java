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
 * Servlet implementation class GetCategoriesChields
 */
@WebServlet("/GetCategoriesChields")
public class GetCategoriesChields extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetCategoriesChields() {
		super();
		// TODO Auto-generated constructor stub
	}

	private void buildComboBoxes(Connection cn, String category_id, HttpServletResponse response)
			throws SQLException, IOException {
		PreparedStatement ps = cn
				.prepareStatement("SELECT parent_category_id FROM product_categories WHERE category_id=?");
		ps.setString(1, category_id);
		ResultSet rs = ps.executeQuery();
		if (!rs.isBeforeFirst()) {
			return;
		} else {
			try (PrintWriter out = response.getWriter()) {
				while (rs.next()) {
					String parent_category_id = rs.getString("parent_category_id");
					ps = cn.prepareStatement(
							"SELECT category_id,category_name FROM product_categories WHERE parent_category_id=?");
					ps.setString(1, parent_category_id);
					ResultSet rs1 = ps.executeQuery();
					if (!rs1.isBeforeFirst()) {
						return;
					} else {
						out.print("<div class='mb-3'><label for='Category_lvl" + category_id
								+ "' class='form-label'>Categories</label><select class='form-select' id='Category_lvl"
								+ category_id + "' name='Category_lvl" + category_id + "' >");
						while (rs1.next()) {
							if (!parent_category_id.equals(category_id)) {
								out.print("<option value='" + rs1.getString("category_id") + "'>"
										+ rs1.getString("category_name") + "</option>");
							} else {
								out.print("<option value='" + rs1.getString("category_id") + "' selected>"
										+ rs1.getString("category_name") + "</option>");
							}
						}
						out.print("</select></div>");
					}
					buildComboBoxes(cn, parent_category_id, response);
				}
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()) {
			String category_id = request.getParameter("catId");
			Connection cn = ConnectionProvider.getCon();
			buildComboBoxes(cn, category_id, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
