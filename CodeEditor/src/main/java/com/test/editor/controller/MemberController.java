package com.test.editor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

import com.test.editor.model.MemberDTO;

@Controller

public class MemberController {

	@PostMapping("/login")
	public String login(Model model, MemberDTO member) {
		
		model.addAttribute("member", member);
		
		return "main";
	}
}
