package com.test.editor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.editor.dao.MemberTeamDAO;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.TeamDTO;

@Service
public class MemberTeamService {

	@Autowired
	private MemberTeamDAO dao;
	
	public int insert(MemberDTO member, TeamDTO team) {
		return dao.insert(member, team);
	}
}
