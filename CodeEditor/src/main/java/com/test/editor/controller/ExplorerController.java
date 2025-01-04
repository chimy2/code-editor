package com.test.editor.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.test.editor.dao.ExplorerDAO;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.ProjectFile;

import lombok.RequiredArgsConstructor;

/**
 * ExplorerController
 * 프로젝트 파일 탐색을 처리하는 REST 컨트롤러입니다.
 * @author ChoiYuJeong
 */
@RestController
@RequiredArgsConstructor
public class ExplorerController {
	
	/**
	 * 데이터베이스와의 모든 작업은 ExplorerDAO를 통해 이루어집니다.
	 */
	private final ExplorerDAO dao;
	
	/**
	 * 현재 사용자의 프로젝트 파일 목록을 가져옵니다.
	 * @param session 현재 사용자의 세션
	 * @return ProjectFile 리스트 (JSON 형식)
	 */
	@GetMapping(value = "/explorer", produces = "application/json")
	public List<ProjectFile> getProjectFile(HttpSession session) {
		
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq(); 
		
	    String project_seq = (String) session.getAttribute("project_seq");
		
		Map<String, String> projectFile = new HashMap<>();
		projectFile.put("member_seq", member_seq);
		projectFile.put("project_seq", project_seq);
		
		return dao.getProjectFile(projectFile);
	}
	
}