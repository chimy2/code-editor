package com.test.editor.auth;

import org.springframework.security.crypto.password.PasswordEncoder;

public class CustomNoOpPasswordEncoder implements PasswordEncoder{

	@Override
	public String encode(CharSequence rawPassword) { // 사용자가 작성한 암호 : 1111
		
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) { // 1111을 비식별화된 암호
		
		return rawPassword.toString().equals(encodedPassword);
	}

	
	
	
	
}




























































