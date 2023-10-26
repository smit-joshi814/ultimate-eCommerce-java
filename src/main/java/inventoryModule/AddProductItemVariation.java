package inventoryModule;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
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
 * Servlet implementation class AddProductItemVariation
 */
@MultipartConfig
@WebServlet("/AddProductItemVariation")
public class AddProductItemVariation extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddProductItemVariation() {
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
			ResultSet rs;
			String product = request.getParameter("ProductListVar");
			String product_item = request.getParameter("ProductItemList");
			// String variation = request.getParameter("ProductVariationList");
			String variation_option = request.getParameter("ProductVariationValueList");
			boolean isColor = request.getParameter("hdnIsColor").equals("yes");
			boolean isPublish = false;
			String map_id;
			if (request.getParameter("isPublish") != null) {
				isPublish = true;
			}

			ps = cn.prepareStatement(
					"INSERT INTO product_variation_mapping (product_item_id,variation_option_id) VALUES(?,?)");
			ps.setString(1, product_item);
			ps.setString(2, variation_option);
			ps.execute();
			ps = cn.prepareStatement("SELECT LAST_INSERT_ID()");
			rs = ps.executeQuery();
			rs.next();
			map_id = rs.getString(1);
			if (isColor) {
				String name = "productImg";
				for (int i = 1; i <= 5; i++) {
					String path = "";
					String PARAMETER_NAME = name + i;
					if (request.getPart(PARAMETER_NAME) != null) {
						Part fpart = request.getPart(PARAMETER_NAME);
						if (fpart.getSize() > 1) {
							String FILE_NAME = fpart.getSubmittedFileName();
							int index = FILE_NAME.lastIndexOf(".");
							String extention = FILE_NAME.substring(index + 1).toLowerCase();
							path = getServletContext().getRealPath(File.separator + "img" + File.separator + "shop"
									+ File.separator + "products" + File.separator + product);

							File dir = new File(path);
							if (!dir.exists()) {
								dir.mkdirs();
							}
							path += File.separator + product_item;
							dir = new File(path);
							if (!dir.exists()) {
								dir.mkdirs();
							}

							ps = cn.prepareStatement(
									"SELECT A.variation_option_id,B.var_value,C.product_name FROM `variation_options` A INNER JOIN variation_combo_values B ON A.variation_value_id=B.var_val_id INNER JOIN product C WHERE C.product_id=? and A.variation_option_id=?");
							ps.setString(1, product);
							ps.setString(2, variation_option);
							rs = ps.executeQuery();
							rs.next();
							String product_name = rs.getString("product_name");
							if (product_name.length() > 10) {
								product_name = product_name.substring(0, 10).trim();
							}
							// Updating The Path
							path += File.separator + i + " " + product_name + " " + rs.getString("var_value") + "."
									+ extention;
							// System.out.println(path);
							// Writing Image
							InputStream is = fpart.getInputStream();
							byte[] data = new byte[is.available()];
							FileOutputStream fos = new FileOutputStream(path);
							is.read(data);
							fos.write(data);
							fos.flush();
							fos.close();

//						for (Part part : request.getParts()) {
//							part.write(path);
//						}

							// Storing the Path In The database
							path = product + File.separator + product_item + File.separator + i + " " + product_name
									+ " " + rs.getString("var_value") + "." + extention;
							ps = cn.prepareStatement("INSERT INTO product_item_images (image_name,map_id) VALUES(?,?)");
							ps.setString(1, path);
							ps.setString(2, map_id);
							ps.execute();
						}
					}
				}
				if (isPublish) {
					ps = cn.prepareStatement("UPDATE product_item SET Active=? WHERE product_item_id=?");
					ps.setBoolean(1, true);
					ps.setString(2, product_item);
					ps.execute();
				}
			}
			out.print("<p class='text-success'>Product Variation Added SuccessFully</p>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
