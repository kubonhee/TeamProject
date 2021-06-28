package net.yangchoo.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.BoardVO;
import net.yangchoo.domain.Criteria;
import net.yangchoo.mapper.BoardMapperTests;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class BoardServiceTests {
	@Autowired
	private BoardService service;
	@Test
	public void testExist(){
		assertNotNull(service);
		log.info(service);
	}
	@Test
	public void testRegister(){ //글 등록,추가
		BoardVO boardVO = new BoardVO();
		boardVO.setTitle("단위테스트 작성 제목 in Service");
		boardVO.setContent("단위테스트 작성 내용 in Service");
		boardVO.setWriter("newbie");
		boardVO.setPrice(5000L);
		boardVO.setCategory(1);
		service.register(boardVO);
		log.info("생성된 게시글의 번호 : " + boardVO.getBno());
	}
	@Test
	public void testGetList(){ //글 조회
		service.getList(new Criteria()).forEach(log::info);
	}
	@Test
	public void testGetList1(){ //글 조회
	}
	
	@Test
	public void testModify(){//글 수정
		BoardVO boardVO = new BoardVO();
		boardVO.setTitle("수정된 단위테스트 작성 in Service");
		boardVO.setContent("수정된 단위테스트 작성 내용 in Service");
		boardVO.setWriter("newbie");
		boardVO.setPrice(5000L);
		boardVO.setCategory(1);;
		boardVO.setBno(5L);
		
		log.info(service.modify(boardVO));
	}

	@Test
	public void testGet(){ //상세보기 특정글 가져오기
		log.info(service.get(5L));
	}
	
	@Test
	public void testDelete(){//글 삭제
		log.info(service.remove(2L));
	}
	@Test
	public void testGetTotal(){
		log.info(service.getTotal(new Criteria()));

	}

}
