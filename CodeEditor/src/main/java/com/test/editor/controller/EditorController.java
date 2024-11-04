package com.test.editor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EditorController {
	
	@GetMapping("/code")
	public String view() {
		return "editor";
	}
	

}
