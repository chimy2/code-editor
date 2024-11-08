package com.test.editor.auth;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		System.out.println("로그인을 성공했습니다.");
		
		// 성공 직후 하고 싶은 일 구현
		// - 인증 후 권한 확인
		// 1. 회원 > member.do
		// 2. 관리자 > admin.do
		
		List<String> rolelist = new ArrayList<String>();
		authentication.getAuthorities().forEach(authority ->{
			rolelist.add(authority.getAuthority());
			
		});
		
		//System.out.println(rolelist); 
		
		// hong 로그인했더니 [ROLE_MEMBER]
		// lee 로그인했더니 [ROLE_ADMIN, ROLE_MEMBER]
		/*
		if(rolelist.contains("ROLE_ADMIN")) {
			response.sendRedirect("/editor/admin.do");
			return;
		}
		
		if(rolelist.contains("ROLE_MEMBER")) {
			response.sendRedirect("/editor/member.do");
			return;
		}
		*/
		response.sendRedirect("/editor");
		
	}
}




























