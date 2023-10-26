package userModule;

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

/**
 * Servlet implementation class AddAddress
 */
@WebServlet("/AddAddress")
public class AddAddress extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddAddress() {
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
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps;
			String address_line1 = request.getParameter("address-line1");
			String address_line2 = request.getParameter("address-line2");
			String zipPostal = request.getParameter("address-zip");
			String city = request.getParameter("city");
			String address_primary = null;
			if (request.getParameter("address-primary") != null) {
				address_primary = "1";
				ps = cn.prepareStatement("UPDATE user_address_mapping SET is_default=? WHERE user_id=?");
				ps.setString(1, "0");
				ps.setString(2, session.getAttribute("uid").toString());
				ps.execute();
			} else {
				address_primary = "0";
			}

			ps = cn.prepareStatement(
					"INSERT INTO address(address_line1,address_line2,city_id,postal_code) VALUES(?,?,?,?)");
			ps.setString(1, address_line1);
			ps.setString(2, address_line2);
			ps.setString(3, city);
			ps.setString(4, zipPostal);
			ps.execute();
			ps = cn.prepareStatement("SELECT LAST_INSERT_ID()");
			ResultSet rs = ps.executeQuery();
			rs.next();

			ps = cn.prepareStatement("INSERT INTO user_address_mapping(user_id,address_id,is_default) VALUES(?,?,?)");
			ps.setString(1, session.getAttribute("uid").toString());
			ps.setString(2, rs.getString(1));
			ps.setString(3, address_primary);
			ps.execute();
			out.print("<p class='text-success'>Address Added Successfully</p>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
