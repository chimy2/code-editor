package com.test.editor.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.ExplorerMapper;
import com.test.editor.model.ProjectFile;

@Repository
public class ExplorerDAO {
	
	@Autowired
	private ExplorerMapper mapper;

	public List<ProjectFile> getProjectFile(Map<String, String> projectFile) {
		return mapper.getProjectFile(projectFile);
	}
 

}
