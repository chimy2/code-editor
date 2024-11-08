package com.test.editor.mapper;

import com.test.editor.model.MemberDTO;

public interface MemberMapper {

	MemberDTO login(MemberDTO member);

	MemberDTO loadUser(String username);
	
	
}
