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
 * Servlet implementation class GetProductCategoriesForVar
 */
@WebServlet("/GetProductCategoriesForVar")
public class GetProductCategoriesForVar extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetProductCategoriesForVar() {
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
			String hirarchyLevels = request.getParameter("lavel");
			if (request.getParameter("lavel").equals("0")) {
				PreparedStatement ps = cn.prepareStatement(
						"SELECT category_id,category_name from product_categories WHERE parent_category_id IS NULL");
				ResultSet rs = ps.executeQuery();
				out.print(
						"<div class='mb-3'><label for='cat_lavelPV0' class='form-label'>Categories</label><select class='form-select' id='cat_lavelPV0' name='cat_lavelPV0' onchange='getProductCategoriesForVar($(this).val(),0,1)' required>");
				out.print("<option value='0'>Open this select menu</option>");
				while (rs.next()) {
					out.print("<option value='" + rs.getString("category_id") + "'>" + rs.getString("category_name")
							+ "</option>");
				}
				out.print("</select></div>");
				out.print("<input type='hidden' name='hdnMaxlevelOldPV' id='hdnMaxlevelOldPV' value='"
						+ request.getParameter("old") + "' />");
				out.print("<input type='hidden' name='hdnMaxlevelPV' id='hdnMaxlevelPV' value='" + hirarchyLevels
						+ "' />");
			} else {
				PreparedStatement ps = cn.prepareStatement(
						"SELECT category_id,category_name from product_categories WHERE parent_category_id=?");
				ps.setString(1, hirarchyLevels);
				ResultSet rs = ps.executeQuery();
				if (rs.isBeforeFirst()) {
					out.print("<div class='mb-3'><label for='cat_lavelPV" + hirarchyLevels
							+ "' class='form-label'>Sub Categories</label><select class='form-select' id='cat_lavelPV"
							+ hirarchyLevels + "' name='cat_lavelPV" + hirarchyLevels
							+ "' onchange='getProductCategoriesForVar($(this).val(),1)' required>");
					out.print("<option value='null'>Open this select menu</option>");
					while (rs.next()) {
						out.print("<option value='" + rs.getString("category_id") + "'>" + rs.getString("category_name")
								+ "</option>");
					}
					out.print("</select></div>");
					out.print("<input type='hidden' name='hdnMaxlevelnPV' id='hdnMaxlevelnPV' value='" + hirarchyLevels
							+ "' />");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
