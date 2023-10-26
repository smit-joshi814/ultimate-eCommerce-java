package layoutManager;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import generalModule.SiteConstants;

/**
 * Servlet implementation class UpdateLayout
 */
@WebServlet("/UpdateLayout")
public class UpdateLayout extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateLayout() {
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
			SiteConstants.PRODUCT_RS_GRID_SIZE = Integer.parseInt(request.getParameter("productGridMax"));
			SiteConstants.PRODUCTS_RS_LIST_SIZE = Integer.parseInt(request.getParameter("productListMax"));
			SiteConstants.MINIMUM_DISCOUNT_RATE_BADGE = Integer.parseInt(request.getParameter("discountLblMin"));
			SiteConstants.MAXIMUM_DISCOUNT_RATE_BADGE = Integer.parseInt(request.getParameter("discountLblMax"));
			SiteConstants.MAX_COOKIE_AGE_FOR_CART = ((((Integer.parseInt(request.getParameter("MaxtempStorage"))) * 60)
					* 60) * 24);
			SiteConstants.SERVICE_TAX = (Double.parseDouble(request.getParameter("serviceTax")) / 100);
			SiteConstants.STOCK_LEFT_MESSAGE_BADGE_AT = Integer.parseInt(request.getParameter("stockLeft"));
			SiteConstants.FEACTURED_CATEGORY = request.getParameter("FeaturedCategory");

			out.print("<p class='text-success'>Preferences Updated Successfully</p>");
		}
	}

}
