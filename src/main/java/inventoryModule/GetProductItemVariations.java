package inventoryModule;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conModule.ConnectionProvider;
import product.Product;

/**
 * Servlet implementation class GetProductItemVariations
 */
@WebServlet("/GetProductItemVariations")
public class GetProductItemVariations extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetProductItemVariations() {
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
			PreparedStatement ps;
			ResultSet rs;
			int category_id;

			ArrayList<Integer> checkVariations = new ArrayList<>();
			ps = cn.prepareStatement(
					"SELECT B.variation_id from product_variation_mapping A INNER JOIN variation_options B ON A.variation_option_id=B.variation_option_id INNER JOIN variation C ON B.variation_id=C.variation_id WHERE A.product_item_id=?");
			ps.setString(1, product_item_id);
			rs = ps.executeQuery();
			while (rs.next()) {
				checkVariations.add(rs.getInt("variation_id"));
			}

			ps = cn.prepareStatement(
					"SELECT c.category_id FROM product_item A INNER JOIN product B ON A.product_id=B.product_id INNER JOIN product_categories C ON B.category_id=C.category_id WHERE A.product_item_id=?");
			ps.setString(1, product_item_id);
			rs = ps.executeQuery();
			rs.next();
			category_id = rs.getInt("category_id");

			ps = cn.prepareStatement(
					"SELECT A.variation_id,B.var_name FROM variation A INNER JOIN variation_combo B ON A.variation_name_id=B.var_id WHERE category_id=?");
			ps.setInt(1, category_id);
			rs = ps.executeQuery();
			while (!rs.isBeforeFirst()) {
				category_id = Product.getSuperCategoryId(category_id);
				ps = cn.prepareStatement(
						"SELECT A.variation_id,B.var_name FROM variation A INNER JOIN variation_combo B ON A.variation_name_id=B.var_id WHERE category_id=?");
				ps.setInt(1, category_id);
				rs.close();
				rs = ps.executeQuery();
			}

			out.print("<option value>Select Variation</option>");
			while (rs.next()) {
				boolean isAlreadyCreated = false;
				for (Integer checkVariation : checkVariations)
					if (checkVariation.equals(rs.getInt("variation_id"))) {
						isAlreadyCreated = true;
						break;
					} else {
						isAlreadyCreated = false;
					}
				if (!isAlreadyCreated) {
					out.print("<option value='" + rs.getString("variation_id") + "'>" + rs.getString("var_name")
							+ "</option>");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
