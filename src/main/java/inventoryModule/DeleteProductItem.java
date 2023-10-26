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
 * Servlet implementation class DeleteProductItem
 */
@WebServlet("/DeleteProductItem")
public class DeleteProductItem extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteProductItem() {
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
			String product_item_id = request.getParameter("product_item_id");
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement("SELECT product_id FROM product_item WHERE product_item_id=?");
			ps.setString(1, product_item_id);
			ResultSet rs = ps.executeQuery();
			rs.next();
			String product_id = rs.getString("product_id");

			String path = getServletContext().getRealPath(File.separator + "img" + File.separator + "shop"
					+ File.separator + "products" + File.separator + product_id + File.separator + product_item_id);

			File dir = new File(path);
			String[] images = dir.list();
			if (images != null) {
				for (String image : images) {
					File del = new File(dir, image);
					del.delete();
				}
				dir.delete();
			}

			ps = cn.prepareStatement("DELETE FROM product_item WHERE product_item_id=?");
			ps.setString(1, product_item_id);
			ps.execute();
			out.print("1");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
