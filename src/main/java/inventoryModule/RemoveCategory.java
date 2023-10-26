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
 * Servlet implementation class RemoveCategory
 */
@WebServlet("/RemoveCategory")
public class RemoveCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RemoveCategory() {
		super();
		// TODO Auto-generated constructor stub
	}

	private void DeleteImages(Connection cn, String category_id) throws SQLException {
		String sql = "SELECT category_id,category_image,parent_category_id FROM product_categories WHERE parent_category_id=?";
		PreparedStatement ps = cn.prepareStatement(sql);
		ps.setString(1, category_id);
		ResultSet rs = ps.executeQuery();
		if (!rs.isBeforeFirst()) {
			return;
		} else {
			while (rs.next()) {
				DeleteImages(cn, rs.getString("category_id"));
				String path = getServletContext().getRealPath(File.separator + "resources" + File.separator + "Images"
						+ File.separator + "Category" + File.separator + rs.getString("category_image"));
				File f = new File(path);
				f.delete();
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
			DeleteImages(cn, category_id);
			PreparedStatement ps = cn
					.prepareStatement("SELECT category_image FROM product_categories WHERE category_id=?");
			ps.setString(1, category_id);
			ResultSet rs = ps.executeQuery();
			rs.next();
			String path = getServletContext().getRealPath(File.separator + "resources" + File.separator + "Images"
					+ File.separator + "Category" + File.separator + rs.getString("category_image"));
			File f = new File(path);
			f.delete();
			ps = cn.prepareStatement("DELETE FROM product_categories WHERE category_id=?");
			ps.setString(1, category_id);
			ps.execute();
			out.print(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
