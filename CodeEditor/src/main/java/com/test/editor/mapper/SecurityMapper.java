package com.test.editor.mapper;

import org.apache.ibatis.annotations.Select;

import com.test.editor.model.UserDTO;

public interface SecurityMapper {
	
	// 기존 방식 : 어노테이션
	@Select("select sysdate from dual")
	String time1();
	
	// 새로운 방식 : 인터페이스 사용
	String time2();

	UserDTO loadUser(String username);

}
