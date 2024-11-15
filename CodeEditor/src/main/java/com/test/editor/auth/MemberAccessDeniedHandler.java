package com.test.editor.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
/**
 * 
 * MemberAccessDeniedHandler
 * 로그인이 성공했을 때 요청을 처리하는 컨트롤러입니다.
 * @author bohwa Jang
 * 
 */
public class MemberAccessDeniedHandler implements AccessDeniedHandler{

	/**
	 * 로그인 성공 시 console창에 확인을 하기 위함
	 */
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {

		System.out.println("MemberAccessDeniedHandler가 호출되었습니다.");
		response.sendRedirect("/editor/login");
		
	}
	
}

































