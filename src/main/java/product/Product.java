/**
 *
 */
package product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conModule.ConnectionProvider;

/**
 * @author smitj
 *
 */
public class Product {
	static Connection cn = ConnectionProvider.getCon();
	static PreparedStatement ps;
	static ResultSet rs;

	public static Cart getCartItems(int product_item_id, int item_quantity) throws SQLException {
		Cart cart = new Cart();
		ps = cn.prepareStatement(
				"SELECT P.product_name,P.product_id,PC.category_name,B.brand_name,PI.item_selling_price,PI.item_quantity FROM product P INNER JOIN product_item PI ON P.product_id=PI.product_id INNER JOIN product_categories PC ON P.category_id=PC.category_id INNER JOIN brands B ON P.brand_id=B.brand_id WHERE PI.product_item_id=?");
		ps.setInt(1, product_item_id);
		rs = ps.executeQuery();
		rs.next();
		cart.setProduct_id(rs.getInt("product_id"));
		cart.setProduct_item_id(product_item_id);
		cart.setProduct_name(rs.getString("product_name"));
		cart.setOption1(rs.getString("category_name"));
		cart.setOption2(rs.getString("brand_name"));
		cart.setProduct_price(rs.getInt("item_selling_price"));
		cart.setProduct_quantity(item_quantity);
		cart.setProduct_final_price();
		if (rs.getInt("item_quantity") != 0) {
			cart.setInStock(true);
			cart.setStock_items(rs.getInt("item_quantity"));
		} else {
			cart.setInStock(false);
		}
		ps = cn.prepareStatement(
				"SELECT PM.map_id,vc.var_name,vcv.var_value FROM product_variation_mapping PM INNER JOIN variation_options VO ON PM.variation_option_id=VO.variation_option_id INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation_combo VC ON VCV.var_id=VC.var_id WHERE product_item_id=? and VC.var_name LIKE '%COLOR%' OR VC.var_name LIKE '%SIZE%' OR vc.var_name LIKE '%CAPACITY%';");
		ps.setInt(1, product_item_id);
		rs = ps.executeQuery();
		int map_id = 0;
		if (rs.isBeforeFirst()) {
			while (rs.next()) {
				if (rs.getString("var_name").equalsIgnoreCase("Color")) {
					String[] option = new String[2];
					map_id = rs.getInt("map_id");
					option[0] = rs.getString("var_name");
					option[1] = rs.getString("var_value");
					cart.setOption3(option);
				} else if (rs.getString("var_name").equalsIgnoreCase("Size")
						|| rs.getString("var_name").equalsIgnoreCase("capacity")) {
					String[] option = new String[2];
					option[0] = rs.getString("var_name");
					option[1] = rs.getString("var_value");
					cart.setOption4(option);
				}
			}
		}
		if (map_id != 0) {
			ps = cn.prepareStatement("SELECT image_name FROM product_item_images WHERE map_id=? LIMIT 1");
			ps.setInt(1, map_id);
			rs = ps.executeQuery();
			rs.next();
			cart.setProduct_item_image_path("img\\shop\\products\\" + rs.getString("image_name"));
		}
		return cart;
	}

	public static ArrayList<ProductImagesCatalog> getItemImages(int product_item_id) throws SQLException {
		ArrayList<ProductImagesCatalog> product_images = new ArrayList<>();
		ps = cn.prepareStatement(
				"SELECT PM.map_id FROM product_variation_mapping PM INNER JOIN variation_options VO ON PM.variation_option_id=VO.variation_option_id INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation_combo VC ON VCV.var_id=VC.var_id WHERE product_item_id=? and VC.var_name IN('COLOR')");
		ps.setInt(1, product_item_id);
		ResultSet rs = ps.executeQuery();
		rs.next();
		ps = cn.prepareStatement("SELECT * FROM product_item_images WHERE map_id=?");
		ps.setString(1, rs.getString("map_id"));
		ResultSet rs1 = ps.executeQuery();
		while (rs.next()) {
			product_images.add(new ProductImagesCatalog(rs1.getInt("image_id"), product_item_id, rs1.getInt("map_id"),
					rs1.getString("image_name")));
		}
		return product_images;
	}

