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
 * Servlet implementation class AddPaymentMethod
 */
@WebServlet("/AddPaymentMethod")
public class AddPaymentMethod extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddPaymentMethod() {
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
			String payment_type_id = request.getParameter("payment-method");
			String name_on_card = request.getParameter("name-on-card");
			String account_number = PasswordOperations.passwordEncrypter(request.getParameter("account-number"));
			String expiry_date = request.getParameter("expiry");
			String is_default = request.getParameter("payment-primary");

			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps;
			if (is_default != null) {
				ps = cn.prepareStatement("UPDATE payment_methods SET is_default=? WHERE user_id=?");
				ps.setBoolean(1, false);
				ps.setString(2, session.getAttribute("uid").toString());
				ps.executeUpdate();
			}

			ps = cn.prepareStatement(
					"INSERT INTO payment_methods(user_id, payment_type_id, name_on_card, account_number, expiry_date, is_default) VALUES(?,?,?,?,?,?)");
			ps.setString(1, session.getAttribute("uid").toString());
			ps.setString(2, payment_type_id);
			ps.setString(3, name_on_card);
			ps.setString(4, account_number);
			ps.setString(5, expiry_date);
			if (is_default != null) {
				ps.setBoolean(6, true);
			} else {
				ps.setBoolean(6, false);
			}
			ps.executeUpdate();

			out.print("<p class='text-success'>Payment Method Added SuccessFully</p>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
