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
 * Servlet implementation class LoadAdressDetails
 */
@WebServlet("/LoadAdressDetails")
public class LoadAdressDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoadAdressDetails() {
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
			String address_id = request.getParameter("address_id");
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement(
					"select A.*,S.state_id,B.country_id,u.is_default FROM address A INNER JOIN cities C ON A.city_id = C.city_id INNER JOIN states S ON S.state_id= S.state_id INNER JOIN countries B ON S.country_id=B.country_id INNER JOIN user_address_mapping U ON A.address_id=U.address_id WHERE A.address_id=? AND A.city_id=C.city_id AND S.state_id=C.state_id AND S.country_id = S.country_id AND A.address_id=U.address_id");
			ps.setString(1, address_id);
			ResultSet rs = ps.executeQuery();
			rs.next();

			out.print(
					"<div class='row gx-4 gy-3'><div class='col-sm-6'><label class='form-label' for='countryUpd'>Country</label><select class='form-select' id='countryUpd' name='countryUpd' required><option value>Select Country</option>");

			ps = cn.prepareStatement("SELECT country_id,country_name FROM countries");
			ResultSet rsCountries = ps.executeQuery();
			while (rsCountries.next()) {
				if (rs.getString("country_id").equals(rsCountries.getString("country_id"))) {
					out.print("<option value='" + rsCountries.getString("country_id") + "' selected>"
							+ rsCountries.getString("country_name") + "</option>");
				} else {
					out.print("<option value='" + rsCountries.getString("country_id") + "'>"
							+ rsCountries.getString("country_name") + "</option>");
				}
			}
			out.print(
					"</select><div class='invalid-feedback'>Please select your country!</div></div><div class='col-sm-6'><label class='form-label' for='stateUpd'>State</label><select class='form-select' id='stateUpd' name='stateUpd' required><option value>Select Country First</option>");
			ps = cn.prepareStatement("SELECT state_id,state_name FROM states WHERE country_id=?");
			ps.setString(1, rs.getString("country_id"));
			ResultSet rsStates = ps.executeQuery();
			while (rsStates.next()) {
				if (rs.getString("state_id").equals(rsStates.getString("state_id"))) {
					out.print("<option value='" + rsStates.getString("state_id") + "' selected>"
							+ rsStates.getString("state_name") + "</option>");
				} else {
					out.print("<option value='" + rsStates.getString("state_id") + "'>"
							+ rsStates.getString("state_name") + "</option>");
				}
			}
			out.print(
					"</select><div class='invalid-feedback'>Please select your state!</div></div><div class='col-sm-6'><label class='form-label' for='cityUpd'>City</label><select class='form-select' id='cityUpd' name='cityUpd' required><option value>Select State First</option>");
			ps = cn.prepareStatement("SELECT city_id,city_name FROM cities WHERE state_id=?");
			ps.setString(1, rs.getString("state_id"));
			ResultSet rsCities = ps.executeQuery();
			while (rsCities.next()) {
				if (rs.getString("city_id").equals(rsCities.getString("city_id"))) {
					out.print("<option value='" + rsCities.getString("city_id") + "' selected>"
							+ rsCities.getString("city_name") + "</option>");
				} else {
					out.print("<option value='" + rsCities.getString("city_id") + "' >"
							+ rsCities.getString("city_name") + "</option>");
				}
			}
			out.print(
					"</select><div class='invalid-feedback'>Please select your city!</div></div><div class='col-sm-6'><label class='form-label' for='address-line1Upd'>Line 1</label>");
			out.print("<input class='form-control' type='text' id='address-line1Upd' name='address-line1Upd' value='"
					+ rs.getString("address_line1")
					+ "' required><div class='invalid-feedback'>Please fill in your address!</div></div><div class='col-sm-6'><label class='form-label' for='address-line2Upd'>Line 2</label>");
			out.print("<input class='form-control' type='text' id='address-line2Upd' name='address-line2Upd' value='"
					+ rs.getString("address_line2")
					+ "'></div><div class='col-sm-6'><label class='form-label' for='address-zipUpd'>ZIP code</label>");
			out.print("<input class='form-control' type='text' id='address-zipUpd' name='address-zipUpd' value='"
					+ rs.getString("postal_code")
					+ "' required><div class='invalid-feedback'>Please add your ZIP code!</div></div><div class='col-12'><div class='form-check'>");
			if (rs.getString("is_default").equals("1")) {
				out.print(
						"<input class='form-check-input' type='checkbox' id='address-primaryUpd' name='address-primaryUpd' checked>");
			} else {
				out.print(
						"<input class='form-check-input' type='checkbox' id='address-primaryUpd' name='address-primaryUpd' >");
			}
			out.print(
					"<label class='form-check-label' for='address-primaryUpd'>Make this address primary</label></div></div><div class='mt-2 mb-2' id='msgUpdated'></div></div>");
			out.print("<input type='hidden' name='hdnaddress_id' value='" + address_id + "' >");
			out.print(
					"<script>$('#countryUpd').change(function() {let country = $(this).val();$.ajax({url : 'GetStates',type : 'POST',data : {country : country},success : function(data) {$('#stateUpd').html(data);}});});$('#stateUpd').change(function() {let state = $(this).val();$.ajax({url : 'GetCity',type : 'POST',data : {state : state},success : function(data) {$('#cityUpd').html(data);}});});</script>");

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
