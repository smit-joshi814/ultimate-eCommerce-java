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
 * Servlet implementation class DeleteVariationMapping
 */
@WebServlet("/DeleteVariationMapping")
public class DeleteVariationMapping extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteVariationMapping() {
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
			String map_id = request.getParameter("map_id");
			boolean isColoVariation = request.getParameter("var_name").toString().equalsIgnoreCase("color");
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps;
			ResultSet rs;
			if (isColoVariation) {
				ps = cn.prepareStatement(
						"SELECT PVM.product_item_id,PI.product_id from product_variation_mapping PVM INNER JOIN product_item PI ON PVM.product_item_id=PI.product_item_id WHERE map_id=?");
				ps.setString(1, map_id);
				rs = ps.executeQuery();
				rs.next();
				String product_item_id = rs.getString("product_item_id");
				String product_id = rs.getString("product_id");

				String path = getServletContext().getRealPath(File.separator + "img" + File.separator + "shop"
						+ File.separator + "products" + File.separator + product_id + File.separator + product_item_id);
				// System.out.println(path);
				File dir = new File(path);
				String[] images = dir.list();
				if (images != null) {
					for (String image : images) {
						File del = new File(dir, image);
						del.delete();
					}
					dir.delete();
				}

				ps = cn.prepareStatement("DELETE FROM product_item_images WHERE map_id=?");
				ps.setString(1, map_id);
				ps.execute();
				ps = cn.prepareStatement("UPDATE product_item SET Active=? WHERE product_item_id=?");
				ps.setBoolean(1, false);
				ps.setString(2, product_item_id);
				ps.execute();
			}
			ps = cn.prepareStatement("DELETE FROM product_variation_mapping WHERE map_id=?");
			ps.setString(1, map_id);
			ps.execute();

			out.print("1");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
