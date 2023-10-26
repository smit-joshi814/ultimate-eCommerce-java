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
import javax.servlet.http.HttpSession;

import conModule.ConnectionProvider;
import generalModule.PasswordOperations;
import generalModule.SendNewEmail;
import generalModule.SiteConstants;

/**
 * Servlet implementation class ManageCompany
 */
@WebServlet("/ManageCompany")
public class ManageCompany extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ManageCompany() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getParameter("varification") != null && request.getParameter("company_id") != null) {
			try (PrintWriter out = response.getWriter()) {
				Connection cn = ConnectionProvider.getCon();
				PreparedStatement ps = cn
						.prepareStatement("UPDATE site_companies_info SET is_Allowed=?  WHERE company_id=?");
				ps.setString(1, "1");
				ps.setString(2, request.getParameter("company_id"));
				ps.execute();
				response.sendRedirect("admin/index.jsp");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()) {
			HttpSession session = request.getSession();
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps;
			ResultSet rs;

			String company_name = request.getParameter("txtName");
			String company_email = request.getParameter("hdnEmail");
			String company_phone = request.getParameter("txtPhone");
			String company_webSite = request.getParameter("txtSite");
			String company_GSTN = request.getParameter("txtGst");
			String Password = PasswordOperations.passwordEncrypter(request.getParameter("txtPassword"));
			ps = cn.prepareStatement("SELECT company_id FROM site_companies_info WHERE login_id=?");
			ps.setString(1, session.getAttribute("aid").toString());
			rs = ps.executeQuery();
			rs.next();
			String company_id = rs.getString(1);
			ps = cn.prepareStatement(
					"UPDATE site_companies_info SET company_name=?,company_phone=?,company_website=?,company_GSTN=?,is_Allowed=? WHERE company_id=?");
			ps.setString(1, company_name);
			ps.setString(2, company_phone);
			ps.setString(3, company_webSite);
			ps.setString(4, company_GSTN);
			ps.setString(5, "0");
			ps.setString(6, company_id);
			ps.execute();
			// out.print(company_email);
			String to = company_email;
			String subject = "MyECommerceSite: Company Verification Email";
			String body = "<h2>Click Below Link To Verify</h2><h5><a href='" + SiteConstants.SITE_URL
					+ "/ManageCompany?varification=1&company_id=" + company_id + "'>Verify Me</a></h5>";
			SendNewEmail email = new SendNewEmail();
			boolean isSent = email.send(to, subject, body);
			if (isSent) {
				out.print(
						"<p class='text-success'>Check Your Mail Box For varification Mail! You can Start Listing Products After varification</p>");
				ps = cn.prepareStatement("UPDATE site_admins SET password=? WHERE admin_id=?");
				ps.setString(1, Password);
				ps.setString(2, session.getAttribute("aid").toString());
				ps.execute();
			} else {
				out.print("<p class='text-danger'>There is Something Wrong At our Side Please Try After Some time</p>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
