package net.yangchoo.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.BoardVO;

/**
 *  구본희
 *  
 *  권한에 따른 로그인
 * 
 * 
 * */

@Controller
@RequestMapping("/sample")
@Log4j
public class SampleController {
	@GetMapping("all")
	public void doAll() {
		
		
	}
	@GetMapping("member")
	public void doMember() {
		
	}
	@GetMapping("admin")
	public void doAdmin() {
		
	}
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("annoMember")
	public void doMember2() {
		log.info("doMember2()...");
	}
	@Secured("ROLE_ADMIN")
	@GetMapping("annoAdmin")
	public void doAdmin2() {
		log.info("doAdmin2()...");
	}
	
	@GetMapping("form")
	public void getForm(Model model) {
		BoardVO vo = new BoardVO();
		vo.setTitle("제목");
		vo.setContent("내용");
		vo.setWriter("작성자");
		model.addAttribute("vo", vo);
	}
	@PostMapping("form") 
	public String postForm(@ModelAttribute BoardVO vo) {
		log.info(vo);
		return "redirect:/sample/form";
	}
}
