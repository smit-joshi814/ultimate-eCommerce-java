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
import generalModule.PasswordOperations;

/**
 * Servlet implementation class LoadUpdatePaymentMethodModal
 */
@WebServlet("/LoadUpdatePaymentMethodModal")
public class LoadUpdatePaymentMethodModal extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoadUpdatePaymentMethodModal() {
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

			String payment_method_id = request.getParameter("pmid");
			String payment_type_id;
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps;
			ResultSet rs, rs1;
			ps = cn.prepareStatement("SELECT * FROM payment_methods WHERE payment_method_id=?");
			ps.setString(1, payment_method_id);
			rs = ps.executeQuery();
			rs.next();
			payment_type_id = rs.getString("payment_type_id");

			ps = cn.prepareStatement(
					"SELECT * FROM payment_types WHERE payment_type_name NOT LIKE '%cash On Delivery%'");
			rs1 = ps.executeQuery();

			out.print("<div class='row g-3 mb-2'>");

			while (rs1.next()) {
				out.print("<div class='col-sm-6 form-check mb-1'>");
				out.print("<input class='form-check-input' type='radio' name='updpayment-method' value='"
						+ rs1.getString("payment_type_id") + "' ");
				if (payment_type_id.equals(rs1.getString("payment_type_id"))) {
					out.print("checked");
				}
				out.print(">");
				out.print("<label class='form-check-label'>" + rs1.getString("payment_type_name") + "</label></div>");
			}
			out.print("<div class='col-sm-6'>");
			out.print(
					"<input class='form-control' type='number' name='updaccount-number'	max='9999999999999999' placeholder='Card Number' value='"
							+ PasswordOperations.PasswordDecrypter(rs.getString("account_number")) + "' required>");
			out.print("<div class='invalid-feedback'>Please fill in the card number!</div></div>");
			out.print("<div class='col-sm-6'>");
			out.print("<input class='form-control' type='text' name='updname-on-card'	placeholder='Full Name' value='"
					+ rs.getString("name_on_card") + "' required>");
			out.print("<div class='invalid-feedback'>Please provide name on the	card!</div></div>");
			out.print("<div class='col-sm-3'><input class='form-control' type='text' name='updexpiry' value='"
					+ rs.getString("expiry_date") + "' placeholder='MM/YY' required>");
			out.print("<div class='invalid-feedback'>Please provide card expiration date!</div></div>");
			out.print("<div class='col-sm-3 mt-4'><div class='form-check'>");
			out.print(
					"<input class='form-check-input' type='checkbox' id='updpayment-primary' name='updpayment-primary' ");
			if (rs.getString("is_default").equals("1")) {
				out.print("checked");
			}
			out.print("> <label class='form-check-label' for='updpayment-primary'>Make this Card primary</label>");
			out.print("</div></div><div class='col-sm-6'>");
			out.print(
					"<button class='btn btn-primary d-block w-100' type='submit'>Save Changes</button></div><div class='col-sm-12' id='changestatus'></div></div>");
			out.print("<input type='hidden' name='hdnpmid' value=" + payment_method_id + " />");

			out.print("<script>$('#update-payment').on('submit', function(e) {");
			out.print(
					"e.preventDefault();$.ajax({url : 'UpdatePaymentMethod',type : 'POST',data : $(this).serialize(),success : function(data) {$('#changestatus').hide();$('#changestatus').html(data);$('#changestatus').fadeIn();}});});</script>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
