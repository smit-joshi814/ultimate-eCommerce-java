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
 * Servlet implementation class UpdateProductItem
 */
@WebServlet("/UpdateProductItem")
public class UpdateProductItem extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateProductItem() {
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

			String product_item_id = request.getParameter("hdnProductItemId");
			String item_quantity = request.getParameter("updateproductQty");
			String item_listing_price = request.getParameter("updatelistPrice");
			String item_salling_price = request.getParameter("updateselPrice");
			String item_sku = request.getParameter("updatesku");
			boolean isColorExist = request.getParameter("isColorExist").toString().equals("1");
			boolean active = false;
			if (isColorExist) {
				if (request.getParameter("isPublishChecked") != null) {
					active = true;
				}
			} else {
				active = false;
			}

			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement(
					"UPDATE product_item SET item_quantity=?,item_listing_price=?,item_selling_price=?,item_sku=?,Active=? WHERE product_item_id=?");
			ps.setString(1, item_quantity);
			ps.setString(2, item_listing_price);
			ps.setString(3, item_salling_price);
			ps.setString(4, item_sku);
			ps.setBoolean(5, active);
			ps.setString(6, product_item_id);
			ps.execute();
			out.print("<p class='text-success'>Product Item Updated SuccessFully</p>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
