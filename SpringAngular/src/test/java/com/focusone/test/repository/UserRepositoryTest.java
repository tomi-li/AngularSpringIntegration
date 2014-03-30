package com.focusone.test.repository;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.focusone.test.model.User;

@RunWith(SpringJUnit4ClassRunner.class)
// @ContextConfiguration(classes = {PersistenceContext.class})
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
// @TestExecutionListeners({ DependencyInjectionTestExecutionListener.class,
// DbUnitTestExecutionListener.class })
public class UserRepositoryTest {

	@Autowired
	private UserRepository userRepository;

	@Test
	public void save() {
		User user = new User();
		user.setUsername("tomi");
		user.setPassword("11");
		userRepository.save(user);
	}

}
