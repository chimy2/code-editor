package com.test.editor.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.test.editor.model.MemberDTO;
import com.test.editor.model.TeamDTO;

@Mapper
public interface MemberTeamMapper {

	int insert(@Param("member") MemberDTO  member, @Param("team") TeamDTO team);
}
