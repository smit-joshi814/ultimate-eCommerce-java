package userModule;

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
 * Servlet implementation class GenerateOrderinvoice
 */
@WebServlet("/GenerateOrderinvoice")
public class GenerateOrderinvoice extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static void addMetaData(Document document) {
		document.addTitle("Generate PDF Order");
		document.addSubject("Generate PDF Order");
		document.addAuthor("Smit Joshi");
		document.addCreator("Smit Joshi");
	}

	private static void addTitlePage(Document document) throws DocumentException {

		Paragraph preface = new Paragraph();
		creteEmptyLine(preface, 1);
		preface.add(new Paragraph("Order invoice", new Font(FontFamily.TIMES_ROMAN)));

		creteEmptyLine(preface, 1);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");
		preface.add(new Paragraph("Order invoice " + simpleDateFormat.format(new Date())));
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
		String order_id = request.getParameter("oid");
		String user_id = request.getParameter("uid");

		SQL = "SELECT DATE_FORMAT(order_date,'%d-%M-%Y') as order_date,DATE_FORMAT(payment_date,'%d-%M-%Y') as payment_date FROM shop_order WHERE order_id=?";
		ps = cn.prepareStatement(SQL);
		ps.setString(1, order_id);
		rs = ps.executeQuery();
		rs.next();

		Paragraph preface = new Paragraph();
		creteEmptyLine(preface, 1);
		preface.add(new Paragraph("You have purchased Product On : " + rs.getString("order_date")));
		document.add(preface);

		if (rs.getString("payment_date") != null) {
			preface.clear();

			SQL = "SELECT SU.user_name,SU.user_email,SU.user_phone,A.address_line1,A.address_line2,CO.country_phone,CO.currency_symbol FROM site_users SU INNER JOIN user_address_mapping UAM ON UAM.user_id=SU.user_id INNER JOIN address A ON UAM.address_id=A.address_id INNER JOIN cities C ON C.city_id=A.city_id INNER JOIN states S ON C.state_id=S.state_id INNER JOIN countries CO ON S.country_id=CO.country_id WHERE UAM.is_default=true AND SU.user_id=?";
			ps = cn.prepareStatement(SQL);
			ps.setString(1, user_id);
			rs = ps.executeQuery();
			rs.next();
			creteEmptyLine(preface, 3);
			preface.add(new Paragraph("Name: " + rs.getString("user_name")));
			preface.add(new Paragraph("Email: " + rs.getString("user_email")));
			preface.add(new Paragraph("Phone: +" + rs.getString("country_phone") + rs.getString("user_phone")));
			preface.add(
					new Paragraph("Address: " + rs.getString("address_line1") + "\n" + rs.getString("address_line2")));
			document.add(preface);
			preface.clear();
			creteEmptyLine(preface, 4);
			document.add(preface);
			preface.clear();

			String currency_symbol = rs.getString("currency_symbol");

			PdfPTable table = new PdfPTable(6);

			PdfPCell c1 = new PdfPCell(new Phrase("No."));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			c1.setPadding(3f);
			table.addCell(c1);

			c1 = new PdfPCell(new Phrase("Product Name"));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			c1.setPadding(3f);
			table.addCell(c1);

			c1 = new PdfPCell(new Phrase("Item Number "));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			c1.setPadding(3f);
			table.addCell(c1);

			c1 = new PdfPCell(new Phrase("Category"));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			c1.setPadding(3f);
			table.addCell(c1);

			c1 = new PdfPCell(new Phrase("Brand"));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			c1.setPadding(3f);
			table.addCell(c1);

			c1 = new PdfPCell(new Phrase("Price"));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			c1.setPadding(3f);
			table.addCell(c1);

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
				int SubTotal = 0;

				int i = 1;
				ps = cn.prepareStatement(
						"SELECT P.product_name,PI.item_selling_price,PI.item_sku,PC.category_name,B.brand_name FROM order_line OL INNER JOIN product_item PI ON OL.product_item_id=PI.product_item_id INNER JOIN product P ON PI.product_id=P.product_id INNER JOIN product_categories PC ON p.category_id=PC.category_id INNER JOIN brands B ON B.brand_id=P.brand_id WHERE order_id=?");
				ps.setString(1, order_id);
				ResultSet rs1 = ps.executeQuery();

				while (rs1.next()) {
					String product_name = rs1.getString("product_name");
					int item_selling_price = rs1.getInt("item_selling_price");
					String item_sku = rs1.getString("item_sku");
					String category_name = rs1.getString("category_name");
					String brand_name = rs1.getString("brand_name");

					TableCell = new PdfPCell(new Phrase(i));
					table.addCell(TableCell);
					TableCell = new PdfPCell(new Phrase(product_name));
					table.addCell(TableCell);
					TableCell = new PdfPCell(new Phrase(item_sku));
					table.addCell(TableCell);
					TableCell = new PdfPCell(new Phrase(category_name));
					table.addCell(TableCell);
					TableCell = new PdfPCell(new Phrase(brand_name));
					table.addCell(TableCell);
					TableCell = new PdfPCell(new Phrase(currency_symbol + item_selling_price));
					table.addCell(TableCell);
					SubTotal += item_selling_price;
					i++;
				}

				SQL = "SELECT SO.order_total,SM.shipping_method_name,SM.price FROM shop_order SO INNER JOIN shipping_method SM ON SO.shipping_method=SM.shipping_method_id WHERE order_id=?";
				ps = cn.prepareStatement(SQL);
				ps.setString(1, order_id);
				rs = ps.executeQuery();
				rs.next();

				TableCell = new PdfPCell(new Phrase("Sub Total: "));
				TableCell.setColspan(5);
				table.addCell(TableCell);
				TableCell = new PdfPCell(new Phrase(currency_symbol + SubTotal));
				table.addCell(TableCell);

				TableCell = new PdfPCell(new Phrase("Shipping Charges : "));
				TableCell.setColspan(5);
				table.addCell(TableCell);
				TableCell = new PdfPCell(new Phrase(currency_symbol + rs.getString("price")));
				table.addCell(TableCell);

				TableCell = new PdfPCell(new Phrase("Grand Total : "));
				TableCell.setColspan(5);
				table.addCell(TableCell);
				TableCell = new PdfPCell(new Phrase(currency_symbol + rs.getString("order_total")));
				table.addCell(TableCell);

				document.add(table);

				creteEmptyLine(preface, 5);
				preface.add(new Paragraph("Thank You For Choosing MyECommerceSite, We Hope You've Enjoyed Shopping"));
				document.add(preface);
				preface.clear();

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {
			creteEmptyLine(preface, 2);
			preface.add(new Paragraph("Invoice Will be Genarated After Payment"));
			document.add(preface);
			preface.clear();
		}
	}

	private static void creteEmptyLine(Paragraph paragraph, int number) {
		for (int i = 0; i < number; i++) {
			paragraph.add(new Paragraph(" "));
		}
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GenerateOrderinvoice() {
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
			String fileName = "Order invoice " + System.currentTimeMillis() + ".pdf";
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
