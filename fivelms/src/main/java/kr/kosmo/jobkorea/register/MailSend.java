package kr.kosmo.jobkorea.register;

import java.io.UnsupportedEncodingException;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSend {
	// 5자리 숫자 코드 랜덤 생성 ( 인증 코드 )
	public String randomCode() {
		StringBuffer rand = new StringBuffer();

		for (int i = 0; i < 5; i++) {
			int n = (int) (Math.random() * 10);
			rand.append(n);
		}
		return rand.toString();
	}

	// 메일 전송 메서드
	public String RegisterFindIdEmailSend(String user_email) {
		String host = "smtp.gmail.com";
		final String username = "yoosejong1995@gmail.com";
		final String password = "tpwhd13d!@";
		int port = 465;
		String authNum = null;

		Properties props = System.getProperties();

		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", true);
		props.put("mail.smtp.ssl.trust", host);

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un = username;
			String pw = password;

			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(un, pw);
			}
		});
		session.setDebug(true);

		try {
			MimeMessage message = new MimeMessage(session);
			try {
				message.setFrom(new InternetAddress("yoosejong1995@gmail.com", "<KOSMO> 수강신청 사이트 인증번호입니다.", "utf-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}

			// 메일 받는 사람
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(user_email));

			// 메일 제목
			message.setSubject("수강신청 사이트 인증 코드 발송");

			// 메일 내용
			authNum = randomCode();
			message.setText("인증코드는  : " + authNum + " 입니다.");

			Transport.send(message);
			System.out.println("전송완료");

		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return authNum;
	}

	public String randPwd() {
		StringBuffer rand = new StringBuffer();

		for (int i = 0; i < 5; i++) {
			int n = (int) (Math.random() * 10);
			rand.append(n);
		}
		return rand.toString();
	}

	public String RegisterFindPwdEmailSend(String user_email) {

		String host = "smtp.gmail.com";
		final String username = "yoosejong1995@gmail.com";
		final String password = "tpwhd13d!@";
		int port = 465;
		String authNum = null;

		Properties props = System.getProperties();

		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", true);
		props.put("mail.smtp.ssl.trust", host);

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un = username;
			String pw = password;

			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(un, pw);
			}
		});
		session.setDebug(true);

		try {
			MimeMessage message = new MimeMessage(session);
			try {
				message.setFrom(new InternetAddress("yoosejong1995@gmail.com", "<KOSMO> 수강신청 사이트 인증번호입니다.", "utf-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}

			// 메일 받는 사람
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(user_email));

			// 메일 제목
			message.setSubject("수강신청 사이트 임시비밀번호 발송");

			// 메일 내용
			authNum = randPwd();
			message.setText("임시비밀번호는  : " + authNum + " 입니다.");

			Transport.send(message);
			System.out.println("전송완료");

		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}

		return authNum;

	}

	

	

}
