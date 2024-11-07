package com.test.chat.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class ChatController {
	
	 //클라이언트가 연결 요청을 했을떄
	  
	  
	@GetMapping("/chatIndex")
	public String chatIndex(Model model) {
		 return "chatIndex";
	}


	@GetMapping("/chatScreen")
	public String chatScreen(Model model) {
		 return "chatScreen";
	}


	@GetMapping("/test")
	public String test() {
		 return "test";
	}




}
