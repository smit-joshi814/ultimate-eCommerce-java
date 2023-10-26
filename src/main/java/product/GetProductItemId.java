package product;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetProductItemId
 */
@WebServlet("/GetProductItemId")
public class GetProductItemId extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetProductItemId() {
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
			int product_id = Integer.parseInt(request.getParameter("product_id"));
			String color = request.getParameter("color");
			String otherVar = request.getParameter("other");

			String combination = color + "-" + otherVar;

			ArrayList<ItemVariationCatalog> colors = Product.getVariationCombination(product_id, "'%COLOR%'");
			ArrayList<ItemVariationCatalog> other = Product.getVariationCombination(product_id,
					"'%SIZE%','%CAPACITY%'");

			int product_item_id = 0;

			if (colors != null && other != null) {
				for (int i = 0; i < colors.size(); i++) {
					String expectedString = null;
					expectedString = getExpectedString(colors, i);
					expectedString += "-";
					expectedString += getExpectedString(other, i);
					if (combination.equals(expectedString)) {
						product_item_id = colors.get(i).getProduct_item_id();
						break;
					}
				}
			} else if (colors != null && other == null) {
				for (int i = 0; i < colors.size(); i++) {
					String expectedString = null;
					expectedString = getExpectedString(colors, i);
					expectedString += "-";
					if (combination.equals(expectedString)) {
						product_item_id = colors.get(i).getProduct_item_id();
						break;
					}
				}
			} else if (other != null && colors == null) {
				for (int i = 0; i < other.size(); i++) {
					String expectedString = null;
					expectedString = getExpectedString(other, i);
					expectedString += "-";
					if (combination.equals(expectedString)) {
						product_item_id = other.get(i).getProduct_item_id();
						break;
					}
				}
			}
			out.print(product_item_id);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private String getExpectedString(ArrayList<ItemVariationCatalog> catalog, int i) {
		return catalog.get(i).getVariation_value();
	}
}
