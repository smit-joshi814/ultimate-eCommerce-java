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
import generalModule.PasswordOperations;

/**
 * Servlet implementation class CreateNewAdmin
 */
@WebServlet("/CreateNewAdmin")
public class CreateNewAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateNewAdmin() {
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
			String txtName = request.getParameter("txtName");
			String txtEmail = request.getParameter("txtEmail");
			String txtPass = request.getParameter("txtPassword");
			String role = request.getParameter("AdminRole");
			txtEmail = txtEmail.trim();
			txtPass = PasswordOperations.passwordEncrypter(txtPass);
			Connection cn = ConnectionProvider.getCon();
			try {
				PreparedStatement ps = cn.prepareStatement("SELECT admin_email FROM site_admins WHERE admin_email=?");
				ps.setString(1, txtEmail);
				ResultSet rs = ps.executeQuery();
				if (rs.isBeforeFirst()) {
					out.print("<p class='text-warning'>User With Same Email Already Exists</p");
				} else {
					ps = cn.prepareStatement(
							"INSERT INTO site_admins (admin_name,admin_email,password,is_verified,admin_type) VALUES(?,?,?,?,?)");
					ps.setString(1, txtName);
					ps.setString(2, txtEmail);
					ps.setString(3, txtPass);
					ps.setString(4, "1");
					ps.setString(5, role);
					ps.execute();

					if (role.equals("2")) {
						ps = cn.prepareStatement("SELECT LAST_INSERT_ID()");
						rs = ps.executeQuery();
						rs.next();
						ps = cn.prepareStatement("INSERT INTO site_companies_info (login_id,is_Allowed) VALUES(?,?)");
						ps.setString(1, rs.getString(1));
						ps.setString(2, "0");
						ps.execute();
					}
					out.print("<p class='text-success'>Admin Created SuccessFully</p>");
				}
			} catch (SQLException e) {
				out.print("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
			}
		}
	}

}
