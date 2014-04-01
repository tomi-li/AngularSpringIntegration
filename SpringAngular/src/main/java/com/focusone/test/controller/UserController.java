package com.focusone.test.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.focusone.test.model.User;
import com.focusone.test.repository.UserRepository;

@RestController
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserRepository userRepository;

	@RequestMapping(value = "/user", method = RequestMethod.POST)
	public void add(@RequestBody User user) {
		logger.info(user.getUsername() + "|" + user.getPassword());
		userRepository.save(user);
	}

	@RequestMapping(value = "/user/{username}", method = RequestMethod.GET)
	public User get(@PathVariable String username) {
		return userRepository.findOne(username);
	}

	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public List<User> list() {
		return userRepository.findAll();
	}

	@RequestMapping(value = "/user/{username}", method = RequestMethod.DELETE)
	public void delete(@PathVariable String username) {
		userRepository.delete(username);
	}
	
}
