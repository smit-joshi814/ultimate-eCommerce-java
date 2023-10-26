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
 * Servlet implementation class RemoveVariation
 */
@WebServlet("/RemoveVariation")
public class RemoveVariation extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RemoveVariation() {
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
			String varId = request.getParameter("varId");
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement("DELETE FROM variation_options WHERE variation_id=?");
			ps.setString(1, varId);
			ps.execute();
			ps = cn.prepareStatement("DELETE FROM variation WHERE variation_id=?");
			ps.setString(1, varId);
			ps.execute();
			out.print(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
