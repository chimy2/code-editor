package com.test.editor.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.test.editor.dao.MemberDAO;
import com.test.editor.model.CustomUser;

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
	/*
	@PreAuthorize("isAuthenticated()")
	
	@GetMapping("/mypage")
	public String mypage(@AuthenticationPrincipal CustomUser user, Model model) {
	 if (user != null) {
	        model.addAttribute("user", user);
	        model.addAttribute("member", user.getMemberDTO());  // member 값을 model에 추가
	    }
		return "mypage";
	}
	*/
	/*
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/mypage")
	public String mypage(@AuthenticationPrincipal Principal principal) {
		System.out.println("Principal Username: " + principal.toString());
	    if (principal instanceof CustomUser) {
	        CustomUser customUser = (CustomUser) principal;
	        MemberDTO member = customUser.getMemberDTO();

	        // MemberDTO의 세부 정보 출력
	        System.out.println("Username: " + member.getId());
	        System.out.println("Seq: " + member.getSeq());
	        System.out.println("OAuthType: " + member.getOAuthType());
	    } else {
	        System.out.println("Principal is not of type CustomUser.");
	    }
		
		
		
	    return "mypage";
	}
	*/
	/*
	@GetMapping("/mypage")
	public String mypage(@AuthenticationPrincipal CustomUser customUser) {
	    // memberDTO는 로그인한 사용자의 정보를 포함한 객체입니다.
		if (customUser != null) {
		MemberDTO member = customUser.getMember();
	    System.out.println("Username: " + customUser.toString());
		 } else {
		        System.out.println("CustomUser is null.");
		    }
	    return "mypage";
	}
	*/
	
	
	
	
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
