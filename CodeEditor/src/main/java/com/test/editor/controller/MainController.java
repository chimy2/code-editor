package com.test.editor.controller;

import org.springframework.http.HttpStatus; 
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.editor.dao.UserDAO;

import lombok.RequiredArgsConstructor;

@ContextConfiguration(locations = {
			"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
			"file:src/main/webapp/WEB-INF/spring/security-context.xml"
		})
@Controller
@RequiredArgsConstructor
public class MainController {
	
	private final UserDAO dao;
	
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
	
	@GetMapping("/delbot")
	public String delbot(@RequestParam("seq") String seq, Model model) {
		
	    model.addAttribute("seq", seq);
	    return "delbot";
	}
	
	@DeleteMapping("/delbot/{seq}")
	public ResponseEntity<Void> delbotdo(@PathVariable("seq") String seq) {
	    int result = dao.delbot(seq);
	    
	    if (result > 0) {
	        // 삭제가 성공한 경우 200 OK 응답을 반환
	        return ResponseEntity.ok().build();
	    } else {
	        // 삭제가 실패한 경우 500 Internal Server Error 응답을 반환
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	    }
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
