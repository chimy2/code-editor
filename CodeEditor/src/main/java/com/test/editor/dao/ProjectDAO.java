package com.test.editor.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.test.editor.mapper.ProjectMapper;
import com.test.editor.model.ProjectDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ProjectDAO {

	private final ProjectMapper mapper;
	
	public int insert(ProjectDTO project) {
		return mapper.insert(project);
	}

	public int insertDefault(ProjectDTO project) {
		return mapper.insertDefault(project);
	}
	
	public ProjectDTO get(String seq) {
		return mapper.get(seq);
	}
	
	public List<ProjectDTO> getList() {
		return mapper.getList();
	}
}
