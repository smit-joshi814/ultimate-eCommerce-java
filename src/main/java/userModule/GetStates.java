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

import conModule.ConnectionProvider;

/**
 * Servlet implementation class GetStates
 */
@WebServlet("/GetStates")
public class GetStates extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetStates() {
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
			String country = request.getParameter("country");
			Connection cn = ConnectionProvider.getCon();
			try {
				PreparedStatement ps = cn.prepareStatement("SELECT state_id,state_name FROM states WHERE country_id=?");
				ps.setString(1, country);
				ResultSet rs = ps.executeQuery();
				if (rs.isBeforeFirst()) {
					out.print("<option value>Select State</option>");
					while (rs.next()) {
						out.print("<option value='" + rs.getString("state_id") + "'>" + rs.getString("state_name")
								+ "</option>");
					}
				} else {
					out.print("<option selected>Available Soon..</option>");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
