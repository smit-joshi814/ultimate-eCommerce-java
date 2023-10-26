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
import javax.servlet.http.HttpSession;

import conModule.ConnectionProvider;

/**
 * Servlet implementation class CreateProduct
 */
@WebServlet("/CreateProduct")
public class CreateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateProduct() {
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
			String productName = request.getParameter("productName");
			String brand = request.getParameter("ProductBrand");
			String productDescription = request.getParameter("productDescription");
			Connection cn = ConnectionProvider.getCon();

			String buildParam = request.getParameter("hdnMaxlevelP");
			String parentCategoryId = null;
			if (buildParam.equals("0")) {
				parentCategoryId = request.getParameter("cat_lavelP" + buildParam);
				// out.print("1: "+parentCategoryId);
			} else {
				buildParam = request.getParameter("hdnMaxlevelP");
				parentCategoryId = request.getParameter("cat_lavelP" + buildParam);
				// out.print("2: "+parentCategoryId);
			}
			if (parentCategoryId == null || parentCategoryId.equals("null")) {
				buildParam = request.getParameter("hdnMaxlevelOldP");
				parentCategoryId = request.getParameter("cat_lavelP" + buildParam);
				// out.print("3: "+parentCategoryId);
			}
			PreparedStatement ps = cn.prepareStatement(
					"INSERT INTO product (product_name,category_id,brand_id,product_description) VALUES(?,?,?,?)");
			ps.setString(1, productName.translateEscapes());
			if (parentCategoryId.equals("0")) {
				out.print("<p class='text-danger'>Please Select Category First</p>");
				return;
			} else {
				ps.setString(2, parentCategoryId);
			}
			ps.setString(3, brand);
			ps.setString(4, productDescription.translateEscapes());
			ps.execute();

			ps = cn.prepareStatement("SELECT LAST_INSERT_ID()");
			ResultSet rs = ps.executeQuery();
			rs.next();
			String product_id = rs.getString(1);

			// checking if current User is Company Or Not
			HttpSession session = request.getSession();
			String admin_id = session.getAttribute("aid").toString();
			ps = cn.prepareStatement("SELECT Admin_type FROM site_admins WHERE admin_id=?");
			ps.setString(1, admin_id);
			rs = ps.executeQuery();
			rs.next();
			boolean isCompany = rs.getString("Admin_type").equals("2");

			// if current user is company the We'll map the recently inserted product with
			// company's unique id
			if (isCompany) {
				ps = cn.prepareStatement("SELECT company_id FROM site_companies_info WHERE login_id=?");
				ps.setString(1, admin_id);
				rs = ps.executeQuery();
				rs.next();
				String company_id = rs.getString("company_id");
				// Mapping Product With company's id
				ps = cn.prepareStatement("INSERT INTO product_company_mapping (company_id,product_id) VALUES(?,?)");
				ps.setString(1, company_id);
				ps.setString(2, product_id);
				ps.execute();
			}

			out.print("<p class='text-success'>Product Created Successfully</p>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
