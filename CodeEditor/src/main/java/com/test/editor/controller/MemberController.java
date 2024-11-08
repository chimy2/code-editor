package com.test.editor.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.test.editor.dao.MemberDAO;
import com.test.editor.model.MemberDTO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class MemberController {

	private final MemberDAO dao;	
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
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
	
	// 회원가입 완료
	@PostMapping("/join")
	public int joinOk(@RequestBody MemberDTO dto) {
		
		dto.setPw(passwordEncoder.encode(dto.getPw()));
		
		int result = dao.joinOk(dto);
	    System.out.println(result);
		return result;
	}
	
	
	
}
