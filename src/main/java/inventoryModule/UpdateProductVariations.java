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
 * Servlet implementation class UpdateProductVariations
 */
@WebServlet("/UpdateProductVariations")
public class UpdateProductVariations extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateProductVariations() {
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
			String varId = request.getParameter("hdnVarId");
			String varName = request.getParameter("mdlVariationName");
			String[] varValues = request.getParameter("mdlVariationValues").split(",");
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement("UPDATE variation SET variation_name=? WHERE variation_id=?");
			ps.setString(1, varName);
			ps.setString(2, varId);
			ps.execute();
			ps = cn.prepareStatement("DELETE FROM variation_options WHERE variation_id=?");
			ps.setString(1, varId);
			ps.execute();
			for (String varValue : varValues) {
				ps = cn.prepareStatement("INSERT INTO variation_options(variation_value,variation_id) VALUES(?,?)");
				ps.setString(1, varValue.trim());
				ps.setString(2, varId);
				ps.execute();
			}
			out.print("<p class='text-success'>Variation Updated Successfully</p>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
