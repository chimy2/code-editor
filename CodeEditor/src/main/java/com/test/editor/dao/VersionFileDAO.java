package com.test.editor.dao;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.VersionFileMapper;
import com.test.editor.model.VersionFileDTO;

/**
 * VersionFileDAO는 데이터베이스 접근을 위한 DAO(Data Access Object) 클래스입니다.
 * 
 * @Repository: 이 클래스가 Spring의 DAO 컴포넌트로 등록되도록 지정합니다.
 *              DAO 계층을 나타내는 명시적인 애노테이션입니다.
 */
@Repository
public class VersionFileDAO {

    /**
     * VersionFileMapper는 MyBatis를 사용하여 데이터베이스 쿼리를 실행하는 매퍼 인터페이스입니다.
     * 
     * @Autowired: Spring 컨테이너에서 VersionFileMapper 객체를 자동으로 주입합니다.
     */
    @Autowired
    private VersionFileMapper versionFileMapper;

    /**
     * 주어진 ID(seq)에 해당하는 버전 파일 정보를 조회합니다.
     * 
     * @param seq 버전 파일의 고유 식별자
     * @return VersionFileDTO - 조회된 버전 파일 정보
     * 
     * 추가 로직을 작성할 경우 메서드 내부에서 처리 가능합니다.
     */
    public VersionFileDTO getVersionFileById(Integer seq) {
        return versionFileMapper.getVersionFileById(seq);
    }

    /**
     * 모든 버전 파일 정보를 조회합니다.
     * 
     * @return List<VersionFileDTO> - 데이터베이스에서 조회된 모든 버전 파일 목록
     * 
     * 추가 로직을 작성할 경우 메서드 내부에서 처리 가능합니다.
     */
    public List<VersionFileDTO> getAllVersionFiles() {
        return versionFileMapper.getAllVersionFiles();
    }

    /**
     * 새로운 버전 파일을 데이터베이스에 추가합니다.
     * 
     * @param versionFile 추가할 버전 파일 정보
     * 
     * 추가 로직을 작성할 경우 메서드 내부에서 처리 가능합니다.
     */
    public void insertVersionFile(VersionFileDTO versionFile) {
        versionFileMapper.insertVersionFile(versionFile);
    }
}
