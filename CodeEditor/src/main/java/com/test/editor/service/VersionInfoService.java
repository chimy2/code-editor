package com.test.editor.service;

import org.springframework.stereotype.Service;

import com.test.editor.dao.VersionInfoDAO;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.ProjectDTO;
import com.test.editor.model.VersionInfoDTO;

import lombok.RequiredArgsConstructor;

/**
 * 버전 관리와 관련된 비즈니스 로직을 처리하는 서비스 클래스
 */
@Service
@RequiredArgsConstructor
public class VersionInfoService {

    private final VersionInfoDAO dao; // 버전 관련 데이터를 처리하는 레포지토리

    private final VersionFileService versionFileService;
    
    public int insertBasicVersion(MemberDTO member, ProjectDTO project) {
    	VersionInfoDTO versionInfo = new VersionInfoDTO().getDefault();
    	insert(member, project, versionInfo);
    	return versionFileService.insertBasicFiles(versionInfo);
    }
    
    public int insert(MemberDTO member, ProjectDTO project, VersionInfoDTO versionInfo) {
    	return dao.insert(member, project, versionInfo);
    }
    
    public Integer getLastVersionSeq(String projectSeq) {
    	return dao.getLastVersionSeq(projectSeq);
    }
    
}
