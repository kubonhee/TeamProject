package net.yangchoo.mapper;

import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.BoardVO;
import net.yangchoo.domain.Criteria;
import net.yangchoo.domain.MemberVO;
import net.yangchoo.domain.ReplyVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml" })
@Log4j
public class BoardMapperTests {

	@Autowired
	private BoardMapper mapper;

	@Test
	public void testExist() {
		log.info(mapper);

	}

	/*
	 * @Test public void testGetTotalCount(){ Criteria criteria = new
	 * Criteria(); criteria.setType("TCW"); criteria.setKeyword("의");
	 * log.info(mapper.getTotalCount(criteria)); }
	 */

	@Test
	public void testGetListWithPaging() {
		mapper.getListWithPaging(new Criteria(1, 9)).forEach(log::info);
	}

	@Test
	public void testGetList() {
		mapper.getList().forEach(log::info);
	}

	@Test
	public void testInsert() { // 추가 ok
		BoardVO boardVO = new BoardVO();
		boardVO.setTitle("단위테스트 작성 제목1");
		boardVO.setContent("단위테스트 작성 내용1");
		boardVO.setWriter("newbie1");
		boardVO.setPrice(5000L);
		boardVO.setCategory(1);
		mapper.insert(boardVO);
		log.info(boardVO);
	}

	@Test
	public void testUpdate() {// 수정 ok
		BoardVO boardVO = new BoardVO();
		boardVO.setTitle("수정된 단위테스트 작성 제목");
		boardVO.setContent("수정된 단위테스트 작성 내용");
		boardVO.setWriter("newbie");
		boardVO.setPrice(15000L);
		boardVO.setCategory(1);
		boardVO.setBno(5L);

		log.info(mapper.update(boardVO));
	}

	@Test
	public void testInsertSelectKey() {// ok
		// pk값 자동으로 추가되는것을 확인해야 하는 상황에 유용
		IntStream.range(1, 36).forEach(i -> {
			BoardVO boardVO = new BoardVO();
			boardVO.setTitle("페이징 확인18개씩3");
			boardVO.setContent("작성 내용13");
			boardVO.setWriter("ssoyoni003@naver.com");
			boardVO.setPrice(2000L);
			boardVO.setCategory(1);
			boardVO.setLatitude(36.82743770632362);
			boardVO.setLongitude(127.14133678631336);
			boardVO.setDetailaddr("충남 천안시 서북구 성정동 1466");

			mapper.insertSelectKey(boardVO);
			log.info(boardVO);
		});
	}

	@Test
	public void testRead() { // 조회 ok
		log.info(mapper.read(5L));
		// log.info(mapper.read(1044L));
	}

	@Test
	public void testDelete() {// 삭제 ok
		log.info(mapper.delete(4L));
	}
	/*
	 * 양수봉
	 * 
	 * Mybatis는 한가지 자료형밖에 처리를 못하기때문에 컨트롤러단에서 서비스단으로 던지는 객체수는 한개여야한다. 2개를 던지려고
	 * 한다면 VO로 뭉쳐서 던지거나 Map함수를 사용하여 하나로 뭉쳐서 던져주거나 해야한다. 컨트롤러에서 @param을 쓰고 매퍼에서
	 * parameterYper을 써주는 방법도 있다.
	 */

	@Test
	public void testNearList() {

		MemberVO memberVO = new MemberVO();
		memberVO.setLatitude(36.82588960617383);
		memberVO.setLongitude(127.13656990000001);

		// log.info(mapper.nearList(memberVO));
		//log.info(mapper.nearList(36.822854500000005, 127.1398095195538));
	}

	/*
	 * 양수봉
	 */

	@Test
	public void testcategoryList() {
		log.info(mapper.getTotalCount(new Criteria(5, 20)));
	}

	@Test
	public void testgetNearListTotalCount() {
		MemberVO memberVO = new MemberVO();
		memberVO.setLatitude(36.822854500000005);
		memberVO.setLongitude(127.13656990000001);
		//log.info(mapper.getNearListTotalCount());
		//log.info(mapper.getNearListTotalCount(36.822854500000005,127.1398095195538));
	}
	
	@Test
	public void testgetgetNearListWithPaging() {
		MemberVO memberVO = new MemberVO();
		Criteria cri = new Criteria();
		memberVO.setLatitude(36.822854500000005);
		memberVO.setLongitude(127.13656990000001);
		//log.info(mapper.getNearListWithPaging(memberVO.getLatitude(),memberVO.getLongitude(), cri.getPageNum(),cri.getAmount()));
	}

	/*
	 * @Test public void testSearch(){ Criteria criteria = new Criteria();
	 * criteria.setType("TCW"); criteria.
	 * setKeyword("'UNION SELECT NULL,NULL,NULL,NULL,NULL,NULL FROM TBL_BOARD--"
	 * ); //criteria.setKeyword("과");
	 * 
	 * mapper.getListWithPaging(criteria); }
	 */

}
