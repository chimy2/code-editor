package com.test.editor.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.editor.dao.VersionFileDAO;
import com.test.editor.model.VersionFileDTO;

/**
 * VersionFileService는 비즈니스 로직을 처리하는 서비스 계층 클래스입니다.
 * 
 * Service: Spring 컨테이너에 이 클래스를 서비스 컴포넌트로 등록합니다.
 *           비즈니스 로직을 처리하고 DAO 계층과 Controller 계층 간의 중개 역할을 합니다.
 */
@Service
public class VersionFileService {

    /**
     * VersionFileDAO는 데이터베이스와 상호작용하는 DAO 계층 클래스입니다.
     * 
     * Autowired: Spring 컨테이너에서 VersionFileDAO 객체를 자동으로 주입받아 사용합니다.
     */
    @Autowired
    private VersionFileDAO dao;

    public int insertBasicFiles() {
    	return dao.insertBasicFiles();
    }
    
    /**
     * 주어진 ID(seq)에 해당하는 버전 파일 정보를 조회합니다.
     * 
     * @param seq 버전 파일의 고유 식별자
     * @return VersionFileDTO - 조회된 버전 파일 정보
     */
    public VersionFileDTO getVersionFileById(Integer seq) {
        return dao.getVersionFileById(seq);
    }

    /**
     * 모든 버전 파일 정보를 조회합니다.
     * 
     * @return 모든 버전 파일 목록
     */
    public List<VersionFileDTO> getAllVersionFiles() {
        return dao.getAllVersionFiles();
    }

    /**
     * 새로운 버전 파일을 데이터베이스에 추가합니다.
     * 
     * @param versionFile 추가할 버전 파일 정보
     */
    public void insertVersionFile(VersionFileDTO versionFile) {
        dao.insertVersionFile(versionFile);
    }

    /**
     * 버전 파일을 저장합니다.
     * 이 메서드는 insert와 동일한 동작을 수행하지만, 추후 추가 로직을 포함할 수 있습니다.
     * 
     * @param versionFile 저장할 버전 파일 정보
     */
    public void saveVersionFile(VersionFileDTO versionFile) {
        dao.insertVersionFile(versionFile);
    }
}
