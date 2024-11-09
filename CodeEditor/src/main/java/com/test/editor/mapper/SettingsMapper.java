package com.test.editor.mapper;

import java.util.List;
import java.util.Map;

import com.test.editor.model.StyleSettingDTO;
import com.test.editor.model.TemplateDTO;
import com.test.editor.model.ThemeDTO;

public interface SettingsMapper {

	String getTheme(String member_seq);

	int updateTheme(ThemeDTO theme);

	List<StyleSettingDTO> getFont(String member_seq);

	List<StyleSettingDTO> getColor(String member_seq);

	List<TemplateDTO> getTemplate(String member_seq);
 
	int updateFont(Map<String, Object> fontStyle);

	int updateColor(Map<String, Object> colorStyle);

	int updateTemplate(TemplateDTO template);

	int addTemplate(TemplateDTO template);

	int delTemplate(String template_seq);
	
}
