package com.test.editor.mapper;

import com.test.editor.model.MemberDTO;

public interface UserMapper {

	MemberDTO loadUser(String username);

}
