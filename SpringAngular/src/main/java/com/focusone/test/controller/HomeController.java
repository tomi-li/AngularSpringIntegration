package com.focusone.test.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/")
	public String home() {
		return "home";
	}

	@MessageMapping("/hello")
    @SendTo("/topic/greetings")
	public Greeting greeting(HelloMessage message) throws Exception {
		return new Greeting("Hello, " + message.getName() + "!");
	}

	public class Greeting {
		private String content;

		public Greeting(String content) {
			this.content = content;
		}

		public String getContent() {
			return content;
		}
	}

	public class HelloMessage {
		private String name;

		public String getName() {
			return name;
		}
	}

}
