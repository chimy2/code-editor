package com.test.editor.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.ExplorerMapper;
import com.test.editor.model.ProjectFile;

/**
 * ExplorerDAO
 * 프로젝트 파일 데이터에 접근하는 DAO 클래스입니다.
 * 데이터베이스와의 상호작용을 처리합니다.
 * @author ChoiYuJeong
 */
@Repository
public class ExplorerDAO {
	
	/**
	 * ExplorerMapper의 인스턴스를 자동으로 주입합니다.
	 * 데이터베이스 작업을 수행하기 위해 사용됩니다.
	 */
	@Autowired
	private ExplorerMapper mapper;

	/**
	 * 프로젝트 파일 목록을 가져옵니다.
	 * @param projectFile 프로젝트와 관련된 파일 정보가 담긴 맵 (member_seq 및 project_seq)
	 * @return 객체 리스트
	 */
	public List<ProjectFile> getProjectFile(Map<String, String> projectFile) {
		return mapper.getProjectFile(projectFile);
	}
 

}
