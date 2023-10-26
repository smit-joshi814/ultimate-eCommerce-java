package inventoryModule;

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
 * Servlet implementation class LoadBrands
 */
@WebServlet("/LoadBrands")
public class LoadBrands extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoadBrands() {
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
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement("SELECT * FROM brands");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				out.print("<tr><td>" + rs.getString("brand_id") + "</td><td>" + rs.getString("brand_name")
						+ "</td><td><button class='btn btn-warning btn-sm ebra' data-bs-toggle='modal' data-bs-target='#Editbrand' data-ebid='"
						+ rs.getString("brand_id") + "'	data-ebname='" + rs.getString("brand_name")
						+ "'><i class='ci-edit'></i></button></td><td><button class='btn btn-danger btn-sm dbra' data-dbid='"
						+ rs.getString("brand_id") + "'	data-dbname='" + rs.getString("brand_name")
						+ "'><i class='ci-trash'></i></button></td></tr>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
