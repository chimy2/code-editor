package com.test.editor.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.test.editor.mapper.VersionFileMapper;
import com.test.editor.model.VersionFileDTO;
import com.test.editor.model.VersionInfoDTO;

import lombok.RequiredArgsConstructor;

/**
 * VersionFileDAO는 데이터베이스 접근을 위한 DAO(Data Access Object) 클래스입니다.
 * 
 * Repository: 이 클래스가 Spring의 DAO 컴포넌트로 등록되도록 지정합니다.
 *              DAO 계층을 나타내는 명시적인 애노테이션입니다.
 */
@Repository
@RequiredArgsConstructor
public class VersionFileDAO {

    /**
     * VersionFileMapper는 MyBatis를 사용하여 데이터베이스 쿼리를 실행하는 매퍼 인터페이스입니다.
     * 
     */
    private final VersionFileMapper mapper;

	public int insertBasicFiles(VersionInfoDTO versionInfo) {
		return mapper.insertBasicFiles(versionInfo);
	}

	public List<VersionFileDTO> getAllVersionFiles(String versionInfoSeq) {
		return mapper.getAllVersionFiles(versionInfoSeq);
	}
}
