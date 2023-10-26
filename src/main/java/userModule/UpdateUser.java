package userModule;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import conModule.ConnectionProvider;

/**
 * Servlet implementation class UpdateUser
 */
@MultipartConfig
@WebServlet("/UpdateUser")
public class UpdateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateUser() {
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
			String txtName = request.getParameter("txtName");
			String txtPhone = request.getParameter("txtPhone");
			String user_id = session.getAttribute("uid").toString();
			Connection cn = ConnectionProvider.getCon();
			PreparedStatement ps;
			boolean isImg = false;

			Part fpart = request.getPart("ProfileImage");
			String fileName = fpart.getSubmittedFileName();

			int index = fileName.lastIndexOf(".");
			String extention = fileName.substring(index + 1).toLowerCase();
			String path = getServletContext().getRealPath(File.separator + "img" + File.separator + "shop"
					+ File.separator + "account" + File.separator + user_id + "." + extention);

			InputStream is = fpart.getInputStream();
			byte[] data = new byte[is.available()];
			FileOutputStream fos = new FileOutputStream(path);
			try {
				is.read(data);
				fos.write(data);
				fos.flush();
				fos.close();
				isImg = true;
			} catch (IOException e) {
				isImg = false;
			}

			if (isImg) {
				path = user_id + "." + extention;
				ps = cn.prepareStatement("UPDATE site_users SET user_name=?,user_phone=?,user_image=? WHERE user_id=?");
				ps.setString(3, path);
				ps.setString(4, user_id);
			} else {
				ps = cn.prepareStatement("UPDATE site_users SET user_name=?,user_phone=? WHERE user_id=?");
				ps.setString(3, user_id);
			}
			ps.setString(1, txtName);
			ps.setString(2, txtPhone);
			ps.execute();

			out.print("<p class='text-success'>Profile Updated Successfully</p>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}