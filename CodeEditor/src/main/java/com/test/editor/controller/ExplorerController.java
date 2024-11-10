package com.test.editor.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.test.editor.dao.ExplorerDAO;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.ProjectFile;

import lombok.RequiredArgsConstructor;


@RestController
@RequiredArgsConstructor
public class ExplorerController {
	
	private final ExplorerDAO dao;
	
	@GetMapping(value = "/explorer", produces = "application/json")
	public List<ProjectFile> getProjectFile(HttpSession session) {
		
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq(); 
		String project_seq = "1";
		
		Map<String, String> projectFile = new HashMap<>();
		projectFile.put("member_seq", member_seq);
		projectFile.put("project_seq", project_seq);
		
		return dao.getProjectFile(projectFile);
	}
	

}