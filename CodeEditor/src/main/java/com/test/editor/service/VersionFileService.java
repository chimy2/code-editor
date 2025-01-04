package com.test.editor.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.test.editor.dao.VersionFileDAO;
import com.test.editor.model.BasicFileDTO;
import com.test.editor.model.VersionFileDTO;
import com.test.editor.model.VersionInfoDTO;

import lombok.RequiredArgsConstructor;

/**
 * VersionFileService는 비즈니스 로직을 처리하는 서비스 계층 클래스입니다.
 * 
 * Service: Spring 컨테이너에 이 클래스를 서비스 컴포넌트로 등록합니다.
 *           비즈니스 로직을 처리하고 DAO 계층과 Controller 계층 간의 중개 역할을 합니다.
 */
@Service
@RequiredArgsConstructor
public class VersionFileService {

    private final VersionFileDAO dao;
    
    private final BasicFileService basicFileService;

    public int insertBasicFiles(VersionInfoDTO versionInfo) {
    	int firstSeq = getNextSeq();
    	List<BasicFileDTO> basicFiles = basicFileService.getAllFiles();
    	List<VersionFileDTO> versionFiles = new ArrayList<VersionFileDTO>();
    	
    	for(int i=0; i<basicFiles.size(); i++) {
    		BasicFileDTO basicFile = basicFiles.get(i);
    		versionFiles.add(basicFile.toVersionFile(versionInfo, firstSeq));
    	}
    	return dao.insertList(versionFiles);
    }
    
    public List<VersionFileDTO> getAllVersionFiles(String versionInfoSeq) {
    	return dao.getAllVersionFiles(versionInfoSeq);
    }
    
    public int getNextSeq() {
    	return dao.getNextSeq();
    }

	public List<VersionFileDTO> getAllVersionFiles(int lastVersionSeq) {
		return getAllVersionFiles(String.valueOf(lastVersionSeq));
	}

	public VersionFileDTO get(String seq) {
		return dao.get(seq);
	}
}
