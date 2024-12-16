package com.test.editor.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.test.editor.model.ProjectFile;


/**
 * ExplorerMapper
 * 프로젝트 파일 데이터베이스 작업을 정의하는 MyBatis Mapper 인터페이스입니다.
 * @author ChoiYuJeong
 *
 */
@Mapper
public interface ExplorerMapper {

	/**
	 * 프로젝트 파일 목록을 가져옵니다.
	 * 
	 * @param projectFile 프로젝트와 관련된 파일 정보가 담긴 맵 (member_seq 및 project_seq)
	 * @return ProjectFile 객체 리스트
	 */
	List<ProjectFile> getProjectFile(Map<String, String> projectFile);
 

}
