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

import conModule.ConnectionProvider;

/**
 * Servlet implementation class RemoveAddress
 */
@WebServlet("/RemoveAddress")
public class RemoveAddress extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RemoveAddress() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()) {
			String address_id = request.getParameter("address_id");
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement("DELETE FROM user_address_mapping WHERE address_id=?");
			ps.setString(1, address_id);
			ps.execute();
			ps = cn.prepareStatement("DELETE FROM address WHERE address_id=?");
			ps.setString(1, address_id);
			ps.execute();
			out.print("<p class='text-success'>Address Deleted Successfully</p>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
