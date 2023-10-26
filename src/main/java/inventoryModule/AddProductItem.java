package inventoryModule;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conModule.ConnectionProvider;

/**
 * Servlet implementation class AddProductItem
 */
@WebServlet("/AddProductItem")
public class AddProductItem extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddProductItem() {
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
			String Product = request.getParameter("ProductList");
			String productQty = request.getParameter("productQty");
			String listPrice = request.getParameter("listPrice");
			String selPrice = request.getParameter("selPrice");
			String sku = request.getParameter("sku");

			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement(
					"INSERT INTO product_item (`item_quantity`, `item_listing_price`, `item_selling_price`,`item_sku`, `product_id`) VALUES (?,?,?,?,?)");
			ps.setString(1, productQty);
			ps.setString(2, listPrice);
			ps.setString(3, selPrice);
			ps.setString(4, sku);
			ps.setString(5, Product);
			ps.execute();
			out.print("<p class='text-success'>Product Item Added SuccessFully</p>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
