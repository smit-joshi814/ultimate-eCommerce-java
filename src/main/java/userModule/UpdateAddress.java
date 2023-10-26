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
import javax.servlet.http.HttpSession;

import conModule.ConnectionProvider;

/**
 * Servlet implementation class UpdateAddress
 */
@WebServlet("/UpdateAddress")
public class UpdateAddress extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateAddress() {
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
			HttpSession session = request.getSession();
			String address_id = request.getParameter("hdnaddress_id");
			String address_line1 = request.getParameter("address-line1Upd");
			String address_line2 = request.getParameter("address-line2Upd");
			String zipPostal = request.getParameter("address-zipUpd");
			String city = request.getParameter("cityUpd");
			String address_primary = "0";
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps;
			if (request.getParameter("address-primaryUpd") != null) {
				// This Will Set All is_defaults To 0
				ps = cn.prepareStatement("UPDATE user_address_mapping SET is_default=? WHERE user_id=?");
				ps.setString(1, "0");
				ps.setString(2, session.getAttribute("uid").toString());
				ps.execute();
				// To On Particular is_default On
				address_primary = "1";
			}

			ps = cn.prepareStatement("UPDATE user_address_mapping SET is_default=? WHERE address_id=?");
			ps.setString(1, address_primary);
			ps.setString(2, address_id);
			ps.execute();

			ps = cn.prepareStatement(
					"UPDATE address SET address_line1=?,address_line2=?,postal_code=?,city_id=? WHERE address_id=?");
			ps.setString(1, address_line1);
			ps.setString(2, address_line2);
			ps.setString(3, zipPostal);
			ps.setString(4, city);
			ps.setString(5, address_id);
			ps.execute();
			out.print("<p class='text-success'>Address Updated Successfully</p>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
