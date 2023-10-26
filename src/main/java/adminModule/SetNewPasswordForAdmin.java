package adminModule;

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
import generalModule.PasswordOperations;

/**
 * Servlet implementation class SetNewPasswordForAdmin
 */
@WebServlet("/SetNewPasswordForAdmin")
public class SetNewPasswordForAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SetNewPasswordForAdmin() {
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

			String email = request.getParameter("hdnemail").trim();
			String admin_id = request.getParameter("hdnaid");
			String password = request.getParameter("password").trim();
			String conpassword = request.getParameter("conpassword").trim();
			if (password.length() < 8) {
				out.print("<p class='text-danger'>Password Should Be Atleast 8 characters Long<p>");
				return;
			}
			if (password.equals(conpassword)) {
				password = PasswordOperations.passwordEncrypter(password);
				Connection cn = ConnectionProvider.getCon();
				PreparedStatement ps = cn
						.prepareStatement("UPDATE site_admins SET password=? WHERE admin_email=? AND admin_id=?");
				ps.setString(1, password);
				ps.setString(2, email);
				ps.setString(3, admin_id);
				ps.execute();
				out.print("<p class='text-success'>Password Updated SuccessFully</p>");
			} else {
				out.print("<p class='text-danger'>Password Does Not match</p>");
				return;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
