package adminModule;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conModule.ConnectionProvider;
import generalModule.PasswordOperations;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminLogin() {
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
			String txtEmail = request.getParameter("txtEmail");
			String txtPassword = request.getParameter("txtPassword");
			txtEmail = txtEmail.trim();
			txtPassword = PasswordOperations.passwordEncrypter(txtPassword);
			if (request.getParameter("remember") != null) {
				Cookie adminEmail = new Cookie("adminEmail", PasswordOperations.passwordEncrypter(txtEmail));
				Cookie adminPassword = new Cookie("adminPassword", txtPassword);
				adminEmail.setMaxAge(60 * 60 * 24 * 5);
				adminPassword.setMaxAge(60 * 60 * 24 * 5);
				response.addCookie(adminEmail);
				response.addCookie(adminPassword);
			}
			Connection cn = ConnectionProvider.getCon();
			try {
				PreparedStatement ps = cn
						.prepareStatement("SELECT admin_id FROM site_admins WHERE admin_email=? AND password=?");
				ps.setString(1, txtEmail);
				ps.setString(2, txtPassword);
				ResultSet rs = ps.executeQuery();
				if (!rs.isBeforeFirst()) {
					out.print("<p class='text-danger'>Invalid Email Or Password</p>");
				} else {
					rs.next();
					HttpSession session = request.getSession();
					session.setAttribute("aid", rs.getString("admin_id"));
					out.print(1);
				}
			} catch (SQLException e) {
				out.print("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
			}
		}
	}
}
