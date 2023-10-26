
package conModule;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionProvider {
	public static Connection getCon() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshop", "root", "");
			return cn;
		} catch (SQLException | ClassNotFoundException e) {
			return null;
		}
	}
}