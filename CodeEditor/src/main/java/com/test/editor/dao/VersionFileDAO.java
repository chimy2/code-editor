package com.test.editor.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.test.editor.mapper.VersionFileMapper;
import com.test.editor.model.VersionFileDTO;

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

	public List<VersionFileDTO> getAllVersionFiles(String versionInfoSeq) {
		return mapper.getAllVersionFiles(versionInfoSeq);
	}

	public int getNextSeq() {
		return mapper.getNextSeq();
	}

	public int insertList(List<VersionFileDTO> versionFiles) {
		int count = 0;
		
		for (int i=0; i<versionFiles.size(); i++) {
			insert(versionFiles.get(i));
			count++;
			
		}
		
		return count == 7 ? 1 : 0;
	}
	
	public int insert(VersionFileDTO verionFile) {
		return mapper.insert(verionFile);
	}

	
	public VersionFileDTO get(String seq) {
		return mapper.get(seq);
	}
}
