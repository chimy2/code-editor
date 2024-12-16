package com.test.editor.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.test.editor.model.TeamDTO;

@Mapper
public interface TeamMapper {
	
	int insert(TeamDTO team);
}
