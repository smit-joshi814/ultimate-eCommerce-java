package reportsModule;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import conModule.ConnectionProvider;

/**
 * Servlet implementation class SellsReportsRange
 */
@WebServlet("/SellsReportsRange")
public class SellsReportsRange extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static void addMetaData(Document document) {
		document.addTitle("Generate PDF report");
		document.addSubject("Generate PDF report");
		document.addAuthor("Smit Joshi");
		document.addCreator("Smit Joshi");
	}

	private static void addTitlePage(Document document) throws DocumentException {

		Paragraph preface = new Paragraph();
		creteEmptyLine(preface, 1);
		preface.add(new Paragraph("Sells Report", new Font(FontFamily.TIMES_ROMAN)));

		creteEmptyLine(preface, 1);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		preface.add(new Paragraph("Sells Report On " + simpleDateFormat.format(new Date())));
		document.add(preface);

	}

	private static ByteArrayOutputStream convertPDFToByteArrayOutputStream(String fileName) {

		InputStream inputStream = null;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try {

			inputStream = new FileInputStream(fileName);

			byte[] buffer = new byte[1024];
			baos = new ByteArrayOutputStream();

			int bytesRead;
			while ((bytesRead = inputStream.read(buffer)) != -1) {
				baos.write(buffer, 0, bytesRead);
			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return baos;
	}

	public static Document createPDF(String file, HttpServletRequest request) throws SQLException {
		Document document = null;
		try {
			document = new Document();
			PdfWriter.getInstance(document, new FileOutputStream(file));
			document.open();
			addMetaData(document);
			addTitlePage(document);
			createTable(document, request);
			document.close();

		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return document;

	}

	private static void createTable(Document document, HttpServletRequest request)
			throws DocumentException, SQLException {

		Connection cn = ConnectionProvider.getCon();
		ResultSet rs;
		PreparedStatement ps;
		String SQL = null;
		String company_id = null;
		boolean isAdmin = false;
		String dates = request.getParameter("fromtodates");
		String From = dates.substring(0, dates.indexOf("t") - 1);
		String To = dates.substring(dates.indexOf("t") + 2).trim();
		Paragraph preface = new Paragraph();
		creteEmptyLine(preface, 1);
		preface.add(new Paragraph("Sells Report From Date: " + From + " To Date: " + To));
		document.add(preface);

		HttpSession session = request.getSession();
		SQL = "SELECT Admin_type FROM site_admins WHERE admin_id=?";
		ps = cn.prepareStatement(SQL);
		ps.setString(1, session.getAttribute("aid").toString());
		rs = ps.executeQuery();
		rs.next();
		isAdmin = rs.getString("Admin_type").equals("1");
		if (!isAdmin) {
			SQL = "SELECT company_id FROM site_companies_info WHERE login_id=?";
			ps = cn.prepareStatement(SQL);
			ps.setString(1, session.getAttribute("aid").toString());
			rs = ps.executeQuery();
			rs.next();
			company_id = rs.getString("company_id");
		}

		Paragraph paragraph = new Paragraph();
		creteEmptyLine(paragraph, 2);
		document.add(paragraph);
		PdfPTable table = new PdfPTable(4);

		PdfPCell c1 = new PdfPCell(new Phrase("Order Id"));
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);

		c1 = new PdfPCell(new Phrase("Product Name"));
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);

		c1 = new PdfPCell(new Phrase("Order Date"));
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);

		c1 = new PdfPCell(new Phrase("Order Total"));
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);

//		c1 = new PdfPCell(new Phrase("Address"));
//		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
//		table.addCell(c1);

