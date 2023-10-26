package inventoryModule;

import java.io.File;
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
 * Servlet implementation class GetCategoryImage
 */
@WebServlet("/GetCategoryImage")
public class GetCategoryImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetCategoryImage() {
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
					.prepareStatement("SELECT category_image from product_categories WHERE category_id=?");
			ps.setString(1, request.getParameter("catId"));
			ResultSet rs = ps.executeQuery();
			rs.next();
			String path = "../" + "img" + File.separator + "shop" + File.separator + "categories" + File.separator
					+ rs.getString("category_image");
			out.print("<image class='rounded mx-auto d-block img-thumbnail' src=\"" + path
					+ "\" height='150px' width='150px' onerror=\"this.src='../img/shop/categories/imageError.svg' \" />");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
