package userModule;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conModule.ConnectionProvider;
import generalModule.PasswordOperations;
import generalModule.SendNewEmail;
import generalModule.SiteConstants;

/**
 * Servlet implementation class SignUpAction
 */
@WebServlet(description = "for User SignUp", urlPatterns = { "/SignUpAction" })
public class SignUpAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SignUpAction() {
		super();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		String username = request.getParameter("txtName");
		String email = request.getParameter("txtEmail");
		String mobile = request.getParameter("txtMobile");
		String password = request.getParameter("txtPassword");
		password = PasswordOperations.passwordEncrypter(password);
		try {
			Connection con = ConnectionProvider.getCon();
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql = "";
			sql = "SELECT user_email FROM site_users WHERE user_email=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if (rs.isBeforeFirst()) {
				out.print("<p class='text-warning mt-2'>User with Same Email exists");
			} else {
				ps = con.prepareStatement(
						"INSERT INTO site_users (user_name,user_email,user_phone,user_password) VALUES(?,?,?,?)");
				ps.setString(1, username);
				ps.setString(2, email);
				ps.setString(3, mobile);
				ps.setString(4, password);
				ps.execute();
				ps = con.prepareStatement("SELECT LAST_INSERT_ID()");
				rs = ps.executeQuery();
				rs.next();
				session.setAttribute("uid", rs.getInt(1));
				out.println(1);
			}
			// Greeting Email
			String to = email;
			String subject = "Hello " + username + ", Welcome To MyECommerceSite";
			String body = "<h1>Hello," + username
					+ "</h1><h4><a style='color:cyan;text-decoration:none;font-weight:700;' href='"
					+ SiteConstants.SITE_URL + "/index.jsp'>Start Shopping</a></h4>";
			SendNewEmail greet = new SendNewEmail();
			greet.send(to, subject, body);

			RequestDispatcher fillcart = request.getRequestDispatcher("FillShoppingCart");
			fillcart.include(request, response);

		} catch (Exception e) {
			out.print("<p class='text-danger mt-2'>Error: " + e.getMessage() + "</p>");
		}
	}
}
