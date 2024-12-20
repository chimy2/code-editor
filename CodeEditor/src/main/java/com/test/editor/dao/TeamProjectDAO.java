package com.test.editor.dao;

import org.springframework.stereotype.Repository;

import com.test.editor.mapper.TeamProjectMapper;
import com.test.editor.model.ProjectDTO;
import com.test.editor.model.TeamDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class TeamProjectDAO {

	private final TeamProjectMapper mapper;

	public int insert(TeamDTO team, ProjectDTO project) {
		return mapper.insert(team, project);
	}
	
}
