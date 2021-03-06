package net.yangchoo.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.MemberVO;
import net.yangchoo.service.MemberService;

@Controller
@Log4j
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired
	MemberService memberService;
	
	/** 제작자 : 구본희
	 *  회원가입 페이지
	 * */
	// get
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public void getRegister() throws Exception {
		logger.info("get memberJoin");
	}

	// post
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String postRegister(MemberVO memberVO) throws Exception {
		logger.info("post memberJoin");

		memberService.register(memberVO);

		return "redirect:/memberLogin";
	}

	/** 제작자 : 구본희
	 * 약관동의
	 * */
	
	@RequestMapping(value = "/memberTerms")
	public String terms() {

		return "memberTerms";
	}
	
	/**
	 *  제작자 : 구본희
	 *  회원 정보 수정
	 * */
	
	@RequestMapping(value = "/memberModify", method = RequestMethod.GET)
	public void getMemberModify() {
	}
	
	@RequestMapping(value = "/memberModify", method = RequestMethod.POST)
	public String postMemberModify(MemberVO memberVO, HttpSession session) throws Exception {
		log.info(memberVO);
		memberService.memberModify(memberVO);
		session.invalidate();
		return "redirect:/memberLogin";
	}
	
	/** 
	 * 제작자 : 구본희 
	 * 회원정보 보기
	 * */
	
	@RequestMapping(value = "/memberInfo", method = RequestMethod.GET)
	public void memberInfo(HttpSession session, Model model) throws Exception{
		
	}
	/**
	 *  제작자 : 구본희
	 *  회원 삭제
	 * */
	
	@RequestMapping(value = "/memberRemove", method = RequestMethod.GET)
	public void getMemberRemove() {
		
	}
	/**
	 *  제작자 : 구본희
	 *  회원 삭제
	 * */
	@RequestMapping(value = "/memberRemove", method = RequestMethod.POST)
	public String postMemberRemove(MemberVO memberVO, HttpSession session) {
		log.info(memberVO);
		memberService.memberRemove(memberVO);
		session.invalidate();
		return "redirect:/board/list";
	}

}
