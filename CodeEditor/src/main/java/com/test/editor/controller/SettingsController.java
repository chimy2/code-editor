package com.test.editor.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.editor.dao.SettingsDAO;
import com.test.editor.model.ThemeDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class SettingsController {

	private final SettingsDAO dao;

	@GetMapping("/settings")
	public String getSettingsPage() {
		
		return "settings";
	}
	
	@GetMapping("/theme")
	@ResponseBody
	public String getTheme(HttpSession session) {		
		
		//String member_seq = (String) session.getAttribute("member_seq");
		String member_seq = "1";
		System.out.println("유정이 힘을내");
		return dao.getTheme(member_seq);
	}
	
	
	@PutMapping("/theme")
	@ResponseBody
	public String updateTheme(@RequestBody ThemeDTO theme, HttpSession session) {
				
		String member_seq = "1";
		theme.setMember_seq(member_seq);
		
		System.out.println(theme.toString());
		
		dao.updateTheme(theme);
		
		return "update !!!!";
	}
	
	@GetMapping("/font")
	@ResponseBody
	public String getFont(HttpSession session) {
		
		return null;
	}
	
}















