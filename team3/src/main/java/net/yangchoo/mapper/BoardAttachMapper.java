package net.yangchoo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import net.yangchoo.domain.BoardAttachVO;

public interface BoardAttachMapper {
	void insert(BoardAttachVO vo);
	
	void delete(String uuid); 
	
	List<BoardAttachVO> findBy(Long bno);
	
	@Delete("DELETE ATTACH WHERE BNO = #{bno}")//파일 리스트 삭제
	void deleteAll(Long bno);
	
	@Delete("DELETE ATTACH")
	void deleteAllComplete();
	
	@Select("SELECT * FROM ATTACH WHERE UPLOADPATH = TO_CHAR(SYSDATE -1, 'YYYY/MM/DD')")
	List<BoardAttachVO> getOldFiles();
	
	
}