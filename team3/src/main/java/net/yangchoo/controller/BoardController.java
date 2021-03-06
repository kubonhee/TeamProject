package net.yangchoo.controller;

import java.io.File;
import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.BoardAttachVO;
import net.yangchoo.domain.BoardVO;
import net.yangchoo.domain.Criteria;
import net.yangchoo.domain.PageDTO;
import net.yangchoo.service.BoardService;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	/*
	 * board 김소연*/
	
	private BoardService service;
	
	//목록조회
	@GetMapping({"category", "list"})
	public void list(Criteria cri ,Model model){
		log.info("list.....");
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker",new PageDTO(cri, service.getTotal(cri)));
	}
	@GetMapping({"nearList"})
	public void nearList(Criteria cri ,Model model){
		log.info("list.....");
		model.addAttribute("list", service.nearList(cri));
		model.addAttribute("pageMaker",new PageDTO(cri, service.getNearListTotalCount(cri)));
	}
	
	@GetMapping({"details","modify"})
	@PreAuthorize("isAuthenticated()")
	public void get(@RequestParam Long bno,@ModelAttribute("cri") Criteria cri, Model model){
		log.info("get or modify.....");
		model.addAttribute("board",service.get(bno));
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("cri",cri);
	}
	
	@GetMapping("register")
	@PreAuthorize("isAuthenticated()")
	public void register(){
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("register")
	public String register(BoardVO boardVO, RedirectAttributes rttr){
		log.info("register...");
		boardVO.getAttachList().forEach(log::info);
		log.info(boardVO);
		service.register(boardVO);
		rttr.addFlashAttribute("result",boardVO.getBno());
		
		return "redirect:/board/list";
	}
	
	@PreAuthorize("principal.username == #boardVO.writer")
	@PostMapping("modify")
	public String modify(BoardVO boardVO,@ModelAttribute("cri") Criteria cri,RedirectAttributes rttr){
		log.info("modify..." + boardVO);
		service.modify(boardVO);
		boardVO.getAttachList().forEach(log::info);
		log.info(boardVO);
		if(service.modify(boardVO)){
			rttr.addFlashAttribute("result","success");
		}
		log.info("redirect:/board/list"+ cri.getListLink());
		return "redirect:/board/list"+ cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("remove")
	public String remove(String writer, @RequestParam Long bno,@ModelAttribute("cri")Criteria cri,RedirectAttributes rttr){
		log.info("remove...");
		List<BoardAttachVO> list = service.getAttachList(bno);
		
		if(service.remove(bno)){
			deleteFiles(list);
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list"+ cri.getListLink();
	}
	
	@ResponseBody
	@GetMapping("getAttachList")
	public List<BoardAttachVO> getAttachList(Long bno){
		log.info("getAttachList.." + bno);
		return service.getAttachList(bno);
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList){
		log.info("deleteFiles......");
		log.info(attachList);
		
		attachList.forEach(attach ->{
			new File(UploadController.UPLOAD_PATH,attach.getDownPath()).delete();
			if(attach.isImage()){
				new File(UploadController.UPLOAD_PATH,attach.getThumbPath()).delete();
			}
		});
	}
}
