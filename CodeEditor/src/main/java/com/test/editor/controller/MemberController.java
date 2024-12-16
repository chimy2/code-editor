package com.test.editor.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.test.editor.dao.MemberDAO;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.MemberProject;
import com.test.editor.service.MemberService;

import lombok.RequiredArgsConstructor;
/**
 * 
 * MemberController
 * 웹 애플리케이션에서 메인 페이지 및 마이페이지 관련된 요청을 처리하는 역할을 맡는 컨트롤러입니다.
 * @author bohwa Jang
 */
@RestController
@RequiredArgsConstructor
public class MemberController {
	
	private final MemberService service;

	/**
	 * DB 처리를 위한 의존 객체입니다.
	 * 
	 */
	private final MemberDAO dao;	
	
	/**
	 * 회원가입 시 비밀번호 비식별화를 위한 암호화 인터페이스입니다.
	 * 
	 */
	@Autowired
	private PasswordEncoder passwordEncoder;	
	
	/**
	 * 회원가입 시 이메일과 닉네입 중복을 확인 요청 메서드
	 * @param check 회원가입 시 이메일과 닉네임 정보
	 * @return 중복 확인한 결과값을 제공
	 */
	// 회원가입 중복
	@GetMapping("/duplicated/join")
	public int joinCheck(@RequestParam("check") String check) {
		System.out.println(check);
		int result;
	    if (check.indexOf('@') > -1) {
	        result = dao.duplicatedCheck(check);
	    } else {
	        result = dao.duplicatedNickCheck(check);
	    }
	    
	    System.out.println(result);
		return result;
	}
	
	/**
	 * 회원가입 완료된 seq를 가져오는 메서드
	 * @param dto 유저의 모든 정보를 담고 있는 객체
	 * @return 유저가 있는지 확인한 결과값을 제공
	 */
	// 회원가입 완료
	@PostMapping("/join")
	public int joinOk(@RequestBody MemberDTO dto) {
		
		dto.setPw(passwordEncoder.encode(dto.getPw()));
		
		int result = service.join(dto);
		
		return result;
	}
	
	/**
	 * 유저가 닉네임을 변경했을 때 데이터 변경 메서드
	 * @param dto 유저의 모든 정보를 담고 있는 객체
	 * @return 유저 정보가 변경된 것을 확인한 결과값을 제공
	 */
	@PostMapping("/nickEdit/mypage")
	public int nickEdit(@RequestBody MemberDTO dto) {
		
		int result = dao.nickEdit(dto);
		
		return result;
	}
	
	/**
	 * 유저가 포함된 프로젝트 정보를 불러오는 메서드
	 * @param session 로그인된 유저 정보를 가진 HttpSession 객체
	 * @return 개인이 포함된 모든 팀 seq
	 */
	@GetMapping(value="/mypage/project", produces="application/json")
	@ResponseBody
	public List<MemberProject> getMemberProject(HttpSession session) {
		
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq();  
		
		return dao.getMemberProject(member_seq);
	}
	
	/**
	 * 팀에 포함된 프로젝트 정보를 불러오는 메서드
	 * @param team_seq 팀의 seq
	 * @param session 유저 정보를 가진 HttpSession 객체 
	 * @return 유저와 팀의 seq
	 */
	@GetMapping(value="/mypage/project/{teamSeq}", produces="application/json")
	@ResponseBody
	public List<MemberProject> getSelProject(@PathVariable("teamSeq") String team_seq, HttpSession session ) {
		
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq();  
		
		Map<String, String> selTeam = new HashMap<>();
		selTeam.put("member_seq", member_seq);
		selTeam.put("team_seq", team_seq);
		
		return dao.getSelProject(selTeam);
	}
	
	
}
