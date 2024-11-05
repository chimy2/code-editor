package com.test.editor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@GetMapping("/main")
	public String main() {
		return "main";
	}
	
	@GetMapping("/mypage")
	public String mypage() {
		return "mypage";
	}
	
	@GetMapping("/stats")
	public String stats() {
		return "stats";
	}
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@GetMapping("/join")
	public String join() {
		return "join";
	}
}
