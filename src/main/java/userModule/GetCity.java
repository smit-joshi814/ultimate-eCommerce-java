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
 * Servlet implementation class GetCity
 */
@WebServlet("/GetCity")
public class GetCity extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetCity() {
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
			String state = request.getParameter("state");
			Connection cn = ConnectionProvider.getCon();
			try {
				PreparedStatement ps = cn.prepareStatement(
						"SELECT city_id,city_name FROM cities WHERE state_id=? ORDER BY city_name ASC");
				ps.setString(1, state);
				ResultSet rs = ps.executeQuery();
				if (rs.isBeforeFirst()) {
					out.print(" <option value>Select City</option>");
					while (rs.next()) {
						out.print("<option value='" + rs.getString("city_id") + "'>" + rs.getString("city_name")
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
