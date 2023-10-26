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
 * Servlet implementation class UpdateVariationsOptions
 */
@WebServlet("/UpdateVariationsOptions")
public class UpdateVariationsOptions extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateVariationsOptions() {
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
			String var_Id = request.getParameter("mdlHdnVariationId");
			String productVariationValues[] = request.getParameterValues("UpdatevarValues[]");

			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement("DELETE FROM variation_options WHERE variation_id=?");
			ps.setString(1, var_Id);
			ps.execute();

			for (String variation : productVariationValues) {
				ps = cn.prepareStatement("INSERT INTO variation_options(variation_value_id,variation_id) VALUES(?,?)");
				ps.setString(1, variation.trim());
				ps.setString(2, var_Id);
				ps.execute();
			}
			out.print("<p class='text-success'>Variations Updated SuccessFully</p>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
