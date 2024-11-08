package com.test.editor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.editor.dao.MemberDAO;
import com.test.editor.model.MemberDTO;

@Service
public class MemberService {

	@Autowired
	private MemberDAO dao;

	
}
