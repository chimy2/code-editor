package com.test.editor.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.SettingsMapper;
import com.test.editor.model.StyleSettingDTO;
import com.test.editor.model.TemplateDTO;
import com.test.editor.model.ThemeDTO;

@Repository
public class SettingsDAO {

	@Autowired
	private SettingsMapper mapper;
	
	public String getTheme(String member_seq) {
		return mapper.getTheme(member_seq);
	}

	public int updateTheme(ThemeDTO theme) {
		return mapper.updateTheme(theme);
	}

	public List<StyleSettingDTO> getFont(String member_seq) {
		return mapper.getFont(member_seq);
		
	}

	public List<StyleSettingDTO> getColor(String member_seq) {
		return mapper.getColor(member_seq);
	}

	public List<TemplateDTO> getTemplate(String member_seq) {
		return mapper.getTemplate(member_seq);
	}
   
	public int updateFont(Map<String, Object> fontStyle) {
		return mapper.updateFont(fontStyle);
	}

	public int updateColor(Map<String, Object> colorStyle) {
		return mapper.updateColor(colorStyle);
	}

	public int updateTemplate(TemplateDTO template) {
		return mapper.updateTemplate(template);
	}

	public int addTemplate(TemplateDTO template) {
		return mapper.addTemplate(template);
	}

	public int delTemplate(String template_seq) {
		return mapper.delTemplate(template_seq);
	}
	
	

}















