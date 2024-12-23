package com.test.editor.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.VersionFileMapper;

/**
 * VersionFileDAO는 데이터베이스 접근을 위한 DAO(Data Access Object) 클래스입니다.
 * 
 * Repository: 이 클래스가 Spring의 DAO 컴포넌트로 등록되도록 지정합니다.
 *              DAO 계층을 나타내는 명시적인 애노테이션입니다.
 */
@Repository
public class VersionFileDAO {

    /**
     * VersionFileMapper는 MyBatis를 사용하여 데이터베이스 쿼리를 실행하는 매퍼 인터페이스입니다.
     * 
     * Autowired: Spring 컨테이너에서 VersionFileMapper 객체를 자동으로 주입합니다.
     */
    @Autowired
    private VersionFileMapper mapper;

	public int insertBasicFiles() {
		return 0;
	}
}
