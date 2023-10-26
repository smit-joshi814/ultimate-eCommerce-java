package inventoryModule;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
 * Servlet implementation class AddCategory
 */
@MultipartConfig
@WebServlet(description = "to add new categories", urlPatterns = { "/AddCategory" })
public class AddCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddCategory() {
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
			String categoryName = request.getParameter("CategoryName").trim();
			Part fpart = request.getPart("catImage");
			String fileName = fpart.getSubmittedFileName();
			int index = fileName.lastIndexOf(".");
			String extention = fileName.substring(index + 1).toLowerCase();
			String path = getServletContext().getRealPath(File.separator + "img" + File.separator + "shop"
					+ File.separator + "categories" + File.separator + categoryName + "." + extention);
			for (Part part : request.getParts()) {
				part.write(path);
			}
			path = categoryName + "." + extention;
			try (Connection cn = ConnectionProvider.getCon()) {
				if (request.getParameter("isSuper") != null) {
					PreparedStatement ps = cn.prepareStatement(
							"INSERT INTO product_categories (category_name,category_image,parent_category_id) VALUES(?,?,?)");
					ps.setString(1, categoryName.translateEscapes());
					ps.setString(2, path);
					ps.setString(3, null);
					ps.execute();
					out.print("<p class='text-success'>Category Added Successfully</p>");
				} else {
					String buildParam = request.getParameter("hdnMaxlevel");
					String parentCategoryId = null;
					if (buildParam.equals("0")) {
						parentCategoryId = request.getParameter("cat_lavel" + buildParam);
						// out.print("1: "+parentCategoryId);
					} else {
						buildParam = request.getParameter("hdnMaxlevel");
						parentCategoryId = request.getParameter("cat_lavel" + buildParam);
						// out.print("2: "+parentCategoryId);
					}
					if (parentCategoryId == null || parentCategoryId.equals("null")) {
						buildParam = request.getParameter("hdnMaxlevelOld");
						parentCategoryId = request.getParameter("cat_lavel" + buildParam);
						// out.print("3: "+parentCategoryId);
					}
					PreparedStatement ps = cn.prepareStatement(
							"INSERT INTO product_categories (category_name,category_image,parent_category_id) VALUES(?,?,?)");
					ps.setString(1, categoryName);
					ps.setString(2, path);
					ps.setString(3, parentCategoryId);
					ps.execute();
					out.print("<p class='text-success'>Sub Category Added Successfully</p>");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
