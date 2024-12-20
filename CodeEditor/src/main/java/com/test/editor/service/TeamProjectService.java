package com.test.editor.service;

import org.springframework.stereotype.Service;

import com.test.editor.dao.TeamProjectDAO;
import com.test.editor.model.ProjectDTO;
import com.test.editor.model.TeamDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TeamProjectService {

	private final TeamProjectDAO dao;
	
	public int insert(TeamDTO team, ProjectDTO project) {
		return dao.insert(team, project);
	}
}
