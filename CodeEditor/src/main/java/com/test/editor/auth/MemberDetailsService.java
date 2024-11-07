package com.test.editor.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.test.editor.mapper.UserMapper;
import com.test.editor.model.CustomUser;
import com.test.editor.model.MemberDTO;

public class MemberDetailsService implements UserDetailsService{

	@Autowired
	private UserMapper mapper;
	
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		MemberDTO dto = mapper.loadUser(username);
		return dto != null ? new CustomUser(dto) : null;
		
	}

}








































