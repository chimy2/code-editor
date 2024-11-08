package com.test.editor.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public String updateFont(@RequestBody List<StyleSettingDTO> styleSettings, HttpSession session) {

		String member_seq = "1";
 
	    Map<String, Object> fontStyle = new HashMap<>();
	    
	    for (StyleSettingDTO setting : styleSettings) {
	        if ("1".equals(setting.getStyleType_seq())) {
	        	fontStyle.put("fontSize", setting);
	        } else if ("2".equals(setting.getStyleType_seq())) {
	        	fontStyle.put("fontFamily", setting);
	        }
	    }
	    
	    fontStyle.put("member_seq", member_seq);
	    
	    dao.updateFont(fontStyle);
	    
		return "update font";
	}
	
	
	@PutMapping(value="/color", produces="application/json")
	@ResponseBody
	public String updateColor(@RequestBody List<StyleSettingDTO> styleSettings, HttpSession session) {
		
		String member_seq = "1";
		
		Map<String, Object> colorStyle = new HashMap<>();
		
		for (StyleSettingDTO data : styleSettings) {
			if ("3".equals(data.getStyleType_seq())) {
			    colorStyle.put("background", data);
			    System.out.println(data);
			} else if ("4".equals(data.getStyleType_seq())) {
			    colorStyle.put("foreground", data);
			    System.out.println(data);
			} else if ("5".equals(data.getStyleType_seq())) {
			    colorStyle.put("comment", data);
			    System.out.println(data);
			} else if ("6".equals(data.getStyleType_seq())) {
			    colorStyle.put("keyword", data);
			    System.out.println(data);
			} else if ("7".equals(data.getStyleType_seq())) {
			    colorStyle.put("String", data);
			    System.out.println(data);
			} 
			
		}
		
		colorStyle.put("member_seq", member_seq);
		dao.updateColor(colorStyle);
		
		return "update color";
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
