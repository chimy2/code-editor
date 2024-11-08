package com.test.editor.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.MemberMapper;
import com.test.editor.model.MemberDTO;

@Repository
public class MemberDAO  {

	@Autowired
	private MemberMapper mapper;

	public MemberDTO list(String nick) {
		// TODO Auto-generated method stub
		return mapper.list(nick);
	}

	public int duplicatedCheck(String check) {
		
		return mapper.duplicatedCheck(check);
	}

	public int duplicatedNickCheck(String check) {
		
		return mapper.duplicatedNickCheck(check);
	}

	
	
	
}
