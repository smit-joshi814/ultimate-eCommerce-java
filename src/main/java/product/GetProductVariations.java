package product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.TreeMap;

import conModule.ConnectionProvider;
import generalModule.SiteConstants;

public class GetProductVariations {
	static Connection cn = ConnectionProvider.getCon();
	static PreparedStatement ps;

	public static HashMap<String, String> getAllVariationsFor(String product_item_id) throws SQLException {
		HashMap<String, String> variations = new HashMap<>();
		ps = cn.prepareStatement(
				"SELECT PM.map_id,VC.var_name,VCV.var_value FROM product_variation_mapping PM INNER JOIN variation_options VO ON PM.variation_option_id=VO.variation_option_id INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation_combo VC ON VCV.var_id=VC.var_id WHERE product_item_id=?");
		ps.setString(1, product_item_id);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			variations.put(rs.getString("var_name"), rs.getString("var_value"));
		}
		return variations;
	}

	public static HashMap<String, Integer> getColorVariation(String product_id) throws SQLException {
		HashMap<String, Integer> colors = new HashMap<>();
		ResultSet rs = getProductItems(product_id);
		while (rs.next()) {
			ps = cn.prepareStatement(
					"SELECT VCV.var_value FROM product_variation_mapping PVM INNER JOIN variation_options VO ON PVM.variation_option_id=VO.variation_option_id INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation_combo VC ON VCV.var_id=VC.var_id WHERE product_item_id=? AND VC.var_name IN('COLOR') LIMIT 1");
			ps.setString(1, rs.getString("product_item_id"));
			ResultSet rs1 = ps.executeQuery();
			rs1.next();
			colors.put(rs1.getString("var_value"), rs.getInt("product_item_id"));
		}
		return colors;
	}

	public static ArrayList<String> getProductItemImagesFor(int product_item_id, int LIMIT) throws SQLException {
		ArrayList<String> images = new ArrayList<>();
		ps = cn.prepareStatement(
				"SELECT PM.map_id FROM product_variation_mapping PM INNER JOIN variation_options VO ON PM.variation_option_id=VO.variation_option_id INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation_combo VC ON VCV.var_id=VC.var_id WHERE product_item_id=? and VC.var_name IN('COLOR')");
		ps.setInt(1, product_item_id);
		ResultSet rs = ps.executeQuery();
		rs.next();
		ps = cn.prepareStatement("SELECT * FROM product_item_images WHERE map_id=? LIMIT " + LIMIT);
		ps.setString(1, rs.getString("map_id"));
		rs = ps.executeQuery();
		while (rs.next()) {
			images.add(rs.getString("image_name"));
		}
		return images;
	}

	public static ArrayList<String> getProductItemImagesFor(String product_item_id) throws SQLException {
		ArrayList<String> images = new ArrayList<>();
		ps = cn.prepareStatement(
				"SELECT PM.map_id FROM product_variation_mapping PM INNER JOIN variation_options VO ON PM.variation_option_id=VO.variation_option_id INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation_combo VC ON VCV.var_id=VC.var_id WHERE product_item_id=? and VC.var_name IN('COLOR')");
		ps.setString(1, product_item_id);
		ResultSet rs = ps.executeQuery();
		rs.next();
		ps = cn.prepareStatement("SELECT * FROM product_item_images WHERE map_id=?");
		ps.setString(1, rs.getString("map_id"));
		rs = ps.executeQuery();
		while (rs.next()) {
			images.add(rs.getString("image_name"));
		}
		return images;
	}

	private static ResultSet getProductItems(String product_id) throws SQLException {
		String SQL = "SELECT product_item_id FROM product_item WHERE product_id=? AND Active=?";
		ps = cn.prepareStatement(SQL, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ps.setString(1, product_id);
		ps.setBoolean(2, true);
		ResultSet rs = ps.executeQuery();
		return rs;
	}

	public static TreeMap<String, Integer> getSizeCapacityVariation(String product_id) throws SQLException {
		TreeMap<String, Integer> CapSize = new TreeMap<>(Collections.reverseOrder());
		ResultSet rs = getProductItems(product_id);
		while (rs.next()) {
			ps = cn.prepareStatement(
					"SELECT VCV.var_value,VC.var_name FROM product_variation_mapping PVM INNER JOIN variation_options VO ON PVM.variation_option_id=VO.variation_option_id INNER JOIN variation_combo_values VCV ON VO.variation_value_id=VCV.var_val_id INNER JOIN variation_combo VC ON VCV.var_id=VC.var_id WHERE product_item_id=? AND VC.var_name LIKE '%SIZE%' OR VC.var_name LIKE '%CAPACITY%' LIMIT 1");
			ps.setString(1, rs.getString("product_item_id"));
			ResultSet rs1 = ps.executeQuery();
			if (!rs1.isBeforeFirst()) {
				return null;
			}
			rs1.next();
			CapSize.put(rs1.getString("var_value"), rs.getInt("product_item_id"));
			SiteConstants.VAR_NAME_COMBO = rs1.getString("var_name");
		}
		return CapSize;
	}

}
