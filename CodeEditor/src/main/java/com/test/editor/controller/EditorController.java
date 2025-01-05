package com.test.editor.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.test.editor.dao.MemberDAO;
import com.test.editor.model.VersionFileDTO;
import com.test.editor.service.VersionService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EditorController {

	private final MemberDAO dao;
	
	private final VersionService versionService;
	
	@GetMapping("/code")
	public String view() {
		return "editor";
	}
	
	@GetMapping("/code/{projectSeq}")
	public String viewEditor(Model model, @PathVariable("projectSeq") String projectSeq, HttpSession session) {
		List<VersionFileDTO> files = versionService.getLastVersionFiles(projectSeq);
		Map<String, List<VersionFileDTO>> fileMap = versionService.groupByParentSeq(files);

		session.setAttribute("project_seq", projectSeq); 
		model.addAttribute("fileMap", fileMap);
		
		return "editor";
	}

}