//		c1 = new PdfPCell(new Phrase("Email Id"));
//		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
//		table.addCell(c1);

		table.setHeaderRows(1);

		PdfPCell[] cells = table.getRow(0).getCells();
		for (PdfPCell cell : cells) {
			cell.setBorderColor(BaseColor.BLACK);
			cell.setBackgroundColor(BaseColor.GRAY);
		}

		try {
			PdfPCell TableCell = null;
			table.setWidthPercentage(100);
			table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
			table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
			int GrandTotal = 0;

			if (isAdmin) {
				SQL = "SELECT DISTINCT(SO.order_id) as order_id,SO.order_date,SO.order_total,SO.order_status FROM shop_order SO INNER JOIN order_status OS ON SO.order_status=OS.status_id INNER JOIN order_line OL ON OL.order_id=SO.order_id INNER JOIN product_item PI ON OL.product_item_id=PI.product_item_id INNER JOIN product P ON PI.product_id=P.product_id WHERE OS.status_value IN(\"Completed\") AND SO.payment_date  BETWEEN '"
						+ From + "' AND '" + To + "'";
				ps = cn.prepareStatement(SQL);
			} else if (!isAdmin && company_id != null) {
				SQL = "SELECT DISTINCT(SO.order_id),SO.order_date,SO.order_total,SO.order_status FROM order_line OL INNER JOIN shop_order SO ON SO.order_id=OL.order_id INNER JOIN order_status OS ON SO.order_status=OS.status_id INNER JOIN product_item PI ON OL.product_item_id=PI.product_item_id INNER JOIN product P ON PI.product_id =P.product_id INNER JOIN product_company_mapping PCM ON PCM.product_id=P.product_id WHERE OS.status_value IN(\"Completed\") AND PCM.company_id=? AND payment_date BETWEEN '"
						+ From + "' AND '" + To + "'";
				ps.close();
				ps = cn.prepareStatement(SQL);
				ps.setString(1, company_id);
			}
			rs = ps.executeQuery();
			if (rs.isBeforeFirst()) {
				while (rs.next()) {
					ps = cn.prepareStatement(
							"SELECT P.product_name FROM product P INNER JOIN product_item PI ON P.product_id=PI.product_id INNER JOIN order_line OL ON OL.product_item_id=PI.product_item_id INNER JOIN shop_order SO ON OL.order_id=SO.order_id WHERE SO.order_id=? LIMIT 1");
					ps.setString(1, rs.getString("order_id"));
					ResultSet rs1 = ps.executeQuery();
					rs1.next();
					String order_id = rs.getString("order_id");
					String product_name = rs1.getString("product_name");
					String order_date = rs.getString("order_date");
					String order_total = rs.getString("order_total");
					// String address = resultset.getString("address");
					// String email = resultset.getString("email");
					TableCell = new PdfPCell(new Phrase(order_id));
					table.addCell(TableCell);
					TableCell = new PdfPCell(new Phrase(product_name));
					table.addCell(TableCell);
					TableCell = new PdfPCell(new Phrase(order_date));
					table.addCell(TableCell);
					TableCell = new PdfPCell(new Phrase("INR. " + order_total));
					table.addCell(TableCell);
//				TableCell = new PdfPCell(new Phrase(address));
//				table.addCell(TableCell);
//				TableCell = new PdfPCell(new Phrase(email));
//				table.addCell(TableCell);
					GrandTotal += rs.getInt("order_total");
				}
				TableCell = new PdfPCell(new Phrase());
				table.addCell(TableCell);
				TableCell = new PdfPCell(new Phrase());
				table.addCell(TableCell);
				TableCell = new PdfPCell(new Phrase("Total: "));
				table.addCell(TableCell);
				TableCell = new PdfPCell(new Phrase("INR. " + GrandTotal));
				table.addCell(TableCell);
			} else {
				creteEmptyLine(preface, 5);
				preface.add(new Paragraph("There Are No Sells From " + From + " To " + To));
				document.add(preface);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		document.add(table);

	}

	private static void creteEmptyLine(Paragraph paragraph, int number) {
		for (int i = 0; i < number; i++) {
			paragraph.add(new Paragraph(" "));
		}
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SellsReportsRange() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			final ServletContext servletContext = request.getSession().getServletContext();
			final File tempDirectory = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
			final String temperotyFilePath = tempDirectory.getAbsolutePath();
			String fileName = "Sells Report" + System.currentTimeMillis() + ".pdf";
			response.setContentType("application/pdf");
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Cache-Control", "max-age=0");
			response.setHeader("Content-disposition", "attachment; " + "filename=" + fileName);

			createPDF(temperotyFilePath + "\\" + fileName, request);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			baos = convertPDFToByteArrayOutputStream(temperotyFilePath + "\\" + fileName);
			OutputStream os = response.getOutputStream();
			baos.writeTo(os);
			os.flush();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	}

}
