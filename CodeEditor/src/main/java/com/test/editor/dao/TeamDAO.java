package com.test.editor.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.TeamMapper;
import com.test.editor.model.TeamDTO;

@Repository
public class TeamDAO {

	@Autowired
	private TeamMapper mapper;
	
	public void insert(TeamDTO team) {
		mapper.insert(team);
	}
}