	public static ArrayList<ProductImagesCatalog> getItemImages(int product_item_id, int LIMIT) throws SQLException {
		ArrayList<ProductImagesCatalog> product_images = new ArrayList<>();
		ps = cn.prepareStatement(
				"SELECT PM.map_id FROM product_variation_mapping PM INNER JOIN variation_options VO ON PM.variation_option_id=VO.variation_option_id INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation_combo VC ON VCV.var_id=VC.var_id WHERE product_item_id=? and VC.var_name IN('COLOR')");
		ps.setInt(1, product_item_id);
		ResultSet rs = ps.executeQuery();
		rs.next();
		ps = cn.prepareStatement("SELECT * FROM product_item_images WHERE map_id=? LIMIT " + LIMIT);
		ps.setString(1, rs.getString("map_id"));
		ResultSet rs1 = ps.executeQuery();
		while (rs.next()) {
			product_images.add(new ProductImagesCatalog(rs1.getInt("image_id"), product_item_id, rs1.getInt("map_id"),
					rs1.getString("image_name")));
		}
		return product_images;
	}

	public static ArrayList<ItemVariationCatalog> getItemVariationInfo(int product_item_id) throws SQLException {
		ArrayList<ItemVariationCatalog> variations = new ArrayList<>();
		ps = cn.prepareStatement(
				"SELECT PM.map_id,VC.var_name,VCV.var_value FROM product_variation_mapping PM INNER JOIN variation_options VO ON PM.variation_option_id=VO.variation_option_id INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation_combo VC ON VCV.var_id=VC.var_id WHERE product_item_id=?");
		ps.setInt(1, product_item_id);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			variations.add(new ItemVariationCatalog(product_item_id, rs.getInt("map_id"), rs.getString("var_name"),
					rs.getString("var_value")));
		}
		return variations;
	}

	public static ArrayList<ProductCatalog> getProductInfo(int MAX_LIMIT) throws SQLException {
		ArrayList<ProductCatalog> product = new ArrayList<>();
		ps = cn.prepareStatement(
				"SELECT * FROM product P INNER JOIN product_categories PC ON P.category_id=PC.category_id INNER JOIN brands B ON P.brand_id=B.brand_id  LIMIT "
						+ MAX_LIMIT);
		rs = ps.executeQuery();
		while (rs.next()) {
			product.add(new ProductCatalog(rs.getInt("product_id"), rs.getString("product_name"),
					rs.getString("product_description"), rs.getString("category_name"), rs.getString("brand_name"),
					rs.getInt("category_id"), rs.getInt("brand_id")));
		}
		return product;
	}

	public static ArrayList<ProductCatalog> getProductInfo(int MAX_LIMIT, String ORDER) throws SQLException {
		ArrayList<ProductCatalog> product = new ArrayList<>();
		ps = cn.prepareStatement(
				"SELECT * FROM product P INNER JOIN product_categories PC ON P.category_id=PC.category_id INNER JOIN brands B ON P.brand_id=B.brand_id "
						+ ORDER + "  LIMIT " + MAX_LIMIT);
		rs = ps.executeQuery();
		while (rs.next()) {
			product.add(new ProductCatalog(rs.getInt("product_id"), rs.getString("product_name"),
					rs.getString("product_description"), rs.getString("category_name"), rs.getString("brand_name"),
					rs.getInt("category_id"), rs.getInt("brand_id")));
		}
		return product;
	}

	public static ArrayList<ProductCatalog> getProductInfo(String LIKE_CATEGORY, String ORDER) throws SQLException {
		ArrayList<ProductCatalog> product = new ArrayList<>();
		ps = cn.prepareStatement(
				"SELECT * FROM product P INNER JOIN product_categories PC ON P.category_id=PC.category_id INNER JOIN brands B ON P.brand_id=B.brand_id WHERE PC.category_name LIKE '%"
						+ LIKE_CATEGORY + "%' " + ORDER);
		rs = ps.executeQuery();
		while (rs.next()) {
			product.add(new ProductCatalog(rs.getInt("product_id"), rs.getString("product_name"),
					rs.getString("product_description"), rs.getString("category_name"), rs.getString("brand_name"),
					rs.getInt("category_id"), rs.getInt("brand_id")));
		}
		return product;
	}

	public static ArrayList<ProductItemCatalog> getProductItemInfo(int product_id, int MAX_LIMIT) throws SQLException {
		ArrayList<ProductItemCatalog> product_item = new ArrayList<>();
		ps = cn.prepareStatement("SELECT * FROM product_item WHERE product_id=? LIMIT " + MAX_LIMIT);
		ps.setInt(1, product_id);
		rs = ps.executeQuery();
		while (rs.next()) {
			product_item.add(new ProductItemCatalog(rs.getInt("product_item_id"), rs.getInt("item_listing_price"),
					rs.getInt("item_selling_price"), rs.getInt("item_quantity"), rs.getBoolean("Active")));
		}
		return product_item;
	}

	public static ArrayList<ProductItemCatalog> getProductItemInfo(int product_id, int OFFSET, int MAX_LIMIT,
			String ORDER) throws SQLException {
		ArrayList<ProductItemCatalog> product_item = new ArrayList<>();

		ps = cn.prepareStatement("SELECT * FROM product_item WHERE product_id=? AND Active=1 " + ORDER + " LIMIT "
				+ OFFSET + "," + MAX_LIMIT);
		ps.setInt(1, product_id);
		rs = ps.executeQuery();
		while (rs.next()) {
			product_item.add(new ProductItemCatalog(rs.getInt("product_item_id"), rs.getInt("item_listing_price"),
					rs.getInt("item_selling_price"), rs.getInt("item_quantity"), rs.getBoolean("Active")));
		}
		return product_item;
	}

	public static ArrayList<ProductItemCatalog> getProductItemInfo(int product_id, int MAX_LIMIT, String ORDER)
			throws SQLException {
		ArrayList<ProductItemCatalog> product_item = new ArrayList<>();

		ps = cn.prepareStatement(
				"SELECT * FROM product_item WHERE product_id=? AND Active=1 " + ORDER + " LIMIT " + MAX_LIMIT);
		ps.setInt(1, product_id);
		rs = ps.executeQuery();
		while (rs.next()) {
			product_item.add(new ProductItemCatalog(rs.getInt("product_item_id"), rs.getInt("item_listing_price"),
					rs.getInt("item_selling_price"), rs.getInt("item_quantity"), rs.getBoolean("Active")));
		}
		return product_item;
	}

	public static int getRatingCount(String product_id, int rating) throws SQLException {
		ps = cn.prepareStatement(
				"SELECT count(UR.rating_value) as rating_count FROM user_review UR INNER JOIN order_line L ON UR.ordered_product_id=L.order_line_id INNER JOIN product_item PI ON L.product_item_id=PI.product_item_id INNER JOIN product P ON PI.product_id=P.product_id WHERE P.product_id=? AND UR.rating_value=?");
		ps.setString(1, product_id);
		ps.setInt(2, rating);
		rs = ps.executeQuery();
		rs.next();
		return rs.getInt("rating_count");
	}

	public static int getSuperCategoryId(int category_id) throws SQLException {
		ps = cn.prepareStatement("SELECT parent_category_id FROM product_categories WHERE category_id=? LIMIT 1");
		ps.setInt(1, category_id);
		rs = ps.executeQuery();
		rs.next();
		return rs.getInt("parent_category_id");
	}

	public static ArrayList<ItemVariationCatalog> getVariationCombination(int product_id, String VARIATION)
			throws SQLException {
		ArrayList<ItemVariationCatalog> catalogs = new ArrayList<>();
		String SQL = "SELECT PM.map_id,VC.var_name,VCV.var_value,PI.product_item_id FROM product_variation_mapping PM INNER JOIN variation_options VO ON PM.variation_option_id=VO.variation_option_id INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation_combo VC ON VCV.var_id=VC.var_id  INNER JOIN product_item PI ON PM.product_item_id=PI.product_item_id INNER JOIN product P ON PI.product_id=P.product_id WHERE P.product_id=? AND PI.Active=? AND ";
		String vars[] = VARIATION.split(",");
		for (int i = 0; i < vars.length; i++) {
			if (i == vars.length - 1) {
				SQL += "VC.var_name LIKE " + vars[i] + " ";
			} else {
				SQL += "VC.var_name LIKE " + vars[i] + " OR ";
			}
		}
		ps = cn.prepareStatement(SQL);
		ps.setInt(1, product_id);
		ps.setBoolean(2, true);
		rs = ps.executeQuery();
		if (rs.isBeforeFirst()) {
			while (rs.next()) {
				catalogs.add(new ItemVariationCatalog(rs.getInt("product_item_id"), rs.getInt("map_id"),
						rs.getString("var_name"), rs.getString("var_value")));
			}
			return catalogs;
		} else {
			return null;
		}
	}

}
