package net.yangchoo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import net.yangchoo.domain.Criteria;
import net.yangchoo.domain.ReplyVO;

public interface ReplyMapper {

	int insert(ReplyVO vo);
	
	int insert2(Map<String, Object > vo);

	ReplyVO read(Long rno);
	
	int update(ReplyVO vo);
	
	int delete(Long rno);
	
	List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri, @Param("bno") Long bno);
	
	List<Map<String, Object>> getListWithPaging2(
			@Param("cri") Criteria cri, @Param("bno") Long bno);

	int getTotalCount(@Param("cri") Criteria cri, @Param("bno") Long bno);
	
	List<ReplyVO> getListWithShowMore(@Param("rno") Long rno, @Param("bno") Long bno);
}
