package net.yangchoo.controller.api;

import java.security.SecureRandom;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.EmailDTO;
import net.yangchoo.domain.MemberVO;
import net.yangchoo.domain.ResponseDTO;
import net.yangchoo.service.EmailService;
import net.yangchoo.service.MemberService;

@RestController
@Log4j
public class MemberApiController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private EmailService EmailService;
	/**
	 * 회원 가입
	 * @param memberVO
	 * @return
	 * @throws Exception
	 */
	@PostMapping("/api/member")
	public ResponseDTO<Integer> save(@RequestBody MemberVO memberVO) throws Exception { // useremail, userpw,username,userLOC의 데이터를 입력 받는다.
		System.out.println("MemberApiController : save 호출");
		// 실제로 DB에 insert를 하고 return
		
		int result = memberService.register(memberVO);
		
		return new ResponseDTO<Integer>(HttpStatus.OK,result);
	}
	/**
	 * 인증번호 발송을 위한 인증 키 생성
	 * 
	 * */
	
	private static SecureRandom random = new SecureRandom();

	public static String generate(String DATA, int length) {
		if (length < 1)
			throw new IllegalArgumentException("length must be a positive number.");
		StringBuilder sb = new StringBuilder(length);
		for (int i = 0; i < length; i++) {
			sb.append(DATA.charAt(random.nextInt(DATA.length())));
		}
		return sb.toString();
	}
	
	/**
	 * 발송
	 * 
	 * @param emailDTO
	 * @return
	 * @throws Exception
	 */
	
	@PostMapping("/api/email")
	public ResponseDTO<Integer> send(@RequestBody EmailDTO emailDTO,HttpSession session) throws Exception{
		
		String ENGLISH_LOWER = "abcdefghijklmnopqrstuvwxyz";
		String ENGLISH_UPPER = ENGLISH_LOWER.toUpperCase();
		String NUMBER = "0123456789";
		String DATA_FOR_RANDOM_STRING = ENGLISH_LOWER + ENGLISH_UPPER + NUMBER;
		int random_string_length = 10;
		
		System.out.println("MemberApiController : send 호출");
		
		emailDTO.setMessage(generate(DATA_FOR_RANDOM_STRING, random_string_length));
		log.info(emailDTO);
		int result = EmailService.sendMail(emailDTO);
		session.setAttribute("send", emailDTO.getMessage());
		
		log.info(session.getAttribute("send"));
		
		return new ResponseDTO<Integer>(HttpStatus.OK,result);
		
	}
	/**
	 * 확인
	 * 
	 * 
	 */
	@PostMapping("/api/confirm")
	public ResponseDTO<Integer> confirm(@RequestBody EmailDTO emailDTO,HttpSession session) throws Exception{
		
		
		log.info("session.send :: " + session.getAttribute("send"));
		log.info("dto.confirm :: " + emailDTO.getConfirm());
		if(session.getAttribute("send") == null) {
			return new ResponseDTO<>(HttpStatus.OK, 0);
		}
		if(session.getAttribute("send").toString().equals(emailDTO.getConfirm())) {
			return new ResponseDTO<>(HttpStatus.OK, 1);
		}
		return new ResponseDTO<>(HttpStatus.OK, 0);
		
	}
}
