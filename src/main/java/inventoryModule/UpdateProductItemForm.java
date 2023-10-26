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
import product.ItemStatus;

/**
 * Servlet implementation class UpdateProductItemForm
 */
@WebServlet("/UpdateProductItemForm")
public class UpdateProductItemForm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateProductItemForm() {
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
			PreparedStatement ps = cn.prepareStatement("SELECT * FROM product_item WHERE product_item_id=?");
			ps.setString(1, product_item_id);
			ResultSet rs = ps.executeQuery();
			rs.next();
			boolean isColorAvailable = ItemStatus.isPublishable(product_item_id);

			out.print(
					"<form id='UpdateProductItem'><div class='mb-3'><label for='updateProductItem' class='form-label'>Product Item</label> <input id='updateProductItem' name='updateProductItem'	class='form-control' ");
			out.print("value='" + rs.getString("item_sku")
					+ "' disabled> <input type='hidden' name='hdnProductItemId' id='hdnProductItemId' ");
			out.print("value='" + rs.getString("product_item_id")
					+ "' /></div><div class='mb-3'><label for='updateproductQty' class='form-label'>Update Item Quantity <b>In Stock</b></label> <input type='number' class='form-control' id='updateproductQty' name='updateproductQty' ");
			out.print("value='" + rs.getString("item_quantity")
					+ "' required></div><div class='mb-3'><label for='updatelistPrice' class='form-label'>Update Listing Price</label> <input type='number' class='form-control' id='updatelistPrice' name='updatelistPrice' ");
			out.print("value='" + rs.getString("item_listing_price")
					+ "' required></div><div class='mb-3'><label for='updateselPrice' class='form-label'>Update Selling Price</label> <input type='number' class='form-control' id='updateselPrice' name='updateselPrice' ");
			out.print("value='" + rs.getString("item_selling_price")
					+ "' required></div><div class='mb-3'><label for='updatesku' class='form-label'>Update SKU</label> <input type='text' class='form-control' id='updatesku' name='updatesku' ");
			out.print("value='" + rs.getString("item_sku") + "' required></div>");
			if (isColorAvailable) {
				out.print("<input type='hidden' name='isColorExist' id='isColorExist' value='1' />");
				out.print(
						"<div class='form-check form-switch mb-3'><input class='form-check-input' name='isPublishChecked' type='checkbox' role='switch' id='isPublishChecked'");
				if (rs.getString("Active").equals("1")) {
					out.print("checked");
				}
				out.print("> <label class='form-check-label' for='isPublishChecked'>Publish ?</label></div>");
			} else {
				out.print(
						"<p class='text-info'>Item can Only be published after adding Color Variation<br/><small class='text-danger'>Please Add Color Variation to Publish The Item</small></p>");
				out.print("<input type='hidden' name='isColorExist' id='isColorExist' value='0' />");
			}
			out.print(
					"<div class='mb-2 mt-2' id='msgUpdateProductItemInfo'></div><button type='submit' class='btn btn-outline-primary'>Update Item</button></form>");

			out.print(
					"<script>$('#UpdateProductItem').on('submit',function(e){	e.preventDefault();	$.ajax({ url:'../UpdateProductItem', type:'POST', data:$(this).serialize(), success:function(data){ $('#msgUpdateProductItemInfo').hide(); $('#msgUpdateProductItemInfo').html(data); $('#msgUpdateProductItemInfo').fadeIn('slow'); } }); }); </script>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
