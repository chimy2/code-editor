package com.test.editor.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.editor.dao.MemberDAO;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.MemberProject;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	
	private final MemberDAO dao;
	
	
	
	@PreAuthorize("isAnonymous() or isAuthenticated()")
	@GetMapping("/")
	public String main() {
		return "main";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/mypage")
	public String mypage(HttpSession session,Model model) {
		System.out.println(session.getAttribute("member"));
		//MemberDTO dto = dao.loadUser()
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		 if (member != null) {
	        String seq = member.getSeq(); 
	        List<MemberDTO> dto = dao.load(seq);
	        System.out.println(dto);
	        model.addAttribute("dto",dto);
	    }
		
		return "mypage";
	}

	
	@GetMapping("/stats")
	public String stats() {
		
		return "stats";
	}
	
	@PreAuthorize("isAnonymous()")
	@GetMapping("/login")
	public String login(Model model) {
		List<MemberDTO> username = dao.username();
		model.addAttribute("username", username);
		return "login";
	}
	
	@PreAuthorize("isAnonymous()")
	@GetMapping("/join")
	public String join() {
		return "join";
	}
	
	@GetMapping("/document")
	public String document() {
		return "document";
	}
	
	
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
	
	
	@GetMapping(value="/mypage/project", produces="application/json")
	@ResponseBody
	public List<MemberProject> getMemberProject(HttpSession session) {
		
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq();  
		
		return dao.getMemberProject(member_seq);
	}
}
