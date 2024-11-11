package com.test.editor.mapper;

import java.util.List;
import java.util.Map;

import com.test.editor.model.ProjectFile;

public interface ExplorerMapper {

	List<ProjectFile> getProjectFile(Map<String, String> projectFile);
 

}
