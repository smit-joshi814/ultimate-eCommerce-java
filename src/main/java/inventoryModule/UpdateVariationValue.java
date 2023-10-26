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
 * Servlet implementation class UpdateVariationValue
 */
@WebServlet("/UpdateVariationValue")
public class UpdateVariationValue extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateVariationValue() {
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
			PreparedStatement ps = cn
					.prepareStatement("UPDATE variation_combo_values SET var_value=? WHERE var_val_id=?");
			ps.setString(1, request.getParameter("mdlUpdateVariationValue"));
			ps.setString(2, request.getParameter("hdnmdlVarValId"));
			ps.execute();
			out.print("<p class='text-success'>Variation Value Updated SuccessFully</p>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
