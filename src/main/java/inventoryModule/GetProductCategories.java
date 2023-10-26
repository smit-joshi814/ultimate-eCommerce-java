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
 * Servlet implementation class GetProductCategories
 */
@WebServlet("/GetProductCategories")
public class GetProductCategories extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetProductCategories() {
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
						"<div class='mb-3'><label for='cat_lavelP0' class='form-label'>Select Category</label><select class='form-select' id='cat_lavelP0' name='cat_lavelP0' onchange='getProductCategories($(this).val(),0,1)' required>");
				out.print("<option value='0'>Open this select menu</option>");
				while (rs.next()) {
					out.print("<option value='" + rs.getString("category_id") + "'>" + rs.getString("category_name")
							+ "</option>");
				}
				out.print("</select></div>");
				out.print("<input type='hidden' name='hdnMaxlevelOldP' id='hdnMaxlevelOldP' value='"
						+ request.getParameter("old") + "' />");
				out.print(
						"<input type='hidden' name='hdnMaxlevelP' id='hdnMaxlevelP' value='" + hirarchyLevels + "' />");
			} else {
				PreparedStatement ps = cn.prepareStatement(
						"SELECT category_id,category_name from product_categories WHERE parent_category_id=?");
				ps.setString(1, hirarchyLevels);
				ResultSet rs = ps.executeQuery();
				if (rs.isBeforeFirst()) {
					out.print("<div class='mb-3'><label for='cat_lavelP" + hirarchyLevels
							+ "' class='form-label'>Select SubCategory</label><select class='form-select' id='cat_lavelP"
							+ hirarchyLevels + "' name='cat_lavelP" + hirarchyLevels
							+ "' onchange='getProductCategories($(this).val(),1)' required>");
					out.print("<option value='null'>Open this select menu</option>");
					while (rs.next()) {
						out.print("<option value='" + rs.getString("category_id") + "'>" + rs.getString("category_name")
								+ "</option>");
					}
					out.print("</select></div>");
					out.print("<input type='hidden' name='hdnMaxlevelnP' id='hdnMaxlevelnP' value='" + hirarchyLevels
							+ "' />");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
