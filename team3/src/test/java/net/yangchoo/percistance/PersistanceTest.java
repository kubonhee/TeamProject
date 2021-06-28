package net.yangchoo.percistance;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import net.yangchoo.mapper.BoardMapperTests;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PersistanceTest {
	@Autowired
//	SqlSession session;
	DataSource dataSource;
	
	
	@Test
	public void testSession() {
		log.info(dataSource);
	}
}
