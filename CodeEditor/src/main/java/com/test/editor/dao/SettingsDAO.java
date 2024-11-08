package com.test.editor.dao;

import java.util.List;

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

	public String updateTheme(ThemeDTO theme) {
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
	
	

}















