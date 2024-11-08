package com.test.editor.mapper;

import java.util.List;

import com.test.editor.model.MemberDTO;

public interface MemberMapper {

	MemberDTO loadUser(String username);

	MemberDTO list(String nick);

	int duplicatedCheck(String email);

	int duplicatedNickCheck(String check);

	int joinOk(MemberDTO dto);

	
	
	
}
