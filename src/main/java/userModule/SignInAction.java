package userModule;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import conModule.ConnectionProvider;
import generalModule.PasswordOperations;
import generalModule.SendNewEmail;
import generalModule.SiteConstants;

@WebServlet(description = "for user sign in", urlPatterns = { "/SignInAction" })
public class SignInAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SignInAction() {
		super();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String email = request.getParameter("txtEmail").trim();
		String password = PasswordOperations.passwordEncrypter(request.getParameter("txtPassword"));
		if (request.getParameter("chkRemember") != null) {
			Cookie em = new Cookie("email", PasswordOperations.passwordEncrypter(email));
			Cookie ps = new Cookie("password", password);
			em.setMaxAge(SiteConstants.MAX_COOKIE_AGE_FOR_USER);
			ps.setMaxAge(SiteConstants.MAX_COOKIE_AGE_FOR_USER);
			response.addCookie(em);
			response.addCookie(ps);
		}
		try {
			String user_name = "";
			boolean loginStatus = false;

			Connection con = ConnectionProvider.getCon();
			String sql = "SELECT user_id,user_email,user_password,user_name FROM site_users WHERE user_email=? and user_password=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if (!rs.isBeforeFirst()) {
				out.print("<p class='text-danger mt-2'>Invalid Email Or Password<p>");
				loginStatus = false;
			} else {
				rs.next();
				session.setAttribute("uid", rs.getString("user_id"));
				out.print(1);
				user_name = rs.getString("user_name");
				loginStatus = true;
			}
			// New Login Email
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			Date date = new Date();

			String to = email;
			String subject = "";
			if (loginStatus) {
				subject = "MyECommerceSite : New Login Detected To Your Account";
			} else {
				subject = "MyECommerceSite : Unknown Login Attempt Detected To Your Account";
			}
			String body = "";
			if (loginStatus) {
				body = "<h1>Hello, " + user_name + "</h1><h3>Your Login Time Is : " + formatter.format(date) + "</h3>";
			} else {
				body = "<h3 style='color:red'>Unknown / UnsuccesFull Login Attempt Time : " + formatter.format(date)
						+ "</h3>";
			}
			SendNewEmail emailAttemp = new SendNewEmail();
			emailAttemp.send(to, subject, body);

			RequestDispatcher fillcart = request.getRequestDispatcher("FillShoppingCart");
			fillcart.include(request, response);

		} catch (Exception e) {
			out.print("<p class='text-danger mt-2'>Error: " + e.getMessage() + "</p>");
		}
	}
}