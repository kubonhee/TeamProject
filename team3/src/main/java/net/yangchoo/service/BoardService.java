package net.yangchoo.service;

import java.util.List;
import java.util.Optional;

import net.yangchoo.domain.BoardVO;
import net.yangchoo.domain.Criteria;
import net.yangchoo.domain.MemberVO;
import net.yangchoo.domain.BoardAttachVO;

public interface BoardService {
	
	void register(BoardVO boardVO);//글 등록
	
	BoardVO get(Long bno);//상세 조회
	
	boolean modify(BoardVO boardVO); //글 수정
	
	boolean remove(Long bno); //글 삭제
	
	List<BoardVO> getList(Criteria cri); //페이지 처리가 된 목록조회

	int getTotal(Criteria cri);
	
	int getNearListTotalCount(Criteria cri);
	
	List<BoardAttachVO> getAttachList(Long bno);

	List<BoardVO> categoryList(Long category);
	
	List<BoardVO> nearList(Criteria cri);

}
