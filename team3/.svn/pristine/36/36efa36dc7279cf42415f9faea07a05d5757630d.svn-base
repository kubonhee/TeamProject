package net.yangchoo.controller;

import java.security.SecureRandom;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import net.yangchoo.domain.EmailDTO;
import net.yangchoo.service.EmailService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("email/*") // 공통 맵핑 주소
public class EmailController {

	@Inject
	EmailService emailService; // 서비스를 호출하기위한 의존성

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

	@RequestMapping("write.do") // 이메일 쓰기를 누르면 이 매소드로 맵핑
	public String write(@ModelAttribute EmailDTO dto, Model model, HttpSession session) {
		String ENGLISH_LOWER = "abcdefghijklmnopqrstuvwxyz";
		String ENGLISH_UPPER = ENGLISH_LOWER.toUpperCase();
		String NUMBER = "0123456789";
		String DATA_FOR_RANDOM_STRING = ENGLISH_LOWER + ENGLISH_UPPER + NUMBER;
		int random_string_length = 10;

		emailService.sendMail(dto);
		session.setAttribute("send", generate(DATA_FOR_RANDOM_STRING, random_string_length)); // 이메일이 발송되었다는 메세지를 출력 시킨다.
		return "/register"; // 다시 write jsp 페이지로 이도하고 jsp 페이지에서 내용을 다 채운뒤에 확인 버튼을 누르면 send.do로 넘어감
	}

	@RequestMapping("send.do") // 확인(메일보내기) 버튼을 누르면 맵핑되는 메소드
	public String send(@ModelAttribute EmailDTO dto, Model model) {
		try {
			emailService.sendMail(dto); // dto (메일관련 정보)를 sendMail에 저장함
			model.addAttribute("message", "이메일이 발송되었습니다."); // 이메일이 발송되었다는 메세지를 출력 시킨다.

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "이메일 발송 실패..."); // 이메일 발송이 실패되었다는 메세지를 출력 시킨다.

		}
		return "register"; // 실패했으므로 다시 write.jsp 페이지로 이동

	}

	// private static final Logger logger =
	// LoggerFactory.getLogger(EmailController.class);
	//
	// /**
	// * Simply selects the home view to render by returning its name.
	// */
	// @RequestMapping(value = "/email", method = RequestMethod.GET)
	// public String home(Locale locale, Model model) {
	// logger.info("Welcome home! The client locale is {}.", locale);
	//
	// Date date = new Date();
	// DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG,
	// DateFormat.LONG, locale);
	//
	// String formattedDate = dateFormat.format(date);
	//
	// model.addAttribute("serverTime", formattedDate );
	//
	// return "email";
	// }

}
