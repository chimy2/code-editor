package com.test.editor.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

	
	
	@GetMapping(value="/mypage/project", produces="application/json")
	@ResponseBody
	public List<MemberProject> getMemberProject(HttpSession session) {
		
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq();  
		
		return dao.getMemberProject(member_seq);
	}
	
	@GetMapping(value="/mypage/project/{teamSeq}", produces="application/json")
	@ResponseBody
	public List<MemberProject> getSelProject(@PathVariable("teamSeq") String team_seq, HttpSession session) {
		
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq();  
		
		Map<String, String> selTeam = new HashMap<>();
		selTeam.put("member_seq", member_seq);
		selTeam.put("team_seq", team_seq);
		
		return dao.getSelProject(selTeam);
	}

}
