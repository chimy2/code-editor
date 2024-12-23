package com.test.editor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.editor.dao.VersionInfoDAO;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.ProjectDTO;
import com.test.editor.model.VersionInfoDTO;

/**
 * 버전 관리와 관련된 비즈니스 로직을 처리하는 서비스 클래스
 */
@Service
public class VersionInfoService {

    @Autowired
    private VersionInfoDAO dao; // 버전 관련 데이터를 처리하는 레포지토리

    
    public int insertBasicVersion(MemberDTO member, ProjectDTO project) {
    	VersionInfoDTO versionInfo = new VersionInfoDTO().getDefault();
    	return insert(member, project, versionInfo);
    }
    
    public int insert(MemberDTO member, ProjectDTO project, VersionInfoDTO versionInfo) {
    	return dao.insert(member, project, versionInfo);
    }
}
