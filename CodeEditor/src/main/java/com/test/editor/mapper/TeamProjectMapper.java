package com.test.editor.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.test.editor.model.ProjectDTO;
import com.test.editor.model.TeamDTO;

@Mapper
public interface TeamProjectMapper {

	int insert(@Param("team") TeamDTO team, @Param("project") ProjectDTO project);

}
