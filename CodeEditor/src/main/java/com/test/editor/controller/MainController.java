package com.test.editor.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.test.editor.dao.MemberDAO;
import com.test.editor.model.MemberDTO;
import com.test.editor.service.MemberService;

import lombok.RequiredArgsConstructor;

/**
 * 
 * MainController
 * 웹 애플리케이션에서 메인 페이지 및 마이페이지 관련된 요청을 처리하고, 메인 페이지와 마이페이지 렌더링하는 역할을 맡는 컨트롤러입니다.
 * @author bohwa Jang
 *
 */
@Controller
@RequiredArgsConstructor
public class MainController {
	
	/**
	 * DB 처리를 위한 의존 객체입니다.
	 * 
	 */
	private final MemberDAO dao;
	
	private final MemberService service;
	
	
	/**
	 * 메인 페이지 요청 메서드
	 * @return 메인 페이지
	 */
	@PreAuthorize("isAnonymous() or isAuthenticated()")
	@GetMapping("/")
	public String main() {
		return "main";
	}
	
	/**
	 * 마이 페이지 요청 메서드
	 * @param session 로그인된 유저 정보를 가진 HttpSession 객체
     * @param model 마이페이지에 유저 정보를 넘기기 위한 Model 객체
     * @param authentication 로그인된 유저 정보를 가진 Authentication 객체
	 * @return 마이 페이지
	 */
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/mypage")
	public String mypage(HttpSession session,Model model, Authentication authentication) {
//		System.out.println(session.getAttribute("member"));
//		System.out.println("여기 확인:>>>>>>>>>>>>>>>>>>"+authentication.toString());
//		System.out.println(((CustomUser)authentication.getPrincipal()).getMember());
		
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		 if (member != null) {
	        String seq = member.getSeq(); 
	        List<MemberDTO> dto = dao.load(seq);
	         System.out.println(dto);
	        model.addAttribute("dto",dto);
	    }
		
		return "mypage";
	}
	
	
	/**
	 * 로그인 페이지 요청 메서드
	 * @param model 마이페이지에 유저 정보를 넘기기 위한 Model 객체
	 * @return 로그인 페이지
	 */
	@PreAuthorize("isAnonymous()")
	@GetMapping("/login")
	public String login(Model model) {
		List<MemberDTO> username = dao.username();
		List<String> autoLoginIDs = service.getAutoLoginIDs();
		
		model.addAttribute("username", username);
		model.addAttribute("autoLoginIDs", autoLoginIDs);
		return "login";
	}
	
	/**
	 * 회원가입 페이지 요청 메서드
	 * @return 회원가입 페이지
	 */
	@PreAuthorize("isAnonymous()")
	@GetMapping("/join")
	public String join() {
		return "join";
	}
	
	/**
	 * 사이트 정보를 제공하는 페이지 요청 메서드
	 * @return 사이트 정보 제공 페이지
	 */
	@GetMapping("/document")
	public String document() {
		return "document";
	}
	
	/**
	 * 로그아웃 페이지 요청 메서드
	 * @return 로그아웃 페이지
	 */
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/logout")
	public String logout() {
		return "logout";
	}

	
	

}
