package com.test.editor.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.MemberTeamMapper;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.TeamDTO;

@Repository
public class MemberTeamDAO {

	@Autowired
	private MemberTeamMapper mapper;

	public int insert(MemberDTO member, TeamDTO team) {
		return mapper.insert(member, team);
	}
	
	
}
