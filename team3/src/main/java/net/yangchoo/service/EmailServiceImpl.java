package net.yangchoo.service;

import java.security.SecureRandom;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import net.yangchoo.domain.EmailDTO;

@Service
public class EmailServiceImpl implements EmailService{
	@Inject
	JavaMailSender mailSender;
	
	private static SecureRandom random = new SecureRandom();
	


	public static String generate(String DATA, int length) {
        if (length < 1) throw new IllegalArgumentException("length must be a positive number.");
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append( DATA.charAt(
            		random.nextInt(DATA.length())
            		));
        }
        return sb.toString();
    }



	
	public int sendMail (EmailDTO dto) {
		
//		String ENGLISH_LOWER = "abcdefghijklmnopqrstuvwxyz";
//        String ENGLISH_UPPER = ENGLISH_LOWER.toUpperCase();
//        String NUMBER = "0123456789";
//        String DATA_FOR_RANDOM_STRING = ENGLISH_LOWER + ENGLISH_UPPER + NUMBER;
//        int random_string_length=10;
       
		try {
			// 이메일 객체
			MimeMessage msg = mailSender.createMimeMessage();
			
			// 받는 사람 설정(수신자, 받는사람의 이메일 주소 객체를 생성해서 수신자 이메일 주소를 담음)
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
			
			/*
			 * createMimeMessage() : MimeMessage 객체를 생성(이를 이용해서 메세지를 구성한 뒤 메일 발송)
			 * addRecipient() : 메세지의 발신자를 성정 InternetAddress() : 이메일 주소 getReceiveMail() :
			 * 수신자 이메일 주소
			 * */
			
			/*
			 * 보내는 사람(이메일주소 + 이름)
			 * (발신자, 보내는 사람의 이메일 주소와 이름을 담는다.)
			 * 이메일 발신자
	 		 * */
			msg.addFrom(new InternetAddress[] { new InternetAddress("qhsgml2@gmail.com", "운영자") });
			
			// 이메일 제목 (인코딩 사용해야 한글이 잘나옴 utf-8)
			msg.setSubject("이메일 인증 번호");
			// 이메일 본문
			msg.setText(dto.getMessage());
			// 인증 키
//			msg.setText(generate(DATA_FOR_RANDOM_STRING, random_string_length));
			
			
//			Random rnd = new Random();
//			String randomStr = String.valueOf(rnd.nextInt(10));
//			msg.setText(randomStr); //난수 담
			
//			-------------------- 참고 -----------------------------
//          html로 보낼 경우            
//          MimeMessage message = mailSender.createMimeMessage();
//          MimeMessageHelper helper 
//          = new MimeMessageHelper(message, true);
//          helper.setTo("test@host.com");
//          helper.setText("<html><body><img src='cid:identifier1234'></body></html>", true);
			
			// 이메일 보내기
			mailSender.send(msg);
			return 1;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1; 
	}
	
	public void confirm(EmailDTO emailDTO) {
		
		System.out.println(emailDTO.getConfirm());
		System.out.println(emailDTO.getConfirm());
		emailDTO.getConfirm();
	}

}
