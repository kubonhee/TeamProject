package net.yangchoo.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.BoardAttachVO;
import net.yangchoo.domain.BoardVO;
import net.yangchoo.domain.Criteria;
import net.yangchoo.domain.MemberVO;
import net.yangchoo.mapper.BoardAttachMapper;
import net.yangchoo.mapper.BoardMapper;



@Service
@AllArgsConstructor
@Log4j
@Transactional
public class BoardServiceImpl implements BoardService{
	private BoardMapper boardMapper; 
	private BoardAttachMapper boardAttachMapper;
	
	@Override
	@Transactional
	public void register(BoardVO boardVO) {
		log.info("register..." + boardVO);
		boardMapper.insertSelectKey(boardVO);
		boardVO.getAttachList().forEach(a -> {
			a.setBno(boardVO.getBno());
			boardAttachMapper.insert(a);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get :: " + bno);
		return boardMapper.read(bno);
	}

	@Override
	@Transactional
	public boolean modify(BoardVO boardVO) {
		log.info("modify....."+boardVO);
		boardAttachMapper.deleteAll(boardVO.getBno());
		boardVO.getAttachList().forEach(a -> {
			a.setBno(boardVO.getBno());
			boardAttachMapper.insert(a);
		});
		return boardMapper.update(boardVO)>0;
	}

	@Override
	@Transactional
	public boolean remove(Long bno) {
		log.info("remove....." + bno);
		boardAttachMapper.deleteAll(bno);
		return boardMapper.delete(bno)>0;
	}
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList...");
		List<BoardVO> list = boardMapper.getListWithPaging(cri);
		list.forEach(vo->{
			List<BoardAttachVO> attachs = boardAttachMapper.findBy(vo.getBno());
			for(BoardAttachVO att : attachs){
				if(att.isImage()){
					log.warn(att);
					attachs.set(0, att);
					vo.setAttachList(attachs.subList(0, 1));
					log.warn(attachs);
					break;
				}
			}
			if(attachs.size()==0){
				vo.setAttachList(null);
			}
		});
		return list;
	}
	

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("getAttachList..." + bno);
		return boardAttachMapper.findBy(bno);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return boardMapper.getTotalCount(cri);
	}

	@Override
	public List<BoardVO> categoryList(Long category) {
		log.info("category :: " + category);
		List<BoardVO> list = boardMapper.categoryList(category);
		list.forEach(v -> {
			v.setAttachList(boardAttachMapper.findBy(v.getBno()));
		});
		return list;
	}
	
	@Override
	public List<BoardVO> nearList(Criteria cri) {
		log.info("nearList latitude,longitude :: " + cri);
		List<BoardVO> list = boardMapper.getNearListWithPaging(cri);
		//List<BoardVO> list = boardMapper.nearList(memberVO.getLatitude(),memberVO.getLongitude());
		/*list.forEach(v -> {
			v.setAttachList(boardAttachMapper.findBy(v.getBno()));
		});*/
		list.forEach(vo->{
			List<BoardAttachVO> attachs = boardAttachMapper.findBy(vo.getBno());
			for(BoardAttachVO att : attachs){
				if(att.isImage()){
					log.warn(att);
					attachs.set(0, att);
					vo.setAttachList(attachs.subList(0, 1));
					log.warn(attachs);
					break;
				}
			}
			if(attachs.size()==0){
				vo.setAttachList(null);
			}
		});
		return list;
	}

	@Override
	public int getNearListTotalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return boardMapper.getNearListTotalCount(cri);
	}
}
