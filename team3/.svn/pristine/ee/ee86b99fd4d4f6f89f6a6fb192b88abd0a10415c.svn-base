package net.yangchoo.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
@WebAppConfiguration
public class ReplyControllerTests {
	@Autowired
	private WebApplicationContext ctx;
	private MockMvc mvc; //가짜 Mock //web처럼수행하고 uri를 보내는 가짜 객체를 생성하는것

	@Before
	public void setup(){ //테스트하기 전에 하는 전처리.필요한 떄에 객체생성하겠다
		mvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	@Test
	public void testList() throws Exception{// 목록 조회
		log.info(mvc.perform(MockMvcRequestBuilders.get("/replies/pages/1/184339"))
				.andReturn());
	}
	
}
