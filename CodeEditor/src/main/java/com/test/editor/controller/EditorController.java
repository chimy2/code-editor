package com.test.editor.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.test.editor.dao.MemberDAO;
import com.test.editor.model.MemberDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EditorController {

	private final MemberDAO dao;
	
	@GetMapping("/code")
	public String view() {
		return "editor";
	}
	
	@GetMapping("/code/{projectSeq}")
	public String viewEditor(Model model, @PathVariable("projectSeq") String projectSeq, HttpSession session) {

		System.out.println("projectSeq" + projectSeq);
		session.setAttribute("project_seq", projectSeq); 
		return "editor";
	}

}
