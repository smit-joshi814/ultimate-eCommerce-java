package userModule;

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
 * Servlet implementation class RemovePaymentMethod
 */
@WebServlet("/RemovePaymentMethod")
public class RemovePaymentMethod extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RemovePaymentMethod() {
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
			String payment_method_id = request.getParameter("pmid");
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement("DELETE FROM payment_methods WHERE payment_method_id=?");
			ps.setString(1, payment_method_id);
			ps.executeUpdate();
			out.print(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
