package adminModule;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conModule.ConnectionProvider;
import generalModule.SendNewEmail;
import generalModule.SiteConstants;

/**
 * Servlet implementation class PasswordRecoveryEmail
 */
@WebServlet("/PasswordRecoveryEmail")
public class PasswordRecoveryEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PasswordRecoveryEmail() {
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
			String email = request.getParameter("Email").trim();
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn
					.prepareStatement("SELECT admin_id,admin_name FROM site_admins WHERE admin_email=?");
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if (!rs.isBeforeFirst()) {
				out.print(
						"<p class='text-danger'>Given Email Does Not Exist In Our System,<small class='text-warning'>Please Provide valid Email</small></p>");
				return;
			}
			rs.next();

			// String hash = GenerateRandomString.generateString();

			String to = email;
			String subject = "Password Recovery Email For MyECommerceSite -admin";
			String body = "<h2>Hello," + rs.getString("admin_name")
					+ "</h2><br/><h3>Click Below Link To Reset Password</h3><a href='" + SiteConstants.SITE_URL
					+ "/admin/SetNewPassword.jsp?verify=1&&email=" + email + "&&aid=" + rs.getString("admin_id")
					+ "'>Reset Password</a>";
			SendNewEmail send = new SendNewEmail();
			send.send(to, subject, body);
			out.print("<p class='text-success'>Password Reset Link Sent SuccessFully</p>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
