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
 * Servlet implementation class AddProductVariation
 */
@WebServlet("/AddProductVariation")
public class AddProductVariation extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddProductVariation() {
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
			String productVariationName = request.getParameter("productVariationNames");
			String[] productVariationValues = request.getParameterValues("varValues[]");
			Connection cn = ConnectionProvider.getCon();

			String buildParam = request.getParameter("hdnMaxlevelPV");
			String parentCategoryId = null;
			if (buildParam.equals("0")) {
				parentCategoryId = request.getParameter("cat_lavelPV" + buildParam);
				// out.print("1: " + parentCategoryId);
			} else {
				buildParam = request.getParameter("hdnMaxlevelP");
				parentCategoryId = request.getParameter("cat_lavelPV" + buildParam);
				// out.print("2: " + parentCategoryId);
			}
			if (parentCategoryId == null || parentCategoryId.equals("null")) {
				buildParam = request.getParameter("hdnMaxlevelOldPV");
				parentCategoryId = request.getParameter("cat_lavelPV" + buildParam);
				// out.print("3: " + parentCategoryId);
			}
			PreparedStatement ps = cn
					.prepareStatement("INSERT INTO variation (variation_name_id,category_id) VALUES(?,?)");
			ps.setString(1, productVariationName.translateEscapes());
			if (parentCategoryId.equals("0")) {
				out.print("<p class='text-danger'>Please Select Category First</p>");
				return;
			} else {
				ps.setString(2, parentCategoryId);
				// out.print("Normal");
			}
			ps.execute();
			ps = cn.prepareStatement("SELECT LAST_INSERT_ID()");
			ResultSet rs = ps.executeQuery();
			rs.next();
			for (String variation : productVariationValues) {
				ps = cn.prepareStatement("INSERT INTO variation_options(variation_value_id,variation_id) VALUES(?,?)");
				ps.setString(1, variation.trim());
				ps.setString(2, rs.getString(1));
				ps.execute();
			}
			out.print("<p class='text-success'>Product Variation Created Successfully</p>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
