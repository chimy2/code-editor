package com.test.editor.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.test.editor.model.MemberDTO;
import com.test.editor.model.ProjectDTO;
import com.test.editor.model.VersionInfoDTO;

@Mapper
public interface VersionInfoMapper {

	int insert(@Param("member") MemberDTO member, @Param("project") ProjectDTO project,
			@Param("versionInfo") VersionInfoDTO versionInfo);

	Integer getLastVersionSeq(String projectSeq);

}
