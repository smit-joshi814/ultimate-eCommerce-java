package adminHomeModule;

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
 * Servlet implementation class GetCategoryTree
 */
@WebServlet("/GetCategoryTree")
public class GetCategoryTree extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetCategoryTree() {
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
					"SELECT category_id,category_name from product_categories WHERE parent_category_id IS NULL");
			ResultSet rs = ps.executeQuery();
			out.print(
					"<div class='tf-tree tf-gap-sm tf-custom pt-1 mb-2'><ul><li><span class='tf-nc'>product_categories</span><ul>");
			while (rs.next()) {
				out.print("<li><span class='tf-nc'>" + rs.getString("category_name") + "</span>");
				GenerateSubTree(cn, out, rs.getString("category_id"));
				out.print("</li>");
			}
			out.print("</ul></li></ul></div>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void GenerateSubTree(Connection cn, PrintWriter out, String Category_id) throws SQLException {
		PreparedStatement ps = cn.prepareStatement(
				"SELECT category_id,category_name from product_categories WHERE parent_category_id=?");
		ps.setString(1, Category_id);
		ResultSet rs = ps.executeQuery();
		if (!rs.isBeforeFirst()) {
			return;
		} else {
			out.print("<ul>");
			while (rs.next()) {
				out.print("<li><span class='tf-nc'>" + rs.getString("category_name") + "</span>");
				GenerateSubTree(cn, out, rs.getString("category_id"));
				out.print("</li>");
			}
			out.print("</ul>");
		}
	}
}