package com.test.editor.model;

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;


@Data
public class CustomUser extends User {

	private MemberDTO member;
		
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> oAuthType){
		super(username, password, oAuthType);
	}

	public CustomUser(MemberDTO dto) {
		super(dto.getId(), dto.getPw(), Collections.singletonList(new SimpleGrantedAuthority(dto.getIng())));
		this.member = dto;

	}
	
}
