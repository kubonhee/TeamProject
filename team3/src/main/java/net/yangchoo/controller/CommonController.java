package net.yangchoo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	@GetMapping("accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("accessDenied .... " + auth);
		model.addAttribute("msg", "Access Denied (접근 거부)");
	}
	
	@GetMapping("memberLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error :: " + error);
		log.info("logout :: " + logout);
		
		if(error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		if(logout != null) {
			model.addAttribute("logout", "logout!!!");
		}
	}
	
	@GetMapping("/memberLogout")
	public void logoutGet(HttpServletRequest req) {
		log.warn("custom logout");
		log.warn(req.getHeader("referer"));
	}
	
	@PostMapping("/memberLogout")
	public void logoutPost(HttpServletRequest req,HttpSession session) {
		log.warn("post custom logout");
		log.warn(req.getHeader("referer"));
		session.invalidate();
	}
	
	@GetMapping("/join")
	public void join(HttpServletRequest req) {
		log.warn("custom logout");
		log.warn(req.getHeader("referer"));
	}
	
}
