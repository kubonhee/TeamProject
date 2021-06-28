package net.yangchoo.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import net.yangchoo.domain.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberServiceTests {
	
	@Autowired
	private MemberService service;
	
	@Test
	public void testExist(){
		assertNotNull(service);
		log.info(service);
	}	
	@Test
	public void testRead(){
		log.info(service.read("tnqhd1212@naver.com"));
	}
	@Test
	public void testOauthLogin(){
		log.info(service.oauthLogin("bt2ZQgZ-J9k72qYZB-fVFGBQRpmgCOcmXQrKyl2Yj6Y"));
	}
}



