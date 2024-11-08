package com.test.editor.mapper;

import com.test.editor.model.MemberDTO;

public interface MemberMapper {

	MemberDTO login(MemberDTO member);

	MemberDTO loadUser(String username);

	MemberDTO list(String nick);

	int duplicatedCheck(String email);

	int duplicatedNickCheck(String check);


	
	
}
