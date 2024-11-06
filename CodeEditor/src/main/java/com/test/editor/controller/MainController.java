package com.test.editor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.GetMapping;

@ContextConfiguration(locations = {
			"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
			"file:src/main/webapp/WEB-INF/spring/security-context.xml"
		})
@Controller
public class MainController {
	
	@GetMapping("/")
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
	
	@GetMapping("/document")
	public String document() {
		return "document";
	}
	
	// 나중에 login이랑 security 처리할 예정
	@GetMapping("/logout")
	public String logout() {
		return "logout";
	}
	
	// 나중에 mypage랑 합칠 예정 -> ui 먼저 하는 중
	@GetMapping("/mypage/membersetting")
	public String membersetting() {
		return "membersetting";
	}
	
	@GetMapping("/mypage/teamsetting")
	public String teamsetting() {
		return "teamsetting";
	}
	
	@GetMapping("/mypage/projectsetting")
	public String projectsetting() {
		return "projectsetting";
	}
	
	
	
}
