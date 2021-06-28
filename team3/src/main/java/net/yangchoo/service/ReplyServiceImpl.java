package net.yangchoo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.Criteria;
import net.yangchoo.domain.ReplyPageDTO;
import net.yangchoo.domain.ReplyVO;
import net.yangchoo.mapper.BoardMapper;
import net.yangchoo.mapper.ReplyMapper;

@Service
@AllArgsConstructor
@Log4j
@Transactional
public class ReplyServiceImpl implements ReplyService{
	private BoardMapper boardMapper;
	private ReplyMapper replyMapper;

	@Override
	public int register(ReplyVO vo) {
		log.info("register :: " + vo);
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		return replyMapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("get :: " + rno);
		return replyMapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify :: " + vo);
		return replyMapper.update(vo);
	}
	
	@Override
	public int remove(Long rno) {
		log.info("remove :: " + rno);
		boardMapper.updateReplyCnt(get(rno).getBno(), -1);
		return replyMapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("getList :: "+ bno + "::" + cri);
		return replyMapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(
				cri,
				replyMapper.getTotalCount(cri, bno), 
				replyMapper.getListWithPaging(cri, bno));
	}

	@Override
	public List<ReplyVO> getListMore(Long rno, Long bno) {
		return replyMapper.getListWithShowMore(rno, bno);
	}
	
}
