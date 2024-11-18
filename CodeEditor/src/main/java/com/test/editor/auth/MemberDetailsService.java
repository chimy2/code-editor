package com.test.editor.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.test.editor.mapper.MemberMapper;
import com.test.editor.model.CustomUser;
import com.test.editor.model.MemberDTO;

/**
 * 
 * MemberDetailsService
 * 로그인 시 사용자 인증을 처리하는 클래스
 * @author bohwa Jang
 *
 */
public class MemberDetailsService implements UserDetailsService{

	/**
	 * 데이터베이스 연동을 담당하는 객체
	 */
	@Autowired
	private MemberMapper mapper;
	
	/**
	 * 사용자 인증을 처리하는 중요한 메서드로, 로그인 시 사용자 정보를 조회하고 해당 정보를 UserDetails 객체로 반환
	 */
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		MemberDTO dto = mapper.loadUser(username);
		
		return dto != null ? new CustomUser(dto) : null;
		
	}

	
	
	
	
	
	
}








































