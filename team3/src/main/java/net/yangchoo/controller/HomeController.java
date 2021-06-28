package net.yangchoo.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.Data;
import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.Criteria;
import net.yangchoo.domain.MemberVO;
import net.yangchoo.domain.PageDTO;
import net.yangchoo.security.domain.CustomUser;
import net.yangchoo.service.BoardService;

/**
 * Handles requests for the application home page.
 */

@Controller
@Log4j
@Data
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return "redirect:/board/list";
	}
	/**
	 * 양수봉 2021/05/28
	 * geolocation 범위계산 목록조회
	 */
	@RequestMapping(value = "/nearList", method = RequestMethod.GET)
	public String nearList(Model model,Criteria cri, Authentication auth) {
		MemberVO vo = new MemberVO();
		
		log.info(auth);
		if(auth.getPrincipal() instanceof CustomUser) {
			vo = ((CustomUser)auth.getPrincipal()).getVo();
			log.info(vo);
			log.info("membervo :: " + vo.getLongitude() + "::"+ vo.getLatitude());
		}
		cri.setLatitude(vo.getLatitude());
		cri.setLongitude(vo.getLongitude());
		
		model.addAttribute("member",vo);
		model.addAttribute("list", boardService.nearList(cri));
		model.addAttribute("pageMaker",new PageDTO(cri, boardService.getNearListTotalCount(cri)));
		
		return "/board/nearList";
	}
}

