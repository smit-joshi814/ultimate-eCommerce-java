package product;

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
 * Servlet implementation class PostReview
 */
@WebServlet("/PostReview")
public class PostReview extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PostReview() {
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

			String review_rating = request.getParameter("review-rating");
			String review_text = request.getParameter("review-text");

			HttpSession session = request.getSession();
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps = cn.prepareStatement(
					"SELECT L.order_line_id FROM order_line L INNER JOIN shop_order O ON L.order_id=O.order_id INNER JOIN product_item PI ON PI.product_item_id=L.product_item_id INNER JOIN product_item P ON P.product_id=PI.product_id WHERE O.user_id=? AND P.product_id=? LIMIT 1;");
			ps.setString(1, session.getAttribute("uid").toString());
			ps.setString(2, request.getParameter("hdnreview"));
			ResultSet rs = ps.executeQuery();
			rs.next();

			ps = cn.prepareStatement(
					"INSERT INTO user_review(user_id, ordered_product_id,rating_value, comment, review_date) VALUES (?,?,?,?,CURDATE())");
			ps.setString(1, session.getAttribute("uid").toString());
			ps.setString(2, rs.getString("order_line_id"));
			ps.setString(3, review_rating);
			ps.setString(4, review_text);
			ps.executeUpdate();

			out.print("<p class='text-success'>Review Added SuccessFully</p>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
