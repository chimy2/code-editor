package com.test.editor.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.test.editor.model.ProjectDTO;

@Mapper
public interface ProjectMapper {

	int insert(ProjectDTO project);

	int insertDefault(ProjectDTO project);

	ProjectDTO get(String seq);

	List<ProjectDTO> getList();

}
