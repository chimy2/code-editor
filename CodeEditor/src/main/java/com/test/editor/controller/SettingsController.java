package com.test.editor.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.editor.dao.SettingsDAO;
import com.test.editor.model.StyleSettingDTO;
import com.test.editor.model.TemplateDTO;
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

		// String member_seq = (String) session.getAttribute("member_seq");
		String member_seq = "1";
		return dao.getTheme(member_seq);
	}

	@PutMapping(value="/theme", produces="application/json")
	@ResponseBody
	public String updateTheme(@RequestBody ThemeDTO theme, HttpSession session) {

		String member_seq = "1";
		theme.setMember_seq(member_seq);
		dao.updateTheme(theme);

		return "update theme";
	}

	@GetMapping(value = "/font", produces="application/json")
	@ResponseBody
	public List<StyleSettingDTO> getFont(HttpSession session) {
		String member_seq = "1";
		return dao.getFont(member_seq);
	}
	
	@PutMapping(value="/font", produces="application/json")
	@ResponseBody
	public String updateFont(@RequestBody StyleSettingDTO styleSetting,HttpSession session) {
		String member_seq = "1";
		styleSetting.setMember_seq(member_seq);
		dao.updateFont(styleSetting);
		
		return "update font";
	}
	

	@GetMapping(value="/color", produces="application/json")
	@ResponseBody
	public List<StyleSettingDTO> getColor(HttpSession session) {

		String member_seq = "1";
		return dao.getColor(member_seq);
	}

    @GetMapping(value="/template", produces="application/json")
    @ResponseBody 
    public List<TemplateDTO> getTemplate(Model model, HttpSession session) {
	    String member_seq = "1"; 
 	    List<TemplateDTO> template = dao.getTemplate(member_seq); 
	    model.addAttribute("template", template);
	    return template; 
    }
 

}
