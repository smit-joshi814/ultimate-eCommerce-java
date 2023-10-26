package inventoryModule;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import conModule.ConnectionProvider;

/**
 * Servlet implementation class UpdateCategory
 */
@MultipartConfig
@WebServlet("/UpdateCategory")
public class UpdateCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateCategory() {
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
			PreparedStatement ps;
			String sql;
			String categoryName = request.getParameter("mdlCategoryName").trim();
			String category_id = request.getParameter("hdnCatId");
			if (request.getParameter("isUpdcatImg") != null) {

				// First We Will Remove Old Product Image
				ps = cn.prepareStatement("SELECT category_image FROM product_categories WHERE category_id=?");
				ps.setString(1, category_id);
				ResultSet rs = ps.executeQuery();
				rs.next();
				String path = getServletContext().getRealPath(File.separator + "img" + File.separator + "shop"
						+ File.separator + "categories" + File.separator + rs.getString("category_image"));
				File f = new File(path);
				f.delete();

				// Then We Will Store The Image
				Part fpart = request.getPart("mdlcatImage");
				String fileName = fpart.getSubmittedFileName();
				int index = fileName.lastIndexOf(".");
				String extention = fileName.substring(index + 1).toLowerCase();
				path = getServletContext().getRealPath(File.separator + "img" + File.separator + "shop" + File.separator
						+ "categories" + File.separator + categoryName + "." + extention);

				for (Part part : request.getParts()) {
					part.write(path);
				}
				path = categoryName + "." + extention;

				// Updating Database Records
				sql = "UPDATE product_categories SET category_name=? , category_image=? WHERE category_id=?";
				ps = cn.prepareStatement(sql);
				ps.setString(1, categoryName);
				ps.setString(2, path);
				ps.setString(3, category_id);
				ps.execute();
				out.print("<p class='text-success'>Category Updated Successfully</p>");
			} else {
				sql = "UPDATE product_categories SET category_name=? WHERE category_id=?";
				ps = cn.prepareStatement(sql);
				ps.setString(1, categoryName);
				ps.setString(2, category_id);
				ps.execute();
				out.print("<p class='text-success'>Category Updated Successfully</p>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
