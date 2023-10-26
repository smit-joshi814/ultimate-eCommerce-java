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
 * Servlet implementation class UpdateProductForm
 */
@WebServlet("/UpdateProductForm")
public class UpdateProductForm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateProductForm() {
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
			String product_id = request.getParameter("product_id");
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement(
					"SELECT P.product_id,P.product_name,P.product_description,PC.category_name,B.brand_name FROM product P INNER JOIN product_categories PC ON P.category_id=PC.category_id INNER JOIN brands B ON P.brand_id=B.brand_id WHERE product_id=?");
			ps.setString(1, product_id);
			ResultSet rs = ps.executeQuery();
			rs.next();
			out.print(
					"<form id='updateProduct'><div class='mb-3'><label for='updateproductName' class='form-label'>Product Name</label> <input type='text' class='form-control' id='updateproductName'	name='updateproductName' ");
			out.print("value='" + rs.getString("product_name")
					+ "'	required></div><div class='mb-3'><label for='updateproductCategory' class='form-label'>Product Category</label> <input type='text' class='form-control' id='updateproductCategory' name='updateproductCategory'");
			out.print("value='" + rs.getString("category_name")
					+ "' disabled></div><div class='mb-3'><label for='updateProductBrand'>Brand</label> <input class='form-control' id='updateProductBrand' name='updateProductBrand'");
			out.print("value='" + rs.getString("brand_name")
					+ "' disabled></div><div class='mb-3'><label for='updateproductDescription' class='form-label'>Description</label><textarea class='form-control' id='updateproductDescription' rows='10' minlength='200' maxlength='2000' name='updateproductDescription' required>");
			out.print(rs.getString("product_description")
					+ "</textarea></div><div class='mb-2 mt-2' id='msgProductUpdateInfo'></div>");
			out.print("<input type='hidden' value='" + rs.getString("product_id")
					+ "' name='hdnproduct_id' id='hdnproduct_id' />");
			out.print("<button type='submit' class='btn btn-outline-primary'>Update Product</button></form>");

			out.print("<script>$('#updateProduct').on('submit',function(e){let product_id=" + rs.getString("product_id")
					+ "; e.preventDefault(); $.ajax({	url:'../UpdateProduct', type:'POST', data:$(this).serialize(), success:function(data){ $('#msgProductUpdateInfo').hide(); $('#msgProductUpdateInfo').html(data); $('#msgProductUpdateInfo').fadeIn('slow');	} }); });</script>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
