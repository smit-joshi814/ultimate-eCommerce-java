package generalModule;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendNewEmail {
	public boolean send(String to, String subject, String text) {
		boolean isSent = false;

		final String from = "myeshoopmailservice@gmail.com";
		final String password = "ripndcpjvhzvksts";
		// final String username = "myeshoopmailservice";
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP Host set by default this
		props.put("mail.smtp.port", "465"); // TLS Port you can use 465 insted of 587
		props.put("mail.smtp.auth", "true"); // enable authentication
		props.put("mail.smtp.ssl.enable", "true"); // enable STARTTLS

		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(from, password);
			}
		});
		// session.setDebug(true);
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(from);
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject(subject);
			message.setContent(text, "text/html");
			// message.setText(text, "text/html; charset=utf-8");
			Transport.send(message);
			isSent = true;
			System.out.println("Mail Sent Successfully");
		} catch (Exception ex) {
			System.err.print(ex.getMessage());
		}
		return isSent;
	}
}