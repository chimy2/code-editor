package com.test.editor.service;

import org.springframework.stereotype.Service;

import com.test.editor.dao.ProjectDAO;
import com.test.editor.model.ProjectDTO;
import com.test.editor.model.TeamDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProjectService {

	private final ProjectDAO dao;
	
	private final TeamProjectService teamProjectService;
	
	public int insert(TeamDTO team, ProjectDTO project) {
		dao.insert(project);
		return teamProjectService.insert(team, project);
	}
	
	public int insertDefault(TeamDTO team) {
		ProjectDTO project = new ProjectDTO().getDefault();
		dao.insertDefault(project);
		return teamProjectService.insert(team, project);
	}

	public ProjectDTO get(int seq) {
		return get(String.valueOf(seq));
	}

	private ProjectDTO get(String seq) {
		return dao.get(seq);
	}
	
}
