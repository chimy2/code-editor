package com.test.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class ChatController {

	//클라이언트가 연결 요청을 했을떄
	
	@GetMapping(value = "/server.do")
	public String server(Model model) {
		return "socket";
	}
}

