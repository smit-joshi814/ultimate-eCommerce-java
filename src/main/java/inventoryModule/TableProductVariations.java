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
 * Servlet implementation class TableProductVariations
 */
@WebServlet("/TableProductVariations")
public class TableProductVariations extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TableProductVariations() {
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
			PreparedStatement ps = cn.prepareStatement(
					"SELECT A.map_id,VC.var_name,VCV.var_value FROM product_variation_mapping A INNER JOIN variation_options B ON A.variation_option_id=B.variation_option_id INNER JOIN variation_combo_values VCV ON B.variation_value_id=VCV.var_val_id INNER JOIN variation_combo VC ON VCV.var_id=VC.var_id WHERE product_item_id=?");
			ps.setString(1, product_item_id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				out.print("<tr><td>" + rs.getString("var_name") + "</td><td>" + rs.getString("var_value") + "</td>");
				out.print("<td><button data-mapid='" + rs.getString("map_id") + "' data-varname='"
						+ rs.getString("var_name")
						+ "' class='btn btn-sm btn-danger mapdel'><i class='ci-trash'></i></button></td>");
				out.print("</tr>");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
