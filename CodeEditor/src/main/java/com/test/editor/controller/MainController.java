package com.test.editor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@GetMapping("/")
	public String test() {
		return "home";
	}
	
	@GetMapping("/mypage")
	public String mypage() {

		return "mypage";
	}
}
