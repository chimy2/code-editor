package com.test.editor.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.test.editor.model.CustomUser;
import com.test.editor.model.MemberDTO;

public class MemberLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		System.out.println("로그인을 성공했습니다.");
		/*
		 CustomUser customUser = (CustomUser) authentication.getPrincipal(); String
		 nick = customUser.getMember().getNick();
		 */
		
		//response.sendRedirect("/editor/mypage?nick=" + URLEncoder.encode(nick, "UTF-8"));
		
		CustomUser customUser = (CustomUser) authentication.getPrincipal(); MemberDTO
		dto = customUser.getMember();
		request.setAttribute("dto", dto);
		
		HttpSession session = request.getSession();
		session.setAttribute("dto", dto);
		
		response.sendRedirect("/editor/mypage");
	
	}
}




























