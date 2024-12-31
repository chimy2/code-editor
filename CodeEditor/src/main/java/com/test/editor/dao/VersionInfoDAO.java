package com.test.editor.dao;

import org.springframework.stereotype.Repository;

import com.test.editor.mapper.VersionInfoMapper;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.ProjectDTO;
import com.test.editor.model.VersionInfoDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class VersionInfoDAO {
	
	private final VersionInfoMapper mapper;

	public int insert(MemberDTO member, ProjectDTO project, VersionInfoDTO versionInfo) {
		return mapper.insert(member, project, versionInfo);
	}

	public Integer getLastVersionSeq(String projectSeq) {
		return mapper.getLastVersionSeq(projectSeq);
	}
	
	
}
