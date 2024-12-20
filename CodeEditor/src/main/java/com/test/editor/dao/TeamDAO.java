package com.test.editor.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.TeamMapper;
import com.test.editor.model.TeamDTO;

@Repository
public class TeamDAO {

	@Autowired
	private TeamMapper mapper;
	
	public int insert(TeamDTO team) {
		return mapper.insert(team);
	}
	
	public TeamDTO get(String seq) {
		return mapper.get(seq);
	}
	
	public TeamDTO get(int seq) {
		return mapper.get(String.valueOf(seq));
	}

	public List<TeamDTO> getList() {
		return mapper.getList();
	}
}
