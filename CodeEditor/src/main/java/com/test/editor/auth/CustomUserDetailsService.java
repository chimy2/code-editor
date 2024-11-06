package com.test.editor.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.test.editor.mapper.SecurityMapper;
import com.test.editor.model.CustomUser;
import com.test.editor.model.UserDTO;

public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	private SecurityMapper mapper;
	
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		// 매개변수로 넘어오는 username은 customlogin에서 만든 username으로 넘어옴
		
		// username > DB > select
		UserDTO dto = mapper.loadUser(username);
		
		//return dto != null? new CustomUser(dto) : null; 
		// null은 로그인 실패했다고 뜸
		return null;
	}

}








































