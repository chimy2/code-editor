package com.test.editor.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

public class CustomAccessDeniedHandler implements AccessDeniedHandler{

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		
		// 하고 싶은 일을 추가 > 21.1보다 디테일함(중간다리가 생겨서)
		// 403 대처 기능을 추가할 수 있음
		// - 로그 기록
		// - 알림 등
		// > 사용자 정의 페이지로 이동
		
		System.out.println("CustomAccessDeniedHandler가 호출되었습니다.");
		//response.sendRedirect("/editor/main");
		
	}
	
}

































