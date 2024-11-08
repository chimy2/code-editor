package com.test.editor.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.test.editor.dao.MemberDAO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class MemberController {

	private final MemberDAO dao;	
	
	// 회원가입 중복
	@PostMapping("/join")
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
}
