package com.test.editor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class EditorController {
	
	@GetMapping("/code")
	public String view() {
		return "editor";
	}
	
	@GetMapping("/code/{projectSeq}")
	public String viewEditor(@PathVariable("projectSeq") String projectSeq) {
		System.out.println("projectSeq" + projectSeq);
		
		return "editor";
	}

}
