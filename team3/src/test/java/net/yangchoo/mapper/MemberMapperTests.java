package net.yangchoo.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.AuthVO;
import net.yangchoo.domain.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberMapperTests {
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired @Qualifier("BCryptPasswordEncoder")
	private PasswordEncoder encoder;
	
	
	@Test
	public void test(){
		log.info(mapper);
	}
	
	@Test
	public void testRegister() {
		MemberVO memberVO = new MemberVO();
		memberVO.setUserEmail("a@b.c");
		memberVO.setUserName("자바맨");
		memberVO.setUserPw(encoder.encode("1234"));
		memberVO.setBirthDate("1993-09-19");
		memberVO.setPostCode("1234");
		memberVO.setRoadAddress("천안");
		memberVO.setJibunAddress("동삭동");
		memberVO.setExtraAddress("성정동");
		mapper.register(memberVO);
	}
	@Test
	public void testModify() {
		MemberVO memberVO = new MemberVO();
		memberVO.setUserName("자바맨");
		memberVO.setUserPw(encoder.encode("1234"));
		memberVO.setBirthDate("1993-09-19");
		memberVO.setPostCode("1234");
		memberVO.setRoadAddress("천안");
		memberVO.setJibunAddress("동삭동");
		memberVO.setExtraAddress("성정동");
		
		mapper.memberModify(memberVO);;
	}
	
	@Test
	public void testAuth() {
		AuthVO authVO = new AuthVO();
		authVO.setUserEmail("a@b.c");
		authVO.setUserAuth("ROLE_ADMIN");
		mapper.insertAuth(authVO);
	}
	
	@Test
	public void testTime() {
		log.info(mapper.testTime());
	}
	/*
	 *양수봉 testOauthLogin 2021-06-07
	*/
	@Test
	public void testOauthLogin() {
		log.info(mapper.oauthLogin("bt2ZQgZ-J9k72qYZB-fVFGBQRpmgCOcmXQrKyl2Yj6Y"));
	}
	/*
	 *양수봉 testOauthJoin 2021-06-07
	*/
	@Test
	public void testOauthJoin() {
		MemberVO memberVO = new MemberVO();
		memberVO.setOauthid("bt2ZQgZ-J9k72qYZB-fVFGBQRpmgCOcmXQrKyl2Yj6Y");
		memberVO.setUserEmail("tnqhd1212@naver.com");
		mapper.oauthJoin(memberVO);
	}

}
