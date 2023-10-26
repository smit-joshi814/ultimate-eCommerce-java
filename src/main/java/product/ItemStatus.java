package product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conModule.ConnectionProvider;

public class ItemStatus {
	public static boolean isPublishable(String product_item_id) {
		Connection cn = ConnectionProvider.getCon();
		try {
			PreparedStatement ps = cn.prepareStatement(
					"SELECT VC.var_name FROM product_variation_mapping M INNER JOIN variation_options VO ON M.variation_option_id=VO.variation_option_id INNER JOIN variation V ON VO.variation_id=V.variation_id INNER JOIN variation_combo VC ON V.variation_name_id=VC.var_id WHERE product_item_id=?");
			ps.setString(1, product_item_id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (rs.getString("var_name").equalsIgnoreCase("color")) {
					return true;
				}
			}
			return false;
		} catch (SQLException e) {
			return false;
		}
	}
}
