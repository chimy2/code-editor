package com.test.editor.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserDAO {
	
	private final SqlSessionTemplate template;

	public int delbot(String seq) {
		
		return template.delete("com.test.editor.mapper.UserMapper.botdel", seq);
	}

}
