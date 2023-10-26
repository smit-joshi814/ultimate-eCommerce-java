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
import generalModule.PasswordOperations;

/**
 * Servlet implementation class UpdatePaymentMethod
 */
@WebServlet("/UpdatePaymentMethod")
public class UpdatePaymentMethod extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdatePaymentMethod() {
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
			String payment_type_id = request.getParameter("updpayment-method");
			String name_on_card = request.getParameter("updname-on-card");
			String account_number = PasswordOperations.passwordEncrypter(request.getParameter("updaccount-number"));
			String expiry_date = request.getParameter("updexpiry");
			String is_default = request.getParameter("updpayment-primary");
			String payment_method_id = request.getParameter("hdnpmid");

			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps;
			if (is_default != null) {
				ps = cn.prepareStatement("UPDATE payment_methods SET is_default=? WHERE user_id=?");
				ps.setBoolean(1, false);
				ps.setString(2, session.getAttribute("uid").toString());
				ps.executeUpdate();
			}
			ps = cn.prepareStatement(
					"UPDATE payment_methods SET payment_type_id=?,name_on_card=?,account_number=?,expiry_date=?,is_default=? WHERE payment_method_id=?");
			ps.setString(1, payment_type_id);
			ps.setString(2, name_on_card);
			ps.setString(3, account_number);
			ps.setString(4, expiry_date);
			if (is_default != null) {
				ps.setBoolean(5, true);
			} else {
				ps.setBoolean(5, false);
			}
			ps.setString(6, payment_method_id);
			ps.executeUpdate();
			out.print("<p class='text-success'>Changes Saved Successfully</p>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
