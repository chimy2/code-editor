package com.test.editor.controller;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.test.editor.dao.MemberDAO;
import com.test.editor.model.MemberDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	
	private final MemberDAO dao;
	
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
	public String login(Model model) {
		List<MemberDTO> username = dao.username();
		model.addAttribute("username", username);
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
	@PreAuthorize("isAuthenticated()")
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
