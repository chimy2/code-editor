package com.test.editor.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.test.editor.model.TeamDTO;

@Mapper
public interface TeamMapper {
	
	int insert(TeamDTO team);

	TeamDTO get(String seq);

	List<TeamDTO> getList();
}
