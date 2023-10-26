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
 * Servlet implementation class TableProductsMain
 */
@WebServlet("/TableProductsMain")
public class TableProductsMain extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TableProductsMain() {
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

			HttpSession session = request.getSession();
			String admin_id = session.getAttribute("aid").toString();
			ps = cn.prepareStatement("SELECT Admin_type FROM site_admins WHERE admin_id=?");
			ps.setString(1, admin_id);
			rs = ps.executeQuery();
			rs.next();
			boolean isCompany = rs.getString("Admin_type").equals("2");
			if (isCompany) {
				ps = cn.prepareStatement("SELECT company_id FROM site_companies_info WHERE login_id=?");
				ps.setString(1, admin_id);
				rs = ps.executeQuery();
				rs.next();
				String company_id = rs.getString("company_id");
				ps = cn.prepareStatement(
						"SELECT P.*,PC.category_name,B.brand_name FROM product P INNER JOIN product_categories PC ON P.category_id=PC.category_id INNER JOIN brands B ON P.brand_id=B.brand_id INNER JOIN product_company_mapping PCM ON PCM.product_id=p.product_id WHERE PCM.company_id=? ORDER BY P.product_id ASC");
				ps.setString(1, company_id);
			} else {
				ps.close();
				ps = cn.prepareStatement(
						"SELECT P.*,PC.category_name,B.brand_name FROM product P INNER JOIN product_categories PC ON P.category_id=PC.category_id INNER JOIN brands B ON P.brand_id=B.brand_id ORDER BY P.product_id ASC");
			}

			rs = ps.executeQuery();
			if (rs.isBeforeFirst()) {
				while (rs.next()) {
					out.print("<tr>");
					out.print("<td>" + rs.getString("product_id") + "</td>");
					out.print("<td>" + rs.getString("product_name") + "</td>");
					out.print("<td>" + rs.getString("category_name") + "</td>");
					out.print("<td>" + rs.getString("brand_name") + "</td>");
					ps = cn.prepareStatement("SELECT item_sku,item_quantity FROM product_item WHERE product_id=?");
					ps.setString(1, rs.getString("product_id"));
					ResultSet items = ps.executeQuery();
					String item_skus = "";
					String item_stocks = "";
					while (items.next()) {
						if (items.isLast()) {
							item_skus += items.getString("item_sku");
							item_stocks += items.getString("item_quantity");
						} else {
							item_skus += items.getString("item_sku") + "<br/>";
							item_stocks += items.getString("item_quantity") + "<br/>";
						}

					}
					out.print("<td>" + item_skus + "</td>");
					out.print("<td>" + item_stocks + "</td>");
					out.print("<td>" + rs.getString("product_description").substring(0, 20).trim() + "...</td>");
					out.print("<td><button data-proid=" + rs.getString("product_id")
							+ " class='btn btn-sm btn-info pshow' data-bs-toggle='modal' data-bs-target='#ShowProductItems'><i class='ci-eye'></i></button></td>");
					out.print("<td><button data-proid=" + rs.getString("product_id") + " data-pname='"
							+ rs.getString("product_name")
							+ "' class='btn btn-sm btn-warning editprod' data-bs-toggle='modal' data-bs-target='#ShowEditProduct'><i class='ci-edit'></i></button></td>");
					out.print("<td><button data-proid=" + rs.getString("product_id") + " data-pname='"
							+ rs.getString("product_name")
							+ "' class='btn btn-sm btn-danger pdelete'><i class='ci-trash'></i></button></td>");
					out.print("</tr>");

				}
			} else {
				out.print("<td class='text-danger text-center' colspan='10'>No Products Available</td>");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
