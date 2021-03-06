package net.yangchoo.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.ChatSession;
import net.yangchoo.domain.MemberVO;
import net.yangchoo.domain.NaverLoginVO;
import net.yangchoo.security.CustomNoOpPasswordEncoder;
import net.yangchoo.security.domain.CustomUser;
import net.yangchoo.service.MemberService;

/**
 * 양수봉 2021/06/08
 * 네이버 로그인 
 */
@Controller
@Log4j
public class LoginController {
	@Autowired
	private MemberService memberService;
	@Autowired @Qualifier("BCryptPasswordEncoder")//주입시켜서 사용
	private PasswordEncoder encoder;
	/* NaverLoginBO */
	private NaverLoginVO naverLoginVO;
	private String apiResult = null;
	@Autowired
	private void setNaverLoginBO(NaverLoginVO naverLoginVO) {
		this.naverLoginVO = naverLoginVO;
	}
	// 로그인 첫 화면 요청 메소드
	@RequestMapping(value = "/naverLogin", method = { RequestMethod.GET, RequestMethod.POST })
	public String naverLogin(Model model, HttpSession session) {
		/*
		 * 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출
		 */
		String naverAuthUrl = naverLoginVO.getAuthorizationUrl(session);
		System.out.println("네이버:" + naverAuthUrl);
		// 네이버
		model.addAttribute("url", naverAuthUrl);
		/* 생성한 인증 URL을 View로 전달 */
		return "memberLogin";
	}
	/*
	 * 양수봉 2021/06/08
	 * 네이버 로그인 성공시 callback호출 메소드
	 */
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {
		System.out.println("callback------------------------------------------");
		OAuth2AccessToken oauthToken;
		MemberVO memberVO = new MemberVO();
		JSONParser parser = new JSONParser();
		oauthToken = naverLoginVO.getAccessToken(session, code, state);
		// 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginVO.getUserProfile(oauthToken);
		System.out.println("apiResult------------------------------------------");
		System.out.println(apiResult);
		// api 정보를 오브젝트 객체에 담아준다
		Object obj = (Object) parser.parse(apiResult);
		// 오브젝트로변환한 api 정보를 다시 JSONObject 타입으로 변환한다
		JSONObject jobj = (JSONObject) obj;
		// apiresult의 필요한 정보를 가져온다
		String email = (String) ((JSONObject) jobj.get("response")).get("email");
		String id = (String) ((JSONObject) jobj.get("response")).get("id");
		//필요한 정보를 화면과 sessoin에 주입
		model.addAttribute("result", apiResult);
		model.addAttribute("id", id);
		session.setAttribute("info", apiResult);
		session.setAttribute("email", email);
		session.setAttribute("id", id);
		//네이버 id를 기준으로 DB에 기록되어 있는 정보를 읽는다.
		memberVO = memberService.oauthLogin(id);
		//네이버 id가 없다면 null 을 return받게되고 naverSuccess페이지로 이동. 
		if (memberVO == null) {
			return "naverSuccess";
		}
		//네이버 id가 존재 한다면 정보를 읽어와 Security에 정보를 주입후 메인페이지로 이동
		MemberVO findbyauth = memberService.read(memberVO.getUserEmail());
		List<GrantedAuthority> roles = new ArrayList<>(1);
		roles.add(new SimpleGrantedAuthority(findbyauth.getAuthList().get(0).getUserAuth()));
		log.info(findbyauth);
		CustomUser user = new CustomUser(findbyauth);
		log.info(user);
		Authentication auth = new UsernamePasswordAuthenticationToken(user, null, roles);
		SecurityContextHolder.getContext().setAuthentication(auth);
		log.info("-----------------------------------");
		log.warn(auth.getName());
		log.info(memberVO);
		/* 네이버 로그인 성공 페이지 View 호출 */
		return "redirect:/board/list";
	}
	
	/**
	 * 양수봉 2021/06/08
	 * 네이버 로그인 성공했지만 네이버 id가 DB에 없을 경우 naverSuccess -> naverTerms호출 메소드 
	 * 네이버 id를 받아와 DB에 저장하는 로직
	 */
	@SuppressWarnings("unused")
	@RequestMapping(value = "/naverTerms", method = { RequestMethod.GET, RequestMethod.POST })
	public String naverTerms(MemberVO memberVO) {
		log.info("------------------네이버 로그인 -------------");
		log.info(memberVO);
		//email을 기준으로 회원의 정보를 읽는다.
		MemberVO findbyauth = memberService.read(memberVO.getUserEmail());
		log.info("------------------비밀번호 체크 -------------");
		//naverSuccess에서 회원이 보낸 rawpassoword와 DB에 저장된 endcode된 password를 비교하고 boolean값을 return받게 된다
		System.out.println(encoder.matches(memberVO.getUserPw(), findbyauth.getUserPw()));
		//회원의 정보를 읽어왔지만 없다면 로그인페이지로 이동
		if (findbyauth == null) {
			return "redirect:/naverLogin";
		}
		//가입되어있는 유저의 email/password가 일치한다면 Security에 정보를 주입후 메인페이지로 이동 
		if (memberVO.getUserEmail().equals(findbyauth.getUserEmail()) && encoder.matches(memberVO.getUserPw(), findbyauth.getUserPw())) {
			List<GrantedAuthority> roles = new ArrayList<>(1);
			roles.add(new SimpleGrantedAuthority(findbyauth.getAuthList().get(0).getUserAuth()));
			log.info(memberVO);
			CustomUser user = new CustomUser(findbyauth);
			log.info(user);
			Authentication auth = new UsernamePasswordAuthenticationToken(user, null, roles);
			SecurityContextHolder.getContext().setAuthentication(auth);
			//네이버 id를 DB에 저장한다.
			memberService.oauthJoin(memberVO);

			return "redirect:/board/list";
		}
		return "redirect:/naverLogin";
	}
}