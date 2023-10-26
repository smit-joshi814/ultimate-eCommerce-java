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
import generalModule.PasswordOperations;

/**
 * Servlet implementation class SetNewPasswordForUser
 */
@WebServlet("/SetNewPasswordForUser")
public class SetNewPasswordForUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SetNewPasswordForUser() {
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
			String password = request.getParameter("password").trim();
			String email = request.getParameter("hdnemail").trim();
			password = PasswordOperations.passwordEncrypter(password);
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement("UPDATE site_users SET user_password=? WHERE user_email=?");
			ps.setString(1, password);
			ps.setString(2, email);
			ps.execute();
			out.print("<p class='text-success'>Password Updated SuccessFully</p>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
