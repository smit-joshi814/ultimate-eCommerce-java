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
 * Servlet implementation class ShowSubCategory
 */
@WebServlet("/ShowSubCategory")
public class ShowSubCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ShowSubCategory() {
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
			String category_id = request.getParameter("catId");
			String category_name = request.getParameter("catName");
			String sql = "SELECT category_id,category_name,parent_category_id FROM product_categories WHERE parent_category_id=?";
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, category_id);
			ResultSet rs = ps.executeQuery();
			if (!rs.isBeforeFirst()) {
				out.print("<p class='text-danger'>No SubCategories Available</p>");
			} else {
				out.print(
						"<table class='table table-hover table-striped table-responsive-sm table-responsive-md table-responsive-lg'>");
				out.print(
						"<thead class='thead-dark'><tr><th>Id</th><th>Name</th><th>View</th><th>Edit</th><th>Delete</th></tr></thead><tbody id='tblSubCat'>");
				while (rs.next()) {
					out.print("<tr><td>" + rs.getString("category_id") + "</td><td>" + rs.getString("category_name")
							+ "</td><td class='text-center'><button type='button' class='btn btn-sm btn-info shSubCat' data-cid='"
							+ rs.getString("category_id") + "' data-cname=\"" + rs.getString("category_name")
							+ "\" ><i class='ci-eye'></i></button></td>"
							+ "<td><button type='button' class='btn btn-warning btn-sm EdtCat' data-bs-toggle='modal' data-bs-target='#EditCat' data-cid='"
							+ rs.getString("category_id") + "' data-cname=\"" + rs.getString("category_name")
							+ "\" ><i class='ci-edit'></i></button></td>"
							+ "<td><button class='btn btn-danger btn-sm catDel' data-cid='"
							+ rs.getString("category_id") + "' data-cname=\"" + rs.getString("category_name")
							+ "\"><i class='ci-trash'></i></button></td></tr>");
//					category_id=rs.getString("parent_category_id");
				}
			}
			ps = cn.prepareStatement(
					"SELECT category_id,category_name,parent_category_id FROM product_categories WHERE category_id=?");
			ps.setString(1, category_id);
			rs = ps.executeQuery();
			if (rs.isBeforeFirst()) {
				rs.next();
				category_name = rs.getString("category_name");
				category_id = rs.getString("parent_category_id");
			}
			if (category_id != null) {
				out.print("</tbody></table><button type='button' class='btn btn-outline-info prevSubCat' data-cid='"
						+ category_id + "' data-cname='" + category_name
						+ "' ><i class='ci-arrow-left-circle'></i></button>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
