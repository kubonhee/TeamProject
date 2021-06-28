package net.yangchoo.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import net.yangchoo.domain.BoardVO;
import net.yangchoo.domain.Criteria;
import net.yangchoo.domain.MemberVO;


public interface BoardMapper {
	
	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public List<BoardVO> getAttachList();
	
	public int insert(BoardVO boardVO);
	
	public void insertSelectKey(BoardVO boardVO);
	
	public BoardVO read(Long bno);
	
	public int delete(long bno);
	
	public int update(BoardVO boardVO);
	
	public int getTotalCount(Criteria cri);
	
	@Update("UPDATE BOARD SET REPLYCNT = REPLYCNT + #{amount} WHERE BNO = #{bno}")
	void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);

	public List<BoardVO> categoryList(@Param("category")Long category);
	
	//public int getNearListTotalCount(@Param("memberVO") MemberVO memberVO, @Param("Criteria") Criteria criteria);
	
	//public List<BoardVO> nearList(MemberVO memberVO);
	public List<BoardVO> nearList(Criteria cri);
	
	public int getNearListTotalCount(Criteria cri);
	//public List<BoardVO> getNearListTotalCount(@Param("latitude")Double latitude,@Param("longitude")Double longitude);
	public List<BoardVO> getNearListWithPaging(Criteria cri);
}
