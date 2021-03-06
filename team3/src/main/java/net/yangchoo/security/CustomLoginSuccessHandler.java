package net.yangchoo.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.ChatSession;
import net.yangchoo.domain.LoginUserDTO;

@Log4j
@Component("customLoginSuccessHandler")
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Autowired
	private ChatSession chatSession;
	
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		log.warn("login success");
		chatSession.addLoginUser(new LoginUserDTO(authentication.getName(), System.currentTimeMillis()));
		response.sendRedirect("/");

		//		List<String> roleNames = new ArrayList<String>();
//		
//		authentication.getAuthorities().forEach(a -> {
//			roleNames.add(a.getAuthority());
//		});
//		
//		log.warn("ROLENAMES :: " + roleNames);
//		
//		if(roleNames.contains("ROLE_ADMIN")) {
//			response.sendRedirect("/sample/admin");
//			return;
//		}
//		if(roleNames.contains("ROLE_MEMBER")) {
//			response.sendRedirect("/sample/member");
//			return;
//		}
//		response.sendRedirect("/");
	}
	
}
